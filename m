Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeD0VRh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:17:37 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37348 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932373AbeD0VRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:17:35 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: display: renesas: Add R-Car M3-N HDMI TX DT bindings
Date: Sat, 28 Apr 2018 00:17:48 +0300
Message-ID: <6846570.vn03TlgmMA@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180427165722.19445-2-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com> <20180427165722.19445-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Friday, 27 April 2018 19:57:12 EEST Kieran Bingham wrote:
> The M3-N HDMI TX controller is compatible with the M3-W and H3. No
> extension to the DT bindings are needed.
> 
> Add an SoC-specific compatible string in case differences between the IP
> versions are found later and require model-specific handling.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  .../devicetree/bindings/display/bridge/renesas,dw-hdmi.txt       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
> b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
> index 3a72a103a18a..a41d280c3f9f 100644
> --- a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
> @@ -14,6 +14,7 @@ Required properties:
>  - compatible : Shall contain one or more of
>    - "renesas,r8a7795-hdmi" for R8A7795 (R-Car H3) compatible HDMI TX
>    - "renesas,r8a7796-hdmi" for R8A7796 (R-Car M3-W) compatible HDMI TX
> +  - "renesas,r8a77965-hdmi" for R8A77965 (R-Car M3-N) compatible HDMI TX
>    - "renesas,rcar-gen3-hdmi" for the generic R-Car Gen3 compatible HDMI TX
> 
>      When compatible with generic versions, nodes must list the SoC-specific


-- 
Regards,

Laurent Pinchart
