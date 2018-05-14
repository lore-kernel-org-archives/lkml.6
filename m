Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeENCb3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 22:31:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59512 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeENCb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 22:31:27 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: niklas.soderlund@ragnatech.se, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: media: rcar-vin: Add R8A77995 support
Date: Mon, 14 May 2018 05:31:42 +0300
Message-ID: <69379240.MQavQczkOG@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1526032802-14376-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org> <1526032802-14376-2-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Friday, 11 May 2018 13:00:00 EEST Jacopo Mondi wrote:
> Add compatible string for R-Car D3 R8A7795 to list of SoCs supported by
> rcar-vin driver.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/media/rcar_vin.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt
> b/Documentation/devicetree/bindings/media/rcar_vin.txt index
> a19517e1..5c6f2a7 100644
> --- a/Documentation/devicetree/bindings/media/rcar_vin.txt
> +++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
> @@ -22,6 +22,7 @@ on Gen3 platforms to a CSI-2 receiver.
>     - "renesas,vin-r8a7795" for the R8A7795 device
>     - "renesas,vin-r8a7796" for the R8A7796 device
>     - "renesas,vin-r8a77970" for the R8A77970 device
> +   - "renesas,vin-r8a77995" for the R8A77995 device
>     - "renesas,rcar-gen2-vin" for a generic R-Car Gen2 or RZ/G1 compatible
>       device.

-- 
Regards,

Laurent Pinchart
