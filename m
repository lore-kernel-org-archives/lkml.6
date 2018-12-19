Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E7CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC620874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeLSO0u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:26:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34961 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729426AbeLSO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:26:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 83D91207BE; Wed, 19 Dec 2018 15:26:47 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 20C372072C;
        Wed, 19 Dec 2018 15:26:47 +0100 (CET)
Date:   Wed, 19 Dec 2018 15:26:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        martin.lund@keep-it-simple.com
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181219152647.76f77711@xps13>
In-Reply-To: <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <MWHPR02MB2623AAEC160F40F061E23194AFD80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181119090246.49060019@bbrezillon>
        <BN6PR02MB2610C7D048E4A192E041BE14AFD90@BN6PR02MB2610.namprd02.prod.outlook.com>
        <20181120120244.7d2442b5@bbrezillon>
        <20181120133624.3fa4742d@xps13>
        <MWHPR02MB26238A2271B33470ABFA1023AFD40@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB26239C2B2A7050310BEF1E9CAFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212091135.1d0cc9a6@xps13>
        <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212100931.149b0cac@xps13>
        <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212141825.69711c57@xps13>
        <MWHPR02MB26235AE6567A06EF4C6362E6AFBC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181217174114.24196d17@xps13>
        <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

+ Martin

Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Tue, 18 Dec 2018
05:33:53 +0000:

> Hi Miquel,
> 
> > -----Original Message-----
> > From: Miquel Raynal [mailto:miquel.raynal@bootlin.com]
> > Sent: Monday, December 17, 2018 10:11 PM
> > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > Cc: Boris Brezillon <boris.brezillon@bootlin.com>; robh@kernel.org; richard@nod.at; linux-
> > kernel@vger.kernel.org; marek.vasut@gmail.com; linux-mtd@lists.infradead.org;
> > nagasuresh12@gmail.com; Michal Simek <michals@xilinx.com>;
> > computersforpeace@gmail.com; dwmw2@infradead.org
> > Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for Arasan
> > NAND Flash Controller
> > 
> > Hi Naga,
> > 
> > [...]
> >   
> > > Inserted biterror @ 48/7
> > > Successfully corrected 25 bit errors per subpage Inserted biterror @
> > > 50/7 ECC failure, invalid data despite read success
> > > root@xilinx-zc1751-dc2-2018_1:~#
> > >
> > > But even in this case also, driver is saying ECC failure but read success.
> > > That means controller is able to detect errors on read page up to 24 bit only.
> > > After that there is no way to say to the upper layers that the page is bad because of the  
> > limitation in the controller.
> > 
> > This is more than a "limitation", the design is broken. I am not sure how to support such
> > controller, and I am not sure if we even want to.  
> 
> The number of errors that are correctable is limited by a parameter 't'(total number of errors),
> If there is a condition that the number of errors greater than 't', then the controller won't be able to detect that.
> I guess this concept is same for other controllers as well.
> In Arasan it is limited to 24-bit.
> 
> Even, in case of Hamming, it is 1-bit error correction and 2-bit error detection.
> What will happen if there are multiple errors(greater than 2-bit)?

Ok let's use the Hamming comparison in your ECC engine case.

-> hamming:
 * 0 bf: everything is fine
 * 1 bf: will be detected, corrected, signaled
 * 2 bf: will be detected, not corrected, signaled
 * 3+ bf: don't care

-> BCH:
 * 0 bf: everything is fine
 * 1-24 bf: will be detected, corrected, signaled
 * 25 bf: everything is fine
 * 26+ bf: don't care

Do you see the problem?

In the 25 bf case, the controller is reporting that everything went
fine while it should report that it detected an uncorrectable
situation.

Here are two leads to solve this issue, please investigate them both:
1/ Talk to your colleagues that developed the RTL, ask if there is a
   hidden/reserved bit for that purpose that is not documented.
2/ Search for a status in the registers that might indicate that an
   error occurred, for instance "0 bf corrected" and "bf have been
   detected".

NB: I know that, with a BCH ECC engine, error detection at (strength +
1) is not 100% sure but statistically it will almost always be detected
and in this case we need the controller to warn the user!


Thanks,
Miquèl
