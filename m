Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDQO02 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:26:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44606 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDQO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:26:25 -0400
X-Google-Smtp-Source: AIpwx48KBxBB/vF95TPNSIQNgjhCpfqrNdoCrf3StUG/3bqO/Brh0ODeuR1AuAPeqBk4I/NWDJLDkA==
Subject: Re: [PATCH v4 6/6] arm: dts: mediatek: modify audio related nodes for
 both MT2701 and MT7623
To: Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>
References: <cover.1520327262.git.ryder.lee@mediatek.com>
 <a431bb8f9c203227b14845058a27d690691d0c20.1520327262.git.ryder.lee@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5195afaf-b386-2380-1de8-232c1260604d@gmail.com>
Date: Tue, 17 Apr 2018 16:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a431bb8f9c203227b14845058a27d690691d0c20.1520327262.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2018 10:09 AM, Ryder Lee wrote:
> Modify audio related nodes to reflect the actual usage in binding documents.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---

applied to v4.17-next/dts32

Thanks!

>  arch/arm/boot/dts/mt2701.dtsi | 188 ++++++++++++++++++++---------------------
>  arch/arm/boot/dts/mt7623.dtsi | 190 ++++++++++++++++++++----------------------
>  2 files changed, 182 insertions(+), 196 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 05557fc..05cf65c 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -426,104 +426,96 @@
>  		status = "disabled";
>  	};
>  
> -	afe: audio-controller@11220000 {
> -		compatible = "mediatek,mt2701-audio";
> -		reg = <0 0x11220000 0 0x2000>,
> -		      <0 0x112a0000 0 0x20000>;
> -		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> -			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-names	= "afe", "asys";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> -
> -		clocks = <&infracfg CLK_INFRA_AUDIO>,
> -			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> -			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> -			 <&topckgen CLK_TOP_AUD_MUX1_DIV>,
> -			 <&topckgen CLK_TOP_AUD_MUX2_DIV>,
> -			 <&topckgen CLK_TOP_AUD_48K_TIMING>,
> -			 <&topckgen CLK_TOP_AUD_44K_TIMING>,
> -			 <&topckgen CLK_TOP_AUDPLL_MUX_SEL>,
> -			 <&topckgen CLK_TOP_APLL_SEL>,
> -			 <&topckgen CLK_TOP_AUD1PLL_98M>,
> -			 <&topckgen CLK_TOP_AUD2PLL_90M>,
> -			 <&topckgen CLK_TOP_HADDS2PLL_98M>,
> -			 <&topckgen CLK_TOP_HADDS2PLL_294M>,
> -			 <&topckgen CLK_TOP_AUDPLL>,
> -			 <&topckgen CLK_TOP_AUDPLL_D4>,
> -			 <&topckgen CLK_TOP_AUDPLL_D8>,
> -			 <&topckgen CLK_TOP_AUDPLL_D16>,
> -			 <&topckgen CLK_TOP_AUDPLL_D24>,
> -			 <&topckgen CLK_TOP_AUDINTBUS_SEL>,
> -			 <&clk26m>,
> -			 <&topckgen CLK_TOP_SYSPLL1_D4>,
> -			 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K5_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K6_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K5_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K6_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S5_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S6_MCLK>,
> -			 <&topckgen CLK_TOP_ASM_M_SEL>,
> -			 <&topckgen CLK_TOP_ASM_H_SEL>,
> -			 <&topckgen CLK_TOP_UNIVPLL2_D4>,
> -			 <&topckgen CLK_TOP_UNIVPLL2_D2>,
> -			 <&topckgen CLK_TOP_SYSPLL_D5>;
> -
> -		clock-names = "infra_sys_audio_clk",
> -			 "top_audio_mux1_sel",
> -			 "top_audio_mux2_sel",
> -			 "top_audio_mux1_div",
> -			 "top_audio_mux2_div",
> -			 "top_audio_48k_timing",
> -			 "top_audio_44k_timing",
> -			 "top_audpll_mux_sel",
> -			 "top_apll_sel",
> -			 "top_aud1_pll_98M",
> -			 "top_aud2_pll_90M",
> -			 "top_hadds2_pll_98M",
> -			 "top_hadds2_pll_294M",
> -			 "top_audpll",
> -			 "top_audpll_d4",
> -			 "top_audpll_d8",
> -			 "top_audpll_d16",
> -			 "top_audpll_d24",
> -			 "top_audintbus_sel",
> -			 "clk_26m",
> -			 "top_syspll1_d4",
> -			 "top_aud_k1_src_sel",
> -			 "top_aud_k2_src_sel",
> -			 "top_aud_k3_src_sel",
> -			 "top_aud_k4_src_sel",
> -			 "top_aud_k5_src_sel",
> -			 "top_aud_k6_src_sel",
> -			 "top_aud_k1_src_div",
> -			 "top_aud_k2_src_div",
> -			 "top_aud_k3_src_div",
> -			 "top_aud_k4_src_div",
> -			 "top_aud_k5_src_div",
> -			 "top_aud_k6_src_div",
> -			 "top_aud_i2s1_mclk",
> -			 "top_aud_i2s2_mclk",
> -			 "top_aud_i2s3_mclk",
> -			 "top_aud_i2s4_mclk",
> -			 "top_aud_i2s5_mclk",
> -			 "top_aud_i2s6_mclk",
> -			 "top_asm_m_sel",
> -			 "top_asm_h_sel",
> -			 "top_univpll2_d4",
> -			 "top_univpll2_d2",
> -			 "top_syspll_d5";
> +	audsys: clock-controller@11220000 {
> +		compatible = "mediatek,mt2701-audsys", "syscon";
> +		reg = <0 0x11220000 0 0x2000>;
> +		#clock-cells = <1>;
> +
> +		afe: audio-controller {
> +			compatible = "mediatek,mt2701-audio";
> +			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names	= "afe", "asys";
> +			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +
> +			clocks = <&infracfg CLK_INFRA_AUDIO>,
> +				 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +				 <&topckgen CLK_TOP_AUD_48K_TIMING>,
> +				 <&topckgen CLK_TOP_AUD_44K_TIMING>,
> +				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
> +				 <&audsys CLK_AUD_I2SO1>,
> +				 <&audsys CLK_AUD_I2SO2>,
> +				 <&audsys CLK_AUD_I2SO3>,
> +				 <&audsys CLK_AUD_I2SO4>,
> +				 <&audsys CLK_AUD_I2SIN1>,
> +				 <&audsys CLK_AUD_I2SIN2>,
> +				 <&audsys CLK_AUD_I2SIN3>,
> +				 <&audsys CLK_AUD_I2SIN4>,
> +				 <&audsys CLK_AUD_ASRCO1>,
> +				 <&audsys CLK_AUD_ASRCO2>,
> +				 <&audsys CLK_AUD_ASRCO3>,
> +				 <&audsys CLK_AUD_ASRCO4>,
> +				 <&audsys CLK_AUD_AFE>,
> +				 <&audsys CLK_AUD_AFE_CONN>,
> +				 <&audsys CLK_AUD_A1SYS>,
> +				 <&audsys CLK_AUD_A2SYS>,
> +				 <&audsys CLK_AUD_AFE_MRGIF>;
> +
> +			clock-names = "infra_sys_audio_clk",
> +				      "top_audio_mux1_sel",
> +				      "top_audio_mux2_sel",
> +				      "top_audio_a1sys_hp",
> +				      "top_audio_a2sys_hp",
> +				      "i2s0_src_sel",
> +				      "i2s1_src_sel",
> +				      "i2s2_src_sel",
> +				      "i2s3_src_sel",
> +				      "i2s0_src_div",
> +				      "i2s1_src_div",
> +				      "i2s2_src_div",
> +				      "i2s3_src_div",
> +				      "i2s0_mclk_en",
> +				      "i2s1_mclk_en",
> +				      "i2s2_mclk_en",
> +				      "i2s3_mclk_en",
> +				      "i2so0_hop_ck",
> +				      "i2so1_hop_ck",
> +				      "i2so2_hop_ck",
> +				      "i2so3_hop_ck",
> +				      "i2si0_hop_ck",
> +				      "i2si1_hop_ck",
> +				      "i2si2_hop_ck",
> +				      "i2si3_hop_ck",
> +				      "asrc0_out_ck",
> +				      "asrc1_out_ck",
> +				      "asrc2_out_ck",
> +				      "asrc3_out_ck",
> +				      "audio_afe_pd",
> +				      "audio_afe_conn_pd",
> +				      "audio_a1sys_pd",
> +				      "audio_a2sys_pd",
> +				      "audio_mrgif_pd";
> +
> +			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
> +					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
> +						 <&topckgen CLK_TOP_AUD2PLL_90M>;
> +			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
> +		};
>  	};
>  
>  	mmsys: syscon@14000000 {
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index b750da5..e4dd31d 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -538,105 +538,99 @@
>  		status = "disabled";
>  	};
>  
> -	afe: audio-controller@11220000 {
> -		compatible = "mediatek,mt7623-audio",
> -			     "mediatek,mt2701-audio";
> -		reg = <0 0x11220000 0 0x2000>,
> -		      <0 0x112a0000 0 0x20000>;
> -		interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> -			      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-names	= "afe", "asys";
> -		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +	audsys: clock-controller@11220000 {
> +		compatible = "mediatek,mt7623-audsys",
> +			     "mediatek,mt2701-audsys",
> +			     "syscon";
> +		reg = <0 0x11220000 0 0x2000>;
> +		#clock-cells = <1>;
>  
> -		clocks = <&infracfg CLK_INFRA_AUDIO>,
> -			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> -			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> -			 <&topckgen CLK_TOP_AUD_MUX1_DIV>,
> -			 <&topckgen CLK_TOP_AUD_MUX2_DIV>,
> -			 <&topckgen CLK_TOP_AUD_48K_TIMING>,
> -			 <&topckgen CLK_TOP_AUD_44K_TIMING>,
> -			 <&topckgen CLK_TOP_AUDPLL_MUX_SEL>,
> -			 <&topckgen CLK_TOP_APLL_SEL>,
> -			 <&topckgen CLK_TOP_AUD1PLL_98M>,
> -			 <&topckgen CLK_TOP_AUD2PLL_90M>,
> -			 <&topckgen CLK_TOP_HADDS2PLL_98M>,
> -			 <&topckgen CLK_TOP_HADDS2PLL_294M>,
> -			 <&topckgen CLK_TOP_AUDPLL>,
> -			 <&topckgen CLK_TOP_AUDPLL_D4>,
> -			 <&topckgen CLK_TOP_AUDPLL_D8>,
> -			 <&topckgen CLK_TOP_AUDPLL_D16>,
> -			 <&topckgen CLK_TOP_AUDPLL_D24>,
> -			 <&topckgen CLK_TOP_AUDINTBUS_SEL>,
> -			 <&clk26m>,
> -			 <&topckgen CLK_TOP_SYSPLL1_D4>,
> -			 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K5_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K6_SRC_SEL>,
> -			 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K5_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_K6_SRC_DIV>,
> -			 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S5_MCLK>,
> -			 <&topckgen CLK_TOP_AUD_I2S6_MCLK>,
> -			 <&topckgen CLK_TOP_ASM_M_SEL>,
> -			 <&topckgen CLK_TOP_ASM_H_SEL>,
> -			 <&topckgen CLK_TOP_UNIVPLL2_D4>,
> -			 <&topckgen CLK_TOP_UNIVPLL2_D2>,
> -			 <&topckgen CLK_TOP_SYSPLL_D5>;
> -
> -		clock-names = "infra_sys_audio_clk",
> -			 "top_audio_mux1_sel",
> -			 "top_audio_mux2_sel",
> -			 "top_audio_mux1_div",
> -			 "top_audio_mux2_div",
> -			 "top_audio_48k_timing",
> -			 "top_audio_44k_timing",
> -			 "top_audpll_mux_sel",
> -			 "top_apll_sel",
> -			 "top_aud1_pll_98M",
> -			 "top_aud2_pll_90M",
> -			 "top_hadds2_pll_98M",
> -			 "top_hadds2_pll_294M",
> -			 "top_audpll",
> -			 "top_audpll_d4",
> -			 "top_audpll_d8",
> -			 "top_audpll_d16",
> -			 "top_audpll_d24",
> -			 "top_audintbus_sel",
> -			 "clk_26m",
> -			 "top_syspll1_d4",
> -			 "top_aud_k1_src_sel",
> -			 "top_aud_k2_src_sel",
> -			 "top_aud_k3_src_sel",
> -			 "top_aud_k4_src_sel",
> -			 "top_aud_k5_src_sel",
> -			 "top_aud_k6_src_sel",
> -			 "top_aud_k1_src_div",
> -			 "top_aud_k2_src_div",
> -			 "top_aud_k3_src_div",
> -			 "top_aud_k4_src_div",
> -			 "top_aud_k5_src_div",
> -			 "top_aud_k6_src_div",
> -			 "top_aud_i2s1_mclk",
> -			 "top_aud_i2s2_mclk",
> -			 "top_aud_i2s3_mclk",
> -			 "top_aud_i2s4_mclk",
> -			 "top_aud_i2s5_mclk",
> -			 "top_aud_i2s6_mclk",
> -			 "top_asm_m_sel",
> -			 "top_asm_h_sel",
> -			 "top_univpll2_d4",
> -			 "top_univpll2_d2",
> -			 "top_syspll_d5";
> +		afe: audio-controller {
> +			compatible = "mediatek,mt7623-audio",
> +				     "mediatek,mt2701-audio";
> +			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names	= "afe", "asys";
> +			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +
> +			clocks = <&infracfg CLK_INFRA_AUDIO>,
> +				 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +				 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +				 <&topckgen CLK_TOP_AUD_48K_TIMING>,
> +				 <&topckgen CLK_TOP_AUD_44K_TIMING>,
> +				 <&topckgen CLK_TOP_AUD_K1_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K2_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K3_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K4_SRC_SEL>,
> +				 <&topckgen CLK_TOP_AUD_K1_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K2_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K3_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_K4_SRC_DIV>,
> +				 <&topckgen CLK_TOP_AUD_I2S1_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S2_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S3_MCLK>,
> +				 <&topckgen CLK_TOP_AUD_I2S4_MCLK>,
> +				 <&audsys CLK_AUD_I2SO1>,
> +				 <&audsys CLK_AUD_I2SO2>,
> +				 <&audsys CLK_AUD_I2SO3>,
> +				 <&audsys CLK_AUD_I2SO4>,
> +				 <&audsys CLK_AUD_I2SIN1>,
> +				 <&audsys CLK_AUD_I2SIN2>,
> +				 <&audsys CLK_AUD_I2SIN3>,
> +				 <&audsys CLK_AUD_I2SIN4>,
> +				 <&audsys CLK_AUD_ASRCO1>,
> +				 <&audsys CLK_AUD_ASRCO2>,
> +				 <&audsys CLK_AUD_ASRCO3>,
> +				 <&audsys CLK_AUD_ASRCO4>,
> +				 <&audsys CLK_AUD_AFE>,
> +				 <&audsys CLK_AUD_AFE_CONN>,
> +				 <&audsys CLK_AUD_A1SYS>,
> +				 <&audsys CLK_AUD_A2SYS>,
> +				 <&audsys CLK_AUD_AFE_MRGIF>;
> +
> +			clock-names = "infra_sys_audio_clk",
> +				      "top_audio_mux1_sel",
> +				      "top_audio_mux2_sel",
> +				      "top_audio_a1sys_hp",
> +				      "top_audio_a2sys_hp",
> +				      "i2s0_src_sel",
> +				      "i2s1_src_sel",
> +				      "i2s2_src_sel",
> +				      "i2s3_src_sel",
> +				      "i2s0_src_div",
> +				      "i2s1_src_div",
> +				      "i2s2_src_div",
> +				      "i2s3_src_div",
> +				      "i2s0_mclk_en",
> +				      "i2s1_mclk_en",
> +				      "i2s2_mclk_en",
> +				      "i2s3_mclk_en",
> +				      "i2so0_hop_ck",
> +				      "i2so1_hop_ck",
> +				      "i2so2_hop_ck",
> +				      "i2so3_hop_ck",
> +				      "i2si0_hop_ck",
> +				      "i2si1_hop_ck",
> +				      "i2si2_hop_ck",
> +				      "i2si3_hop_ck",
> +				      "asrc0_out_ck",
> +				      "asrc1_out_ck",
> +				      "asrc2_out_ck",
> +				      "asrc3_out_ck",
> +				      "audio_afe_pd",
> +				      "audio_afe_conn_pd",
> +				      "audio_a1sys_pd",
> +				      "audio_a2sys_pd",
> +				      "audio_mrgif_pd";
> +
> +			assigned-clocks = <&topckgen CLK_TOP_AUD_MUX1_SEL>,
> +					  <&topckgen CLK_TOP_AUD_MUX2_SEL>,
> +					  <&topckgen CLK_TOP_AUD_MUX1_DIV>,
> +					  <&topckgen CLK_TOP_AUD_MUX2_DIV>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL_98M>,
> +						 <&topckgen CLK_TOP_AUD2PLL_90M>;
> +			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
> +		};
>  	};
>  
>  	mmc0: mmc@11230000 {
> 
