Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeDZUK3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:10:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59286 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753003AbeDZUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:10:27 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: kieran.bingham@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/17] dt-bindings: display: renesas: du: Document the R8A77965 bindings
Date: Thu, 26 Apr 2018 23:10:40 +0300
Message-ID: <69317997.GXJe2a7Jrz@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <e94ae62f-30bb-5056-9646-03941d74ae75@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-3-kieran.bingham+renesas@ideasonboard.com> <e94ae62f-30bb-5056-9646-03941d74ae75@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:57:32 EEST Kieran Bingham wrote:
> Ahem - this one seems to have lost it's commit message.
> 
> Apologies :)

Apart from that, this looks good to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree with the commit message

Document the M3-N (r8a77965) SoC in the R-Car DU bindings

Let me know if you would like a different message.

> On 26/04/18 17:53, Kieran Bingham wrote:
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt
> > b/Documentation/devicetree/bindings/display/renesas,du.txt index
> > a36a6e7ee54f..7c6854bd0a04 100644
> > --- a/Documentation/devicetree/bindings/display/renesas,du.txt
> > +++ b/Documentation/devicetree/bindings/display/renesas,du.txt
> > 
> > @@ -13,6 +13,7 @@ Required Properties:
> >      - "renesas,du-r8a7794" for R8A7794 (R-Car E2) compatible DU
> >      - "renesas,du-r8a7795" for R8A7795 (R-Car H3) compatible DU
> >      - "renesas,du-r8a7796" for R8A7796 (R-Car M3-W) compatible DU
> > +    - "renesas,du-r8a77965" for R8A77965 (R-Car M3-N) compatible DU
> >      - "renesas,du-r8a77970" for R8A77970 (R-Car V3M) compatible DU
> >      - "renesas,du-r8a77995" for R8A77995 (R-Car D3) compatible DU
> > 
> > @@ -59,6 +60,7 @@ corresponding to each DU output.
> > 
> >   R8A7794 (R-Car E2)     DPAD 0         DPAD 1         -              -
> >   R8A7795 (R-Car H3)     DPAD 0         HDMI 0         HDMI 1         LVDS
> >   0
> >   R8A7796 (R-Car M3-W)   DPAD 0         HDMI 0         LVDS 0         -
> > + R8A77965 (R-Car M3-N)  DPAD 0         HDMI 0         LVDS 0         -
> >   R8A77970 (R-Car V3M)   DPAD 0         LVDS 0         -              -
> >   R8A77995 (R-Car D3)    DPAD 0         LVDS 0         LVDS 1         -

-- 
Regards,

Laurent Pinchart
