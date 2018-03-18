Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbeCRMwZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:52:25 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44756 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbeCRMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:15 -0400
X-Google-Smtp-Source: AG47ELv4t6x6tv2EqxTOUGGrWCY9z17WJeqM8Fp8fwGFrBoNUqJKqwluYT+jgL+zAnegxlL+b/6uLg==
Date: Sun, 18 Mar 2018 07:52:12 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drm/sun4i: Add compatible strings for A80 TCONs
Message-ID: <20180318030014.4rkxe4huxxhslj3v@rob-hp-laptop>
References: <20180315114136.24747-1-wens@csie.org>
 <20180315114136.24747-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315114136.24747-2-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 07:41:29PM +0800, Chen-Yu Tsai wrote:
> The A80 has 2 or 3 TCONs. The documentation and vendor kernel are very
> vague about the third TCON, to the point that it might not exist.
> 
> In the documentation, the first TCON is missing channel 1, and the
> second is missing channel 0. However the vendor kernel seems to be
> able to use them regardless. Here we model them like the old TCONs.
> 
> An oddity is that TCON0 requires the reset control for the eDP block
> to be deasserted, for any register access to stick.
> 
> This patch adds compatible strings for TCON0 and TCON1, with TCON0
> requiring an extra "edp" reset control.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
