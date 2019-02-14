Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A07BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3323F222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438239AbfBNKPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:15:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36054 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727061AbfBNKPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:15:32 -0500
X-UUID: dc3eda013f9f4ee99774f18f5bad0ddd-20190214
X-UUID: dc3eda013f9f4ee99774f18f5bad0ddd-20190214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1830313030; Thu, 14 Feb 2019 18:15:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 18:15:06 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 18:15:06 +0800
Message-ID: <1550139306.21510.10.camel@mtksdaap41>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>,
        <mars.cheng@mediatek.com>,
        Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        <linux-serial@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <eddie.huang@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Date:   Thu, 14 Feb 2019 18:15:06 +0800
In-Reply-To: <1550139242.21510.9.camel@mtksdaap41>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
         <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
         <30d3239e-f581-01cb-547a-30faf96c0387@gmail.com>
         <1550048633.10019.2.camel@mtksdaap41>
         <458fd525-3f53-fcd8-2466-4c8046400c5a@gmail.com>
         <1550122026.21510.6.camel@mtksdaap41>
         <e750c805-d744-fec3-a6cb-5ef1a2348cf4@gmail.com>
         <1550139242.21510.9.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 03C402A17B16E5A9FDB52662ED74D7AAA0FD3F760F243EF202BBFD2CE7EF048D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 18:14 +0800, Erin Lo wrote:
> On Thu, 2019-02-14 at 10:01 +0100, Matthias Brugger wrote:
> > 
> > On 14/02/2019 06:27, Erin Lo wrote:
> > > On Wed, 2019-02-13 at 15:54 +0100, Matthias Brugger wrote:
> > >>
> > >> On 13/02/2019 10:03, Erin Lo wrote:
> > >>> On Thu, 2019-02-07 at 16:30 +0100, Matthias Brugger wrote:
> > >>>>
> > >>>> On 24/01/2019 09:07, Erin Lo wrote:
> > >>>>> From: Ben Ho <Ben.Ho@mediatek.com>
> > >>>>>
> > >>>>> Add basic chip support for Mediatek 8183, include
> > >>>>> pinctrl file, uart node with correct uart clocks, pwrap device
> > >>>>>
> > >>>>> Add clock controller nodes, include topckgen, infracfg,
> > >>>>> apmixedsys and subsystem.
> > >>>>>
> > >>>>> Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > >>>>> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > >>>>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > >>>>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > >>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > >>>>> Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > >>>>> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > >>>>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > >>>>> ---
> > >>>>>  arch/arm64/boot/dts/mediatek/Makefile         |    1 +
> > >>>>>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |  136 +++
> > >>>>>  arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h | 1120 +++++++++++++++++++++++++
> > >>>>
> > >>>> Would you mind to make the pinfunc.h a seperate patch and adding the pinctrl
> > >>>> maintainers to the list.
> > >>>>
> > >>>> Regards,
> > >>>> Matthias
> > >>>>
> > >>>
> > >>> OK! I will take pinfunc.h out of this series.
> > >>
> > >> My take would be to somehow change this series in something like.
> > >> One patch which adds basic support for the SoC without any dependencies on other
> > >> series.
> > >> Every node that has a dependency on a different series should go in a separate
> > >> patch. In this case IMHO pinfunc.h can got with the dts node in one patch.
> > >>
> > >> Regards,
> > >> Matthias
> > >>
> > > 
> > > I will separate this patch into 3 patches : basic support for the SoC,
> > > mt8183-pinfunc.h, and spi node.
> > > 
> > > Is that OK?
> > > Is it ok, if pinctrl@1000b000 is included in basic node?
> > > 
> > 
> > Why do you want to do that? Without the pinfunc.h I can't take it independently,
> > right?
> > 
> > Regards,
> > Matthias
> 
> spi node need to use pio in mt8183-evb.dts, unless I don't submit spi
> relative.
> Best Regards.
> Erin

> > 
> > > Best Regards.
> > > Erin
> > > 
> > >>>
> > >>> Best Regards,
> > >>> Erin
> > >>>
> > >>>>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  408 +++++++++
> > >>>>>  4 files changed, 1665 insertions(+)
> > >>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > >>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> > >>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > >>>>>
> > >>>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > >>>>> index e8f952f..458bbc4 100644
> > >>>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
> > >>>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > >>>>> @@ -7,3 +7,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> > >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> > >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
> > >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> > >>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
> > >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > >>>>> new file mode 100644
> > >>>>> index 0000000..b12c6ea
> > >>>>> --- /dev/null
> > >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > >>>>> @@ -0,0 +1,136 @@
> > >>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > >>>>> +/*
> > >>>>> + * Copyright (c) 2018 MediaTek Inc.
> > >>>>> + * Author: Ben Ho <ben.ho@mediatek.com>
> > >>>>> + *	   Erin Lo <erin.lo@mediatek.com>
> > >>>>> + */
> > >>>>> +
> > >>>>> +/dts-v1/;
> > >>>>> +#include "mt8183.dtsi"
> > >>>>> +
> > >>>>> +/ {
> > >>>>> +	model = "MediaTek MT8183 evaluation board";
> > >>>>> +	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
> > >>>>> +
> > >>>>> +	aliases {
> > >>>>> +		serial0 = &uart0;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	memory@40000000 {
> > >>>>> +		device_type = "memory";
> > >>>>> +		reg = <0 0x40000000 0 0x80000000>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	chosen {
> > >>>>> +		stdout-path = "serial0:921600n8";
> > >>>>> +	};
> > >>>>> +};
> > >>>>> +
> > >>>>> +&pio {
> > >>>>> +	spi_pins_0: spi0{
> > >>>>> +		pins_spi{
> > >>>>> +			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
> > >>>>> +				 <PINMUX_GPIO86__FUNC_SPI0_CSB>,
> > >>>>> +				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
> > >>>>> +				 <PINMUX_GPIO88__FUNC_SPI0_CLK>;
> > >>>>> +			bias-disable;
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi_pins_1: spi1{
> > >>>>> +		pins_spi{
> > >>>>> +			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
> > >>>>> +				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
> > >>>>> +				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
> > >>>>> +				 <PINMUX_GPIO164__FUNC_SPI1_A_CLK>;
> > >>>>> +			bias-disable;
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi_pins_2: spi2{
> > >>>>> +		pins_spi{
> > >>>>> +			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
> > >>>>> +				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
> > >>>>> +				 <PINMUX_GPIO2__FUNC_SPI2_CLK>,
> > >>>>> +				 <PINMUX_GPIO94__FUNC_SPI2_MI>;
> > >>>>> +			bias-disable;
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi_pins_3: spi3{
> > >>>>> +		pins_spi{
> > >>>>> +			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
> > >>>>> +				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
> > >>>>> +				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
> > >>>>> +				 <PINMUX_GPIO24__FUNC_SPI3_CLK>;
> > >>>>> +			bias-disable;
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi_pins_4: spi4{
> > >>>>> +		pins_spi{
> > >>>>> +			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
> > >>>>> +				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
> > >>>>> +				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
> > >>>>> +				 <PINMUX_GPIO20__FUNC_SPI4_CLK>;
> > >>>>> +			bias-disable;
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi_pins_5: spi5{
> > >>>>> +		pins_spi{
> > >>>>> +			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
> > >>>>> +				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
> > >>>>> +				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
> > >>>>> +				 <PINMUX_GPIO16__FUNC_SPI5_CLK>;
> > >>>>> +			bias-disable;
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +};
> > >>>>> +
> > >>>>> +&spi0 {
> > >>>>> +	pinctrl-names = "default";
> > >>>>> +	pinctrl-0 = <&spi_pins_0>;
> > >>>>> +	mediatek,pad-select = <0>;
> > >>>>> +	status = "okay";
> > >>>>> +};
> > >>>>> +
> > >>>>> +&spi1 {
> > >>>>> +	pinctrl-names = "default";
> > >>>>> +	pinctrl-0 = <&spi_pins_1>;
> > >>>>> +	mediatek,pad-select = <0>;
> > >>>>> +	status = "okay";
> > >>>>> +};
> > >>>>> +
> > >>>>> +&spi2 {
> > >>>>> +	pinctrl-names = "default";
> > >>>>> +	pinctrl-0 = <&spi_pins_2>;
> > >>>>> +	mediatek,pad-select = <0>;
> > >>>>> +	status = "okay";
> > >>>>> +};
> > >>>>> +
> > >>>>> +&spi3 {
> > >>>>> +	pinctrl-names = "default";
> > >>>>> +	pinctrl-0 = <&spi_pins_3>;
> > >>>>> +	mediatek,pad-select = <0>;
> > >>>>> +	status = "okay";
> > >>>>> +};
> > >>>>> +
> > >>>>> +&spi4 {
> > >>>>> +	pinctrl-names = "default";
> > >>>>> +	pinctrl-0 = <&spi_pins_4>;
> > >>>>> +	mediatek,pad-select = <0>;
> > >>>>> +	status = "okay";
> > >>>>> +};
> > >>>>> +
> > >>>>> +&spi5 {
> > >>>>> +	pinctrl-names = "default";
> > >>>>> +	pinctrl-0 = <&spi_pins_5>;
> > >>>>> +	mediatek,pad-select = <0>;
> > >>>>> +	status = "okay";
> > >>>>> +
> > >>>>> +};
> > >>>>> +
> > >>>>> +&uart0 {
> > >>>>> +	status = "okay";
> > >>>>> +};
> > >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> > >>>>> new file mode 100644
> > >>>>> index 0000000..768e41e
> > >>>>> --- /dev/null
> > >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> > >>>>> @@ -0,0 +1,1120 @@
> > >>>>> +// SPDX-License-Identifier: GPL-2.0
> > >>>>> +/*
> > >>>>> + * Copyright (C) 2018 MediaTek Inc.
> > >>>>> + * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > >>>>> + *
> > >>>>> + */
> > >>>>> +
> > >>>>> +#ifndef __MT8183_PINFUNC_H
> > >>>>> +#define __MT8183_PINFUNC_H
> > >>>>> +
> > >>>>> +#include <dt-bindings/pinctrl/mt65xx.h>
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO0__FUNC_GPIO0 (MTK_PIN_NO(0) | 0)
> > >>>>> +#define PINMUX_GPIO0__FUNC_MRG_SYNC (MTK_PIN_NO(0) | 1)
> > >>>>> +#define PINMUX_GPIO0__FUNC_PCM0_SYNC (MTK_PIN_NO(0) | 2)
> > >>>>> +#define PINMUX_GPIO0__FUNC_TP_GPIO0_AO (MTK_PIN_NO(0) | 3)
> > >>>>> +#define PINMUX_GPIO0__FUNC_SRCLKENAI0 (MTK_PIN_NO(0) | 4)
> > >>>>> +#define PINMUX_GPIO0__FUNC_SCP_SPI2_CS (MTK_PIN_NO(0) | 5)
> > >>>>> +#define PINMUX_GPIO0__FUNC_I2S3_MCK (MTK_PIN_NO(0) | 6)
> > >>>>> +#define PINMUX_GPIO0__FUNC_SPI2_CSB (MTK_PIN_NO(0) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO1__FUNC_GPIO1 (MTK_PIN_NO(1) | 0)
> > >>>>> +#define PINMUX_GPIO1__FUNC_MRG_CLK (MTK_PIN_NO(1) | 1)
> > >>>>> +#define PINMUX_GPIO1__FUNC_PCM0_CLK (MTK_PIN_NO(1) | 2)
> > >>>>> +#define PINMUX_GPIO1__FUNC_TP_GPIO1_AO (MTK_PIN_NO(1) | 3)
> > >>>>> +#define PINMUX_GPIO1__FUNC_CLKM3 (MTK_PIN_NO(1) | 4)
> > >>>>> +#define PINMUX_GPIO1__FUNC_SCP_SPI2_MO (MTK_PIN_NO(1) | 5)
> > >>>>> +#define PINMUX_GPIO1__FUNC_I2S3_BCK (MTK_PIN_NO(1) | 6)
> > >>>>> +#define PINMUX_GPIO1__FUNC_SPI2_MO (MTK_PIN_NO(1) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO2__FUNC_GPIO2 (MTK_PIN_NO(2) | 0)
> > >>>>> +#define PINMUX_GPIO2__FUNC_MRG_DO (MTK_PIN_NO(2) | 1)
> > >>>>> +#define PINMUX_GPIO2__FUNC_PCM0_DO (MTK_PIN_NO(2) | 2)
> > >>>>> +#define PINMUX_GPIO2__FUNC_TP_GPIO2_AO (MTK_PIN_NO(2) | 3)
> > >>>>> +#define PINMUX_GPIO2__FUNC_SCL6 (MTK_PIN_NO(2) | 4)
> > >>>>> +#define PINMUX_GPIO2__FUNC_SCP_SPI2_CK (MTK_PIN_NO(2) | 5)
> > >>>>> +#define PINMUX_GPIO2__FUNC_I2S3_LRCK (MTK_PIN_NO(2) | 6)
> > >>>>> +#define PINMUX_GPIO2__FUNC_SPI2_CLK (MTK_PIN_NO(2) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO3__FUNC_GPIO3 (MTK_PIN_NO(3) | 0)
> > >>>>> +#define PINMUX_GPIO3__FUNC_MRG_DI (MTK_PIN_NO(3) | 1)
> > >>>>> +#define PINMUX_GPIO3__FUNC_PCM0_DI (MTK_PIN_NO(3) | 2)
> > >>>>> +#define PINMUX_GPIO3__FUNC_TP_GPIO3_AO (MTK_PIN_NO(3) | 3)
> > >>>>> +#define PINMUX_GPIO3__FUNC_SDA6 (MTK_PIN_NO(3) | 4)
> > >>>>> +#define PINMUX_GPIO3__FUNC_TDM_MCK (MTK_PIN_NO(3) | 5)
> > >>>>> +#define PINMUX_GPIO3__FUNC_I2S3_DO (MTK_PIN_NO(3) | 6)
> > >>>>> +#define PINMUX_GPIO3__FUNC_SCP_VREQ_VAO (MTK_PIN_NO(3) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO4__FUNC_GPIO4 (MTK_PIN_NO(4) | 0)
> > >>>>> +#define PINMUX_GPIO4__FUNC_PWM_B (MTK_PIN_NO(4) | 1)
> > >>>>> +#define PINMUX_GPIO4__FUNC_I2S0_MCK (MTK_PIN_NO(4) | 2)
> > >>>>> +#define PINMUX_GPIO4__FUNC_SSPM_UTXD_AO (MTK_PIN_NO(4) | 3)
> > >>>>> +#define PINMUX_GPIO4__FUNC_MD_URXD1 (MTK_PIN_NO(4) | 4)
> > >>>>> +#define PINMUX_GPIO4__FUNC_TDM_BCK (MTK_PIN_NO(4) | 5)
> > >>>>> +#define PINMUX_GPIO4__FUNC_TP_GPIO4_AO (MTK_PIN_NO(4) | 6)
> > >>>>> +#define PINMUX_GPIO4__FUNC_DAP_MD32_SWD (MTK_PIN_NO(4) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO5__FUNC_GPIO5 (MTK_PIN_NO(5) | 0)
> > >>>>> +#define PINMUX_GPIO5__FUNC_PWM_C (MTK_PIN_NO(5) | 1)
> > >>>>> +#define PINMUX_GPIO5__FUNC_I2S0_BCK (MTK_PIN_NO(5) | 2)
> > >>>>> +#define PINMUX_GPIO5__FUNC_SSPM_URXD_AO (MTK_PIN_NO(5) | 3)
> > >>>>> +#define PINMUX_GPIO5__FUNC_MD_UTXD1 (MTK_PIN_NO(5) | 4)
> > >>>>> +#define PINMUX_GPIO5__FUNC_TDM_LRCK (MTK_PIN_NO(5) | 5)
> > >>>>> +#define PINMUX_GPIO5__FUNC_TP_GPIO5_AO (MTK_PIN_NO(5) | 6)
> > >>>>> +#define PINMUX_GPIO5__FUNC_DAP_MD32_SWCK (MTK_PIN_NO(5) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO6__FUNC_GPIO6 (MTK_PIN_NO(6) | 0)
> > >>>>> +#define PINMUX_GPIO6__FUNC_PWM_A (MTK_PIN_NO(6) | 1)
> > >>>>> +#define PINMUX_GPIO6__FUNC_I2S0_LRCK (MTK_PIN_NO(6) | 2)
> > >>>>> +#define PINMUX_GPIO6__FUNC_IDDIG (MTK_PIN_NO(6) | 3)
> > >>>>> +#define PINMUX_GPIO6__FUNC_MD_URXD0 (MTK_PIN_NO(6) | 4)
> > >>>>> +#define PINMUX_GPIO6__FUNC_TDM_DATA0 (MTK_PIN_NO(6) | 5)
> > >>>>> +#define PINMUX_GPIO6__FUNC_TP_GPIO6_AO (MTK_PIN_NO(6) | 6)
> > >>>>> +#define PINMUX_GPIO6__FUNC_CMFLASH (MTK_PIN_NO(6) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO7__FUNC_GPIO7 (MTK_PIN_NO(7) | 0)
> > >>>>> +#define PINMUX_GPIO7__FUNC_SPI1_B_MI (MTK_PIN_NO(7) | 1)
> > >>>>> +#define PINMUX_GPIO7__FUNC_I2S0_DI (MTK_PIN_NO(7) | 2)
> > >>>>> +#define PINMUX_GPIO7__FUNC_USB_DRVVBUS (MTK_PIN_NO(7) | 3)
> > >>>>> +#define PINMUX_GPIO7__FUNC_MD_UTXD0 (MTK_PIN_NO(7) | 4)
> > >>>>> +#define PINMUX_GPIO7__FUNC_TDM_DATA1 (MTK_PIN_NO(7) | 5)
> > >>>>> +#define PINMUX_GPIO7__FUNC_TP_GPIO7_AO (MTK_PIN_NO(7) | 6)
> > >>>>> +#define PINMUX_GPIO7__FUNC_DVFSRC_EXT_REQ (MTK_PIN_NO(7) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO8__FUNC_GPIO8 (MTK_PIN_NO(8) | 0)
> > >>>>> +#define PINMUX_GPIO8__FUNC_SPI1_B_CSB (MTK_PIN_NO(8) | 1)
> > >>>>> +#define PINMUX_GPIO8__FUNC_ANT_SEL3 (MTK_PIN_NO(8) | 2)
> > >>>>> +#define PINMUX_GPIO8__FUNC_SCL7 (MTK_PIN_NO(8) | 3)
> > >>>>> +#define PINMUX_GPIO8__FUNC_CONN_MCU_TRST_B (MTK_PIN_NO(8) | 4)
> > >>>>> +#define PINMUX_GPIO8__FUNC_TDM_DATA2 (MTK_PIN_NO(8) | 5)
> > >>>>> +#define PINMUX_GPIO8__FUNC_MD_INT0 (MTK_PIN_NO(8) | 6)
> > >>>>> +#define PINMUX_GPIO8__FUNC_JTRSTN_SEL1 (MTK_PIN_NO(8) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO9__FUNC_GPIO9 (MTK_PIN_NO(9) | 0)
> > >>>>> +#define PINMUX_GPIO9__FUNC_SPI1_B_MO (MTK_PIN_NO(9) | 1)
> > >>>>> +#define PINMUX_GPIO9__FUNC_ANT_SEL4 (MTK_PIN_NO(9) | 2)
> > >>>>> +#define PINMUX_GPIO9__FUNC_CMMCLK2 (MTK_PIN_NO(9) | 3)
> > >>>>> +#define PINMUX_GPIO9__FUNC_CONN_MCU_DBGACK_N (MTK_PIN_NO(9) | 4)
> > >>>>> +#define PINMUX_GPIO9__FUNC_SSPM_JTAG_TRSTN (MTK_PIN_NO(9) | 5)
> > >>>>> +#define PINMUX_GPIO9__FUNC_IO_JTAG_TRSTN (MTK_PIN_NO(9) | 6)
> > >>>>> +#define PINMUX_GPIO9__FUNC_DBG_MON_B10 (MTK_PIN_NO(9) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO10__FUNC_GPIO10 (MTK_PIN_NO(10) | 0)
> > >>>>> +#define PINMUX_GPIO10__FUNC_SPI1_B_CLK (MTK_PIN_NO(10) | 1)
> > >>>>> +#define PINMUX_GPIO10__FUNC_ANT_SEL5 (MTK_PIN_NO(10) | 2)
> > >>>>> +#define PINMUX_GPIO10__FUNC_CMMCLK3 (MTK_PIN_NO(10) | 3)
> > >>>>> +#define PINMUX_GPIO10__FUNC_CONN_MCU_DBGI_N (MTK_PIN_NO(10) | 4)
> > >>>>> +#define PINMUX_GPIO10__FUNC_TDM_DATA3 (MTK_PIN_NO(10) | 5)
> > >>>>> +#define PINMUX_GPIO10__FUNC_EXT_FRAME_SYNC (MTK_PIN_NO(10) | 6)
> > >>>>> +#define PINMUX_GPIO10__FUNC_DBG_MON_B11 (MTK_PIN_NO(10) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO11__FUNC_GPIO11 (MTK_PIN_NO(11) | 0)
> > >>>>> +#define PINMUX_GPIO11__FUNC_TP_URXD1_AO (MTK_PIN_NO(11) | 1)
> > >>>>> +#define PINMUX_GPIO11__FUNC_IDDIG (MTK_PIN_NO(11) | 2)
> > >>>>> +#define PINMUX_GPIO11__FUNC_SCL6 (MTK_PIN_NO(11) | 3)
> > >>>>> +#define PINMUX_GPIO11__FUNC_UCTS1 (MTK_PIN_NO(11) | 4)
> > >>>>> +#define PINMUX_GPIO11__FUNC_UCTS0 (MTK_PIN_NO(11) | 5)
> > >>>>> +#define PINMUX_GPIO11__FUNC_SRCLKENAI1 (MTK_PIN_NO(11) | 6)
> > >>>>> +#define PINMUX_GPIO11__FUNC_I2S5_MCK (MTK_PIN_NO(11) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO12__FUNC_GPIO12 (MTK_PIN_NO(12) | 0)
> > >>>>> +#define PINMUX_GPIO12__FUNC_TP_UTXD1_AO (MTK_PIN_NO(12) | 1)
> > >>>>> +#define PINMUX_GPIO12__FUNC_USB_DRVVBUS (MTK_PIN_NO(12) | 2)
> > >>>>> +#define PINMUX_GPIO12__FUNC_SDA6 (MTK_PIN_NO(12) | 3)
> > >>>>> +#define PINMUX_GPIO12__FUNC_URTS1 (MTK_PIN_NO(12) | 4)
> > >>>>> +#define PINMUX_GPIO12__FUNC_URTS0 (MTK_PIN_NO(12) | 5)
> > >>>>> +#define PINMUX_GPIO12__FUNC_I2S2_DI2 (MTK_PIN_NO(12) | 6)
> > >>>>> +#define PINMUX_GPIO12__FUNC_I2S5_BCK (MTK_PIN_NO(12) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO13__FUNC_GPIO13 (MTK_PIN_NO(13) | 0)
> > >>>>> +#define PINMUX_GPIO13__FUNC_DBPI_D0 (MTK_PIN_NO(13) | 1)
> > >>>>> +#define PINMUX_GPIO13__FUNC_SPI5_MI (MTK_PIN_NO(13) | 2)
> > >>>>> +#define PINMUX_GPIO13__FUNC_PCM0_SYNC (MTK_PIN_NO(13) | 3)
> > >>>>> +#define PINMUX_GPIO13__FUNC_MD_URXD0 (MTK_PIN_NO(13) | 4)
> > >>>>> +#define PINMUX_GPIO13__FUNC_ANT_SEL3 (MTK_PIN_NO(13) | 5)
> > >>>>> +#define PINMUX_GPIO13__FUNC_I2S0_MCK (MTK_PIN_NO(13) | 6)
> > >>>>> +#define PINMUX_GPIO13__FUNC_DBG_MON_B15 (MTK_PIN_NO(13) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO14__FUNC_GPIO14 (MTK_PIN_NO(14) | 0)
> > >>>>> +#define PINMUX_GPIO14__FUNC_DBPI_D1 (MTK_PIN_NO(14) | 1)
> > >>>>> +#define PINMUX_GPIO14__FUNC_SPI5_CSB (MTK_PIN_NO(14) | 2)
> > >>>>> +#define PINMUX_GPIO14__FUNC_PCM0_CLK (MTK_PIN_NO(14) | 3)
> > >>>>> +#define PINMUX_GPIO14__FUNC_MD_UTXD0 (MTK_PIN_NO(14) | 4)
> > >>>>> +#define PINMUX_GPIO14__FUNC_ANT_SEL4 (MTK_PIN_NO(14) | 5)
> > >>>>> +#define PINMUX_GPIO14__FUNC_I2S0_BCK (MTK_PIN_NO(14) | 6)
> > >>>>> +#define PINMUX_GPIO14__FUNC_DBG_MON_B16 (MTK_PIN_NO(14) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO15__FUNC_GPIO15 (MTK_PIN_NO(15) | 0)
> > >>>>> +#define PINMUX_GPIO15__FUNC_DBPI_D2 (MTK_PIN_NO(15) | 1)
> > >>>>> +#define PINMUX_GPIO15__FUNC_SPI5_MO (MTK_PIN_NO(15) | 2)
> > >>>>> +#define PINMUX_GPIO15__FUNC_PCM0_DO (MTK_PIN_NO(15) | 3)
> > >>>>> +#define PINMUX_GPIO15__FUNC_MD_URXD1 (MTK_PIN_NO(15) | 4)
> > >>>>> +#define PINMUX_GPIO15__FUNC_ANT_SEL5 (MTK_PIN_NO(15) | 5)
> > >>>>> +#define PINMUX_GPIO15__FUNC_I2S0_LRCK (MTK_PIN_NO(15) | 6)
> > >>>>> +#define PINMUX_GPIO15__FUNC_DBG_MON_B17 (MTK_PIN_NO(15) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO16__FUNC_GPIO16 (MTK_PIN_NO(16) | 0)
> > >>>>> +#define PINMUX_GPIO16__FUNC_DBPI_D3 (MTK_PIN_NO(16) | 1)
> > >>>>> +#define PINMUX_GPIO16__FUNC_SPI5_CLK (MTK_PIN_NO(16) | 2)
> > >>>>> +#define PINMUX_GPIO16__FUNC_PCM0_DI (MTK_PIN_NO(16) | 3)
> > >>>>> +#define PINMUX_GPIO16__FUNC_MD_UTXD1 (MTK_PIN_NO(16) | 4)
> > >>>>> +#define PINMUX_GPIO16__FUNC_ANT_SEL6 (MTK_PIN_NO(16) | 5)
> > >>>>> +#define PINMUX_GPIO16__FUNC_I2S0_DI (MTK_PIN_NO(16) | 6)
> > >>>>> +#define PINMUX_GPIO16__FUNC_DBG_MON_B23 (MTK_PIN_NO(16) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO17__FUNC_GPIO17 (MTK_PIN_NO(17) | 0)
> > >>>>> +#define PINMUX_GPIO17__FUNC_DBPI_D4 (MTK_PIN_NO(17) | 1)
> > >>>>> +#define PINMUX_GPIO17__FUNC_SPI4_MI (MTK_PIN_NO(17) | 2)
> > >>>>> +#define PINMUX_GPIO17__FUNC_CONN_MCU_TRST_B (MTK_PIN_NO(17) | 3)
> > >>>>> +#define PINMUX_GPIO17__FUNC_MD_INT0 (MTK_PIN_NO(17) | 4)
> > >>>>> +#define PINMUX_GPIO17__FUNC_ANT_SEL7 (MTK_PIN_NO(17) | 5)
> > >>>>> +#define PINMUX_GPIO17__FUNC_I2S3_MCK (MTK_PIN_NO(17) | 6)
> > >>>>> +#define PINMUX_GPIO17__FUNC_DBG_MON_A1 (MTK_PIN_NO(17) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO18__FUNC_GPIO18 (MTK_PIN_NO(18) | 0)
> > >>>>> +#define PINMUX_GPIO18__FUNC_DBPI_D5 (MTK_PIN_NO(18) | 1)
> > >>>>> +#define PINMUX_GPIO18__FUNC_SPI4_CSB (MTK_PIN_NO(18) | 2)
> > >>>>> +#define PINMUX_GPIO18__FUNC_CONN_MCU_DBGI_N (MTK_PIN_NO(18) | 3)
> > >>>>> +#define PINMUX_GPIO18__FUNC_MD_INT0 (MTK_PIN_NO(18) | 4)
> > >>>>> +#define PINMUX_GPIO18__FUNC_SCP_VREQ_VAO (MTK_PIN_NO(18) | 5)
> > >>>>> +#define PINMUX_GPIO18__FUNC_I2S3_BCK (MTK_PIN_NO(18) | 6)
> > >>>>> +#define PINMUX_GPIO18__FUNC_DBG_MON_A2 (MTK_PIN_NO(18) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO19__FUNC_GPIO19 (MTK_PIN_NO(19) | 0)
> > >>>>> +#define PINMUX_GPIO19__FUNC_DBPI_D6 (MTK_PIN_NO(19) | 1)
> > >>>>> +#define PINMUX_GPIO19__FUNC_SPI4_MO (MTK_PIN_NO(19) | 2)
> > >>>>> +#define PINMUX_GPIO19__FUNC_CONN_MCU_TDO (MTK_PIN_NO(19) | 3)
> > >>>>> +#define PINMUX_GPIO19__FUNC_MD_INT2_C2K_UIM1_HOT_PLUG (MTK_PIN_NO(19) | 4)
> > >>>>> +#define PINMUX_GPIO19__FUNC_URXD1 (MTK_PIN_NO(19) | 5)
> > >>>>> +#define PINMUX_GPIO19__FUNC_I2S3_LRCK (MTK_PIN_NO(19) | 6)
> > >>>>> +#define PINMUX_GPIO19__FUNC_DBG_MON_A3 (MTK_PIN_NO(19) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO20__FUNC_GPIO20 (MTK_PIN_NO(20) | 0)
> > >>>>> +#define PINMUX_GPIO20__FUNC_DBPI_D7 (MTK_PIN_NO(20) | 1)
> > >>>>> +#define PINMUX_GPIO20__FUNC_SPI4_CLK (MTK_PIN_NO(20) | 2)
> > >>>>> +#define PINMUX_GPIO20__FUNC_CONN_MCU_DBGACK_N (MTK_PIN_NO(20) | 3)
> > >>>>> +#define PINMUX_GPIO20__FUNC_MD_INT1_C2K_UIM0_HOT_PLUG (MTK_PIN_NO(20) | 4)
> > >>>>> +#define PINMUX_GPIO20__FUNC_UTXD1 (MTK_PIN_NO(20) | 5)
> > >>>>> +#define PINMUX_GPIO20__FUNC_I2S3_DO (MTK_PIN_NO(20) | 6)
> > >>>>> +#define PINMUX_GPIO20__FUNC_DBG_MON_A19 (MTK_PIN_NO(20) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO21__FUNC_GPIO21 (MTK_PIN_NO(21) | 0)
> > >>>>> +#define PINMUX_GPIO21__FUNC_DBPI_D8 (MTK_PIN_NO(21) | 1)
> > >>>>> +#define PINMUX_GPIO21__FUNC_SPI3_MI (MTK_PIN_NO(21) | 2)
> > >>>>> +#define PINMUX_GPIO21__FUNC_CONN_MCU_TMS (MTK_PIN_NO(21) | 3)
> > >>>>> +#define PINMUX_GPIO21__FUNC_DAP_MD32_SWD (MTK_PIN_NO(21) | 4)
> > >>>>> +#define PINMUX_GPIO21__FUNC_CONN_MCU_AICE_TMSC (MTK_PIN_NO(21) | 5)
> > >>>>> +#define PINMUX_GPIO21__FUNC_I2S2_MCK (MTK_PIN_NO(21) | 6)
> > >>>>> +#define PINMUX_GPIO21__FUNC_DBG_MON_B5 (MTK_PIN_NO(21) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO22__FUNC_GPIO22 (MTK_PIN_NO(22) | 0)
> > >>>>> +#define PINMUX_GPIO22__FUNC_DBPI_D9 (MTK_PIN_NO(22) | 1)
> > >>>>> +#define PINMUX_GPIO22__FUNC_SPI3_CSB (MTK_PIN_NO(22) | 2)
> > >>>>> +#define PINMUX_GPIO22__FUNC_CONN_MCU_TCK (MTK_PIN_NO(22) | 3)
> > >>>>> +#define PINMUX_GPIO22__FUNC_DAP_MD32_SWCK (MTK_PIN_NO(22) | 4)
> > >>>>> +#define PINMUX_GPIO22__FUNC_CONN_MCU_AICE_TCKC (MTK_PIN_NO(22) | 5)
> > >>>>> +#define PINMUX_GPIO22__FUNC_I2S2_BCK (MTK_PIN_NO(22) | 6)
> > >>>>> +#define PINMUX_GPIO22__FUNC_DBG_MON_B6 (MTK_PIN_NO(22) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO23__FUNC_GPIO23 (MTK_PIN_NO(23) | 0)
> > >>>>> +#define PINMUX_GPIO23__FUNC_DBPI_D10 (MTK_PIN_NO(23) | 1)
> > >>>>> +#define PINMUX_GPIO23__FUNC_SPI3_MO (MTK_PIN_NO(23) | 2)
> > >>>>> +#define PINMUX_GPIO23__FUNC_CONN_MCU_TDI (MTK_PIN_NO(23) | 3)
> > >>>>> +#define PINMUX_GPIO23__FUNC_UCTS1 (MTK_PIN_NO(23) | 4)
> > >>>>> +#define PINMUX_GPIO23__FUNC_EXT_FRAME_SYNC (MTK_PIN_NO(23) | 5)
> > >>>>> +#define PINMUX_GPIO23__FUNC_I2S2_LRCK (MTK_PIN_NO(23) | 6)
> > >>>>> +#define PINMUX_GPIO23__FUNC_DBG_MON_B7 (MTK_PIN_NO(23) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO24__FUNC_GPIO24 (MTK_PIN_NO(24) | 0)
> > >>>>> +#define PINMUX_GPIO24__FUNC_DBPI_D11 (MTK_PIN_NO(24) | 1)
> > >>>>> +#define PINMUX_GPIO24__FUNC_SPI3_CLK (MTK_PIN_NO(24) | 2)
> > >>>>> +#define PINMUX_GPIO24__FUNC_SRCLKENAI0 (MTK_PIN_NO(24) | 3)
> > >>>>> +#define PINMUX_GPIO24__FUNC_URTS1 (MTK_PIN_NO(24) | 4)
> > >>>>> +#define PINMUX_GPIO24__FUNC_IO_JTAG_TCK (MTK_PIN_NO(24) | 5)
> > >>>>> +#define PINMUX_GPIO24__FUNC_I2S2_DI (MTK_PIN_NO(24) | 6)
> > >>>>> +#define PINMUX_GPIO24__FUNC_DBG_MON_B31 (MTK_PIN_NO(24) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO25__FUNC_GPIO25 (MTK_PIN_NO(25) | 0)
> > >>>>> +#define PINMUX_GPIO25__FUNC_DBPI_HSYNC (MTK_PIN_NO(25) | 1)
> > >>>>> +#define PINMUX_GPIO25__FUNC_ANT_SEL0 (MTK_PIN_NO(25) | 2)
> > >>>>> +#define PINMUX_GPIO25__FUNC_SCL6 (MTK_PIN_NO(25) | 3)
> > >>>>> +#define PINMUX_GPIO25__FUNC_KPCOL2 (MTK_PIN_NO(25) | 4)
> > >>>>> +#define PINMUX_GPIO25__FUNC_IO_JTAG_TMS (MTK_PIN_NO(25) | 5)
> > >>>>> +#define PINMUX_GPIO25__FUNC_I2S1_MCK (MTK_PIN_NO(25) | 6)
> > >>>>> +#define PINMUX_GPIO25__FUNC_DBG_MON_B0 (MTK_PIN_NO(25) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO26__FUNC_GPIO26 (MTK_PIN_NO(26) | 0)
> > >>>>> +#define PINMUX_GPIO26__FUNC_DBPI_VSYNC (MTK_PIN_NO(26) | 1)
> > >>>>> +#define PINMUX_GPIO26__FUNC_ANT_SEL1 (MTK_PIN_NO(26) | 2)
> > >>>>> +#define PINMUX_GPIO26__FUNC_SDA6 (MTK_PIN_NO(26) | 3)
> > >>>>> +#define PINMUX_GPIO26__FUNC_KPROW2 (MTK_PIN_NO(26) | 4)
> > >>>>> +#define PINMUX_GPIO26__FUNC_IO_JTAG_TDI (MTK_PIN_NO(26) | 5)
> > >>>>> +#define PINMUX_GPIO26__FUNC_I2S1_BCK (MTK_PIN_NO(26) | 6)
> > >>>>> +#define PINMUX_GPIO26__FUNC_DBG_MON_B1 (MTK_PIN_NO(26) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO27__FUNC_GPIO27 (MTK_PIN_NO(27) | 0)
> > >>>>> +#define PINMUX_GPIO27__FUNC_DBPI_DE (MTK_PIN_NO(27) | 1)
> > >>>>> +#define PINMUX_GPIO27__FUNC_ANT_SEL2 (MTK_PIN_NO(27) | 2)
> > >>>>> +#define PINMUX_GPIO27__FUNC_SCL7 (MTK_PIN_NO(27) | 3)
> > >>>>> +#define PINMUX_GPIO27__FUNC_DMIC_CLK (MTK_PIN_NO(27) | 4)
> > >>>>> +#define PINMUX_GPIO27__FUNC_IO_JTAG_TDO (MTK_PIN_NO(27) | 5)
> > >>>>> +#define PINMUX_GPIO27__FUNC_I2S1_LRCK (MTK_PIN_NO(27) | 6)
> > >>>>> +#define PINMUX_GPIO27__FUNC_DBG_MON_B9 (MTK_PIN_NO(27) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO28__FUNC_GPIO28 (MTK_PIN_NO(28) | 0)
> > >>>>> +#define PINMUX_GPIO28__FUNC_DBPI_CK (MTK_PIN_NO(28) | 1)
> > >>>>> +#define PINMUX_GPIO28__FUNC_DVFSRC_EXT_REQ (MTK_PIN_NO(28) | 2)
> > >>>>> +#define PINMUX_GPIO28__FUNC_SDA7 (MTK_PIN_NO(28) | 3)
> > >>>>> +#define PINMUX_GPIO28__FUNC_DMIC_DAT (MTK_PIN_NO(28) | 4)
> > >>>>> +#define PINMUX_GPIO28__FUNC_IO_JTAG_TRSTN (MTK_PIN_NO(28) | 5)
> > >>>>> +#define PINMUX_GPIO28__FUNC_I2S1_DO (MTK_PIN_NO(28) | 6)
> > >>>>> +#define PINMUX_GPIO28__FUNC_DBG_MON_B32 (MTK_PIN_NO(28) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO29__FUNC_GPIO29 (MTK_PIN_NO(29) | 0)
> > >>>>> +#define PINMUX_GPIO29__FUNC_MSDC1_CLK (MTK_PIN_NO(29) | 1)
> > >>>>> +#define PINMUX_GPIO29__FUNC_IO_JTAG_TCK (MTK_PIN_NO(29) | 2)
> > >>>>> +#define PINMUX_GPIO29__FUNC_UDI_TCK (MTK_PIN_NO(29) | 3)
> > >>>>> +#define PINMUX_GPIO29__FUNC_CONN_DSP_JCK (MTK_PIN_NO(29) | 4)
> > >>>>> +#define PINMUX_GPIO29__FUNC_SSPM_JTAG_TCK (MTK_PIN_NO(29) | 5)
> > >>>>> +#define PINMUX_GPIO29__FUNC_PCM1_CLK (MTK_PIN_NO(29) | 6)
> > >>>>> +#define PINMUX_GPIO29__FUNC_DBG_MON_A6 (MTK_PIN_NO(29) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO30__FUNC_GPIO30 (MTK_PIN_NO(30) | 0)
> > >>>>> +#define PINMUX_GPIO30__FUNC_MSDC1_DAT3 (MTK_PIN_NO(30) | 1)
> > >>>>> +#define PINMUX_GPIO30__FUNC_DAP_MD32_SWD (MTK_PIN_NO(30) | 2)
> > >>>>> +#define PINMUX_GPIO30__FUNC_CONN_MCU_AICE_TMSC (MTK_PIN_NO(30) | 3)
> > >>>>> +#define PINMUX_GPIO30__FUNC_CONN_DSP_JINTP (MTK_PIN_NO(30) | 4)
> > >>>>> +#define PINMUX_GPIO30__FUNC_SSPM_JTAG_TRSTN (MTK_PIN_NO(30) | 5)
> > >>>>> +#define PINMUX_GPIO30__FUNC_PCM1_DI (MTK_PIN_NO(30) | 6)
> > >>>>> +#define PINMUX_GPIO30__FUNC_DBG_MON_A7 (MTK_PIN_NO(30) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO31__FUNC_GPIO31 (MTK_PIN_NO(31) | 0)
> > >>>>> +#define PINMUX_GPIO31__FUNC_MSDC1_CMD (MTK_PIN_NO(31) | 1)
> > >>>>> +#define PINMUX_GPIO31__FUNC_IO_JTAG_TMS (MTK_PIN_NO(31) | 2)
> > >>>>> +#define PINMUX_GPIO31__FUNC_UDI_TMS (MTK_PIN_NO(31) | 3)
> > >>>>> +#define PINMUX_GPIO31__FUNC_CONN_DSP_JMS (MTK_PIN_NO(31) | 4)
> > >>>>> +#define PINMUX_GPIO31__FUNC_SSPM_JTAG_TMS (MTK_PIN_NO(31) | 5)
> > >>>>> +#define PINMUX_GPIO31__FUNC_PCM1_SYNC (MTK_PIN_NO(31) | 6)
> > >>>>> +#define PINMUX_GPIO31__FUNC_DBG_MON_A8 (MTK_PIN_NO(31) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO32__FUNC_GPIO32 (MTK_PIN_NO(32) | 0)
> > >>>>> +#define PINMUX_GPIO32__FUNC_MSDC1_DAT0 (MTK_PIN_NO(32) | 1)
> > >>>>> +#define PINMUX_GPIO32__FUNC_IO_JTAG_TDI (MTK_PIN_NO(32) | 2)
> > >>>>> +#define PINMUX_GPIO32__FUNC_UDI_TDI (MTK_PIN_NO(32) | 3)
> > >>>>> +#define PINMUX_GPIO32__FUNC_CONN_DSP_JDI (MTK_PIN_NO(32) | 4)
> > >>>>> +#define PINMUX_GPIO32__FUNC_SSPM_JTAG_TDI (MTK_PIN_NO(32) | 5)
> > >>>>> +#define PINMUX_GPIO32__FUNC_PCM1_DO0 (MTK_PIN_NO(32) | 6)
> > >>>>> +#define PINMUX_GPIO32__FUNC_DBG_MON_A9 (MTK_PIN_NO(32) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO33__FUNC_GPIO33 (MTK_PIN_NO(33) | 0)
> > >>>>> +#define PINMUX_GPIO33__FUNC_MSDC1_DAT2 (MTK_PIN_NO(33) | 1)
> > >>>>> +#define PINMUX_GPIO33__FUNC_IO_JTAG_TRSTN (MTK_PIN_NO(33) | 2)
> > >>>>> +#define PINMUX_GPIO33__FUNC_UDI_NTRST (MTK_PIN_NO(33) | 3)
> > >>>>> +#define PINMUX_GPIO33__FUNC_DAP_MD32_SWCK (MTK_PIN_NO(33) | 4)
> > >>>>> +#define PINMUX_GPIO33__FUNC_CONN_MCU_AICE_TCKC (MTK_PIN_NO(33) | 5)
> > >>>>> +#define PINMUX_GPIO33__FUNC_PCM1_DO2 (MTK_PIN_NO(33) | 6)
> > >>>>> +#define PINMUX_GPIO33__FUNC_DBG_MON_A10 (MTK_PIN_NO(33) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO34__FUNC_GPIO34 (MTK_PIN_NO(34) | 0)
> > >>>>> +#define PINMUX_GPIO34__FUNC_MSDC1_DAT1 (MTK_PIN_NO(34) | 1)
> > >>>>> +#define PINMUX_GPIO34__FUNC_IO_JTAG_TDO (MTK_PIN_NO(34) | 2)
> > >>>>> +#define PINMUX_GPIO34__FUNC_UDI_TDO (MTK_PIN_NO(34) | 3)
> > >>>>> +#define PINMUX_GPIO34__FUNC_CONN_DSP_JDO (MTK_PIN_NO(34) | 4)
> > >>>>> +#define PINMUX_GPIO34__FUNC_SSPM_JTAG_TDO (MTK_PIN_NO(34) | 5)
> > >>>>> +#define PINMUX_GPIO34__FUNC_PCM1_DO1 (MTK_PIN_NO(34) | 6)
> > >>>>> +#define PINMUX_GPIO34__FUNC_DBG_MON_A11 (MTK_PIN_NO(34) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO35__FUNC_GPIO35 (MTK_PIN_NO(35) | 0)
> > >>>>> +#define PINMUX_GPIO35__FUNC_MD1_SIM2_SIO (MTK_PIN_NO(35) | 1)
> > >>>>> +#define PINMUX_GPIO35__FUNC_CCU_JTAG_TDO (MTK_PIN_NO(35) | 2)
> > >>>>> +#define PINMUX_GPIO35__FUNC_MD1_SIM1_SIO (MTK_PIN_NO(35) | 3)
> > >>>>> +#define PINMUX_GPIO35__FUNC_SCP_JTAG_TDO (MTK_PIN_NO(35) | 5)
> > >>>>> +#define PINMUX_GPIO35__FUNC_CONN_DSP_JMS (MTK_PIN_NO(35) | 6)
> > >>>>> +#define PINMUX_GPIO35__FUNC_DBG_MON_A28 (MTK_PIN_NO(35) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO36__FUNC_GPIO36 (MTK_PIN_NO(36) | 0)
> > >>>>> +#define PINMUX_GPIO36__FUNC_MD1_SIM2_SRST (MTK_PIN_NO(36) | 1)
> > >>>>> +#define PINMUX_GPIO36__FUNC_CCU_JTAG_TMS (MTK_PIN_NO(36) | 2)
> > >>>>> +#define PINMUX_GPIO36__FUNC_MD1_SIM1_SRST (MTK_PIN_NO(36) | 3)
> > >>>>> +#define PINMUX_GPIO36__FUNC_CONN_MCU_AICE_TMSC (MTK_PIN_NO(36) | 4)
> > >>>>> +#define PINMUX_GPIO36__FUNC_SCP_JTAG_TMS (MTK_PIN_NO(36) | 5)
> > >>>>> +#define PINMUX_GPIO36__FUNC_CONN_DSP_JINTP (MTK_PIN_NO(36) | 6)
> > >>>>> +#define PINMUX_GPIO36__FUNC_DBG_MON_A29 (MTK_PIN_NO(36) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO37__FUNC_GPIO37 (MTK_PIN_NO(37) | 0)
> > >>>>> +#define PINMUX_GPIO37__FUNC_MD1_SIM2_SCLK (MTK_PIN_NO(37) | 1)
> > >>>>> +#define PINMUX_GPIO37__FUNC_CCU_JTAG_TDI (MTK_PIN_NO(37) | 2)
> > >>>>> +#define PINMUX_GPIO37__FUNC_MD1_SIM1_SCLK (MTK_PIN_NO(37) | 3)
> > >>>>> +#define PINMUX_GPIO37__FUNC_SCP_JTAG_TDI (MTK_PIN_NO(37) | 5)
> > >>>>> +#define PINMUX_GPIO37__FUNC_CONN_DSP_JDO (MTK_PIN_NO(37) | 6)
> > >>>>> +#define PINMUX_GPIO37__FUNC_DBG_MON_A30 (MTK_PIN_NO(37) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO38__FUNC_GPIO38 (MTK_PIN_NO(38) | 0)
> > >>>>> +#define PINMUX_GPIO38__FUNC_MD1_SIM1_SCLK (MTK_PIN_NO(38) | 1)
> > >>>>> +#define PINMUX_GPIO38__FUNC_MD1_SIM2_SCLK (MTK_PIN_NO(38) | 3)
> > >>>>> +#define PINMUX_GPIO38__FUNC_CONN_MCU_AICE_TCKC (MTK_PIN_NO(38) | 4)
> > >>>>> +#define PINMUX_GPIO38__FUNC_DBG_MON_A20 (MTK_PIN_NO(38) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO39__FUNC_GPIO39 (MTK_PIN_NO(39) | 0)
> > >>>>> +#define PINMUX_GPIO39__FUNC_MD1_SIM1_SRST (MTK_PIN_NO(39) | 1)
> > >>>>> +#define PINMUX_GPIO39__FUNC_CCU_JTAG_TCK (MTK_PIN_NO(39) | 2)
> > >>>>> +#define PINMUX_GPIO39__FUNC_MD1_SIM2_SRST (MTK_PIN_NO(39) | 3)
> > >>>>> +#define PINMUX_GPIO39__FUNC_SCP_JTAG_TCK (MTK_PIN_NO(39) | 5)
> > >>>>> +#define PINMUX_GPIO39__FUNC_CONN_DSP_JCK (MTK_PIN_NO(39) | 6)
> > >>>>> +#define PINMUX_GPIO39__FUNC_DBG_MON_A31 (MTK_PIN_NO(39) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO40__FUNC_GPIO40 (MTK_PIN_NO(40) | 0)
> > >>>>> +#define PINMUX_GPIO40__FUNC_MD1_SIM1_SIO (MTK_PIN_NO(40) | 1)
> > >>>>> +#define PINMUX_GPIO40__FUNC_CCU_JTAG_TRST (MTK_PIN_NO(40) | 2)
> > >>>>> +#define PINMUX_GPIO40__FUNC_MD1_SIM2_SIO (MTK_PIN_NO(40) | 3)
> > >>>>> +#define PINMUX_GPIO40__FUNC_SCP_JTAG_TRSTN (MTK_PIN_NO(40) | 5)
> > >>>>> +#define PINMUX_GPIO40__FUNC_CONN_DSP_JDI (MTK_PIN_NO(40) | 6)
> > >>>>> +#define PINMUX_GPIO40__FUNC_DBG_MON_A32 (MTK_PIN_NO(40) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO41__FUNC_GPIO41 (MTK_PIN_NO(41) | 0)
> > >>>>> +#define PINMUX_GPIO41__FUNC_IDDIG (MTK_PIN_NO(41) | 1)
> > >>>>> +#define PINMUX_GPIO41__FUNC_URXD1 (MTK_PIN_NO(41) | 2)
> > >>>>> +#define PINMUX_GPIO41__FUNC_UCTS0 (MTK_PIN_NO(41) | 3)
> > >>>>> +#define PINMUX_GPIO41__FUNC_SSPM_UTXD_AO (MTK_PIN_NO(41) | 4)
> > >>>>> +#define PINMUX_GPIO41__FUNC_EXT_FRAME_SYNC (MTK_PIN_NO(41) | 5)
> > >>>>> +#define PINMUX_GPIO41__FUNC_DMIC_CLK (MTK_PIN_NO(41) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO42__FUNC_GPIO42 (MTK_PIN_NO(42) | 0)
> > >>>>> +#define PINMUX_GPIO42__FUNC_USB_DRVVBUS (MTK_PIN_NO(42) | 1)
> > >>>>> +#define PINMUX_GPIO42__FUNC_UTXD1 (MTK_PIN_NO(42) | 2)
> > >>>>> +#define PINMUX_GPIO42__FUNC_URTS0 (MTK_PIN_NO(42) | 3)
> > >>>>> +#define PINMUX_GPIO42__FUNC_SSPM_URXD_AO (MTK_PIN_NO(42) | 4)
> > >>>>> +#define PINMUX_GPIO42__FUNC_EXT_FRAME_SYNC (MTK_PIN_NO(42) | 5)
> > >>>>> +#define PINMUX_GPIO42__FUNC_DMIC_DAT (MTK_PIN_NO(42) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO43__FUNC_GPIO43 (MTK_PIN_NO(43) | 0)
> > >>>>> +#define PINMUX_GPIO43__FUNC_DISP_PWM (MTK_PIN_NO(43) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO44__FUNC_GPIO44 (MTK_PIN_NO(44) | 0)
> > >>>>> +#define PINMUX_GPIO44__FUNC_DSI_TE (MTK_PIN_NO(44) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO45__FUNC_GPIO45 (MTK_PIN_NO(45) | 0)
> > >>>>> +#define PINMUX_GPIO45__FUNC_LCM_RST (MTK_PIN_NO(45) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO46__FUNC_GPIO46 (MTK_PIN_NO(46) | 0)
> > >>>>> +#define PINMUX_GPIO46__FUNC_MD_INT2_C2K_UIM1_HOT_PLUG (MTK_PIN_NO(46) | 1)
> > >>>>> +#define PINMUX_GPIO46__FUNC_URXD1 (MTK_PIN_NO(46) | 2)
> > >>>>> +#define PINMUX_GPIO46__FUNC_UCTS1 (MTK_PIN_NO(46) | 3)
> > >>>>> +#define PINMUX_GPIO46__FUNC_CCU_UTXD_AO (MTK_PIN_NO(46) | 4)
> > >>>>> +#define PINMUX_GPIO46__FUNC_TP_UCTS1_AO (MTK_PIN_NO(46) | 5)
> > >>>>> +#define PINMUX_GPIO46__FUNC_IDDIG (MTK_PIN_NO(46) | 6)
> > >>>>> +#define PINMUX_GPIO46__FUNC_I2S5_LRCK (MTK_PIN_NO(46) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO47__FUNC_GPIO47 (MTK_PIN_NO(47) | 0)
> > >>>>> +#define PINMUX_GPIO47__FUNC_MD_INT1_C2K_UIM0_HOT_PLUG (MTK_PIN_NO(47) | 1)
> > >>>>> +#define PINMUX_GPIO47__FUNC_UTXD1 (MTK_PIN_NO(47) | 2)
> > >>>>> +#define PINMUX_GPIO47__FUNC_URTS1 (MTK_PIN_NO(47) | 3)
> > >>>>> +#define PINMUX_GPIO47__FUNC_CCU_URXD_AO (MTK_PIN_NO(47) | 4)
> > >>>>> +#define PINMUX_GPIO47__FUNC_TP_URTS1_AO (MTK_PIN_NO(47) | 5)
> > >>>>> +#define PINMUX_GPIO47__FUNC_USB_DRVVBUS (MTK_PIN_NO(47) | 6)
> > >>>>> +#define PINMUX_GPIO47__FUNC_I2S5_DO (MTK_PIN_NO(47) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO48__FUNC_GPIO48 (MTK_PIN_NO(48) | 0)
> > >>>>> +#define PINMUX_GPIO48__FUNC_SCL5 (MTK_PIN_NO(48) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO49__FUNC_GPIO49 (MTK_PIN_NO(49) | 0)
> > >>>>> +#define PINMUX_GPIO49__FUNC_SDA5 (MTK_PIN_NO(49) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO50__FUNC_GPIO50 (MTK_PIN_NO(50) | 0)
> > >>>>> +#define PINMUX_GPIO50__FUNC_SCL3 (MTK_PIN_NO(50) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO51__FUNC_GPIO51 (MTK_PIN_NO(51) | 0)
> > >>>>> +#define PINMUX_GPIO51__FUNC_SDA3 (MTK_PIN_NO(51) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO52__FUNC_GPIO52 (MTK_PIN_NO(52) | 0)
> > >>>>> +#define PINMUX_GPIO52__FUNC_BPI_ANT2 (MTK_PIN_NO(52) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO53__FUNC_GPIO53 (MTK_PIN_NO(53) | 0)
> > >>>>> +#define PINMUX_GPIO53__FUNC_BPI_ANT0 (MTK_PIN_NO(53) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO54__FUNC_GPIO54 (MTK_PIN_NO(54) | 0)
> > >>>>> +#define PINMUX_GPIO54__FUNC_BPI_OLAT1 (MTK_PIN_NO(54) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO55__FUNC_GPIO55 (MTK_PIN_NO(55) | 0)
> > >>>>> +#define PINMUX_GPIO55__FUNC_BPI_BUS8 (MTK_PIN_NO(55) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO56__FUNC_GPIO56 (MTK_PIN_NO(56) | 0)
> > >>>>> +#define PINMUX_GPIO56__FUNC_BPI_BUS9 (MTK_PIN_NO(56) | 1)
> > >>>>> +#define PINMUX_GPIO56__FUNC_SCL_6306 (MTK_PIN_NO(56) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO57__FUNC_GPIO57 (MTK_PIN_NO(57) | 0)
> > >>>>> +#define PINMUX_GPIO57__FUNC_BPI_BUS10 (MTK_PIN_NO(57) | 1)
> > >>>>> +#define PINMUX_GPIO57__FUNC_SDA_6306 (MTK_PIN_NO(57) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO58__FUNC_GPIO58 (MTK_PIN_NO(58) | 0)
> > >>>>> +#define PINMUX_GPIO58__FUNC_RFIC0_BSI_D2 (MTK_PIN_NO(58) | 1)
> > >>>>> +#define PINMUX_GPIO58__FUNC_SPM_BSI_D2 (MTK_PIN_NO(58) | 2)
> > >>>>> +#define PINMUX_GPIO58__FUNC_PWM_B (MTK_PIN_NO(58) | 3)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO59__FUNC_GPIO59 (MTK_PIN_NO(59) | 0)
> > >>>>> +#define PINMUX_GPIO59__FUNC_RFIC0_BSI_D1 (MTK_PIN_NO(59) | 1)
> > >>>>> +#define PINMUX_GPIO59__FUNC_SPM_BSI_D1 (MTK_PIN_NO(59) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO60__FUNC_GPIO60 (MTK_PIN_NO(60) | 0)
> > >>>>> +#define PINMUX_GPIO60__FUNC_RFIC0_BSI_D0 (MTK_PIN_NO(60) | 1)
> > >>>>> +#define PINMUX_GPIO60__FUNC_SPM_BSI_D0 (MTK_PIN_NO(60) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO61__FUNC_GPIO61 (MTK_PIN_NO(61) | 0)
> > >>>>> +#define PINMUX_GPIO61__FUNC_MIPI1_SDATA (MTK_PIN_NO(61) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO62__FUNC_GPIO62 (MTK_PIN_NO(62) | 0)
> > >>>>> +#define PINMUX_GPIO62__FUNC_MIPI1_SCLK (MTK_PIN_NO(62) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO63__FUNC_GPIO63 (MTK_PIN_NO(63) | 0)
> > >>>>> +#define PINMUX_GPIO63__FUNC_MIPI0_SDATA (MTK_PIN_NO(63) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO64__FUNC_GPIO64 (MTK_PIN_NO(64) | 0)
> > >>>>> +#define PINMUX_GPIO64__FUNC_MIPI0_SCLK (MTK_PIN_NO(64) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO65__FUNC_GPIO65 (MTK_PIN_NO(65) | 0)
> > >>>>> +#define PINMUX_GPIO65__FUNC_MIPI3_SDATA (MTK_PIN_NO(65) | 1)
> > >>>>> +#define PINMUX_GPIO65__FUNC_BPI_OLAT2 (MTK_PIN_NO(65) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO66__FUNC_GPIO66 (MTK_PIN_NO(66) | 0)
> > >>>>> +#define PINMUX_GPIO66__FUNC_MIPI3_SCLK (MTK_PIN_NO(66) | 1)
> > >>>>> +#define PINMUX_GPIO66__FUNC_BPI_OLAT3 (MTK_PIN_NO(66) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO67__FUNC_GPIO67 (MTK_PIN_NO(67) | 0)
> > >>>>> +#define PINMUX_GPIO67__FUNC_MIPI2_SDATA (MTK_PIN_NO(67) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO68__FUNC_GPIO68 (MTK_PIN_NO(68) | 0)
> > >>>>> +#define PINMUX_GPIO68__FUNC_MIPI2_SCLK (MTK_PIN_NO(68) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO69__FUNC_GPIO69 (MTK_PIN_NO(69) | 0)
> > >>>>> +#define PINMUX_GPIO69__FUNC_BPI_BUS7 (MTK_PIN_NO(69) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO70__FUNC_GPIO70 (MTK_PIN_NO(70) | 0)
> > >>>>> +#define PINMUX_GPIO70__FUNC_BPI_BUS6 (MTK_PIN_NO(70) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO71__FUNC_GPIO71 (MTK_PIN_NO(71) | 0)
> > >>>>> +#define PINMUX_GPIO71__FUNC_BPI_BUS5 (MTK_PIN_NO(71) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO72__FUNC_GPIO72 (MTK_PIN_NO(72) | 0)
> > >>>>> +#define PINMUX_GPIO72__FUNC_BPI_BUS4 (MTK_PIN_NO(72) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO73__FUNC_GPIO73 (MTK_PIN_NO(73) | 0)
> > >>>>> +#define PINMUX_GPIO73__FUNC_BPI_BUS3 (MTK_PIN_NO(73) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO74__FUNC_GPIO74 (MTK_PIN_NO(74) | 0)
> > >>>>> +#define PINMUX_GPIO74__FUNC_BPI_BUS2 (MTK_PIN_NO(74) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO75__FUNC_GPIO75 (MTK_PIN_NO(75) | 0)
> > >>>>> +#define PINMUX_GPIO75__FUNC_BPI_BUS1 (MTK_PIN_NO(75) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO76__FUNC_GPIO76 (MTK_PIN_NO(76) | 0)
> > >>>>> +#define PINMUX_GPIO76__FUNC_BPI_BUS0 (MTK_PIN_NO(76) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO77__FUNC_GPIO77 (MTK_PIN_NO(77) | 0)
> > >>>>> +#define PINMUX_GPIO77__FUNC_BPI_ANT1 (MTK_PIN_NO(77) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO78__FUNC_GPIO78 (MTK_PIN_NO(78) | 0)
> > >>>>> +#define PINMUX_GPIO78__FUNC_BPI_OLAT0 (MTK_PIN_NO(78) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO79__FUNC_GPIO79 (MTK_PIN_NO(79) | 0)
> > >>>>> +#define PINMUX_GPIO79__FUNC_BPI_PA_VM1 (MTK_PIN_NO(79) | 1)
> > >>>>> +#define PINMUX_GPIO79__FUNC_MIPI4_SDATA (MTK_PIN_NO(79) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO80__FUNC_GPIO80 (MTK_PIN_NO(80) | 0)
> > >>>>> +#define PINMUX_GPIO80__FUNC_BPI_PA_VM0 (MTK_PIN_NO(80) | 1)
> > >>>>> +#define PINMUX_GPIO80__FUNC_MIPI4_SCLK (MTK_PIN_NO(80) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO81__FUNC_GPIO81 (MTK_PIN_NO(81) | 0)
> > >>>>> +#define PINMUX_GPIO81__FUNC_SDA1 (MTK_PIN_NO(81) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO82__FUNC_GPIO82 (MTK_PIN_NO(82) | 0)
> > >>>>> +#define PINMUX_GPIO82__FUNC_SDA0 (MTK_PIN_NO(82) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO83__FUNC_GPIO83 (MTK_PIN_NO(83) | 0)
> > >>>>> +#define PINMUX_GPIO83__FUNC_SCL0 (MTK_PIN_NO(83) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO84__FUNC_GPIO84 (MTK_PIN_NO(84) | 0)
> > >>>>> +#define PINMUX_GPIO84__FUNC_SCL1 (MTK_PIN_NO(84) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO85__FUNC_GPIO85 (MTK_PIN_NO(85) | 0)
> > >>>>> +#define PINMUX_GPIO85__FUNC_SPI0_MI (MTK_PIN_NO(85) | 1)
> > >>>>> +#define PINMUX_GPIO85__FUNC_SCP_SPI0_MI (MTK_PIN_NO(85) | 2)
> > >>>>> +#define PINMUX_GPIO85__FUNC_CLKM3 (MTK_PIN_NO(85) | 3)
> > >>>>> +#define PINMUX_GPIO85__FUNC_I2S1_BCK (MTK_PIN_NO(85) | 4)
> > >>>>> +#define PINMUX_GPIO85__FUNC_MFG_DFD_JTAG_TDO (MTK_PIN_NO(85) | 5)
> > >>>>> +#define PINMUX_GPIO85__FUNC_DFD_TDO (MTK_PIN_NO(85) | 6)
> > >>>>> +#define PINMUX_GPIO85__FUNC_JTDO_SEL1 (MTK_PIN_NO(85) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO86__FUNC_GPIO86 (MTK_PIN_NO(86) | 0)
> > >>>>> +#define PINMUX_GPIO86__FUNC_SPI0_CSB (MTK_PIN_NO(86) | 1)
> > >>>>> +#define PINMUX_GPIO86__FUNC_SCP_SPI0_CS (MTK_PIN_NO(86) | 2)
> > >>>>> +#define PINMUX_GPIO86__FUNC_CLKM0 (MTK_PIN_NO(86) | 3)
> > >>>>> +#define PINMUX_GPIO86__FUNC_I2S1_LRCK (MTK_PIN_NO(86) | 4)
> > >>>>> +#define PINMUX_GPIO86__FUNC_MFG_DFD_JTAG_TMS (MTK_PIN_NO(86) | 5)
> > >>>>> +#define PINMUX_GPIO86__FUNC_DFD_TMS (MTK_PIN_NO(86) | 6)
> > >>>>> +#define PINMUX_GPIO86__FUNC_JTMS_SEL1 (MTK_PIN_NO(86) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO87__FUNC_GPIO87 (MTK_PIN_NO(87) | 0)
> > >>>>> +#define PINMUX_GPIO87__FUNC_SPI0_MO (MTK_PIN_NO(87) | 1)
> > >>>>> +#define PINMUX_GPIO87__FUNC_SCP_SPI0_MO (MTK_PIN_NO(87) | 2)
> > >>>>> +#define PINMUX_GPIO87__FUNC_SDA1 (MTK_PIN_NO(87) | 3)
> > >>>>> +#define PINMUX_GPIO87__FUNC_I2S1_DO (MTK_PIN_NO(87) | 4)
> > >>>>> +#define PINMUX_GPIO87__FUNC_MFG_DFD_JTAG_TDI (MTK_PIN_NO(87) | 5)
> > >>>>> +#define PINMUX_GPIO87__FUNC_DFD_TDI (MTK_PIN_NO(87) | 6)
> > >>>>> +#define PINMUX_GPIO87__FUNC_JTDI_SEL1 (MTK_PIN_NO(87) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO88__FUNC_GPIO88 (MTK_PIN_NO(88) | 0)
> > >>>>> +#define PINMUX_GPIO88__FUNC_SPI0_CLK (MTK_PIN_NO(88) | 1)
> > >>>>> +#define PINMUX_GPIO88__FUNC_SCP_SPI0_CK (MTK_PIN_NO(88) | 2)
> > >>>>> +#define PINMUX_GPIO88__FUNC_SCL1 (MTK_PIN_NO(88) | 3)
> > >>>>> +#define PINMUX_GPIO88__FUNC_I2S1_MCK (MTK_PIN_NO(88) | 4)
> > >>>>> +#define PINMUX_GPIO88__FUNC_MFG_DFD_JTAG_TCK (MTK_PIN_NO(88) | 5)
> > >>>>> +#define PINMUX_GPIO88__FUNC_DFD_TCK_XI (MTK_PIN_NO(88) | 6)
> > >>>>> +#define PINMUX_GPIO88__FUNC_JTCK_SEL1 (MTK_PIN_NO(88) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO89__FUNC_GPIO89 (MTK_PIN_NO(89) | 0)
> > >>>>> +#define PINMUX_GPIO89__FUNC_SRCLKENAI0 (MTK_PIN_NO(89) | 1)
> > >>>>> +#define PINMUX_GPIO89__FUNC_PWM_C (MTK_PIN_NO(89) | 2)
> > >>>>> +#define PINMUX_GPIO89__FUNC_I2S5_BCK (MTK_PIN_NO(89) | 3)
> > >>>>> +#define PINMUX_GPIO89__FUNC_ANT_SEL6 (MTK_PIN_NO(89) | 4)
> > >>>>> +#define PINMUX_GPIO89__FUNC_SDA8 (MTK_PIN_NO(89) | 5)
> > >>>>> +#define PINMUX_GPIO89__FUNC_CMVREF0 (MTK_PIN_NO(89) | 6)
> > >>>>> +#define PINMUX_GPIO89__FUNC_DBG_MON_A21 (MTK_PIN_NO(89) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO90__FUNC_GPIO90 (MTK_PIN_NO(90) | 0)
> > >>>>> +#define PINMUX_GPIO90__FUNC_PWM_A (MTK_PIN_NO(90) | 1)
> > >>>>> +#define PINMUX_GPIO90__FUNC_CMMCLK2 (MTK_PIN_NO(90) | 2)
> > >>>>> +#define PINMUX_GPIO90__FUNC_I2S5_LRCK (MTK_PIN_NO(90) | 3)
> > >>>>> +#define PINMUX_GPIO90__FUNC_SCP_VREQ_VAO (MTK_PIN_NO(90) | 4)
> > >>>>> +#define PINMUX_GPIO90__FUNC_SCL8 (MTK_PIN_NO(90) | 5)
> > >>>>> +#define PINMUX_GPIO90__FUNC_PTA_RXD (MTK_PIN_NO(90) | 6)
> > >>>>> +#define PINMUX_GPIO90__FUNC_DBG_MON_A22 (MTK_PIN_NO(90) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO91__FUNC_GPIO91 (MTK_PIN_NO(91) | 0)
> > >>>>> +#define PINMUX_GPIO91__FUNC_KPROW1 (MTK_PIN_NO(91) | 1)
> > >>>>> +#define PINMUX_GPIO91__FUNC_PWM_B (MTK_PIN_NO(91) | 2)
> > >>>>> +#define PINMUX_GPIO91__FUNC_I2S5_DO (MTK_PIN_NO(91) | 3)
> > >>>>> +#define PINMUX_GPIO91__FUNC_ANT_SEL7 (MTK_PIN_NO(91) | 4)
> > >>>>> +#define PINMUX_GPIO91__FUNC_CMMCLK3 (MTK_PIN_NO(91) | 5)
> > >>>>> +#define PINMUX_GPIO91__FUNC_PTA_TXD (MTK_PIN_NO(91) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO92__FUNC_GPIO92 (MTK_PIN_NO(92) | 0)
> > >>>>> +#define PINMUX_GPIO92__FUNC_KPROW0 (MTK_PIN_NO(92) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO93__FUNC_GPIO93 (MTK_PIN_NO(93) | 0)
> > >>>>> +#define PINMUX_GPIO93__FUNC_KPCOL0 (MTK_PIN_NO(93) | 1)
> > >>>>> +#define PINMUX_GPIO93__FUNC_DBG_MON_B27 (MTK_PIN_NO(93) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO94__FUNC_GPIO94 (MTK_PIN_NO(94) | 0)
> > >>>>> +#define PINMUX_GPIO94__FUNC_KPCOL1 (MTK_PIN_NO(94) | 1)
> > >>>>> +#define PINMUX_GPIO94__FUNC_I2S2_DI2 (MTK_PIN_NO(94) | 2)
> > >>>>> +#define PINMUX_GPIO94__FUNC_I2S5_MCK (MTK_PIN_NO(94) | 3)
> > >>>>> +#define PINMUX_GPIO94__FUNC_CMMCLK2 (MTK_PIN_NO(94) | 4)
> > >>>>> +#define PINMUX_GPIO94__FUNC_SCP_SPI2_MI (MTK_PIN_NO(94) | 5)
> > >>>>> +#define PINMUX_GPIO94__FUNC_SRCLKENAI1 (MTK_PIN_NO(94) | 6)
> > >>>>> +#define PINMUX_GPIO94__FUNC_SPI2_MI (MTK_PIN_NO(94) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO95__FUNC_GPIO95 (MTK_PIN_NO(95) | 0)
> > >>>>> +#define PINMUX_GPIO95__FUNC_URXD0 (MTK_PIN_NO(95) | 1)
> > >>>>> +#define PINMUX_GPIO95__FUNC_UTXD0 (MTK_PIN_NO(95) | 2)
> > >>>>> +#define PINMUX_GPIO95__FUNC_MD_URXD0 (MTK_PIN_NO(95) | 3)
> > >>>>> +#define PINMUX_GPIO95__FUNC_MD_URXD1 (MTK_PIN_NO(95) | 4)
> > >>>>> +#define PINMUX_GPIO95__FUNC_SSPM_URXD_AO (MTK_PIN_NO(95) | 5)
> > >>>>> +#define PINMUX_GPIO95__FUNC_CCU_URXD_AO (MTK_PIN_NO(95) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO96__FUNC_GPIO96 (MTK_PIN_NO(96) | 0)
> > >>>>> +#define PINMUX_GPIO96__FUNC_UTXD0 (MTK_PIN_NO(96) | 1)
> > >>>>> +#define PINMUX_GPIO96__FUNC_URXD0 (MTK_PIN_NO(96) | 2)
> > >>>>> +#define PINMUX_GPIO96__FUNC_MD_UTXD0 (MTK_PIN_NO(96) | 3)
> > >>>>> +#define PINMUX_GPIO96__FUNC_MD_UTXD1 (MTK_PIN_NO(96) | 4)
> > >>>>> +#define PINMUX_GPIO96__FUNC_SSPM_UTXD_AO (MTK_PIN_NO(96) | 5)
> > >>>>> +#define PINMUX_GPIO96__FUNC_CCU_UTXD_AO (MTK_PIN_NO(96) | 6)
> > >>>>> +#define PINMUX_GPIO96__FUNC_DBG_MON_B2 (MTK_PIN_NO(96) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO97__FUNC_GPIO97 (MTK_PIN_NO(97) | 0)
> > >>>>> +#define PINMUX_GPIO97__FUNC_UCTS0 (MTK_PIN_NO(97) | 1)
> > >>>>> +#define PINMUX_GPIO97__FUNC_I2S2_MCK (MTK_PIN_NO(97) | 2)
> > >>>>> +#define PINMUX_GPIO97__FUNC_IDDIG (MTK_PIN_NO(97) | 3)
> > >>>>> +#define PINMUX_GPIO97__FUNC_CONN_MCU_TDO (MTK_PIN_NO(97) | 4)
> > >>>>> +#define PINMUX_GPIO97__FUNC_SSPM_JTAG_TDO (MTK_PIN_NO(97) | 5)
> > >>>>> +#define PINMUX_GPIO97__FUNC_IO_JTAG_TDO (MTK_PIN_NO(97) | 6)
> > >>>>> +#define PINMUX_GPIO97__FUNC_DBG_MON_B3 (MTK_PIN_NO(97) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO98__FUNC_GPIO98 (MTK_PIN_NO(98) | 0)
> > >>>>> +#define PINMUX_GPIO98__FUNC_URTS0 (MTK_PIN_NO(98) | 1)
> > >>>>> +#define PINMUX_GPIO98__FUNC_I2S2_BCK (MTK_PIN_NO(98) | 2)
> > >>>>> +#define PINMUX_GPIO98__FUNC_USB_DRVVBUS (MTK_PIN_NO(98) | 3)
> > >>>>> +#define PINMUX_GPIO98__FUNC_CONN_MCU_TMS (MTK_PIN_NO(98) | 4)
> > >>>>> +#define PINMUX_GPIO98__FUNC_SSPM_JTAG_TMS (MTK_PIN_NO(98) | 5)
> > >>>>> +#define PINMUX_GPIO98__FUNC_IO_JTAG_TMS (MTK_PIN_NO(98) | 6)
> > >>>>> +#define PINMUX_GPIO98__FUNC_DBG_MON_B4 (MTK_PIN_NO(98) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO99__FUNC_GPIO99 (MTK_PIN_NO(99) | 0)
> > >>>>> +#define PINMUX_GPIO99__FUNC_CMMCLK0 (MTK_PIN_NO(99) | 1)
> > >>>>> +#define PINMUX_GPIO99__FUNC_CONN_MCU_AICE_TMSC (MTK_PIN_NO(99) | 4)
> > >>>>> +#define PINMUX_GPIO99__FUNC_DBG_MON_B28 (MTK_PIN_NO(99) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO100__FUNC_GPIO100 (MTK_PIN_NO(100) | 0)
> > >>>>> +#define PINMUX_GPIO100__FUNC_CMMCLK1 (MTK_PIN_NO(100) | 1)
> > >>>>> +#define PINMUX_GPIO100__FUNC_PWM_C (MTK_PIN_NO(100) | 2)
> > >>>>> +#define PINMUX_GPIO100__FUNC_MD_INT1_C2K_UIM0_HOT_PLUG (MTK_PIN_NO(100) | 3)
> > >>>>> +#define PINMUX_GPIO100__FUNC_CONN_MCU_AICE_TCKC (MTK_PIN_NO(100) | 4)
> > >>>>> +#define PINMUX_GPIO100__FUNC_DBG_MON_B29 (MTK_PIN_NO(100) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO101__FUNC_GPIO101 (MTK_PIN_NO(101) | 0)
> > >>>>> +#define PINMUX_GPIO101__FUNC_CLKM2 (MTK_PIN_NO(101) | 1)
> > >>>>> +#define PINMUX_GPIO101__FUNC_I2S2_LRCK (MTK_PIN_NO(101) | 2)
> > >>>>> +#define PINMUX_GPIO101__FUNC_CMVREF1 (MTK_PIN_NO(101) | 3)
> > >>>>> +#define PINMUX_GPIO101__FUNC_CONN_MCU_TCK (MTK_PIN_NO(101) | 4)
> > >>>>> +#define PINMUX_GPIO101__FUNC_SSPM_JTAG_TCK (MTK_PIN_NO(101) | 5)
> > >>>>> +#define PINMUX_GPIO101__FUNC_IO_JTAG_TCK (MTK_PIN_NO(101) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO102__FUNC_GPIO102 (MTK_PIN_NO(102) | 0)
> > >>>>> +#define PINMUX_GPIO102__FUNC_CLKM1 (MTK_PIN_NO(102) | 1)
> > >>>>> +#define PINMUX_GPIO102__FUNC_I2S2_DI (MTK_PIN_NO(102) | 2)
> > >>>>> +#define PINMUX_GPIO102__FUNC_DVFSRC_EXT_REQ (MTK_PIN_NO(102) | 3)
> > >>>>> +#define PINMUX_GPIO102__FUNC_CONN_MCU_TDI (MTK_PIN_NO(102) | 4)
> > >>>>> +#define PINMUX_GPIO102__FUNC_SSPM_JTAG_TDI (MTK_PIN_NO(102) | 5)
> > >>>>> +#define PINMUX_GPIO102__FUNC_IO_JTAG_TDI (MTK_PIN_NO(102) | 6)
> > >>>>> +#define PINMUX_GPIO102__FUNC_DBG_MON_B8 (MTK_PIN_NO(102) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO103__FUNC_GPIO103 (MTK_PIN_NO(103) | 0)
> > >>>>> +#define PINMUX_GPIO103__FUNC_SCL2 (MTK_PIN_NO(103) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO104__FUNC_GPIO104 (MTK_PIN_NO(104) | 0)
> > >>>>> +#define PINMUX_GPIO104__FUNC_SDA2 (MTK_PIN_NO(104) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO105__FUNC_GPIO105 (MTK_PIN_NO(105) | 0)
> > >>>>> +#define PINMUX_GPIO105__FUNC_SCL4 (MTK_PIN_NO(105) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO106__FUNC_GPIO106 (MTK_PIN_NO(106) | 0)
> > >>>>> +#define PINMUX_GPIO106__FUNC_SDA4 (MTK_PIN_NO(106) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO107__FUNC_GPIO107 (MTK_PIN_NO(107) | 0)
> > >>>>> +#define PINMUX_GPIO107__FUNC_DMIC_CLK (MTK_PIN_NO(107) | 1)
> > >>>>> +#define PINMUX_GPIO107__FUNC_ANT_SEL0 (MTK_PIN_NO(107) | 2)
> > >>>>> +#define PINMUX_GPIO107__FUNC_CLKM0 (MTK_PIN_NO(107) | 3)
> > >>>>> +#define PINMUX_GPIO107__FUNC_SDA7 (MTK_PIN_NO(107) | 4)
> > >>>>> +#define PINMUX_GPIO107__FUNC_EXT_FRAME_SYNC (MTK_PIN_NO(107) | 5)
> > >>>>> +#define PINMUX_GPIO107__FUNC_PWM_A (MTK_PIN_NO(107) | 6)
> > >>>>> +#define PINMUX_GPIO107__FUNC_DBG_MON_B12 (MTK_PIN_NO(107) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO108__FUNC_GPIO108 (MTK_PIN_NO(108) | 0)
> > >>>>> +#define PINMUX_GPIO108__FUNC_CMMCLK2 (MTK_PIN_NO(108) | 1)
> > >>>>> +#define PINMUX_GPIO108__FUNC_ANT_SEL1 (MTK_PIN_NO(108) | 2)
> > >>>>> +#define PINMUX_GPIO108__FUNC_CLKM1 (MTK_PIN_NO(108) | 3)
> > >>>>> +#define PINMUX_GPIO108__FUNC_SCL8 (MTK_PIN_NO(108) | 4)
> > >>>>> +#define PINMUX_GPIO108__FUNC_DAP_MD32_SWD (MTK_PIN_NO(108) | 5)
> > >>>>> +#define PINMUX_GPIO108__FUNC_PWM_B (MTK_PIN_NO(108) | 6)
> > >>>>> +#define PINMUX_GPIO108__FUNC_DBG_MON_B13 (MTK_PIN_NO(108) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO109__FUNC_GPIO109 (MTK_PIN_NO(109) | 0)
> > >>>>> +#define PINMUX_GPIO109__FUNC_DMIC_DAT (MTK_PIN_NO(109) | 1)
> > >>>>> +#define PINMUX_GPIO109__FUNC_ANT_SEL2 (MTK_PIN_NO(109) | 2)
> > >>>>> +#define PINMUX_GPIO109__FUNC_CLKM2 (MTK_PIN_NO(109) | 3)
> > >>>>> +#define PINMUX_GPIO109__FUNC_SDA8 (MTK_PIN_NO(109) | 4)
> > >>>>> +#define PINMUX_GPIO109__FUNC_DAP_MD32_SWCK (MTK_PIN_NO(109) | 5)
> > >>>>> +#define PINMUX_GPIO109__FUNC_PWM_C (MTK_PIN_NO(109) | 6)
> > >>>>> +#define PINMUX_GPIO109__FUNC_DBG_MON_B14 (MTK_PIN_NO(109) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO110__FUNC_GPIO110 (MTK_PIN_NO(110) | 0)
> > >>>>> +#define PINMUX_GPIO110__FUNC_SCL7 (MTK_PIN_NO(110) | 1)
> > >>>>> +#define PINMUX_GPIO110__FUNC_ANT_SEL0 (MTK_PIN_NO(110) | 2)
> > >>>>> +#define PINMUX_GPIO110__FUNC_TP_URXD1_AO (MTK_PIN_NO(110) | 3)
> > >>>>> +#define PINMUX_GPIO110__FUNC_USB_DRVVBUS (MTK_PIN_NO(110) | 4)
> > >>>>> +#define PINMUX_GPIO110__FUNC_SRCLKENAI1 (MTK_PIN_NO(110) | 5)
> > >>>>> +#define PINMUX_GPIO110__FUNC_KPCOL2 (MTK_PIN_NO(110) | 6)
> > >>>>> +#define PINMUX_GPIO110__FUNC_URXD1 (MTK_PIN_NO(110) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO111__FUNC_GPIO111 (MTK_PIN_NO(111) | 0)
> > >>>>> +#define PINMUX_GPIO111__FUNC_CMMCLK3 (MTK_PIN_NO(111) | 1)
> > >>>>> +#define PINMUX_GPIO111__FUNC_ANT_SEL1 (MTK_PIN_NO(111) | 2)
> > >>>>> +#define PINMUX_GPIO111__FUNC_SRCLKENAI0 (MTK_PIN_NO(111) | 3)
> > >>>>> +#define PINMUX_GPIO111__FUNC_SCP_VREQ_VAO (MTK_PIN_NO(111) | 4)
> > >>>>> +#define PINMUX_GPIO111__FUNC_MD_INT2_C2K_UIM1_HOT_PLUG (MTK_PIN_NO(111) | 5)
> > >>>>> +#define PINMUX_GPIO111__FUNC_DVFSRC_EXT_REQ (MTK_PIN_NO(111) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO112__FUNC_GPIO112 (MTK_PIN_NO(112) | 0)
> > >>>>> +#define PINMUX_GPIO112__FUNC_SDA7 (MTK_PIN_NO(112) | 1)
> > >>>>> +#define PINMUX_GPIO112__FUNC_ANT_SEL2 (MTK_PIN_NO(112) | 2)
> > >>>>> +#define PINMUX_GPIO112__FUNC_TP_UTXD1_AO (MTK_PIN_NO(112) | 3)
> > >>>>> +#define PINMUX_GPIO112__FUNC_IDDIG (MTK_PIN_NO(112) | 4)
> > >>>>> +#define PINMUX_GPIO112__FUNC_AGPS_SYNC (MTK_PIN_NO(112) | 5)
> > >>>>> +#define PINMUX_GPIO112__FUNC_KPROW2 (MTK_PIN_NO(112) | 6)
> > >>>>> +#define PINMUX_GPIO112__FUNC_UTXD1 (MTK_PIN_NO(112) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO113__FUNC_GPIO113 (MTK_PIN_NO(113) | 0)
> > >>>>> +#define PINMUX_GPIO113__FUNC_CONN_TOP_CLK (MTK_PIN_NO(113) | 1)
> > >>>>> +#define PINMUX_GPIO113__FUNC_SCL6 (MTK_PIN_NO(113) | 3)
> > >>>>> +#define PINMUX_GPIO113__FUNC_AUXIF_CLK0 (MTK_PIN_NO(113) | 4)
> > >>>>> +#define PINMUX_GPIO113__FUNC_TP_UCTS1_AO (MTK_PIN_NO(113) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO114__FUNC_GPIO114 (MTK_PIN_NO(114) | 0)
> > >>>>> +#define PINMUX_GPIO114__FUNC_CONN_TOP_DATA (MTK_PIN_NO(114) | 1)
> > >>>>> +#define PINMUX_GPIO114__FUNC_SDA6 (MTK_PIN_NO(114) | 3)
> > >>>>> +#define PINMUX_GPIO114__FUNC_AUXIF_ST0 (MTK_PIN_NO(114) | 4)
> > >>>>> +#define PINMUX_GPIO114__FUNC_TP_URTS1_AO (MTK_PIN_NO(114) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO115__FUNC_GPIO115 (MTK_PIN_NO(115) | 0)
> > >>>>> +#define PINMUX_GPIO115__FUNC_CONN_BT_CLK (MTK_PIN_NO(115) | 1)
> > >>>>> +#define PINMUX_GPIO115__FUNC_UTXD1 (MTK_PIN_NO(115) | 2)
> > >>>>> +#define PINMUX_GPIO115__FUNC_PTA_TXD (MTK_PIN_NO(115) | 3)
> > >>>>> +#define PINMUX_GPIO115__FUNC_AUXIF_CLK1 (MTK_PIN_NO(115) | 4)
> > >>>>> +#define PINMUX_GPIO115__FUNC_DAP_MD32_SWD (MTK_PIN_NO(115) | 5)
> > >>>>> +#define PINMUX_GPIO115__FUNC_TP_UTXD1_AO (MTK_PIN_NO(115) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO116__FUNC_GPIO116 (MTK_PIN_NO(116) | 0)
> > >>>>> +#define PINMUX_GPIO116__FUNC_CONN_BT_DATA (MTK_PIN_NO(116) | 1)
> > >>>>> +#define PINMUX_GPIO116__FUNC_IPU_JTAG_TRST (MTK_PIN_NO(116) | 2)
> > >>>>> +#define PINMUX_GPIO116__FUNC_AUXIF_ST1 (MTK_PIN_NO(116) | 4)
> > >>>>> +#define PINMUX_GPIO116__FUNC_DAP_MD32_SWCK (MTK_PIN_NO(116) | 5)
> > >>>>> +#define PINMUX_GPIO116__FUNC_TP_URXD2_AO (MTK_PIN_NO(116) | 6)
> > >>>>> +#define PINMUX_GPIO116__FUNC_DBG_MON_A0 (MTK_PIN_NO(116) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO117__FUNC_GPIO117 (MTK_PIN_NO(117) | 0)
> > >>>>> +#define PINMUX_GPIO117__FUNC_CONN_WF_HB0 (MTK_PIN_NO(117) | 1)
> > >>>>> +#define PINMUX_GPIO117__FUNC_IPU_JTAG_TDO (MTK_PIN_NO(117) | 2)
> > >>>>> +#define PINMUX_GPIO117__FUNC_TP_UTXD2_AO (MTK_PIN_NO(117) | 6)
> > >>>>> +#define PINMUX_GPIO117__FUNC_DBG_MON_A4 (MTK_PIN_NO(117) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO118__FUNC_GPIO118 (MTK_PIN_NO(118) | 0)
> > >>>>> +#define PINMUX_GPIO118__FUNC_CONN_WF_HB1 (MTK_PIN_NO(118) | 1)
> > >>>>> +#define PINMUX_GPIO118__FUNC_IPU_JTAG_TDI (MTK_PIN_NO(118) | 2)
> > >>>>> +#define PINMUX_GPIO118__FUNC_SSPM_URXD_AO (MTK_PIN_NO(118) | 5)
> > >>>>> +#define PINMUX_GPIO118__FUNC_TP_UCTS2_AO (MTK_PIN_NO(118) | 6)
> > >>>>> +#define PINMUX_GPIO118__FUNC_DBG_MON_A5 (MTK_PIN_NO(118) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO119__FUNC_GPIO119 (MTK_PIN_NO(119) | 0)
> > >>>>> +#define PINMUX_GPIO119__FUNC_CONN_WF_HB2 (MTK_PIN_NO(119) | 1)
> > >>>>> +#define PINMUX_GPIO119__FUNC_IPU_JTAG_TCK (MTK_PIN_NO(119) | 2)
> > >>>>> +#define PINMUX_GPIO119__FUNC_SSPM_UTXD_AO (MTK_PIN_NO(119) | 5)
> > >>>>> +#define PINMUX_GPIO119__FUNC_TP_URTS2_AO (MTK_PIN_NO(119) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO120__FUNC_GPIO120 (MTK_PIN_NO(120) | 0)
> > >>>>> +#define PINMUX_GPIO120__FUNC_CONN_WB_PTA (MTK_PIN_NO(120) | 1)
> > >>>>> +#define PINMUX_GPIO120__FUNC_IPU_JTAG_TMS (MTK_PIN_NO(120) | 2)
> > >>>>> +#define PINMUX_GPIO120__FUNC_CCU_URXD_AO (MTK_PIN_NO(120) | 5)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO121__FUNC_GPIO121 (MTK_PIN_NO(121) | 0)
> > >>>>> +#define PINMUX_GPIO121__FUNC_CONN_HRST_B (MTK_PIN_NO(121) | 1)
> > >>>>> +#define PINMUX_GPIO121__FUNC_URXD1 (MTK_PIN_NO(121) | 2)
> > >>>>> +#define PINMUX_GPIO121__FUNC_PTA_RXD (MTK_PIN_NO(121) | 3)
> > >>>>> +#define PINMUX_GPIO121__FUNC_CCU_UTXD_AO (MTK_PIN_NO(121) | 5)
> > >>>>> +#define PINMUX_GPIO121__FUNC_TP_URXD1_AO (MTK_PIN_NO(121) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO122__FUNC_GPIO122 (MTK_PIN_NO(122) | 0)
> > >>>>> +#define PINMUX_GPIO122__FUNC_MSDC0_CMD (MTK_PIN_NO(122) | 1)
> > >>>>> +#define PINMUX_GPIO122__FUNC_SSPM_URXD2_AO (MTK_PIN_NO(122) | 2)
> > >>>>> +#define PINMUX_GPIO122__FUNC_ANT_SEL1 (MTK_PIN_NO(122) | 3)
> > >>>>> +#define PINMUX_GPIO122__FUNC_DBG_MON_A12 (MTK_PIN_NO(122) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO123__FUNC_GPIO123 (MTK_PIN_NO(123) | 0)
> > >>>>> +#define PINMUX_GPIO123__FUNC_MSDC0_DAT0 (MTK_PIN_NO(123) | 1)
> > >>>>> +#define PINMUX_GPIO123__FUNC_ANT_SEL0 (MTK_PIN_NO(123) | 3)
> > >>>>> +#define PINMUX_GPIO123__FUNC_DBG_MON_A13 (MTK_PIN_NO(123) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO124__FUNC_GPIO124 (MTK_PIN_NO(124) | 0)
> > >>>>> +#define PINMUX_GPIO124__FUNC_MSDC0_CLK (MTK_PIN_NO(124) | 1)
> > >>>>> +#define PINMUX_GPIO124__FUNC_DBG_MON_A14 (MTK_PIN_NO(124) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO125__FUNC_GPIO125 (MTK_PIN_NO(125) | 0)
> > >>>>> +#define PINMUX_GPIO125__FUNC_MSDC0_DAT2 (MTK_PIN_NO(125) | 1)
> > >>>>> +#define PINMUX_GPIO125__FUNC_MRG_CLK (MTK_PIN_NO(125) | 3)
> > >>>>> +#define PINMUX_GPIO125__FUNC_DBG_MON_A15 (MTK_PIN_NO(125) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO126__FUNC_GPIO126 (MTK_PIN_NO(126) | 0)
> > >>>>> +#define PINMUX_GPIO126__FUNC_MSDC0_DAT4 (MTK_PIN_NO(126) | 1)
> > >>>>> +#define PINMUX_GPIO126__FUNC_ANT_SEL5 (MTK_PIN_NO(126) | 3)
> > >>>>> +#define PINMUX_GPIO126__FUNC_UFS_MPHY_SCL (MTK_PIN_NO(126) | 6)
> > >>>>> +#define PINMUX_GPIO126__FUNC_DBG_MON_A16 (MTK_PIN_NO(126) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO127__FUNC_GPIO127 (MTK_PIN_NO(127) | 0)
> > >>>>> +#define PINMUX_GPIO127__FUNC_MSDC0_DAT6 (MTK_PIN_NO(127) | 1)
> > >>>>> +#define PINMUX_GPIO127__FUNC_ANT_SEL4 (MTK_PIN_NO(127) | 3)
> > >>>>> +#define PINMUX_GPIO127__FUNC_UFS_MPHY_SDA (MTK_PIN_NO(127) | 6)
> > >>>>> +#define PINMUX_GPIO127__FUNC_DBG_MON_A17 (MTK_PIN_NO(127) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO128__FUNC_GPIO128 (MTK_PIN_NO(128) | 0)
> > >>>>> +#define PINMUX_GPIO128__FUNC_MSDC0_DAT1 (MTK_PIN_NO(128) | 1)
> > >>>>> +#define PINMUX_GPIO128__FUNC_ANT_SEL2 (MTK_PIN_NO(128) | 3)
> > >>>>> +#define PINMUX_GPIO128__FUNC_UFS_UNIPRO_SDA (MTK_PIN_NO(128) | 6)
> > >>>>> +#define PINMUX_GPIO128__FUNC_DBG_MON_A18 (MTK_PIN_NO(128) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO129__FUNC_GPIO129 (MTK_PIN_NO(129) | 0)
> > >>>>> +#define PINMUX_GPIO129__FUNC_MSDC0_DAT5 (MTK_PIN_NO(129) | 1)
> > >>>>> +#define PINMUX_GPIO129__FUNC_ANT_SEL3 (MTK_PIN_NO(129) | 3)
> > >>>>> +#define PINMUX_GPIO129__FUNC_UFS_UNIPRO_SCL (MTK_PIN_NO(129) | 6)
> > >>>>> +#define PINMUX_GPIO129__FUNC_DBG_MON_A23 (MTK_PIN_NO(129) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO130__FUNC_GPIO130 (MTK_PIN_NO(130) | 0)
> > >>>>> +#define PINMUX_GPIO130__FUNC_MSDC0_DAT7 (MTK_PIN_NO(130) | 1)
> > >>>>> +#define PINMUX_GPIO130__FUNC_MRG_DO (MTK_PIN_NO(130) | 3)
> > >>>>> +#define PINMUX_GPIO130__FUNC_DBG_MON_A24 (MTK_PIN_NO(130) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO131__FUNC_GPIO131 (MTK_PIN_NO(131) | 0)
> > >>>>> +#define PINMUX_GPIO131__FUNC_MSDC0_DSL (MTK_PIN_NO(131) | 1)
> > >>>>> +#define PINMUX_GPIO131__FUNC_MRG_SYNC (MTK_PIN_NO(131) | 3)
> > >>>>> +#define PINMUX_GPIO131__FUNC_DBG_MON_A25 (MTK_PIN_NO(131) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO132__FUNC_GPIO132 (MTK_PIN_NO(132) | 0)
> > >>>>> +#define PINMUX_GPIO132__FUNC_MSDC0_DAT3 (MTK_PIN_NO(132) | 1)
> > >>>>> +#define PINMUX_GPIO132__FUNC_MRG_DI (MTK_PIN_NO(132) | 3)
> > >>>>> +#define PINMUX_GPIO132__FUNC_DBG_MON_A26 (MTK_PIN_NO(132) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO133__FUNC_GPIO133 (MTK_PIN_NO(133) | 0)
> > >>>>> +#define PINMUX_GPIO133__FUNC_MSDC0_RSTB (MTK_PIN_NO(133) | 1)
> > >>>>> +#define PINMUX_GPIO133__FUNC_AGPS_SYNC (MTK_PIN_NO(133) | 3)
> > >>>>> +#define PINMUX_GPIO133__FUNC_DBG_MON_A27 (MTK_PIN_NO(133) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO134__FUNC_GPIO134 (MTK_PIN_NO(134) | 0)
> > >>>>> +#define PINMUX_GPIO134__FUNC_RTC32K_CK (MTK_PIN_NO(134) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO135__FUNC_GPIO135 (MTK_PIN_NO(135) | 0)
> > >>>>> +#define PINMUX_GPIO135__FUNC_WATCHDOG (MTK_PIN_NO(135) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO136__FUNC_GPIO136 (MTK_PIN_NO(136) | 0)
> > >>>>> +#define PINMUX_GPIO136__FUNC_AUD_CLK_MOSI (MTK_PIN_NO(136) | 1)
> > >>>>> +#define PINMUX_GPIO136__FUNC_AUD_CLK_MISO (MTK_PIN_NO(136) | 2)
> > >>>>> +#define PINMUX_GPIO136__FUNC_I2S1_MCK (MTK_PIN_NO(136) | 3)
> > >>>>> +#define PINMUX_GPIO136__FUNC_UFS_UNIPRO_SCL (MTK_PIN_NO(136) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO137__FUNC_GPIO137 (MTK_PIN_NO(137) | 0)
> > >>>>> +#define PINMUX_GPIO137__FUNC_AUD_SYNC_MOSI (MTK_PIN_NO(137) | 1)
> > >>>>> +#define PINMUX_GPIO137__FUNC_AUD_SYNC_MISO (MTK_PIN_NO(137) | 2)
> > >>>>> +#define PINMUX_GPIO137__FUNC_I2S1_BCK (MTK_PIN_NO(137) | 3)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO138__FUNC_GPIO138 (MTK_PIN_NO(138) | 0)
> > >>>>> +#define PINMUX_GPIO138__FUNC_AUD_DAT_MOSI0 (MTK_PIN_NO(138) | 1)
> > >>>>> +#define PINMUX_GPIO138__FUNC_AUD_DAT_MISO0 (MTK_PIN_NO(138) | 2)
> > >>>>> +#define PINMUX_GPIO138__FUNC_I2S1_LRCK (MTK_PIN_NO(138) | 3)
> > >>>>> +#define PINMUX_GPIO138__FUNC_DBG_MON_B24 (MTK_PIN_NO(138) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO139__FUNC_GPIO139 (MTK_PIN_NO(139) | 0)
> > >>>>> +#define PINMUX_GPIO139__FUNC_AUD_DAT_MOSI1 (MTK_PIN_NO(139) | 1)
> > >>>>> +#define PINMUX_GPIO139__FUNC_AUD_DAT_MISO1 (MTK_PIN_NO(139) | 2)
> > >>>>> +#define PINMUX_GPIO139__FUNC_I2S1_DO (MTK_PIN_NO(139) | 3)
> > >>>>> +#define PINMUX_GPIO139__FUNC_UFS_MPHY_SDA (MTK_PIN_NO(139) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO140__FUNC_GPIO140 (MTK_PIN_NO(140) | 0)
> > >>>>> +#define PINMUX_GPIO140__FUNC_AUD_CLK_MISO (MTK_PIN_NO(140) | 1)
> > >>>>> +#define PINMUX_GPIO140__FUNC_AUD_CLK_MOSI (MTK_PIN_NO(140) | 2)
> > >>>>> +#define PINMUX_GPIO140__FUNC_I2S0_MCK (MTK_PIN_NO(140) | 3)
> > >>>>> +#define PINMUX_GPIO140__FUNC_UFS_UNIPRO_SDA (MTK_PIN_NO(140) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO141__FUNC_GPIO141 (MTK_PIN_NO(141) | 0)
> > >>>>> +#define PINMUX_GPIO141__FUNC_AUD_SYNC_MISO (MTK_PIN_NO(141) | 1)
> > >>>>> +#define PINMUX_GPIO141__FUNC_AUD_SYNC_MOSI (MTK_PIN_NO(141) | 2)
> > >>>>> +#define PINMUX_GPIO141__FUNC_I2S0_BCK (MTK_PIN_NO(141) | 3)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO142__FUNC_GPIO142 (MTK_PIN_NO(142) | 0)
> > >>>>> +#define PINMUX_GPIO142__FUNC_AUD_DAT_MISO0 (MTK_PIN_NO(142) | 1)
> > >>>>> +#define PINMUX_GPIO142__FUNC_AUD_DAT_MOSI0 (MTK_PIN_NO(142) | 2)
> > >>>>> +#define PINMUX_GPIO142__FUNC_I2S0_LRCK (MTK_PIN_NO(142) | 3)
> > >>>>> +#define PINMUX_GPIO142__FUNC_VOW_DAT_MISO (MTK_PIN_NO(142) | 4)
> > >>>>> +#define PINMUX_GPIO142__FUNC_DBG_MON_B25 (MTK_PIN_NO(142) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO143__FUNC_GPIO143 (MTK_PIN_NO(143) | 0)
> > >>>>> +#define PINMUX_GPIO143__FUNC_AUD_DAT_MISO1 (MTK_PIN_NO(143) | 1)
> > >>>>> +#define PINMUX_GPIO143__FUNC_AUD_DAT_MOSI1 (MTK_PIN_NO(143) | 2)
> > >>>>> +#define PINMUX_GPIO143__FUNC_I2S0_DI (MTK_PIN_NO(143) | 3)
> > >>>>> +#define PINMUX_GPIO143__FUNC_VOW_CLK_MISO (MTK_PIN_NO(143) | 4)
> > >>>>> +#define PINMUX_GPIO143__FUNC_UFS_MPHY_SCL (MTK_PIN_NO(143) | 6)
> > >>>>> +#define PINMUX_GPIO143__FUNC_DBG_MON_B26 (MTK_PIN_NO(143) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO144__FUNC_GPIO144 (MTK_PIN_NO(144) | 0)
> > >>>>> +#define PINMUX_GPIO144__FUNC_PWRAP_SPI0_MI (MTK_PIN_NO(144) | 1)
> > >>>>> +#define PINMUX_GPIO144__FUNC_PWRAP_SPI0_MO (MTK_PIN_NO(144) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO145__FUNC_GPIO145 (MTK_PIN_NO(145) | 0)
> > >>>>> +#define PINMUX_GPIO145__FUNC_PWRAP_SPI0_CSN (MTK_PIN_NO(145) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO146__FUNC_GPIO146 (MTK_PIN_NO(146) | 0)
> > >>>>> +#define PINMUX_GPIO146__FUNC_PWRAP_SPI0_MO (MTK_PIN_NO(146) | 1)
> > >>>>> +#define PINMUX_GPIO146__FUNC_PWRAP_SPI0_MI (MTK_PIN_NO(146) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO147__FUNC_GPIO147 (MTK_PIN_NO(147) | 0)
> > >>>>> +#define PINMUX_GPIO147__FUNC_PWRAP_SPI0_CK (MTK_PIN_NO(147) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO148__FUNC_GPIO148 (MTK_PIN_NO(148) | 0)
> > >>>>> +#define PINMUX_GPIO148__FUNC_SRCLKENA0 (MTK_PIN_NO(148) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO149__FUNC_GPIO149 (MTK_PIN_NO(149) | 0)
> > >>>>> +#define PINMUX_GPIO149__FUNC_SRCLKENA1 (MTK_PIN_NO(149) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO150__FUNC_GPIO150 (MTK_PIN_NO(150) | 0)
> > >>>>> +#define PINMUX_GPIO150__FUNC_PWM_A (MTK_PIN_NO(150) | 1)
> > >>>>> +#define PINMUX_GPIO150__FUNC_CMFLASH (MTK_PIN_NO(150) | 2)
> > >>>>> +#define PINMUX_GPIO150__FUNC_CLKM0 (MTK_PIN_NO(150) | 3)
> > >>>>> +#define PINMUX_GPIO150__FUNC_DBG_MON_B30 (MTK_PIN_NO(150) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO151__FUNC_GPIO151 (MTK_PIN_NO(151) | 0)
> > >>>>> +#define PINMUX_GPIO151__FUNC_PWM_B (MTK_PIN_NO(151) | 1)
> > >>>>> +#define PINMUX_GPIO151__FUNC_CMVREF0 (MTK_PIN_NO(151) | 2)
> > >>>>> +#define PINMUX_GPIO151__FUNC_CLKM1 (MTK_PIN_NO(151) | 3)
> > >>>>> +#define PINMUX_GPIO151__FUNC_DBG_MON_B20 (MTK_PIN_NO(151) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO152__FUNC_GPIO152 (MTK_PIN_NO(152) | 0)
> > >>>>> +#define PINMUX_GPIO152__FUNC_PWM_C (MTK_PIN_NO(152) | 1)
> > >>>>> +#define PINMUX_GPIO152__FUNC_CMFLASH (MTK_PIN_NO(152) | 2)
> > >>>>> +#define PINMUX_GPIO152__FUNC_CLKM2 (MTK_PIN_NO(152) | 3)
> > >>>>> +#define PINMUX_GPIO152__FUNC_DBG_MON_B21 (MTK_PIN_NO(152) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO153__FUNC_GPIO153 (MTK_PIN_NO(153) | 0)
> > >>>>> +#define PINMUX_GPIO153__FUNC_PWM_A (MTK_PIN_NO(153) | 1)
> > >>>>> +#define PINMUX_GPIO153__FUNC_CMVREF0 (MTK_PIN_NO(153) | 2)
> > >>>>> +#define PINMUX_GPIO153__FUNC_CLKM3 (MTK_PIN_NO(153) | 3)
> > >>>>> +#define PINMUX_GPIO153__FUNC_DBG_MON_B22 (MTK_PIN_NO(153) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO154__FUNC_GPIO154 (MTK_PIN_NO(154) | 0)
> > >>>>> +#define PINMUX_GPIO154__FUNC_SCP_VREQ_VAO (MTK_PIN_NO(154) | 1)
> > >>>>> +#define PINMUX_GPIO154__FUNC_DVFSRC_EXT_REQ (MTK_PIN_NO(154) | 2)
> > >>>>> +#define PINMUX_GPIO154__FUNC_DBG_MON_B18 (MTK_PIN_NO(154) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO155__FUNC_GPIO155 (MTK_PIN_NO(155) | 0)
> > >>>>> +#define PINMUX_GPIO155__FUNC_ANT_SEL0 (MTK_PIN_NO(155) | 1)
> > >>>>> +#define PINMUX_GPIO155__FUNC_DVFSRC_EXT_REQ (MTK_PIN_NO(155) | 2)
> > >>>>> +#define PINMUX_GPIO155__FUNC_CMVREF1 (MTK_PIN_NO(155) | 3)
> > >>>>> +#define PINMUX_GPIO155__FUNC_SCP_JTAG_TDI (MTK_PIN_NO(155) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO156__FUNC_GPIO156 (MTK_PIN_NO(156) | 0)
> > >>>>> +#define PINMUX_GPIO156__FUNC_ANT_SEL1 (MTK_PIN_NO(156) | 1)
> > >>>>> +#define PINMUX_GPIO156__FUNC_SRCLKENAI0 (MTK_PIN_NO(156) | 2)
> > >>>>> +#define PINMUX_GPIO156__FUNC_SCL6 (MTK_PIN_NO(156) | 3)
> > >>>>> +#define PINMUX_GPIO156__FUNC_KPCOL2 (MTK_PIN_NO(156) | 4)
> > >>>>> +#define PINMUX_GPIO156__FUNC_IDDIG (MTK_PIN_NO(156) | 5)
> > >>>>> +#define PINMUX_GPIO156__FUNC_SCP_JTAG_TCK (MTK_PIN_NO(156) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO157__FUNC_GPIO157 (MTK_PIN_NO(157) | 0)
> > >>>>> +#define PINMUX_GPIO157__FUNC_ANT_SEL2 (MTK_PIN_NO(157) | 1)
> > >>>>> +#define PINMUX_GPIO157__FUNC_SRCLKENAI1 (MTK_PIN_NO(157) | 2)
> > >>>>> +#define PINMUX_GPIO157__FUNC_SDA6 (MTK_PIN_NO(157) | 3)
> > >>>>> +#define PINMUX_GPIO157__FUNC_KPROW2 (MTK_PIN_NO(157) | 4)
> > >>>>> +#define PINMUX_GPIO157__FUNC_USB_DRVVBUS (MTK_PIN_NO(157) | 5)
> > >>>>> +#define PINMUX_GPIO157__FUNC_SCP_JTAG_TRSTN (MTK_PIN_NO(157) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO158__FUNC_GPIO158 (MTK_PIN_NO(158) | 0)
> > >>>>> +#define PINMUX_GPIO158__FUNC_ANT_SEL3 (MTK_PIN_NO(158) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO159__FUNC_GPIO159 (MTK_PIN_NO(159) | 0)
> > >>>>> +#define PINMUX_GPIO159__FUNC_ANT_SEL4 (MTK_PIN_NO(159) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO160__FUNC_GPIO160 (MTK_PIN_NO(160) | 0)
> > >>>>> +#define PINMUX_GPIO160__FUNC_ANT_SEL5 (MTK_PIN_NO(160) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO161__FUNC_GPIO161 (MTK_PIN_NO(161) | 0)
> > >>>>> +#define PINMUX_GPIO161__FUNC_SPI1_A_MI (MTK_PIN_NO(161) | 1)
> > >>>>> +#define PINMUX_GPIO161__FUNC_SCP_SPI1_MI (MTK_PIN_NO(161) | 2)
> > >>>>> +#define PINMUX_GPIO161__FUNC_IDDIG (MTK_PIN_NO(161) | 3)
> > >>>>> +#define PINMUX_GPIO161__FUNC_ANT_SEL6 (MTK_PIN_NO(161) | 4)
> > >>>>> +#define PINMUX_GPIO161__FUNC_KPCOL2 (MTK_PIN_NO(161) | 5)
> > >>>>> +#define PINMUX_GPIO161__FUNC_PTA_RXD (MTK_PIN_NO(161) | 6)
> > >>>>> +#define PINMUX_GPIO161__FUNC_DBG_MON_B19 (MTK_PIN_NO(161) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO162__FUNC_GPIO162 (MTK_PIN_NO(162) | 0)
> > >>>>> +#define PINMUX_GPIO162__FUNC_SPI1_A_CSB (MTK_PIN_NO(162) | 1)
> > >>>>> +#define PINMUX_GPIO162__FUNC_SCP_SPI1_CS (MTK_PIN_NO(162) | 2)
> > >>>>> +#define PINMUX_GPIO162__FUNC_USB_DRVVBUS (MTK_PIN_NO(162) | 3)
> > >>>>> +#define PINMUX_GPIO162__FUNC_ANT_SEL5 (MTK_PIN_NO(162) | 4)
> > >>>>> +#define PINMUX_GPIO162__FUNC_KPROW2 (MTK_PIN_NO(162) | 5)
> > >>>>> +#define PINMUX_GPIO162__FUNC_PTA_TXD (MTK_PIN_NO(162) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO163__FUNC_GPIO163 (MTK_PIN_NO(163) | 0)
> > >>>>> +#define PINMUX_GPIO163__FUNC_SPI1_A_MO (MTK_PIN_NO(163) | 1)
> > >>>>> +#define PINMUX_GPIO163__FUNC_SCP_SPI1_MO (MTK_PIN_NO(163) | 2)
> > >>>>> +#define PINMUX_GPIO163__FUNC_SDA1 (MTK_PIN_NO(163) | 3)
> > >>>>> +#define PINMUX_GPIO163__FUNC_ANT_SEL4 (MTK_PIN_NO(163) | 4)
> > >>>>> +#define PINMUX_GPIO163__FUNC_CMMCLK2 (MTK_PIN_NO(163) | 5)
> > >>>>> +#define PINMUX_GPIO163__FUNC_DMIC_CLK (MTK_PIN_NO(163) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO164__FUNC_GPIO164 (MTK_PIN_NO(164) | 0)
> > >>>>> +#define PINMUX_GPIO164__FUNC_SPI1_A_CLK (MTK_PIN_NO(164) | 1)
> > >>>>> +#define PINMUX_GPIO164__FUNC_SCP_SPI1_CK (MTK_PIN_NO(164) | 2)
> > >>>>> +#define PINMUX_GPIO164__FUNC_SCL1 (MTK_PIN_NO(164) | 3)
> > >>>>> +#define PINMUX_GPIO164__FUNC_ANT_SEL3 (MTK_PIN_NO(164) | 4)
> > >>>>> +#define PINMUX_GPIO164__FUNC_CMMCLK3 (MTK_PIN_NO(164) | 5)
> > >>>>> +#define PINMUX_GPIO164__FUNC_DMIC_DAT (MTK_PIN_NO(164) | 6)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO165__FUNC_GPIO165 (MTK_PIN_NO(165) | 0)
> > >>>>> +#define PINMUX_GPIO165__FUNC_PWM_B (MTK_PIN_NO(165) | 1)
> > >>>>> +#define PINMUX_GPIO165__FUNC_CMMCLK2 (MTK_PIN_NO(165) | 2)
> > >>>>> +#define PINMUX_GPIO165__FUNC_SCP_VREQ_VAO (MTK_PIN_NO(165) | 3)
> > >>>>> +#define PINMUX_GPIO165__FUNC_TDM_MCK_2ND (MTK_PIN_NO(165) | 6)
> > >>>>> +#define PINMUX_GPIO165__FUNC_SCP_JTAG_TDO (MTK_PIN_NO(165) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO166__FUNC_GPIO166 (MTK_PIN_NO(166) | 0)
> > >>>>> +#define PINMUX_GPIO166__FUNC_ANT_SEL6 (MTK_PIN_NO(166) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO167__FUNC_GPIO167 (MTK_PIN_NO(167) | 0)
> > >>>>> +#define PINMUX_GPIO167__FUNC_RFIC0_BSI_EN (MTK_PIN_NO(167) | 1)
> > >>>>> +#define PINMUX_GPIO167__FUNC_SPM_BSI_EN (MTK_PIN_NO(167) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO168__FUNC_GPIO168 (MTK_PIN_NO(168) | 0)
> > >>>>> +#define PINMUX_GPIO168__FUNC_RFIC0_BSI_CK (MTK_PIN_NO(168) | 1)
> > >>>>> +#define PINMUX_GPIO168__FUNC_SPM_BSI_CK (MTK_PIN_NO(168) | 2)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO169__FUNC_GPIO169 (MTK_PIN_NO(169) | 0)
> > >>>>> +#define PINMUX_GPIO169__FUNC_PWM_C (MTK_PIN_NO(169) | 1)
> > >>>>> +#define PINMUX_GPIO169__FUNC_CMMCLK3 (MTK_PIN_NO(169) | 2)
> > >>>>> +#define PINMUX_GPIO169__FUNC_CMVREF1 (MTK_PIN_NO(169) | 3)
> > >>>>> +#define PINMUX_GPIO169__FUNC_ANT_SEL7 (MTK_PIN_NO(169) | 4)
> > >>>>> +#define PINMUX_GPIO169__FUNC_AGPS_SYNC (MTK_PIN_NO(169) | 5)
> > >>>>> +#define PINMUX_GPIO169__FUNC_TDM_BCK_2ND (MTK_PIN_NO(169) | 6)
> > >>>>> +#define PINMUX_GPIO169__FUNC_SCP_JTAG_TMS (MTK_PIN_NO(169) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO170__FUNC_GPIO170 (MTK_PIN_NO(170) | 0)
> > >>>>> +#define PINMUX_GPIO170__FUNC_I2S1_BCK (MTK_PIN_NO(170) | 1)
> > >>>>> +#define PINMUX_GPIO170__FUNC_I2S3_BCK (MTK_PIN_NO(170) | 2)
> > >>>>> +#define PINMUX_GPIO170__FUNC_SCL7 (MTK_PIN_NO(170) | 3)
> > >>>>> +#define PINMUX_GPIO170__FUNC_I2S5_BCK (MTK_PIN_NO(170) | 4)
> > >>>>> +#define PINMUX_GPIO170__FUNC_EXT_FRAME_SYNC (MTK_PIN_NO(170) | 5)
> > >>>>> +#define PINMUX_GPIO170__FUNC_TDM_LRCK_2ND (MTK_PIN_NO(170) | 6)
> > >>>>> +#define PINMUX_GPIO170__FUNC_ANT_SEL3 (MTK_PIN_NO(170) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO171__FUNC_GPIO171 (MTK_PIN_NO(171) | 0)
> > >>>>> +#define PINMUX_GPIO171__FUNC_I2S1_LRCK (MTK_PIN_NO(171) | 1)
> > >>>>> +#define PINMUX_GPIO171__FUNC_I2S3_LRCK (MTK_PIN_NO(171) | 2)
> > >>>>> +#define PINMUX_GPIO171__FUNC_SDA7 (MTK_PIN_NO(171) | 3)
> > >>>>> +#define PINMUX_GPIO171__FUNC_I2S5_LRCK (MTK_PIN_NO(171) | 4)
> > >>>>> +#define PINMUX_GPIO171__FUNC_URXD1 (MTK_PIN_NO(171) | 5)
> > >>>>> +#define PINMUX_GPIO171__FUNC_TDM_DATA0_2ND (MTK_PIN_NO(171) | 6)
> > >>>>> +#define PINMUX_GPIO171__FUNC_ANT_SEL4 (MTK_PIN_NO(171) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO172__FUNC_GPIO172 (MTK_PIN_NO(172) | 0)
> > >>>>> +#define PINMUX_GPIO172__FUNC_I2S1_DO (MTK_PIN_NO(172) | 1)
> > >>>>> +#define PINMUX_GPIO172__FUNC_I2S3_DO (MTK_PIN_NO(172) | 2)
> > >>>>> +#define PINMUX_GPIO172__FUNC_SCL8 (MTK_PIN_NO(172) | 3)
> > >>>>> +#define PINMUX_GPIO172__FUNC_I2S5_DO (MTK_PIN_NO(172) | 4)
> > >>>>> +#define PINMUX_GPIO172__FUNC_UTXD1 (MTK_PIN_NO(172) | 5)
> > >>>>> +#define PINMUX_GPIO172__FUNC_TDM_DATA1_2ND (MTK_PIN_NO(172) | 6)
> > >>>>> +#define PINMUX_GPIO172__FUNC_ANT_SEL5 (MTK_PIN_NO(172) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO173__FUNC_GPIO173 (MTK_PIN_NO(173) | 0)
> > >>>>> +#define PINMUX_GPIO173__FUNC_I2S1_MCK (MTK_PIN_NO(173) | 1)
> > >>>>> +#define PINMUX_GPIO173__FUNC_I2S3_MCK (MTK_PIN_NO(173) | 2)
> > >>>>> +#define PINMUX_GPIO173__FUNC_SDA8 (MTK_PIN_NO(173) | 3)
> > >>>>> +#define PINMUX_GPIO173__FUNC_I2S5_MCK (MTK_PIN_NO(173) | 4)
> > >>>>> +#define PINMUX_GPIO173__FUNC_UCTS0 (MTK_PIN_NO(173) | 5)
> > >>>>> +#define PINMUX_GPIO173__FUNC_TDM_DATA2_2ND (MTK_PIN_NO(173) | 6)
> > >>>>> +#define PINMUX_GPIO173__FUNC_ANT_SEL6 (MTK_PIN_NO(173) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO174__FUNC_GPIO174 (MTK_PIN_NO(174) | 0)
> > >>>>> +#define PINMUX_GPIO174__FUNC_I2S2_DI (MTK_PIN_NO(174) | 1)
> > >>>>> +#define PINMUX_GPIO174__FUNC_I2S0_DI (MTK_PIN_NO(174) | 2)
> > >>>>> +#define PINMUX_GPIO174__FUNC_DVFSRC_EXT_REQ (MTK_PIN_NO(174) | 3)
> > >>>>> +#define PINMUX_GPIO174__FUNC_I2S2_DI2 (MTK_PIN_NO(174) | 4)
> > >>>>> +#define PINMUX_GPIO174__FUNC_URTS0 (MTK_PIN_NO(174) | 5)
> > >>>>> +#define PINMUX_GPIO174__FUNC_TDM_DATA3_2ND (MTK_PIN_NO(174) | 6)
> > >>>>> +#define PINMUX_GPIO174__FUNC_ANT_SEL7 (MTK_PIN_NO(174) | 7)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO175__FUNC_GPIO175 (MTK_PIN_NO(175) | 0)
> > >>>>> +#define PINMUX_GPIO175__FUNC_ANT_SEL7 (MTK_PIN_NO(175) | 1)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO176__FUNC_GPIO176 (MTK_PIN_NO(176) | 0)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO177__FUNC_GPIO177 (MTK_PIN_NO(177) | 0)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO178__FUNC_GPIO178 (MTK_PIN_NO(178) | 0)
> > >>>>> +
> > >>>>> +#define PINMUX_GPIO179__FUNC_GPIO179 (MTK_PIN_NO(179) | 0)
> > >>>>> +
> > >>>>> +#endif /* __MT8183-PINFUNC_H */
> > >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > >>>>> new file mode 100644
> > >>>>> index 0000000..63db9cc
> > >>>>> --- /dev/null
> > >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > >>>>> @@ -0,0 +1,408 @@
> > >>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > >>>>> +/*
> > >>>>> + * Copyright (c) 2018 MediaTek Inc.
> > >>>>> + * Author: Ben Ho <ben.ho@mediatek.com>
> > >>>>> + *	   Erin Lo <erin.lo@mediatek.com>
> > >>>>> + */
> > >>>>> +
> > >>>>> +#include <dt-bindings/clock/mt8183-clk.h>
> > >>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > >>>>> +#include <dt-bindings/interrupt-controller/irq.h>
> > >>>>> +#include "mt8183-pinfunc.h"
> > >>>>> +
> > >>>>> +/ {
> > >>>>> +	compatible = "mediatek,mt8183";
> > >>>>> +	interrupt-parent = <&sysirq>;
> > >>>>> +	#address-cells = <2>;
> > >>>>> +	#size-cells = <2>;
> > >>>>> +
> > >>>>> +	cpus {
> > >>>>> +		#address-cells = <1>;
> > >>>>> +		#size-cells = <0>;
> > >>>>> +
> > >>>>> +		cpu-map {
> > >>>>> +			cluster0 {
> > >>>>> +				core0 {
> > >>>>> +					cpu = <&cpu0>;
> > >>>>> +				};
> > >>>>> +				core1 {
> > >>>>> +					cpu = <&cpu1>;
> > >>>>> +				};
> > >>>>> +				core2 {
> > >>>>> +					cpu = <&cpu2>;
> > >>>>> +				};
> > >>>>> +				core3 {
> > >>>>> +					cpu = <&cpu3>;
> > >>>>> +				};
> > >>>>> +			};
> > >>>>> +
> > >>>>> +			cluster1 {
> > >>>>> +				core0 {
> > >>>>> +					cpu = <&cpu4>;
> > >>>>> +				};
> > >>>>> +				core1 {
> > >>>>> +					cpu = <&cpu5>;
> > >>>>> +				};
> > >>>>> +				core2 {
> > >>>>> +					cpu = <&cpu6>;
> > >>>>> +				};
> > >>>>> +				core3 {
> > >>>>> +					cpu = <&cpu7>;
> > >>>>> +				};
> > >>>>> +			};
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu0: cpu@0 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a53";
> > >>>>> +			reg = <0x000>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu1: cpu@1 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a53";
> > >>>>> +			reg = <0x001>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu2: cpu@2 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a53";
> > >>>>> +			reg = <0x002>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu3: cpu@3 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a53";
> > >>>>> +			reg = <0x003>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu4: cpu@100 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a73";
> > >>>>> +			reg = <0x100>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu5: cpu@101 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a73";
> > >>>>> +			reg = <0x101>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu6: cpu@102 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a73";
> > >>>>> +			reg = <0x102>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +
> > >>>>> +		cpu7: cpu@103 {
> > >>>>> +			device_type = "cpu";
> > >>>>> +			compatible = "arm,cortex-a73";
> > >>>>> +			reg = <0x103>;
> > >>>>> +			enable-method = "psci";
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	pmu-a53 {
> > >>>>> +		compatible = "arm,cortex-a53-pmu";
> > >>>>> +		interrupt-parent = <&gic>;
> > >>>>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	pmu-a73 {
> > >>>>> +		compatible = "arm,cortex-a73-pmu";
> > >>>>> +		interrupt-parent = <&gic>;
> > >>>>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	psci {
> > >>>>> +		compatible      = "arm,psci-1.0";
> > >>>>> +		method          = "smc";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	clk26m: oscillator {
> > >>>>> +		compatible = "fixed-clock";
> > >>>>> +		#clock-cells = <0>;
> > >>>>> +		clock-frequency = <26000000>;
> > >>>>> +		clock-output-names = "clk26m";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	timer {
> > >>>>> +		compatible = "arm,armv8-timer";
> > >>>>> +		interrupt-parent = <&gic>;
> > >>>>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
> > >>>>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
> > >>>>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
> > >>>>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	gic: interrupt-controller@c000000 {
> > >>>>> +		compatible = "arm,gic-v3";
> > >>>>> +		#interrupt-cells = <4>;
> > >>>>> +		interrupt-parent = <&gic>;
> > >>>>> +		interrupt-controller;
> > >>>>> +		reg = <0 0x0c000000 0 0x40000>,  /* GICD */
> > >>>>> +		      <0 0x0c100000 0 0x200000>, /* GICR */
> > >>>>> +		      <0 0x0c400000 0 0x2000>,   /* GICC */
> > >>>>> +		      <0 0x0c410000 0 0x1000>,   /* GICH */
> > >>>>> +		      <0 0x0c420000 0 0x2000>;   /* GICV */
> > >>>>> +
> > >>>>> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> > >>>>> +		ppi-partitions {
> > >>>>> +			ppi_cluster0: interrupt-partition-0 {
> > >>>>> +				affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
> > >>>>> +			};
> > >>>>> +			ppi_cluster1: interrupt-partition-1 {
> > >>>>> +				affinity = <&cpu4 &cpu5 &cpu6 &cpu7>;
> > >>>>> +			};
> > >>>>> +		};
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	mcucfg: syscon@c530000 {
> > >>>>> +		compatible = "mediatek,mt8183-mcucfg", "syscon";
> > >>>>> +		reg = <0 0x0c530000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	sysirq: intpol-controller@c530a80 {
> > >>>>> +		compatible = "mediatek,mt8183-sysirq",
> > >>>>> +			     "mediatek,mt6577-sysirq";
> > >>>>> +		interrupt-controller;
> > >>>>> +		#interrupt-cells = <4>;
> > >>>>> +		interrupt-parent = <&gic>;
> > >>>>> +		reg = <0 0x0c530a80 0 0x50>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	topckgen: syscon@10000000 {
> > >>>>> +		compatible = "mediatek,mt8183-topckgen", "syscon";
> > >>>>> +		reg = <0 0x10000000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	infracfg: syscon@10001000 {
> > >>>>> +		compatible = "mediatek,mt8183-infracfg", "syscon";
> > >>>>> +		reg = <0 0x10001000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	pio: pinctrl@1000b000 {
> > >>>>> +		compatible = "mediatek,mt8183-pinctrl";
> > >>>>> +		reg = <0 0x10005000 0 0x1000>,
> > >>>>> +		      <0 0x11f20000 0 0x1000>,
> > >>>>> +		      <0 0x11e80000 0 0x1000>,
> > >>>>> +		      <0 0x11e70000 0 0x1000>,
> > >>>>> +		      <0 0x11e90000 0 0x1000>,
> > >>>>> +		      <0 0x11d30000 0 0x1000>,
> > >>>>> +		      <0 0x11d20000 0 0x1000>,
> > >>>>> +		      <0 0x11c50000 0 0x1000>,
> > >>>>> +		      <0 0x11f30000 0 0x1000>,
> > >>>>> +		      <0 0x1000b000 0 0x1000>;
> > >>>>> +		reg-names = "iocfg0", "iocfg1", "iocfg2",
> > >>>>> +			    "iocfg3", "iocfg4", "iocfg5",
> > >>>>> +			    "iocfg6", "iocfg7", "iocfg8",
> > >>>>> +			    "eint";
> > >>>>> +		gpio-controller;
> > >>>>> +		#gpio-cells = <2>;
> > >>>>> +		gpio-ranges = <&pio 0 0 192>;
> > >>>>> +		interrupt-controller;
> > >>>>> +		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>;
> > >>>>> +		interrupt-parent = <&gic>;
> > >>>>> +		#interrupt-cells = <4>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	apmixedsys: syscon@1000c000 {
> > >>>>> +		compatible = "mediatek,mt8183-apmixedsys", "syscon";
> > >>>>> +		reg = <0 0x1000c000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	pwrap: pwrap@1000d000 {
> > >>>>> +		compatible = "mediatek,mt8183-pwrap";
> > >>>>> +		reg = <0 0x1000d000 0 0x1000>;
> > >>>>> +		reg-names = "pwrap";
> > >>>>> +		interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
> > >>>>> +		clocks = <&topckgen CLK_TOP_MUX_PMICSPI>,
> > >>>>> +			 <&infracfg CLK_INFRA_PMIC_AP>;
> > >>>>> +		clock-names = "spi", "wrap";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	uart0: serial@11002000 {
> > >>>>> +		compatible = "mediatek,mt8183-uart",
> > >>>>> +			     "mediatek,mt6577-uart";
> > >>>>> +		reg = <0 0x11002000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&clk26m>, <&infracfg CLK_INFRA_UART0>;
> > >>>>> +		clock-names = "baud", "bus";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	uart1: serial@11003000 {
> > >>>>> +		compatible = "mediatek,mt8183-uart",
> > >>>>> +			     "mediatek,mt6577-uart";
> > >>>>> +		reg = <0 0x11003000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&clk26m>, <&infracfg CLK_INFRA_UART1>;
> > >>>>> +		clock-names = "baud", "bus";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	uart2: serial@11004000 {
> > >>>>> +		compatible = "mediatek,mt8183-uart",
> > >>>>> +			     "mediatek,mt6577-uart";
> > >>>>> +		reg = <0 0x11004000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&clk26m>, <&infracfg CLK_INFRA_UART2>;
> > >>>>> +		clock-names = "baud", "bus";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi0: spi@1100a000 {
> > >>>>> +		compatible = "mediatek,mt8183-spi";
> > >>>>> +		#address-cells = <1>;
> > >>>>> +		#size-cells = <0>;
> > >>>>> +		reg = <0 0x1100a000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
> > >>>>> +			 <&topckgen CLK_TOP_MUX_SPI>,
> > >>>>> +			 <&infracfg CLK_INFRA_SPI0>;
> > >>>>> +		clock-names = "parent-clk", "sel-clk", "spi-clk";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi1: spi@11010000 {
> > >>>>> +		compatible = "mediatek,mt8183-spi";
> > >>>>> +		#address-cells = <1>;
> > >>>>> +		#size-cells = <0>;
> > >>>>> +		reg = <0 0x11010000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
> > >>>>> +			 <&topckgen CLK_TOP_MUX_SPI>,
> > >>>>> +			 <&infracfg CLK_INFRA_SPI1>;
> > >>>>> +		clock-names = "parent-clk", "sel-clk", "spi-clk";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi2: spi@11012000 {
> > >>>>> +		compatible = "mediatek,mt8183-spi";
> > >>>>> +		#address-cells = <1>;
> > >>>>> +		#size-cells = <0>;
> > >>>>> +		reg = <0 0x11012000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
> > >>>>> +			 <&topckgen CLK_TOP_MUX_SPI>,
> > >>>>> +			 <&infracfg CLK_INFRA_SPI2>;
> > >>>>> +		clock-names = "parent-clk", "sel-clk", "spi-clk";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi3: spi@11013000 {
> > >>>>> +		compatible = "mediatek,mt8183-spi";
> > >>>>> +		#address-cells = <1>;
> > >>>>> +		#size-cells = <0>;
> > >>>>> +		reg = <0 0x11013000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
> > >>>>> +			 <&topckgen CLK_TOP_MUX_SPI>,
> > >>>>> +			 <&infracfg CLK_INFRA_SPI3>;
> > >>>>> +		clock-names = "parent-clk", "sel-clk", "spi-clk";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi4: spi@11018000 {
> > >>>>> +		compatible = "mediatek,mt8183-spi";
> > >>>>> +		#address-cells = <1>;
> > >>>>> +		#size-cells = <0>;
> > >>>>> +		reg = <0 0x11018000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
> > >>>>> +			 <&topckgen CLK_TOP_MUX_SPI>,
> > >>>>> +			 <&infracfg CLK_INFRA_SPI4>;
> > >>>>> +		clock-names = "parent-clk", "sel-clk", "spi-clk";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	spi5: spi@11019000 {
> > >>>>> +		compatible = "mediatek,mt8183-spi";
> > >>>>> +		#address-cells = <1>;
> > >>>>> +		#size-cells = <0>;
> > >>>>> +		reg = <0 0x11019000 0 0x1000>;
> > >>>>> +		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW 0>;
> > >>>>> +		clocks = <&topckgen CLK_TOP_SYSPLL_D5_D2>,
> > >>>>> +			 <&topckgen CLK_TOP_MUX_SPI>,
> > >>>>> +			 <&infracfg CLK_INFRA_SPI5>;
> > >>>>> +		clock-names = "parent-clk", "sel-clk", "spi-clk";
> > >>>>> +		status = "disabled";
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	audiosys: syscon@11220000 {
> > >>>>> +		compatible = "mediatek,mt8183-audiosys", "syscon";
> > >>>>> +		reg = <0 0x11220000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	mfgcfg: syscon@13000000 {
> > >>>>> +		compatible = "mediatek,mt8183-mfgcfg", "syscon";
> > >>>>> +		reg = <0 0x13000000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	mmsys: syscon@14000000 {
> > >>>>> +		compatible = "mediatek,mt8183-mmsys", "syscon";
> > >>>>> +		reg = <0 0x14000000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	imgsys: syscon@15020000 {
> > >>>>> +		compatible = "mediatek,mt8183-imgsys", "syscon";
> > >>>>> +		reg = <0 0x15020000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	vdecsys: syscon@16000000 {
> > >>>>> +		compatible = "mediatek,mt8183-vdecsys", "syscon";
> > >>>>> +		reg = <0 0x16000000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	vencsys: syscon@17000000 {
> > >>>>> +		compatible = "mediatek,mt8183-vencsys", "syscon";
> > >>>>> +		reg = <0 0x17000000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	ipu_conn: syscon@19000000 {
> > >>>>> +		compatible = "mediatek,mt8183-ipu_conn", "syscon";
> > >>>>> +		reg = <0 0x19000000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	ipu_adl: syscon@19010000 {
> > >>>>> +		compatible = "mediatek,mt8183-ipu_adl", "syscon";
> > >>>>> +		reg = <0 0x19010000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	ipu_core0: syscon@19180000 {
> > >>>>> +		compatible = "mediatek,mt8183-ipu_core0", "syscon";
> > >>>>> +		reg = <0 0x19180000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	ipu_core1: syscon@19280000 {
> > >>>>> +		compatible = "mediatek,mt8183-ipu_core1", "syscon";
> > >>>>> +		reg = <0 0x19280000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +
> > >>>>> +	camsys: syscon@1a000000 {
> > >>>>> +		compatible = "mediatek,mt8183-camsys", "syscon";
> > >>>>> +		reg = <0 0x1a000000 0 0x1000>;
> > >>>>> +		#clock-cells = <1>;
> > >>>>> +	};
> > >>>>> +};
> > >>>>>
> > >>>>
> > >>>> _______________________________________________
> > >>>> Linux-mediatek mailing list
> > >>>> Linux-mediatek@lists.infradead.org
> > >>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >>>
> > >>>
> > >>
> > >> _______________________________________________
> > >> Linux-mediatek mailing list
> > >> Linux-mediatek@lists.infradead.org
> > >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > > 
> > > 
> 


