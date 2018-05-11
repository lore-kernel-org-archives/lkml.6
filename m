Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeEKQ4J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:56:09 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45185 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:56:06 -0400
X-Google-Smtp-Source: AB8JxZpRFegLkk9feQxpYlRXcJXSZpZQ+5hDUIJSyogVU9pYRTGgJa8SpcW5V5qDyVC47uD+Ln7tpQ==
Subject: Re: [PATCH 2/2] arm64: dts: mt7622: add audio related device nodes
To: Sean Wang <sean.wang@mediatek.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryder Lee <ryder.lee@mediatek.com>
References: <d208e8cf93f18b97ee9cf24cdd0220aa44188b8b.1525231985.git.sean.wang@mediatek.com>
 <e48bc87f54d7f2e06664ee358822aa9a9e34256b.1525231985.git.sean.wang@mediatek.com>
 <1525233238.14792.14.camel@mtkswgap22>
From: Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <626c6741-00cd-c125-07f9-cfbbdbe36db4@gmail.com>
Date: Fri, 11 May 2018 18:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525233238.14792.14.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/02/2018 05:53 AM, Sean Wang wrote:
> Hi, Matthias
> 
> On Wed, 2018-05-02 at 11:41 +0800, sean.wang@mediatek.com wrote:
>> From: Ryder Lee <ryder.lee@mediatek.com>
>>
>> Add audio device nodes and its proper setup for all used pins
>>
>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 11 +++-
>>  arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 89 ++++++++++++++++++++++++++++
>>  2 files changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
>> index 45d8655..b783764 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
>> @@ -18,7 +18,7 @@
>>  	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
>>  
>>  	chosen {
>> -		bootargs = "console=ttyS0,115200n1";
>> +		bootargs = "console=ttyS0,115200n1 swiotlb=512";
>>  	};
>>  
>>  	cpus {
>> @@ -163,10 +163,17 @@
>>  	i2s1_pins: i2s1-pins {
>>  		mux {
>>  			function = "i2s";
>> -			groups =  "i2s_out_bclk_ws_mclk",
>> +			groups =  "i2s_out_mclk_bclk_ws",
> 
> The old one ("i2s_out_bclk_ws_mclk") should be the indecisive value when
> I initially worked on the pinctrl device.
> 
> It has to be corrected with "i2s_out_mclk_bclk_ws" to comply with the
> final dt-bindings.
> 
>>  				  "i2s1_in_data",
>>  				  "i2s1_out_data";
>>  		};
>> +
>> +		conf {
>> +			pins = "I2S1_IN", "I2S1_OUT", "I2S_BCLK",
>> +			       "I2S_WS", "I2S_MCLK";
>> +			drive-strength = <12>;
>> +			bias-pull-down;
>> +		};
>>  	};
>>  
>>  	irrx_pins: irrx-pins {
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>> index 6bbabb6..9213c96 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>> @@ -527,6 +527,95 @@
>>  		status = "disabled";
>>  	};
>>  
>> +	audsys: clock-controller@11220000 {
>> +		compatible = "mediatek,mt7622-audsys", "syscon";
>> +		reg = <0 0x11220000 0 0x2000>;
>> +		#clock-cells = <1>;
> 
> The binding have been through broonie/sound.git around a week ago
> 

Thanks for the clarifications!
Pushed to v4.17-next/dts64

Regards,
Matthias

>> +
>> +		afe: audio-controller {
>> +			compatible = "mediatek,mt7622-audio";
>> +			interrupts =  <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW>,
>> +				      <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
>> +			interrupt-names	= "afe", "asys";
>> +
>> +			clocks = <&infracfg CLK_INFRA_AUDIO_PD>,
>> +				 <&topckgen CLK_TOP_AUD1_SEL>,
>> +				 <&topckgen CLK_TOP_AUD2_SEL>,
>> +				 <&topckgen CLK_TOP_A1SYS_HP_DIV_PD>,
>> +				 <&topckgen CLK_TOP_A2SYS_HP_DIV_PD>,
>> +				 <&topckgen CLK_TOP_I2S0_MCK_SEL>,
>> +				 <&topckgen CLK_TOP_I2S1_MCK_SEL>,
>> +				 <&topckgen CLK_TOP_I2S2_MCK_SEL>,
>> +				 <&topckgen CLK_TOP_I2S3_MCK_SEL>,
>> +				 <&topckgen CLK_TOP_I2S0_MCK_DIV>,
>> +				 <&topckgen CLK_TOP_I2S1_MCK_DIV>,
>> +				 <&topckgen CLK_TOP_I2S2_MCK_DIV>,
>> +				 <&topckgen CLK_TOP_I2S3_MCK_DIV>,
>> +				 <&topckgen CLK_TOP_I2S0_MCK_DIV_PD>,
>> +				 <&topckgen CLK_TOP_I2S1_MCK_DIV_PD>,
>> +				 <&topckgen CLK_TOP_I2S2_MCK_DIV_PD>,
>> +				 <&topckgen CLK_TOP_I2S3_MCK_DIV_PD>,
>> +				 <&audsys CLK_AUDIO_I2SO1>,
>> +				 <&audsys CLK_AUDIO_I2SO2>,
>> +				 <&audsys CLK_AUDIO_I2SO3>,
>> +				 <&audsys CLK_AUDIO_I2SO4>,
>> +				 <&audsys CLK_AUDIO_I2SIN1>,
>> +				 <&audsys CLK_AUDIO_I2SIN2>,
>> +				 <&audsys CLK_AUDIO_I2SIN3>,
>> +				 <&audsys CLK_AUDIO_I2SIN4>,
>> +				 <&audsys CLK_AUDIO_ASRCO1>,
>> +				 <&audsys CLK_AUDIO_ASRCO2>,
>> +				 <&audsys CLK_AUDIO_ASRCO3>,
>> +				 <&audsys CLK_AUDIO_ASRCO4>,
>> +				 <&audsys CLK_AUDIO_AFE>,
>> +				 <&audsys CLK_AUDIO_AFE_CONN>,
>> +				 <&audsys CLK_AUDIO_A1SYS>,
>> +				 <&audsys CLK_AUDIO_A2SYS>;
>> +
>> +			clock-names = "infra_sys_audio_clk",
>> +				      "top_audio_mux1_sel",
>> +				      "top_audio_mux2_sel",
>> +				      "top_audio_a1sys_hp",
>> +				      "top_audio_a2sys_hp",
>> +				      "i2s0_src_sel",
>> +				      "i2s1_src_sel",
>> +				      "i2s2_src_sel",
>> +				      "i2s3_src_sel",
>> +				      "i2s0_src_div",
>> +				      "i2s1_src_div",
>> +				      "i2s2_src_div",
>> +				      "i2s3_src_div",
>> +				      "i2s0_mclk_en",
>> +				      "i2s1_mclk_en",
>> +				      "i2s2_mclk_en",
>> +				      "i2s3_mclk_en",
>> +				      "i2so0_hop_ck",
>> +				      "i2so1_hop_ck",
>> +				      "i2so2_hop_ck",
>> +				      "i2so3_hop_ck",
>> +				      "i2si0_hop_ck",
>> +				      "i2si1_hop_ck",
>> +				      "i2si2_hop_ck",
>> +				      "i2si3_hop_ck",
>> +				      "asrc0_out_ck",
>> +				      "asrc1_out_ck",
>> +				      "asrc2_out_ck",
>> +				      "asrc3_out_ck",
>> +				      "audio_afe_pd",
>> +				      "audio_afe_conn_pd",
>> +				      "audio_a1sys_pd",
>> +				      "audio_a2sys_pd";
>> +
>> +			assigned-clocks = <&topckgen CLK_TOP_A1SYS_HP_SEL>,
>> +					  <&topckgen CLK_TOP_A2SYS_HP_SEL>,
>> +					  <&topckgen CLK_TOP_A1SYS_HP_DIV>,
>> +					  <&topckgen CLK_TOP_A2SYS_HP_DIV>;
>> +			assigned-clock-parents = <&topckgen CLK_TOP_AUD1PLL>,
>> +						 <&topckgen CLK_TOP_AUD2PLL>;
>> +			assigned-clock-rates = <0>, <0>, <49152000>, <45158400>;
>> +		};
>> +	};
>> +
>>  	mmc0: mmc@11230000 {
>>  		compatible = "mediatek,mt7622-mmc";
>>  		reg = <0 0x11230000 0 0x1000>;
> 
> 
