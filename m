Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeDSSHi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:07:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41487 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeDSSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:07:36 -0400
X-Google-Smtp-Source: AIpwx490ijZceomr+W8jQAVOFEuTT84WUm2/rDkAF2Md8A495tjMhk0+PDZY2jM/5bXV567ib6DsSw==
From: Kevin Hilman <khilman@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Carlo Caione <carlo@caione.org>, Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-gpio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: meson-axg: fix the range of aobus bank
Organization: BayLibre
References: <20180417170824.18670-1-yixun.lan@amlogic.com>
Date: Thu, 19 Apr 2018 11:07:32 -0700
In-Reply-To: <20180417170824.18670-1-yixun.lan@amlogic.com> (Yixun Lan's
        message of "Tue, 17 Apr 2018 17:08:24 +0000")
Message-ID: <7hd0yv3w9n.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> The GPIOAO bank is range from GPIOAO_0 to GPIOAO_13.
>
> Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Reported-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/pinctrl/meson/pinctrl-meson-axg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> index 4b91ff74779b..99a6ceac8e53 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -898,7 +898,7 @@ static struct meson_bank meson_axg_periphs_banks[] = {
>  
>  static struct meson_bank meson_axg_aobus_banks[] = {
>  	/*   name    first      last      irq	pullen  pull    dir     out     in  */
> -	BANK("AO",   GPIOAO_0,  GPIOAO_9, 0, 13, 0,  16,  0, 0,  0,  0,  0, 16,  1,  0),
> +	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  16,  0, 0,  0,  0,  0, 16,  1,  0),
>  };
>  
>  static struct meson_pmx_bank meson_axg_periphs_pmx_banks[] = {
