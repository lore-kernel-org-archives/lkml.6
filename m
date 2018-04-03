Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeDCWT0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:19:26 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:42792 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeDCWTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:19:25 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, Jacopo Mondi <jacopo@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Wed, 04 Apr 2018 01:19:33 +0300
Message-ID: <6322311.C1mXSAZMCy@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180326212447.7380-2-peda@axentia.se>
References: <20180326212447.7380-1-peda@axentia.se> <20180326212447.7380-2-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Tuesday, 27 March 2018 00:24:43 EEST Peter Rosin wrote:
> Start list of actual chips compatible with "lvds-encoder".
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 ++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index fd39ad34c383..50220190c203 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -22,7 +22,13 @@ among others.
> 
>  Required properties:
> 
> -- compatible: Must be "lvds-encoder"
> +- compatible: Must be one or more of the following
> +  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
> +  - "lvds-encoder" for a generic LVDS encoder device
> +
> +  When compatible with the generic version, nodes must list the
> +  device-specific version corresponding to the device first
> +  followed by the generic version.
> 
>  Required nodes:


-- 
Regards,

Laurent Pinchart
