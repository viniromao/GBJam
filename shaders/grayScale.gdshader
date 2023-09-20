shader_type canvas_item;

uniform float quantity : hint_range(0.0, 1.0);

void fragment() {
    vec4 original = texture(TEXTURE, UV);
    
    // Calculate the grayscale value by taking the average of the color channels
    float mean = (original.r + original.g + original.b) / 3.0;
    
    // Create a grayscale color using the mean value for all channels
    vec4 gray = vec4(mean, mean, mean, original.a);
    
    // Interpolate between the original color and grayscale based on quantity
    COLOR = mix(original, gray, quantity);
}
