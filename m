Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeC1LQ2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:16:28 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:51280 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeC1LQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:16:26 -0400
X-Google-Smtp-Source: AIpwx49wBCVCTfCeiIGUOyFdJT9pOFnHd1KtoRYug+P/1B9zsdRaFLCrW7gIa2gik1wPlSaWOGm8UA==
Date: Wed, 28 Mar 2018 12:16:22 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v2 3/8] dt-bindings: mfd: stm32-timers: add
 support for dmas
Message-ID: <20180328111622.r7f7e7duq7knvzfg@dell>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
 <1518602679-3064-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518602679-3064-4-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Fabrice Gasnier wrote:

> Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
> dma requests: up to 4 channels, update, compare and trigger.
> DMAs may be used to transfer data from pwm capture for instance.
> DMA support is made optional, PWM capture support is also an option.
> This is much more wise system-wide to avoid shortage on DMA request
> lines as there's significant amount of timer instances that can
> request up to 7 channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
