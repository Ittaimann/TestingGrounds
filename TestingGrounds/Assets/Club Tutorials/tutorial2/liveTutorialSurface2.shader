shader "live/surface"
{
    Properties
    {
        _MainTex("this is the main texture", 2D )="white"{}
        _mainCOlor("this is the main color",color)=(1,1,1,1)
    }

    Subshader
    {
        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        float4 _mainCOlor;

     struct Input
     {
         float2 uv_MainTex;
     };

     void surf(Input IN, inout SurfaceOutputStandard o)
     {
       	fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
		o.Albedo = c.rgb;
        o.Emission= _mainCOlor;
         o.Alpha = c.a;
     }
     ENDCG
    }
}