Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E997C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445DE20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445DE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeGYIjz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:39:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53976 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbeGYIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:39:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39B35207A8; Wed, 25 Jul 2018 09:29:29 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id D9F5D20618;
        Wed, 25 Jul 2018 09:29:28 +0200 (CEST)
Date:   Wed, 25 Jul 2018 09:29:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-mtd@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] mtd: nand: fix spelling in driver api documentation
Message-ID: <20180725092928.243bf07f@xps13>
In-Reply-To: <20180723181915.5f35f668@bbrezillon>
References: <20180720075334.24254-1-marcel@ziswiler.com>
        <20180723093924.04af0e2f@lwn.net>
        <20180723181915.5f35f668@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Mon, 23 Jul 2018
18:19:15 +0200:

> Hi Jonathan,
> 
> On Mon, 23 Jul 2018 09:39:24 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
> 
> > On Fri, 20 Jul 2018 09:53:33 +0200
> > Marcel Ziswiler <marcel@ziswiler.com> wrote:
> >   
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > This fixes some spelling mistakes.    
> > 
> > So I hate to complain about a documentation improvement, but...
> >   
> > > 
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > ---
> > > 
> > >  Documentation/driver-api/mtdnand.rst | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/driver-api/mtdnand.rst b/Documentation/driver-api/mtdnand.rst
> > > index dcd63599f700..c55a6034c397 100644
> > > --- a/Documentation/driver-api/mtdnand.rst
> > > +++ b/Documentation/driver-api/mtdnand.rst
> > > @@ -374,7 +374,7 @@ The nand driver supports three different types of hardware ECC.
> > >  
> > >  -  NAND_ECC_HW8_512
> > >  
> > > -   Hardware ECC generator providing 6 bytes ECC per 512 byte.
> > > +   Hardware ECC generator providing 8 bytes ECC per 512 byte.    
> > 
> > That's not a spelling mistake, that's a factual change.  I'll apply the
> > patch since it appears to be correct, but will be tweaking the changelog.  
> 
> I think Miquel had planned to apply this patch to the NAND tree, but we
> don't seem to have conflicting changes on this file, so feel free to
> take it in the doc tree.
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

Can you confirm you will take this patch?

Thanks,
Miquèl
