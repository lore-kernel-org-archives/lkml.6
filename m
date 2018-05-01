Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756108AbeEAQWQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:22:16 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46332 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeEAQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:22:13 -0400
X-Google-Smtp-Source: AB8JxZpfKbplvR8pVUYffRDomjEPjyHzGSRyQQ9nuNspGqg3UZPcVhGFIzAI24LxdIZgYyEzSlwMWA==
Date: Tue, 1 May 2018 11:22:12 -0500
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
Subject: Re: [PATCH 12/21] bindings: display: Add compatible for A64 tcon-tv
Message-ID: <20180501162212.GA6950@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-13-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-13-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:10:49PM +0530, Jagan Teki wrote:
> tcon-tv on Allwinner A64 has similar behavior like Allwinner A83T.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 5d448ef2132f..8b6b4bc43d98 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -150,6 +150,7 @@ Required properties:
>     * allwinner,sun8i-v3s-tcon
>     * allwinner,sun9i-a80-tcon-lcd
>     * allwinner,sun9i-a80-tcon-tv
> +   * allwinner,sun50i-a64-tcon-tv

Fallback?

>   - reg: base address and size of memory-mapped region
>   - interrupts: interrupt associated to this IP
>   - clocks: phandles to the clocks feeding the TCON.
> -- 
> 2.14.3
> 
