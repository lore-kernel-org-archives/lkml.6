Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755761AbeDZUIA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:08:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59242 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755376AbeDZUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:07:58 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] dt-bindings: display: renesas: du: Increase indent in output table
Date: Thu, 26 Apr 2018 23:08:11 +0300
Message-ID: <2616564.acR4Iy4qTH@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426165346.494-2-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:30 EEST Kieran Bingham wrote:
> The DU output table lists the port combinations for each supported DU
> type.  Newer models of R-Car Gen3 platforms have an increased string
> length.
> 
> Increase the table indentation in preparation for supporting new target
> types.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  .../bindings/display/renesas,du.txt           | 26 +++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt
> b/Documentation/devicetree/bindings/display/renesas,du.txt index
> c9cd17f99702..a36a6e7ee54f 100644
> --- a/Documentation/devicetree/bindings/display/renesas,du.txt
> +++ b/Documentation/devicetree/bindings/display/renesas,du.txt
> @@ -47,20 +47,20 @@ bindings specified in
> Documentation/devicetree/bindings/graph.txt. The following table lists for
> each supported model the port number corresponding to each DU output.
> 
> -                      Port0          Port1          Port2          Port3
> +                        Port0          Port1          Port2          Port3
>  ---------------------------------------------------------------------------
> -- - R8A7743 (RZ/G1M)     DPAD 0         LVDS 0         -              - -
> R8A7745 (RZ/G1E)     DPAD 0         DPAD 1         -              - -
> R8A7779 (R-Car H1)   DPAD 0         DPAD 1         -              - -
> R8A7790 (R-Car H2)   DPAD 0         LVDS 0         LVDS 1         - -
> R8A7791 (R-Car M2-W) DPAD 0         LVDS 0         -              - -
> R8A7792 (R-Car V2H)  DPAD 0         DPAD 1         -              - -
> R8A7793 (R-Car M2-N) DPAD 0         LVDS 0         -              - -
> R8A7794 (R-Car E2)   DPAD 0         DPAD 1         -              - -
> R8A7795 (R-Car H3)   DPAD 0         HDMI 0         HDMI 1         LVDS 0 -
> R8A7796 (R-Car M3-W) DPAD 0         HDMI 0         LVDS 0         - -
> R8A77970 (R-Car V3M) DPAD 0         LVDS 0         -              - -
> R8A77995 (R-Car D3)  DPAD 0         LVDS 0         LVDS 1         - +
> R8A7743 (RZ/G1M)       DPAD 0         LVDS 0         -              - +
> R8A7745 (RZ/G1E)       DPAD 0         DPAD 1         -              - +
> R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              - +
> R8A7790 (R-Car H2)     DPAD 0         LVDS 0         LVDS 1         - +
> R8A7791 (R-Car M2-W)   DPAD 0         LVDS 0         -              - +
> R8A7792 (R-Car V2H)    DPAD 0         DPAD 1         -              - +
> R8A7793 (R-Car M2-N)   DPAD 0         LVDS 0         -              - +
> R8A7794 (R-Car E2)     DPAD 0         DPAD 1         -              - +
> R8A7795 (R-Car H3)     DPAD 0         HDMI 0         HDMI 1         LVDS 0
> + R8A7796 (R-Car M3-W)   DPAD 0         HDMI 0         LVDS 0         - +
> R8A77970 (R-Car V3M)   DPAD 0         LVDS 0         -              - +
> R8A77995 (R-Car D3)    DPAD 0         LVDS 0         LVDS 1         -
> 
> 
>  Example: R8A7795 (R-Car H3) ES2.0 DU


-- 
Regards,

Laurent Pinchart
