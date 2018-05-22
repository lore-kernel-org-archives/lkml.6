Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeEVSKF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:10:05 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35463 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEVSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:10:03 -0400
X-Google-Smtp-Source: AB8JxZqO8yO1v+x4C5RYxap2/2flENEUTCefVTh69yjaHAGJXjBJP13RPGliE6b5y9jiCHJpqB+fiw==
Date: Tue, 22 May 2018 13:10:00 -0500
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
Subject: Re: [PATCH v2 07/26] dt-bindings: display: Add compatible for A64
 DE2 tcon1 blocks
Message-ID: <20180522181000.GA19875@rob-hp-laptop>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518094536.17201-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518094536.17201-8-jagan@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:15:17PM +0530, Jagan Teki wrote:
> Allwinner A64 has DE2 pipeline with tcon0 and tcon1 block
> which is similar Allwinner A83T.
> 
> This patch adds dt-binding documentation for A64 DE2 tcon1 blocks.
> 
> Mixer1 has different configuration for A64 so use separate compatible
> but tcon1 has similar behaviour with A83T so add fallback compatible.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Add fallback compatible for tcon1
> - Add separate compatible for mixer1 
> 
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
