Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeBJHIo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 02:08:44 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55058 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeBJHIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 02:08:40 -0500
X-Google-Smtp-Source: AH8x226+I+X8WoJ/8BYkeAVvwWe8AaSPNRodm/J/fg6rAD4BGbP9Hrgr797Fu+nm5Yh2fK1KFnBMULnwhApVeFfaWgs=
MIME-Version: 1.0
In-Reply-To: <20180210013806.28496-6-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com> <20180210013806.28496-6-marcel@ziswiler.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sat, 10 Feb 2018 08:07:58 +0100
Message-ID: <CAOFm3uH+aasUA9MrV+uXvHUT=fzS63PvC2fDfNo3q687dUQ_dw@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: tegra: apalis-tk1: copyright period,
 spurious newlines
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel,

On Sat, Feb 10, 2018 at 2:38 AM, Marcel Ziswiler <marcel@ziswiler.com> wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Update the copyright period and get rid of some spurious newlines.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> ---
>
>  arch/arm/boot/dts/tegra124-apalis-eval.dts |  6 ++----
>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 11 +----------
>  2 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> index f1010cefb993..a6ad759dddb4 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
> +++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2016 Toradex AG
> + * Copyright 2016-2018 Toradex AG
>   *
>   * This file is dual-licensed: you can use it either under the terms
>   * of the GPL or the X11 license, at your option. Note that this dual

Since you are fixing copyrights, would you consider also fixing the
license to use a proper SPDX Id instead?

It would be super gentle of you!

And you will get extra good karma point if you feel like doing the
same for every Toradex-copyrighted files ;)

The (still new and fresh) license documentation contributed by tglx
--the only real-time docu-mentalist-- is in:
Documentation/process/license-rules.rst

Thanks!
-- 
Cordially
Philippe Ombredanne
