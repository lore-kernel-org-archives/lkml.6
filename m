Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeCUOFE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:05:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35038 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeCUOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:05:00 -0400
X-Google-Smtp-Source: AG47ELtoK8ReN7cBPT2QLBO0FuhQTIShHHuYVt/+GwLzCTjn+RnklBy64CBW+mj7hgQGP0RNseWSKIN4ovUGUJOGOWk=
MIME-Version: 1.0
In-Reply-To: <20180321120807.18032-4-brgl@bgdev.pl>
References: <20180321120807.18032-1-brgl@bgdev.pl> <20180321120807.18032-4-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Mar 2018 15:04:58 +0100
Message-ID: <CAMRc=MePv9GAApdzW9+i_xW9j6-ydBY_Wfb1Hmphsvzn9waGnQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] ARM: davinci: dts: add a reset control to the dsp node
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-21 13:08 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The davinci-rproc driver will soon use the reset framework. Add the
> resets property to the dsp node in da850.dtsi.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 89af749c5b6f..5b485e44b83e 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -124,6 +124,7 @@
>                         compatible = "ti,da850-psc0";
>                         reg = <0x10000 0x1000>;
>                         #clock-cells = <1>;
> +                       #reset-cells = <1>;
>                         #power-domain-cells = <1>;
>                         clocks = <&pll0_sysclk 1>, <&pll0_sysclk 2>,
>                                  <&pll0_sysclk 4>, <&pll0_sysclk 6>,
> --
> 2.16.1
>

I noticed I mixed up the descriptions in patches 2/8 and 3/8. It'll
need a v2, but I'll wait for some reviews first.

Bart
