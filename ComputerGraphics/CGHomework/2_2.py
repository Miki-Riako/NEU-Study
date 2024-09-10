import numpy as np
import time

# Function to clip points directly in device coordinate space
def clip_in_device_space(coordinates, screen_width, screen_height):
    return coordinates[(coordinates[:, 0] >= 0) & 
                       (coordinates[:, 0] <= screen_width) & 
                       (coordinates[:, 1] >= 0) & 
                       (coordinates[:, 1] <= screen_height)]

# Simulate rendering process without NDC (direct device coordinates)
def render_without_ndc(screen_width, screen_height, num_points):
    # Generate random points, some of which are outside the screen space
    screen_coordinates = (np.random.rand(num_points, 2) - 0.5) * [screen_width * 2, screen_height * 2]
    
    # Start timing the rendering process
    start_time = time.time()
    
    # Perform clipping in device coordinate space
    clipped_points = clip_in_device_space(screen_coordinates, screen_width, screen_height)
    
    # End timing the rendering process
    render_time = time.time() - start_time
    
    return len(clipped_points), render_time

# Define screen resolution and number of points
screen_width, screen_height = 1920, 1080
num_points = 10000000  # 10 million points

# Perform rendering without NDC
clipped_points, render_time = render_without_ndc(screen_width, screen_height, num_points)

print(f"Clipped Points: {clipped_points}, Render Time: {render_time:.6f} seconds")

