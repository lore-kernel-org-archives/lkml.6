Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeCGIfr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:35:47 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53846 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeCGIfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:35:43 -0500
X-Google-Smtp-Source: AG47ELsF3RCyfaxVM9Qw5bm3DsPp2gPqiaSwIk6xus5Symp9kd1njB/iOpbcam9ZcNaDGW58SPJGAw==
Date: Wed, 7 Mar 2018 08:35:39 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mcoquelin.stm32@gmail.com
Subject: Re: [PATCH v2 0/6] Add mmc support for STM32F7 boards
Message-ID: <20180307083538.vicxhbu72jex7zi6@dell>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <44ed2e2c-83f1-77f5-fa70-29c5525b9ee7@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44ed2e2c-83f1-77f5-fa70-29c5525b9ee7@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Mar 2018, Alexandre Torgue wrote:

> Hi Patrice,
> 
> On 03/01/2018 11:53 AM, patrice.chotard@st.com wrote:
> > From: Patrice Chotard <patrice.chotard@st.com>
> > 
> > This series adds :
> >   _ SDIO pins definition for STM32F7 SoCs family
> >   _ add sdio1 DT entry for STM32F746 Discovery board
> >   _ add sdio1 DT entry for STM32F746 Evaluation board
> >   _ add sdio1 DT entry for STM32F769 Discovery board
> >   _ add SDMMC2 entry in stm32f7-rcc.h
> >   _ replace sdio2 hard coded value in stm32f746.dtsi
> > 
> > v2: _ rename sdio_pins / sdio_od_pins to sdio_pins_a / sdio_od_pins_a
> >        and update board dts files accordingly.
> > 
> > 
> > Patrice Chotard (6):
> >    ARM: dts: stm32: Add sdio pins definition for stm32f7
> >    ARM: dts: stm32: Enable sdio1 for stm32f746-disco
> >    ARM: dts: stm32: Enable sdio1 for stm32f746-eval
> >    ARM: dts: stm32: Enable sdio1 for stm32f769-disco
> >    dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
> >    ARM: dts: stm32: Fix sdio2 rcc hard coded value
> > 
> >   arch/arm/boot/dts/stm32746g-eval.dts   | 17 ++++++++++
> >   arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 62 ++++++++++++++++++++++++++++++++++
> >   arch/arm/boot/dts/stm32f746-disco.dts  | 19 +++++++++++
> >   arch/arm/boot/dts/stm32f746.dtsi       |  2 +-
> >   arch/arm/boot/dts/stm32f769-disco.dts  | 19 +++++++++++
> >   include/dt-bindings/mfd/stm32f7-rcc.h  |  1 +
> >   6 files changed, 119 insertions(+), 1 deletion(-)
> > 
> Series applied on stm32-next.

Even the MFD patch?

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
