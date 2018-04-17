Return-Path: <mgautam@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+V1Ivx6XqOp0zcCRyfSJr3z9S+7zSwmGShUyNG7Emc9Jn9HuIsWw8c+LydKAaUGYuamhQB
ARC-Seal: i=1; a=rsa-sha256; t=1523936398; cv=none;
        d=google.com; s=arc-20160816;
        b=kMzB3h8tVOEaTVCgV4fKEKeXnZZ+chDCsfQc1fsECUxAmcCQCpfZ9vJYBeZo0pQltc
         2AWlGBGus0jooSeWF3eoZGkBttcNZw+qkud77xtidz+eSuYhbGD2rzywk7/6C1DVnWpM
         eeuLmWr4G2H4cbghNlPbsnnlYaK7G1OvHFRDih6v+ElkpCivdViv1F0SjckV56gkpHur
         QH16tdNFD9Umq6p6Ijpju4BrspIe4WGkwdMUvK3RFUohbr1zj4zdu9NzzKh4KLocCLju
         vLEBxFRDWz5/7Sr2++mNBRPRajKEzXNMpIfUA64H2z6c1+3BpJNgOwfZxnenWOl7d+P3
         SfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/ZQQsha8XDB8mQWqcy2fspv+EI21lcf1UVDnUrlEwEM=;
        b=JEmIh+9cL+c9ftOEJJ9Z17GXyYdfyDtfaPAyceeMyxypomErdPbIjcJq/T8XSN3Hhn
         wwnhNJl1Nw0bkrRKpw8oqPw91y5P3U4ZKF0kxSm52RZw8LcYtBHl51qqG5gLFAt3kUFF
         GUi41T1S6LWK/irCSzb0VGWg90LXqACWtLwUMz1hGYVRxZ8UnPTjIekLsdodyAsEoqYL
         H5y+IulrMwYC8aVjHoXSdzDlgwDzmiOtpaqB3PPurSnJXVtxSwCzJJMKtSpUIzG50pbU
         GWnc4VEP6UKbEuVvD0g+CYrNgJrczlZ+7N+H9odNB8MImVGl2Xn5EvDVLmJ4NN/lGM5j
         EsoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eOwWT6yf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UIIp8cpq;
       spf=pass (google.com: domain of mgautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=mgautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eOwWT6yf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UIIp8cpq;
       spf=pass (google.com: domain of mgautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=mgautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D27696071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: Update documentation for
 Qualcomm DWC3 driver
To: Rob Herring <robh@kernel.org>
Cc: balbi@kernel.org, andy.gross@linaro.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
 <1523638285-5742-2-git-send-email-mgautam@codeaurora.org>
 <20180416203827.4jgevj4dgce6r3cq@rob-hp-laptop>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <850b4b09-2156-ef16-f4b8-9879923340c9@codeaurora.org>
Date: Tue, 17 Apr 2018 09:09:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416203827.4jgevj4dgce6r3cq@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597650577027023315?=
X-GMAIL-MSGID: =?utf-8?q?1597963133287423966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,


On 4/17/2018 2:08 AM, Rob Herring wrote:
> On Fri, Apr 13, 2018 at 10:21:22PM +0530, Manu Gautam wrote:
>> Existing documentation has lot of incorrect information as it
>> was originally added for a driver that no longer exists.
>>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  .../devicetree/bindings/usb/qcom,dwc3.txt          | 78 ++++++++++++++++------
>>  1 file changed, 57 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
>> index bc8a2fa..fdc574a 100644
>> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
>> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.txt
>> @@ -1,54 +1,90 @@
>>  Qualcomm SuperSpeed DWC3 USB SoC controller
>>  
>>  Required properties:
>> -- compatible:	should contain "qcom,dwc3"
>> +- compatible:		should contain "qcom,dwc3"
> Needs an SoC specific compatible string.

Thanks for review.
Sure. Will add that.

>
>> +- reg:			offset and length of register set for QSCRATCH wrapper
>> +- power-domains:	specifies a phandle to PM domain provider node
>>  - clocks:		A list of phandle + clock-specifier pairs for the
>>  				clocks listed in clock-names
>> -- clock-names:	Should contain the following:
>> +- clock-names:		Should contain the following:
>>    "core"		Master/Core clock, have to be >= 125 MHz for SS
>>  				operation and >= 60MHz for HS operation
>> +  "mock_utmi"		Mock utmi clock needed for ITP/SOF generation in
>> +				host mode. Its frequency should be 19.2MHz.
>> +  "sleep"		Sleep clock, used for wakeup when USB3 core goes
>> +				into low power mode (U3).
>>  
>>  Optional clocks:
>>    "iface"		System bus AXI clock.  Not present on all platforms
>> -  "sleep"		Sleep clock, used when USB3 core goes into low
>> -				power mode (U3).
>> +  "cfg_noc"		System Config NOC clock. Not present on all platforms
> These need to be specific as to which compatible properties have or 
> don't have these clocks.
ok

>
>> +- assigned-clocks:	should be:
>> +				MOCK_UTMI_CLK
>> +				MASTER_CLK
>> +- assigned-clock-rates: should be:
>> +                                19.2Mhz (192000000) for MOCK_UTMI_CLK
>> +                                >=125Mhz (125000000) for MASTER_CLK in SS mode
>> +                                >=60Mhz (60000000) for MASTER_CLK in HS mode
>> +
>> +Optional properties:
>> +- resets:		list of phandle and reset specifier pairs
> How many?
I will provide exact detail for each compatible property.
>
>> +- interrupts:		specifies interrupts from controller wrapper used
>> +			to wakeup from low power/susepnd state.	Must contain
>> +			one or more entry for interrupt-names property
>> +- interrupt-names:	Must include the following entries:
>> +			- "hs_phy_irq": The interrupt that is asserted when a
>> +			   wakeup event is received on USB2 bus
>> +			- "ss_phy_irq": The interrupt that is asserted when a
>> +			   wakeup event is received on USB3 bus
>> +			- "dm_hs_phy_irq" and "dp_hs_phy_irq": Separate
>> +			   interrupts for any wakeup event on DM and DP lines
> Sounds like the irqs are actually part of the PHYs? If so, then that's 
> where they should be in the DT.
No. These are actually part of controller wrapper called - qscratch which
has connectivity to phy outputs signals. Also, these are abstracted from PHY
and are present irrespective of type of phy present. I will add soc specific
info also in comments specifying which interrupts are not present on particular
soc/compatible.

>
>> +- qcom,select-utmi-as-pipe-clk: if present, disable USB3 pipe_clk requirement.
>> +				Used when dwc3 operates without SSPHY and only
>> +				HS/FS/LS modes are supported.
>>  
>>  Required child node:
>>  A child node must exist to represent the core DWC3 IP block. The name of
>>  the node is not important. The content of the node is defined in dwc3.txt.
>>  
>>  Phy documentation is provided in the following places:
>> -Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
>> +Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   - USB3 QMP PHY
>> +Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt - USB2 QUSB2 PHY
>>  
>>  Example device nodes:
>>  
>>  		hs_phy: phy@100f8800 {
>> -			compatible = "qcom,dwc3-hs-usb-phy";
>> -			reg = <0x100f8800 0x30>;
>> -			clocks = <&gcc USB30_0_UTMI_CLK>;
>> -			clock-names = "ref";
>> -			#phy-cells = <0>;
>> -
>> +			compatible = "qcom,qusb2-v2-phy";
>> +			...
>>  		};
>>  
>>  		ss_phy: phy@100f8830 {
>> -			compatible = "qcom,dwc3-ss-usb-phy";
>> -			reg = <0x100f8830 0x30>;
>> -			clocks = <&gcc USB30_0_MASTER_CLK>;
>> -			clock-names = "ref";
>> -			#phy-cells = <0>;
>> -
>> +			compatible = "qcom,qmp-v3-usb3-phy";
>> +			...
>>  		};
>>  
>> -		usb3_0: usb30@0 {
>> +		usb3_0: usb30@a6f8800 {
>>  			compatible = "qcom,dwc3";
>> +			reg = <0xa6f8800 0x400>;
>>  			#address-cells = <1>;
>>  			#size-cells = <1>;
>> -			clocks = <&gcc USB30_0_MASTER_CLK>;
>> -			clock-names = "core";
>> -
>>  			ranges;
>>  
>> +			interrupts = <0 131 0>, <0 486 0>, <0 488 0>, <0 489 0>;
>> +			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>> +				  "dm_hs_phy_irq", "dp_hs_phy_irq";
>> +
>> +			clocks = <&gcc GCC_USB30_PRIM_MASTER_CLK>,
>> +				<&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
>> +				<&gcc GCC_USB30_PRIM_SLEEP_CLK>;
>> +			clock-names = "core", "mock_utmi", "sleep";
>> +
>> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
>> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
>> +			assigned-clock-rates = <19200000>, <133000000>;
>> +
>> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
>> +			reset-names = "core_reset";
>> +			power-domains = <&gcc USB30_PRIM_GDSC>;
>> +			qcom,select-utmi-as-pipe-clk;
>>  
>>  			dwc3@10000000 {
>>  				compatible = "snps,dwc3";
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
