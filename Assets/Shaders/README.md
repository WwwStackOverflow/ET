# Water Ripple Shader (水波纹着色器)

## Overview / 概述

This is a Unity shader that creates a beautiful water ripple effect with animated waves. It can be used for water surfaces, reflective effects, or any other visual element requiring a dynamic ripple animation.

这是一个Unity着色器，可以创建漂亮的水波纹效果和动画波浪。它可用于水面、反射效果或任何需要动态波纹动画的视觉元素。

## Features / 特性

- **Animated Ripples**: Dynamic ripple animation that radiates from the center (动态波纹动画从中心向外扩散)
- **Vertex Displacement**: 3D wave effect on vertices (顶点上的3D波浪效果)
- **Customizable Parameters**: Fully adjustable ripple speed, frequency, amplitude, and more (完全可调的波纹速度、频率、振幅等)
- **Transparency Support**: Alpha blending for realistic water effect (支持透明度混合以实现逼真的水面效果)
- **Performance Optimized**: Efficient shader code suitable for real-time applications (性能优化，适合实时应用)

## Files / 文件

- `Assets/Shaders/WaterRipple.shader` - The water ripple shader (水波纹着色器)
- `Assets/Materials/WaterRippleMaterial.mat` - Example material using the shader (使用着色器的示例材质)
- `Assets/Materials/WaterRipplePlane.prefab` - Ready-to-use water plane prefab (可直接使用的水面预制体)

## Shader Properties / 着色器属性

| Property | Type | Description (English) | 描述 (中文) |
|----------|------|----------------------|------------|
| **Base Texture** | Texture2D | Base texture for the water surface | 水面基础纹理 |
| **Water Color** | Color | The color tint of the water | 水的颜色 |
| **Ripple Speed** | Float (0-10) | Speed of ripple animation | 波纹动画速度 |
| **Ripple Frequency** | Float (0-20) | Frequency/density of ripples | 波纹的频率/密度 |
| **Ripple Amplitude** | Float (0-0.5) | Height/intensity of ripples | 波纹的高度/强度 |
| **Wave Speed** | Float (0-5) | Speed of wave animation | 波浪动画速度 |
| **Wave Amplitude** | Float (0-0.2) | Height of waves | 波浪高度 |
| **Transparency** | Float (0-1) | Overall transparency of the effect | 效果的整体透明度 |

## Usage / 使用方法

### Basic Setup / 基本设置

1. Create a new material in Unity (在Unity中创建新材质)
2. Assign the "Custom/WaterRipple" shader to the material (将"Custom/WaterRipple"着色器分配给材质)
3. Apply the material to a plane or mesh (将材质应用到平面或网格上)
4. Adjust the parameters to achieve desired effect (调整参数以获得所需效果)

### Quick Start with Prefab / 使用预制体快速开始

The easiest way to get started:
1. Drag `WaterRipplePlane.prefab` from Assets/Materials into your scene
2. Press Play to see the animated water ripple effect
3. Select the prefab and adjust material properties in the Inspector

最简单的开始方式：
1. 将 Assets/Materials 中的 `WaterRipplePlane.prefab` 拖入场景
2. 按下播放按钮查看动画水波纹效果
3. 选择预制体并在检视面板中调整材质属性

### Using the Example Material / 使用示例材质

The `WaterRippleMaterial.mat` is pre-configured with default settings. You can directly apply this material to any GameObject with a Mesh Renderer.

`WaterRippleMaterial.mat` 已预先配置了默认设置。您可以直接将此材质应用到任何带有Mesh Renderer的GameObject上。

### Recommended Settings / 推荐设置

#### For Subtle Water Effect / 轻微水面效果
- Ripple Speed: 1.5
- Ripple Frequency: 3.0
- Ripple Amplitude: 0.05
- Wave Speed: 0.8
- Wave Amplitude: 0.03

#### For Strong Ripple Effect / 强烈波纹效果
- Ripple Speed: 5.0
- Ripple Frequency: 10.0
- Ripple Amplitude: 0.2
- Wave Speed: 2.0
- Wave Amplitude: 0.1

#### For Calm Water / 平静水面
- Ripple Speed: 0.5
- Ripple Frequency: 2.0
- Ripple Amplitude: 0.02
- Wave Speed: 0.3
- Wave Amplitude: 0.01

## Technical Details / 技术细节

### Rendering Pipeline / 渲染管线
- Compatible with Built-in Render Pipeline (兼容内置渲染管线)
- Queue: Transparent (队列：透明)
- Render Type: Transparent (渲染类型：透明)

### Shader Features / 着色器特性
- **Vertex Shader**: Applies ripple and wave displacement to vertices (顶点着色器：对顶点应用波纹和波浪位移)
- **Fragment Shader**: Adds ripple pattern and applies color/transparency (片段着色器：添加波纹图案并应用颜色/透明度)
- **Time-based Animation**: Uses `_Time` for automatic animation (基于时间的动画：使用`_Time`实现自动动画)

### Performance / 性能
This shader is optimized for real-time rendering:
- LOD 100 (suitable for most applications)
- Single pass rendering
- Efficient mathematical operations

此着色器针对实时渲染进行了优化：
- LOD 100（适用于大多数应用）
- 单通道渲染
- 高效的数学运算

## Example Use Cases / 使用示例

1. **Water Surfaces**: Apply to plane meshes for ponds, lakes, or ocean surfaces (水面：应用到平面网格上以创建池塘、湖泊或海面)
2. **Magical Effects**: Use for magic circles or spell effects (魔法效果：用于魔法阵或法术效果)
3. **Holograms**: Create futuristic holographic displays (全息图：创建未来感的全息显示)
4. **UI Effects**: Apply to UI elements for dynamic backgrounds (UI效果：应用到UI元素上以创建动态背景)

## Customization Tips / 自定义提示

### Changing Ripple Direction / 更改波纹方向
Modify the vertex shader's ripple calculation:
```cg
// Original: radiates from center
float dist = length(o.worldPos.xz);

// Alternative: ripples along X-axis
float dist = o.worldPos.x;
```

### Adding Multiple Ripple Sources / 添加多个波纹源
You can combine multiple ripple calculations with different centers:
```cg
float ripple1 = sin(dist1 * _RippleFrequency - _Time.y * _RippleSpeed);
float ripple2 = sin(dist2 * _RippleFrequency - _Time.y * _RippleSpeed);
float finalRipple = (ripple1 + ripple2) * 0.5 * _RippleAmplitude;
```

## Troubleshooting / 故障排除

**Problem**: Shader doesn't appear or shows pink material  
**Solution**: Make sure the shader file is correctly placed in the Assets/Shaders folder and Unity has compiled it without errors.

**问题**：着色器未出现或显示粉红色材质  
**解决方案**：确保着色器文件正确放置在Assets/Shaders文件夹中，并且Unity已正确编译它。

**Problem**: Ripples don't animate  
**Solution**: Ensure the object with this material is in Play mode. The animation uses Unity's `_Time` variable which only updates during play.

**问题**：波纹不动画  
**解决方案**：确保带有此材质的对象处于播放模式。动画使用Unity的`_Time`变量，该变量仅在播放期间更新。

**Problem**: Effect too subtle or too strong  
**Solution**: Adjust the amplitude and frequency parameters to control the intensity of the effect.

**问题**：效果太微弱或太强烈  
**解决方案**：调整振幅和频率参数以控制效果的强度。

## License / 许可证

This shader is part of the ET Framework project and follows the same license as the main project.

此着色器是ET框架项目的一部分，遵循与主项目相同的许可证。

## Credits / 致谢

Created for the ET Framework Unity project.
为ET框架Unity项目创建。
