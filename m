Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755987AbeEAQTM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:19:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36283 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbeEAQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:19:10 -0400
X-Google-Smtp-Source: AB8JxZrsUAVXi3WFoNJgKhA0uTjFY9toDnNM6TRt0phZbtTE060BJGQN0y4WtFnTjeTr+CAfyJeHZg==
Date: Tue, 1 May 2018 11:19:09 -0500
From: Rob Herring <robh@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 08/21] bindings: display: Add compatible for A64 HDMI PHY
Message-ID: <20180501161909.GA1728@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-9-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-9-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:10:45PM +0530, Jagan Teki wrote:
> HDMI PHY on Allwinner A64 has similar like H3/H5.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 9ea4353caadd..7dcd1d64dfe4 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -104,6 +104,7 @@ Required properties:
>    - compatible: value must be one of:
>      * allwinner,sun8i-a83t-hdmi-phy
>      * allwinner,sun8i-h3-hdmi-phy
> +    * allwinner,sun50i-a64-hdmi-phy

This should be one valid combination per line. The dts shows that the h3 
string is a fallback which should be captured in the binding doc.

>    - reg: base address and size of memory-mapped region
>    - clocks: phandles to the clocks feeding the HDMI PHY
>      * bus: the HDMI PHY interface clock
> -- 
> 2.14.3
> 
