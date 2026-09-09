#!/usr/bin/env python3
"""
Simple TRIM Experiment Analysis
Usage: python3 trim_analyze.py [CSV_FILE]
"""

import pandas as pd
import numpy as np
import sys
import os

def main():
    # Get CSV file
    if len(sys.argv) > 1:
        csv_file = sys.argv[1]
    else:
        csv_file = os.path.expanduser("~/trim_experiment/logs/experiment_results.csv")
    
    # Check if file exists
    if not os.path.exists(csv_file):
        print(f"Error: File '{csv_file}' not found!")
        print("Usage: python3 trim_analyze.py [CSV_FILE]")
        sys.exit(1)
    
    # Load data
    df = pd.read_csv(csv_file)
    
    # Parse time if needed (handles "0:04.45" format)
    def parse_time(t):
        if isinstance(t, str):
            if ':' in t:
                parts = t.split(':')
                if len(parts) == 2:
                    return float(parts[0]) * 60 + float(parts[1])
            if t.endswith('s'):
                return float(t[:-1])
        return float(t)
    
    df['real_time_sec'] = df['real_time'].apply(parse_time)
    df['trimmed_gb'] = df['trimmed_bytes'] / (1024**3)
    
    print("\n" + "="*60)
    print("TRIM EXPERIMENT RESULTS")
    print("="*60)
    
    # Overall statistics
    print(f"\nTotal runs: {len(df)}")
    print(f"Fill levels tested: {sorted(df['fill_level'].unique())}%")
    print(f"Wait times tested: {sorted(df['wait_minutes'].unique())} minutes")
    
    # ============================================
    # 1. Recovery by Fill Level
    # ============================================
    print("\n" + "-"*60)
    print("RECOVERY BY FILL LEVEL")
    print("-"*60)
    
    for fill in sorted(df['fill_level'].unique()):
        data = df[df['fill_level'] == fill]
        print(f"\nFill Level: {fill}%")
        print(f"  Mean recovered: {data['recovered_files'].mean():.1f} files")
        print(f"  Std dev:        {data['recovered_files'].std():.1f} files")
        print(f"  Min recovered:  {data['recovered_files'].min():.1f} files")
        print(f"  Max recovered:  {data['recovered_files'].max():.1f} files")
        print(f"  Total runs:     {len(data)}")
    
    # ============================================
    # 2. Recovery by Wait Time
    # ============================================
    print("\n" + "-"*60)
    print("RECOVERY BY WAIT TIME")
    print("-"*60)
    
    for wait in sorted(df['wait_minutes'].unique()):
        data = df[df['wait_minutes'] == wait]
        print(f"\nWait Time: {wait} minutes")
        print(f"  Mean recovered: {data['recovered_files'].mean():.1f} files")
        print(f"  Std dev:        {data['recovered_files'].std():.1f} files")
        print(f"  Min recovered:  {data['recovered_files'].min():.1f} files")
        print(f"  Max recovered:  {data['recovered_files'].max():.1f} files")
        print(f"  Total runs:     {len(data)}")
    
    # ============================================
    # 3. TRIM Performance
    # ============================================
    print("\n" + "-"*60)
    print("TRIM PERFORMANCE")
    print("-"*60)
    
    for fill in sorted(df['fill_level'].unique()):
        data = df[df['fill_level'] == fill]
        print(f"\nFill Level: {fill}%")
        print(f"  Mean TRIM time:   {data['real_time_sec'].mean():.3f}s")
        print(f"  Std dev:          {data['real_time_sec'].std():.3f}s")
        print(f"  Min TRIM time:    {data['real_time_sec'].min():.3f}s")
        print(f"  Max TRIM time:    {data['real_time_sec'].max():.3f}s")
        print(f"  Mean trimmed:     {data['trimmed_gb'].mean():.2f} GB")
        print(f"  Total trimmed:    {data['trimmed_gb'].sum():.2f} GB")
    
    # ============================================
    # 4. TRIM Correlation
    # ============================================
    print("\n" + "-"*60)
    print("TRIM VS RECOVERY CORRELATION")
    print("-"*60)
    
    zero_trim = df[df['trimmed_gb'] == 0]
    nonzero_trim = df[df['trimmed_gb'] > 0]
    
    print(f"\nRuns with 0 bytes trimmed: {len(zero_trim)}")
    if len(zero_trim) > 0:
        print(f"  Average recovery: {zero_trim['recovered_files'].mean():.1f} files")
    
    print(f"\nRuns with data trimmed: {len(nonzero_trim)}")
    if len(nonzero_trim) > 0:
        print(f"  Average recovery: {nonzero_trim['recovered_files'].mean():.1f} files")
    
    # ============================================
    # 5. Best and Worst Cases
    # ============================================
    print("\n" + "-"*60)
    print("BEST AND WORST CASES")
    print("-"*60)
    
    best = df.loc[df['recovered_files'].idxmax()]
    worst = df.loc[df['recovered_files'].idxmin()]
    
    print(f"\nBest Recovery:")
    print(f"  Fill Level: {best['fill_level']}%")
    print(f"  Wait Time:  {best['wait_minutes']} minutes")
    print(f"  Recovered:  {best['recovered_files']} files")
    print(f"  TRIM Time:  {best['real_time']}s")
    print(f"  Trimmed:    {best['trimmed_gb']:.2f} GB")
    
    print(f"\nWorst Recovery:")
    print(f"  Fill Level: {worst['fill_level']}%")
    print(f"  Wait Time:  {worst['wait_minutes']} minutes")
    print(f"  Recovered:  {worst['recovered_files']} files")
    print(f"  TRIM Time:  {worst['real_time']}s")
    print(f"  Trimmed:    {worst['trimmed_gb']:.2f} GB")
    
    # ============================================
    # 6. Summary Statistics Table
    # ============================================
    print("\n" + "-"*60)
    print("QUICK REFERENCE TABLE")
    print("-"*60)
    
    # Pivot table: fill level vs wait time
    pivot = df.pivot_table(
        values='recovered_files',
        index='wait_minutes',
        columns='fill_level',
        aggfunc='mean'
    ).round(1)
    
    print("\nAverage Recovered Files:")
    print(pivot)
    
    # TRIM time pivot
    trim_pivot = df.pivot_table(
        values='real_time_sec',
        index='wait_minutes',
        columns='fill_level',
        aggfunc='mean'
    ).round(3)
    
    print("\nAverage TRIM Time (seconds):")
    print(trim_pivot)

if __name__ == "__main__":
    main()
