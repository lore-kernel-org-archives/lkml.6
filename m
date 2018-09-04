Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ACEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A590220659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A590220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeIDRL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:11:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39052 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeIDRL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:11:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A9A90207B4; Tue,  4 Sep 2018 14:46:28 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 37E57204AE;
        Tue,  4 Sep 2018 14:46:28 +0200 (CEST)
Date:   Tue, 4 Sep 2018 14:46:27 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Cc:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Message-ID: <20180904144627.1de264b6@bbrezillon>
In-Reply-To: <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 09:54:08 +0000
Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:

> Dear Yogesh,
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-  
> > owner@vger.kernel.org> On Behalf Of Yogesh Gaur  
> > Sent: Friday, August 31, 2018 4:00 PM
> > To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> > arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh
> > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI driver
> > 
> > Add binding file for NXP FlexSPI driver.
> > 
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> > ++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> > fspi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > new file mode 100644
> > index 0000000..9f07116
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > @@ -0,0 +1,42 @@
> > +* NXP Flex Serial Peripheral Interface (FSPI)
> > +
> > +Required properties:
> > +  - compatible : Should be "nxp,lx2160a-fspi"
> > +  - reg :        First contains the register location and length,
> > +                 Second contains the memory mapping address and length  
> 
> Why are we overriding reg property.  Is there any special requirement. 
> 
> Can we use "reg" and "ranges" property in device tree.
> Here "reg" represents controller registers and "ranges" represent the memory address of flash.

No, ranges is not used for that. It's used when you need to convert
from one address space to another, which is not what you're describing
here. Check section 2.38 of this document [1] for more details.

[1]https://elinux.org/images/c/cf/Power_ePAPR_APPROVED_v1.1.pdf
