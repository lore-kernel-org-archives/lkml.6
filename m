Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032947AbeBOOCQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:02:16 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:48493 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032283AbeBOOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:02:15 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kbingham@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, geert@glider.be,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] dt-bindings: display: renesas,lvds: Add LVDS binding for D3
Date: Thu, 15 Feb 2018 16:02:49 +0200
Message-ID: <2442341.aT5bf8aohc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1518683903-10681-4-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org> <1518683903-10681-4-git-send-email-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 15 February 2018 10:38:18 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The D3 supports two LVDS channels. Extend the binding to support them.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt index
> 79860f58a7ad..0dcf488b70df 100644
> --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> @@ -14,6 +14,7 @@ Required properties:
>  - compatible : Shall contain one of
>    - "renesas,lvds-r8a7795" for R8A7795 (R-Car H3) compatible LVDS encoders
>    - "renesas,lvds-r8a7796" for R8A7796 (R-Car M3-W) compatible LVDS
> encoders
> +  - "renesas,lvds-r8a77995" for R8A77995 (R-Car D3) compatible
> LVDS encoders

This should be "renesas,r8a77995-lvds". I've already fixed the series you've 
based this patch on.

Apart from this,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and taken in my tree with the compatible string fixed.

> 
>  - reg: Base address and length for the memory-mapped registers
>  - clocks: A phandle + clock-specifier pair for the functional clock


-- 
Regards,

Laurent Pinchart
