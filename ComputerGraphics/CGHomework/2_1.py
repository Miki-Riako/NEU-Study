import numpy as np
import time

# Function to normalize coordinates to NDC space ([-1, 1])
def normalize_to_ndc(coordinates, screen_width, screen_height):
    normalized_x = 2 * coordinates[:, 0] / screen_width - 1
    normalized_y = 2 * coordinates[:, 1] / screen_height - 1
    return np.column_stack((normalized_x, normalized_y))

# Simulate rendering process with NDC
def render_with_ndc(screen_width, screen_height, num_points):
    # Generate random points, some of which are outside the screen space
    screen_coordinates = (np.random.rand(num_points, 2) - 0.5) * [screen_width * 2, screen_height * 2]
    
    # Start timing the rendering process
    start_time = time.time()
    
    # Normalize the points to NDC space
    ndc_coordinates = normalize_to_ndc(screen_coordinates, screen_width, screen_height)
    
    # Perform clipping in NDC space (only keep points within [-1, 1])
    ndc_clipped = ndc_coordinates[(ndc_coordinates[:, 0] >= -1) & 
                                  (ndc_coordinates[:, 0] <= 1) & 
                                  (ndc_coordinates[:, 1] >= -1) & 
                                  (ndc_coordinates[:, 1] <= 1)]
    
    # End timing the rendering process
    render_time = time.time() - start_time
    
    return len(ndc_clipped), render_time

# Define screen resolution and number of points
screen_width, screen_height = 1920, 1080
num_points = 10000000  # 10 million points

# Perform rendering with NDC
clipped_points, render_time = render_with_ndc(screen_width, screen_height, num_points)

print(f"Clipped Points: {clipped_points}, Render Time: {render_time:.6f} seconds")

