Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeDPMXj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:23:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40270 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbeDPMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:23:36 -0400
X-Google-Smtp-Source: AIpwx4/WTo9bg/FzdDsVfMG375qjLh54vdKK4gmhNNX4LDaHTcqbJDJ3QYatXRpeRBurm/AhWseNSw==
Date: Mon, 16 Apr 2018 13:23:32 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: mfd: stm32-timers: add support for
 dmas
Message-ID: <20180416122332.jkshovyzejd6koo6@dell>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-2-git-send-email-fabrice.gasnier@st.com>
 <20180416122306.qfp5rf7khexabydm@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180416122306.qfp5rf7khexabydm@dell>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018, Lee Jones wrote:

> On Fri, 30 Mar 2018, Fabrice Gasnier wrote:
> 
> > Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
> > dma requests: up to 4 channels, update, compare and trigger.
> > DMAs may be used to transfer data from pwm capture for instance.
> > DMA support is made optional, PWM capture support is also an option.
> > This is much more wise system-wide to avoid shortage on DMA request
> > lines as there's significant amount of timer instances that can
> > request up to 7 channels.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > ---
> >  .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Actually:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
