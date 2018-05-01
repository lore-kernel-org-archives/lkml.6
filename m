Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756210AbeEAQVe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:21:34 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44722 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeEAQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:21:32 -0400
X-Google-Smtp-Source: AB8JxZrkLnk3GYDwiXReEvkQTnZyetjL1RjnbiRg3p/bfmAOv8ats3TqVsEGyeYAtmGHyRVlBivuSA==
Date: Tue, 1 May 2018 11:21:30 -0500
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
Subject: Re: [PATCH 11/21] bindings: display: Add compatible for A64 Mixer1
Message-ID: <20180501162130.GA6219@rob-hp-laptop>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-12-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430114058.5061-12-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 05:10:48PM +0530, Jagan Teki wrote:
> Mixer1 on Allwinner A64 has similar behavior like Allwinner A83T.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index 7dcd1d64dfe4..5d448ef2132f 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -313,6 +313,7 @@ Required properties:
>      * allwinner,sun8i-a83t-de2-mixer-1
>      * allwinner,sun8i-h3-de2-mixer-0
>      * allwinner,sun8i-v3s-de2-mixer
> +    * allwinner,sun50i-a64-de2-mixer-1

Need to capture fallbacks here.

>    - reg: base address and size of the memory-mapped region.
>    - clocks: phandles to the clocks feeding the mixer
>      * bus: the mixer interface clock
> -- 
> 2.14.3
> 
