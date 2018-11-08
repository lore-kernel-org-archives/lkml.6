Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13484C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06752086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="qNAZbeQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06752086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeKHV6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:58:48 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:45045 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeKHV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:58:48 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id C6CF625B75A;
        Thu,  8 Nov 2018 23:23:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1541679812; bh=uhinyoMHN3hbsYYoC339lxf76cZWFE1YYKC1jQ3Wltw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNAZbeQvCt1QXBPYOFfZuCVtgty9JnJwQDlAEaxmHAsHuisTWQb/IiaRuBXk4Dvqc
         RgvNdAVxXNaX26LfqRBvGe8J7NUIuFYjUJUwaySYMQcBURle01zTEzATVcgpF8X56u
         bu6blJgQt5/3up5F8Lnn4gHr+vSknmAnjyq0ItMM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id AAB0894048A; Thu,  8 Nov 2018 13:23:29 +0100 (CET)
Date:   Thu, 8 Nov 2018 13:23:29 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Message-ID: <20181108122329.pxxjrmaaxutxxel3@verge.net.au>
References: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB17708409052CFB9469856335C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB17708409052CFB9469856335C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

I believe this one is for Vinod.

On Thu, Nov 08, 2018 at 11:03:53AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> Who is the best person to take this patch?
> 
> Thanks,
> Fab
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 14 August 2018 13:32
> > Subject: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
> >
> > Renesas' RZ/G2M (R8A774A1) SoC has DMA controllers compatible
> > with this driver, therefore document RZ/G2M specific bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > index 946229c..2de2eed 100644
> > --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > @@ -1,6 +1,6 @@
> >  * Renesas R-Car (RZ/G) DMA Controller Device Tree bindings
> >
> > -Renesas R-Car Generation 2 SoCs have multiple multi-channel DMA
> > +Renesas R-Car (Gen 2/3) and RZ/G SoCs have multiple multi-channel DMA
> >  controller instances named DMAC capable of serving multiple clients. Channels
> >  can be dedicated to specific clients or shared between a large number of
> >  clients.
> > @@ -19,6 +19,7 @@ Required Properties:
> >  - "renesas,dmac-r8a7743" (RZ/G1M)
> >  - "renesas,dmac-r8a7745" (RZ/G1E)
> >  - "renesas,dmac-r8a77470" (RZ/G1C)
> > +- "renesas,dmac-r8a774a1" (RZ/G2M)
> >  - "renesas,dmac-r8a7790" (R-Car H2)
> >  - "renesas,dmac-r8a7791" (R-Car M2-W)
> >  - "renesas,dmac-r8a7792" (R-Car V2H)
> > --
> > 2.7.4
> 
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> 
