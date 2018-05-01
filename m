Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756125AbeEAQVO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:21:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52831 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755720AbeEAQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:21:12 -0400
X-Google-Smtp-Source: AB8JxZpPpEyMoD1bi8CADnpAeiNTem5BYTW5bvEzEdI57GP1+8CI1s9CgSWYdeFhIMMZylFrUvn9YA==
MIME-Version: 1.0
In-Reply-To: <20180430114058.5061-11-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com> <20180430114058.5061-11-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 2 May 2018 00:20:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_WjVOfz0maTU7K9WWEChGjQoYqpc=xZkmy4W64+9DLw@mail.gmail.com>
Message-ID: <CAGb2v67_WjVOfz0maTU7K9WWEChGjQoYqpc=xZkmy4W64+9DLw@mail.gmail.com>
Subject: Re: [PATCH 10/21] drm/sun4i: Enable DesignWare HDMI for Allwinner
 64-bit SoCs
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 7:40 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Allwinner 64-bit SoC like H5/A64 has DesignWare HDMI so
> enable them as default.

Should we not also enable it by default for SUN8I (A83T, H3, R40?, etc.)

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/gpu/drm/sun4i/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index eee6bc0eaf97..60468a779a63 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -42,6 +42,7 @@ config DRM_SUN4I_BACKEND
>
>  config DRM_SUN8I_DW_HDMI
>         tristate "Support for Allwinner version of DesignWare HDMI"
> +       default ARM64 && ARCH_SUNXI
>         depends on DRM_SUN4I
>         select DRM_DW_HDMI
>         help
> --
> 2.14.3
>
