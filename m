Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbeCGTg3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:36:29 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36380 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeCGTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:36:27 -0500
X-Google-Smtp-Source: AG47ELuQoR8hJOOU37K3mqzfvsXoO+6kiS+U7NPFrsuPh9N/e5aA0L/NVgvEANp+YWeqryAdcChrmA==
Date: Wed, 7 Mar 2018 13:36:25 -0600
From: Rob Herring <robh@kernel.org>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 04/16] clk: sunxi-ng: h3: h5: export CLK_PLL_VIDEO
Message-ID: <20180307193625.twmxfo3fiy4sjeuk@rob-hp-laptop>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-5-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301213442.16677-5-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 10:34:30PM +0100, Jernej Skrabec wrote:
> CLK_PLL_VIDEO needs to be referenced in HDMI DT entry as a possible
> PHY clock parent.
> 
> Export it so it can be used later in DT.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.h      | 4 +++-
>  include/dt-bindings/clock/sun8i-h3-ccu.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
