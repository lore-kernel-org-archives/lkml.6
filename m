Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033048AbeBOOEY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:04:24 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:48505 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032283AbeBOOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:04:22 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Kieran Bingham <kbingham@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>, geert@glider.be,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] dt-bindings: display: renesas,lvds: Add LVDS binding for D3
Date: Thu, 15 Feb 2018 16:04:55 +0200
Message-ID: <3242490.rUUU4MHlpR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <ad5ea103-b039-7a2e-01c8-2cb16324115d@ideasonboard.com>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org> <1518683903-10681-4-git-send-email-kbingham@kernel.org> <ad5ea103-b039-7a2e-01c8-2cb16324115d@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Thursday, 15 February 2018 10:45:33 EET Kieran Bingham wrote:
> On 15/02/18 08:38, Kieran Bingham wrote:
> > From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> > The D3 supports two LVDS channels. Extend the binding to support them.
> > 
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> > b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt index
> > 79860f58a7ad..0dcf488b70df 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> > +++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
> > 
> > @@ -14,6 +14,7 @@ Required properties:
> >  - compatible : Shall contain one of
> >    - "renesas,lvds-r8a7795" for R8A7795 (R-Car H3) compatible LVDS
> >    encoders
> >    - "renesas,lvds-r8a7796" for R8A7796 (R-Car M3-W) compatible LVDS
> >    encoders
> > +  - "renesas,lvds-r8a77995" for R8A77995 (R-Car D3) compatible LVDS
> > encoders
> 
> Hi Laurent,
> 
> Are we unable to have a generic lvds-gen3 here?
> 
> (Although to perhaps answer my own question I see that the D3/E3 have extra
> registers)
> 
> Also "lets pretend" that I intentionally separated out the LVDS updates to
> the rcar_lvds_of_table :)

We could for H3 and M3-W, but as you've noticed D3/E3 differ, and so does V3M.

> >  - reg: Base address and length for the memory-mapped registers
> >  - clocks: A phandle + clock-specifier pair for the functional clock

-- 
Regards,

Laurent Pinchart
