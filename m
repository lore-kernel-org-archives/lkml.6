Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758690AbeD0Qdy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:33:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53072 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757565AbeD0Qdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:33:51 -0400
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 11/17] arm64: dts: r8a77965: Add VSP instances
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-12-kieran.bingham+renesas@ideasonboard.com>
 <1787243.JuNJAuBqMb@avalon>
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham+renesas@ideasonboard.com;
 prefer-encrypt=mutual; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <81161c97-2be8-2b5a-14a2-3db8709f5ff7@ideasonboard.com>
Date: Fri, 27 Apr 2018 17:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1787243.JuNJAuBqMb@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 26/04/18 22:11, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Thursday, 26 April 2018 19:53:40 EEST Kieran Bingham wrote:
>> The r8a77965 has 4 VSP instances.
>>
>> Based on a similar patch of the R8A7796 device tree
>> by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> [Kieran: Rebased to top of tree, fixed sort orders]
>> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 44 +++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>> b/arch/arm64/boot/dts/renesas/r8a77965.dtsi index
>> 1f44ed7c1b1c..e92e6b03333a 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
>> @@ -1009,6 +1009,17 @@
>>  			resets = <&cpg 615>;
>>  		};
>>
>> +		vspb: vsp@fe960000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfe960000 0 0x8000>;
>> +			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 626>;
>> +			power-domains = <&sysc R8A77965_PD_A3VP>;
>> +			resets = <&cpg 626>;
>> +
>> +			renesas,fcp = <&fcpvb0>;
>> +		};
>> +
>>  		fcpvb0: fcp@fe96f000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfe96f000 0 0x200>;
>> @@ -1017,6 +1028,17 @@
>>  			resets = <&cpg 607>;
>>  		};
>>
>> +		vspi0: vsp@fe9a0000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfe9a0000 0 0x8000>;
>> +			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 631>;
>> +			power-domains = <&sysc R8A77965_PD_A3VP>;
>> +			resets = <&cpg 631>;
>> +
>> +			renesas,fcp = <&fcpvi0>;
>> +		};
>> +
>>  		fcpvi0: fcp@fe9af000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfe9af000 0 0x200>;
>> @@ -1025,6 +1047,17 @@
>>  			resets = <&cpg 611>;
>>  		};
>>
>> +		vspd0: vsp@fea20000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfea20000 0 0x4000>;
> 
> RFP2 has a CLUT so the register range needs to be extended. I'd recommend 
> covering the entire space (0x8000) even if no LUT or CLU module is present.

Ah yes, of course.
Updated.

> 
>> +			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 623>;
>> +			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
>> +			resets = <&cpg 623>;
>> +
>> +			renesas,fcp = <&fcpvd0>;
>> +		};
>> +
>>  		fcpvd0: fcp@fea27000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfea27000 0 0x200>;
>> @@ -1033,6 +1066,17 @@
>>  			resets = <&cpg 603>;
>>  		};
>>
>> +		vspd1: vsp@fea28000 {
>> +			compatible = "renesas,vsp2";
>> +			reg = <0 0xfea28000 0 0x4000>;
> 
> Same here.
> 

And here...


> With this fixed,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Collected.

--
Kieran


> 
>> +			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 622>;
>> +			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
>> +			resets = <&cpg 622>;
>> +
>> +			renesas,fcp = <&fcpvd1>;
>> +		};
>> +
>>  		fcpvd1: fcp@fea2f000 {
>>  			compatible = "renesas,fcpv";
>>  			reg = <0 0xfea2f000 0 0x200>;
> 
> 
