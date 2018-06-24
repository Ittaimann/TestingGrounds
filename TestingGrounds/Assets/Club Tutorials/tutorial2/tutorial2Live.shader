Shader "liveDemo/whatever"
{
    Properties
    {
        _mainTex("this is the main texture", 2D )="white"{}
        _mainCOlor("this is the main color",color)=(1,1,1,1)
    }
    Subshader
    {
        pass// hey draw it
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct Appdata
            {
                float4 pos: POSITION;
                float2 uv: TEXCOORD0;
            };

            struct v2f
            {
                float4 pos: SV_POSITION;
                float2 uv: TEXCOORD0;
            };
            sampler2D _mainTex;
            float4 _mainCOlor,_mainTex_ST;

            v2f vert(Appdata i)
            {
                v2f o;
                o.pos= UnityObjectToClipPos(i.pos);
                o.uv=TRANSFORM_TEX(i.uv,_mainTex);
                return o;
            };

            float4 frag(v2f i): SV_TARGET
            {
                float4 c=tex2D(_mainTex,i.uv);
                return c*_mainCOlor;
            };

            ENDCG
        }
    }
}
