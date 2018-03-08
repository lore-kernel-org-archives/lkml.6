Return-Path: <leo.wen@rock-chips.com>
X-Google-Smtp-Source: AG47ELuOvEU/YbhRKGKhITe6Ll1aClpTqgE7o5l+TK7oHxhsBAir0GGjUnmdOY9Ga7D4n0MaydSX
ARC-Seal: i=1; a=rsa-sha256; t=1520469976; cv=none;
        d=google.com; s=arc-20160816;
        b=I150mn+rYVtN4codU3cXt6XdE0f7M1RJYFEt/Zl42sVsUyerTE6YfTy0vVcbzQd/y5
         Ugef2poF6p3sfEv9x3ycVKzibrIRGT5/PdedndX26D/XR3O+tfH8KHugv/s9D2si6Hyv
         LE1X57JClbjiEEJPhet48nCr9uR2OmS05K6yNoInHAU/qC4eYcLm636hlWM+bkugMQiY
         kEFIBll6PoMhzPPkqsxBr/LtgHWwK03dfcre8WgT4K3idli5PVT6J8fjke7c/VxtfE5g
         VhmAf6C7QosWPnTN8vh7Xq1Y/ZtpHs4Wok4aal62UBUgXiKxtoAWtZSIu2Yqgil7jppa
         OFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=gYpzgVhDZbakqEpWPJz0I6uH2KAlOHUB0d4M26p9HfY=;
        b=mpdvwxvhkKsiYf+p3aQAxcvcy5jGq7nRPOSVModBI5F/OPlo+HU394sJnuEN9xF81O
         iT5Fn4xLg4/madrf1B+0OqGPevbZgGqaavvnnbBWnfLuiGiBCdGdJgtwt92exlOmP14m
         7ZS+6qQcbyi7D3SnTntRuWZiU0B6D2iq2R2uDVCivQA9xYLYKnC+HmPkzQsu0Tl2eyWf
         X+PSEBT76l5q32f9W9rCsNONgOIYB4VbYPK19LzPHwBZtjHkoYG8LbcTitNFKWSlLpnJ
         7XdsVtTErYDpey9/wdbX41p0bDmLzRnl0kYa8uydM4zUdsrLGnZ/TnHS3lBhWZ/p8cBx
         y+Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.137 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.137 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: leo.wen@rock-chips.com
X-FST-TO: eddie.cai@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: leo.wen@rock-chips.com
X-UNIQUE-TAG: <e5924c07b979f74c7310b6cdf33d2659>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH V2 2/2] dt-bindings: Document the Rockchip RK1608 bindings
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: mchehab@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org, rdunlap@infradead.org, jacob2.chen@rock-chips.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 eddie.cai@rock-chips.com
References: <1519633504-64357-1-git-send-email-leo.wen@rock-chips.com>
 <20180307095308.5eo4mthzx2oujszn@valkosipuli.retiisi.org.uk>
From: leo <leo.wen@rock-chips.com>
Message-ID: <fab0e426-6686-b2e5-d607-a41a6c9f71e2@rock-chips.com>
Date: Thu, 8 Mar 2018 08:46:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307095308.5eo4mthzx2oujszn@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593451230041702429?=
X-GMAIL-MSGID: =?utf-8?q?1594328326331018752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi Sakari,

Thanks for your advice,  i'll revise it.
> Hi Wen,
>
> On Mon, Feb 26, 2018 at 04:25:04PM +0800, Wen Nuan wrote:
>> From: Leo Wen <leo.wen@rock-chips.com>
>>
>> Add DT bindings documentation for Rockchip RK1608.
>>
>> Changes V2:
>> - Delete spi-min-frequency property.
>> - Add the external sensor's control pin and clock properties.
>> - Delete the '&pinctrl' node.
>>
>> Signed-off-by: Leo Wen <leo.wen@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/media/rk1608.txt | 97 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  1 +
>>   2 files changed, 98 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/rk1608.txt
>>
>> diff --git a/Documentation/devicetree/bindings/media/rk1608.txt b/Documentation/devicetree/bindings/media/rk1608.txt
>> new file mode 100644
>> index 0000000..a9721a8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/rk1608.txt
>> @@ -0,0 +1,97 @@
>> +Rockchip RK1608 as a PreISP to link on Soc
>> +------------------------------------------
>> +
>> +Required properties:
>> +
>> +- compatible		: "rockchip,rk1608";
>> +- reg			: SPI slave address of the rk1608;
>> +- clocks		: Must contain an entry for each entry in clock-names;
>> +- clock-names		: Must contain "mclk" for the device's master clock;
>> +- reset-gpio		: GPIO connected to reset pin;
>> +- irq-gpio		: GPIO connected to irq pin;
>> +- sleepst-gpio		: GPIO connected to sleepst pin;
>> +- wakeup-gpio		: GPIO connected to wakeup pin;
>> +- powerdown-gpio	: GPIO connected to powerdown pin;
>> +- rockchip,powerdown0	: GPIO connected to the sensor0's powerdown pin;
>> +- rockchip,reset0	: GPIO connected to the sensor0's reset pin;
>> +- rockchip,powerdown1	: GPIO connected to the sensor1's powerdown pin;
>> +- rockchip,reset1	: GPIO connected to the sensor1's reset pin;
> Aren't these sensor's properties and not related to the ISP?
There not related to the ISP,  just connected to the external sensor0/1.
>
>> +- pinctrl-names		: Should contain only one value - "default";
>> +- pinctrl-0		: Pin control group to be used for this controller;
>> +
>> +Optional properties:
>> +
>> +- spi-max-frequency	: Maximum SPI clocking speed of the device;
>> +
>> +The device node should contain one 'port' child node with one child 'endpoint'
>> +node, according to the bindings defined in Documentation/devicetree/bindings/
>> +media/video-interfaces.txt. The following are properties specific to those
>> +nodes.
>> +
>> +endpoint node
>> +-------------
>> +
>> +- data-lanes : (optional) specifies MIPI CSI-2 data lanes as covered in
>> +	       video-interfaces.txt. If present it should be <1> - the device
>> +	       supports only one data lane without re-mapping.
>> +
>> +Note1: Since no data is generated in RK1608，so this is meaningful that you need
>> +a extra sensor (such as a camera) mounted on RK1608. You need to use endpoint@x
>> +to match these sensors.
>> +
>> +Note2:You must set the current value of the spi pins to be 8mA, if they are not.
>> +
>> +Example:
>> +&spi0 {
>> +	status = "okay";
>> +	spi_rk1608@00 {
>> +		compatible =  "rockchip,rk1608";
>> +		status = "okay";
>> +		reg = <0>;
>> +		spi-max-frequency = <24000000>;
>> +		link-freqs = /bits/ 64 <400000000>;
>> +		clocks = <&cru SCLK_SPI0>, <&cru SCLK_VIP_OUT>,
>> +		<&cru DCLK_VOP0>, <&cru ACLK_VIP>, <&cru HCLK_VIP>,
>> +		<&cru PCLK_ISP_IN>, <&cru PCLK_ISP_IN>,
>> +		<&cru PCLK_ISP_IN>, <&cru SCLK_MIPIDSI_24M>,
>> +		<&cru PCLK_MIPI_CSI>;
>> +		clock-names = "mclk", "mipi_clk",  "pd_cif", "aclk_cif",
>> +			"hclk_cif", "cif0_in", "g_pclkin_cif",
>> +			"cif0_out", "clk_mipi_24m", "hclk_mipiphy";
>> +		reset-gpio = <&gpio6 0 GPIO_ACTIVE_HIGH>;
>> +		irq-gpio = <&gpio6 2 GPIO_ACTIVE_HIGH>;
>> +		sleepst-gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
>> +		wakeup-gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;
>> +		powerdown-gpio = <&gpio8 0 GPIO_ACTIVE_HIGH>;
>> +
>> +		rockchip,powerdown1 = <&gpio5 9 GPIO_ACTIVE_HIGH>;
>> +		rockchip,reset1 = <&gpio6 8 GPIO_ACTIVE_HIGH>;
>> +
>> +		rockchip,powerdown0 = <&gpio5 8 GPIO_ACTIVE_HIGH>;
>> +		rockchip,reset0 = <&gpio6 7 GPIO_ACTIVE_HIGH>;
>> +
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&rk1608_irq_gpios &rk1608_wake_gpios
>> +			     &rk1608_sleep_gpios>;
>> +
>> +		port@0 {
>> +			mipi_dphy_out: endpoint {
>> +				remote-endpoint = <&mipi_dphy_in>;
>> +				clock-lanes = <0>;
>> +				data-lanes = <1 2 3 4>;
>> +				clock-noncontinuous;
>> +				link-frequencies =
>> +					/bits/ 64 <400000000>;
>> +			};
>> +		};
>> +		/* Example: we have two cameras */
> What determines which one is active? The documentation above states there
> may only be a single endpoint per port. And a single port only, not two as
> you have here.
>
I'm  sorry , i wrote the wrongcommend.
There can be a lot of it on every port.
If you just want sensor0 to be active, delete the 'sensor_in1' node.
>> +		port@1 {
>> +			sensor_in0: endpoint@0 {
>> +				remote-endpoint = <&sensor_out0>;
>> +			};
>> +			sensor_in1: endpoint@1 {
>> +				remote-endpoint = <&sensor_out1>;
>> +			};
>> +		};
>> +	};
>> +};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b2a98e3..04d227b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -141,6 +141,7 @@ M:	Leo Wen <leo.wen@rock-chips.com>
>>   S:	Maintained
>>   F:	drivers/media/spi/rk1608.c
>>   F:	drivers/media/spi/rk1608.h
>> +F:	Documentation/devicetree/bindings/media/rk1608.txt
>>   
>>   3C59X NETWORK DRIVER
>>   M:	Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
