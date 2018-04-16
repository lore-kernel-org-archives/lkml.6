Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeDPMZ2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:25:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38535 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753999AbeDPMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:25:24 -0400
X-Google-Smtp-Source: AIpwx49HJm3o8GicbDgBVi9V4r/Z/7HWJg4APrtcR91RHUvuz2oIfZYYZsYZ91EcxF/And+TF5HJRA==
Date: Mon, 16 Apr 2018 13:25:19 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] pwm: stm32: use input prescaler to improve period
 capture
Message-ID: <20180416122519.5fnnyuuel64kfjfw@dell>
References: <1522404084-24903-1-git-send-email-fabrice.gasnier@st.com>
 <1522404084-24903-6-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522404084-24903-6-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Fabrice Gasnier wrote:

> Using input prescaler, capture unit will trigger DMA once every
> configurable /2, /4 or /8 events (rising edge). This helps improve
> period (only) capture accuracy at high rates.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> Changes in v2:
> - Adopt DMA read from MFD core.
> ---
>  drivers/pwm/pwm-stm32.c          | 63 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/mfd/stm32-timers.h |  1 +

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 62 insertions(+), 2 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
