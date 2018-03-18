Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754664AbeCRM4y (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:56:54 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35673 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754507AbeCRMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:17 -0400
X-Google-Smtp-Source: AG47ELv1wSOkHEV9NbYkI3kIsreMqBhMMwYAlz7WHL2YfmvKVLBDYAB3NlPY5tkw2pGZuRYJ78yF7A==
Date: Sun, 18 Mar 2018 07:52:14 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] drm/sun4i: Add DT binding for Detail Enhancement
 Unit in Allwinner A80 SoC
Message-ID: <20180318030113.756rexmhlkrqnmlg@rob-hp-laptop>
References: <20180315114136.24747-1-wens@csie.org>
 <20180315114136.24747-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315114136.24747-3-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 07:41:30PM +0800, Chen-Yu Tsai wrote:
> The display pipeline on the A80 SoC has what is called the Detail
> Enhancement Unit, or DEU for short, block in between the display
> frontend and backend. This unit can sharpen images in both luma
> and chroma channels. It seems to also do colorspace conversion.
> 
> This patch adds the device tree binding for this hardware block.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
