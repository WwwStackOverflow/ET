Shader "Custom/WaterRipple"
{
    Properties
    {
        _MainTex ("Base Texture", 2D) = "white" {}
        _Color ("Water Color", Color) = (0.2, 0.5, 0.8, 0.8)
        _RippleSpeed ("Ripple Speed", Range(0, 10)) = 2.0
        _RippleFrequency ("Ripple Frequency", Range(0, 20)) = 5.0
        _RippleAmplitude ("Ripple Amplitude", Range(0, 0.5)) = 0.1
        _WaveSpeed ("Wave Speed", Range(0, 5)) = 1.0
        _WaveAmplitude ("Wave Amplitude", Range(0, 0.2)) = 0.05
        _Transparency ("Transparency", Range(0, 1)) = 0.8
    }
    
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100
        
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        Cull Back
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 worldPos : TEXCOORD1;
            };
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            float _RippleSpeed;
            float _RippleFrequency;
            float _RippleAmplitude;
            float _WaveSpeed;
            float _WaveAmplitude;
            float _Transparency;
            
            v2f vert (appdata v)
            {
                v2f o;
                
                // Calculate world position for ripple effect
                float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                float dist = length(worldPos.xz);
                float ripple = sin(dist * _RippleFrequency - _Time.y * _RippleSpeed) * _RippleAmplitude;
                
                // Add wave effect
                float wave = sin(v.vertex.x * 3.0 + _Time.y * _WaveSpeed) * _WaveAmplitude;
                
                // Apply displacement to vertex
                v.vertex.y += ripple + wave;
                
                // Calculate final world position after displacement
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                // Sample texture
                fixed4 texColor = tex2D(_MainTex, i.uv);
                
                // Create animated ripple pattern in fragment shader for more detail
                float2 center = float2(0.5, 0.5);
                float dist = distance(i.uv, center);
                float ripple = sin(dist * _RippleFrequency * 10.0 - _Time.y * _RippleSpeed * 3.0) * 0.5 + 0.5;
                
                // Mix with water color
                fixed4 finalColor = texColor * _Color;
                finalColor.rgb += ripple * 0.2;
                
                // Apply transparency
                finalColor.a = _Color.a * _Transparency;
                
                return finalColor;
            }
            ENDCG
        }
    }
    
    FallBack "Transparent/Diffuse"
}
