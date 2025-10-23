import sys
import datetime
import os

# Get output directory from argument or default
output_dir = sys.argv[1]

# Ensure the directory exists
os.makedirs(output_dir, exist_ok=True)

# Define output file path
output_path = os.path.join(output_dir, "finish.txt")

# Record the completion message
time_str = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
message = f"[{time_str}] Pipeline finished successfully!\n"

# Write to file
with open(output_path, 'w') as f:
    f.write(message)

print(message)
print(f"Finish file written to: {output_path}")