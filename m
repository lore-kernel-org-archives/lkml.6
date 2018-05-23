Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754887AbeEWSUK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:20:10 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:41100 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754658AbeEWSUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:20:04 -0400
X-Google-Smtp-Source: AB8JxZpM9EYfmUI/S6rmIhWPQPBzMxo5RnchIarNMglRnYxuK7C5DIS9GrUJXB1FLdPhhekuaJJrcQ==
Date: Wed, 23 May 2018 13:20:01 -0500
From: Rob Herring <robh@kernel.org>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: maxime.ripard@bootlin.com, wens@csie.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 03/15] clk: sunxi-ng: r40: Export video PLLs
Message-ID: <20180523182001.GA4527@rob-hp-laptop>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-4-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519183127.2718-4-jernej.skrabec@siol.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 08:31:15PM +0200, Jernej Skrabec wrote:
> Video PLLs need to be referenced in R40 DT as possible HDMI PHY parent.
> 
> Export them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 8 ++++++--
>  include/dt-bindings/clock/sun8i-r40-ccu.h | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
