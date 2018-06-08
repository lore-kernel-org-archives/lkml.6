Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9UpZLgovGlsdPgAAmS7hNA
	; Fri, 08 Jun 2018 07:23:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A7A22607E4; Fri,  8 Jun 2018 07:23:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0913860590;
	Fri,  8 Jun 2018 07:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0913860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeFHHXs convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Fri, 8 Jun 2018 03:23:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34007 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeFHHXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:23:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EC4B42073D; Fri,  8 Jun 2018 09:23:42 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7478E2069C;
        Fri,  8 Jun 2018 09:23:42 +0200 (CEST)
Date: Fri, 8 Jun 2018 09:23:42 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "wmw2@infradead.org" <wmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Message-ID: <20180608092342.2b589cc5@xps13>
In-Reply-To: <MWHPR02MB2623AA49F71D3D24B997C682AF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180607174203.035f187d@xps13>
        <MWHPR02MB2623AA49F71D3D24B997C682AF7B0@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

On Fri, 8 Jun 2018 05:20:33 +0000, Naga Sureshkumar Relli
<nagasure@xilinx.com> wrote:

> Hi Miquel,
> 
> Thanks for the review.
> 
> > -----Original Message-----
> > From: Miquel Raynal [mailto:miquel.raynal@bootlin.com]
> > Sent: Thursday, June 7, 2018 9:12 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: boris.brezillon@bootlin.com; richard@nod.at; wmw2@infradead.org;
> > computersforpeace@gmail.com; marek.vasut@gmail.com; f.fainelli@gmail.com;
> > mmayer@broadcom.com; rogerq@ti.com; ladis@linux-mips.org; ada@thorsis.com;
> > honghui.zhang@mediatek.com; linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org;
> > nagasureshkumarrelli@gmail.com
> > Subject: Re: [LINUX PATCH v9 1/4] Devicetree: Add pl353 smc controller devicetree
> > binding information
> > 
> > Hi Naga,
> > 
> > On Wed, 6 Jun 2018 13:19:39 +0530, Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com> wrote:
> >   
> > > Add pl353 static memory controller devicetree binding information.
> > >
> > > Signed-off-by: Naga Sureshkumar Relli
> > > <naga.sureshkumar.relli@xilinx.com>
> > > ---
> > > Changes in v9:
> > >  - Addressed commens given by Randy Dunlap and Miquel Raynal  
> > 
> > Can you please be more specific in your next changelog? I don't remember what I suggested a
> > few months ago :)  
> Ok, I will update.
> 
> >   
> > > Changes in v8:
> > >  - None
> > > Changes in v7:
> > > - Corrected clocks description
> > > - prefixed '#' for address and size cells Changes in v6:
> > >  - None
> > > Changes in v5:
> > >  - Removed timing properties
> > > Changes in v4:
> > >  - none
> > > Changes in v3:
> > >  - none
> > > Changes in v2:
> > >  - modified timing binding info as per onfi timing parameters
> > >  - add suffix nano second as timing unit
> > >  - modified the clock names as per the IP spec
> > > ---
> > >  .../bindings/memory-controllers/pl353-smc.txt      | 53  
> > ++++++++++++++++++++++  
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > > b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > > new file mode 100644
> > > index 0000000..551e66b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.t
> > > +++ xt
> > > @@ -0,0 +1,53 @@
> > > +Device tree bindings for ARM PL353 static memory controller
> > > +
> > > +PL353 static memory controller supports two kinds of memory
> > > +interfaces.i.e NAND and SRAM/NOR interfaces.
> > > +The actual devices are instantiated from the child nodes of pl353 smc node.
> > > +
> > > +Required properties:
> > > +- compatible		: Should be "arm,pl353-smc-r2p1"  
> > 
> > I thing Rob prefers:
> > 
> > - compatible: Must be one of:
> >   * arm, pl353-smc-r2p1  
> Are you suggesting any other compatibles?
> Or just a change from "should be to Must be one of"?
> >   

Just the rewording + making it a list in case we need to add new
compatibles in the future.

Thanks,
Miquèl
