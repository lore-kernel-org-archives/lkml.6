Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E83C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC3B20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548871810;
	bh=EmZvF7H+0NygrHmdlDz0uULZfAPgJ3b1iTz8wkkFJ5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=st1oTB7oKZIlm7oadI/NKf9otCICkc6m6sU6LvMzDwI5oXjDVqCWk+VhfaFVu+bf6
	 bIf4tbpx92Fy57q6H0sSmg8M7lg9lyYTMtIBtelyVTSU41G/n4ztfXOOLOE1ydv6z2
	 X9bQFTpkTeCuVEXvDVLXTG81w3+1agC7ZtujcGMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbfA3SKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:10:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfA3SKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:10:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD98720869;
        Wed, 30 Jan 2019 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548871808;
        bh=EmZvF7H+0NygrHmdlDz0uULZfAPgJ3b1iTz8wkkFJ5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kobNtMP2vKsufH+UdkMFWtKPcG4I8u8Alcsc0gT169GbufQF/UBNjxPNxV1XSrcnB
         OzfFFD9q7pwtJq7mdYPGPGBoCYII84u9A9mUF8kWSz0Ucvg9/ESjiiKL2lbMAmU+qx
         7S+5VaLnaiPgqT9ZPBFp7Y/t1/DpkjKKm3kH6lRM=
Date:   Wed, 30 Jan 2019 19:10:05 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Carlos Henrique Lima Melara <charlesmelara@outlook.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "neil@brown.name" <neil@brown.name>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130181005.GA15653@kroah.com>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
 <20190130163817.GF21904@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130163817.GF21904@lunn.ch>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 05:38:17PM +0100, Andrew Lunn wrote:
> On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
> > 	This patch fix the checkpatch.p1 warning:
> > 
> > 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> > 	+/*
> > 
> > 	It includes the SPDX expression for GPL-2.0 and corrects the comment format to suit the kernel's coding style.
> > 
> > Signed-off-by: Carlos (Charles) Henrique Lima Melara <charlesmelara@outlook.com>
> > ---
> >  drivers/staging/mt7621-eth/ethtool.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
> > index 40a7d47be913..49d417de64c8 100644
> > --- a/drivers/staging/mt7621-eth/ethtool.c
> > +++ b/drivers/staging/mt7621-eth/ethtool.c
> > @@ -1,15 +1,17 @@
> > -/*   This program is free software; you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; version 2 of the License
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Hi Carlos
> 
> drivers/staging/mt7621-eth$ grep LICENSE *
> gsw_mt7621.c:MODULE_LICENSE("GPL");
> mtk_eth_soc.c:MODULE_LICENSE("GPL");
> 
> And include/linux/module.h 
> says:
> 
> /*
>  * The following license idents are currently accepted as indicating free
>  * software modules
>  *
>  *      "GPL"                           [GNU Public License v2 or later]
>  *      "GPL v2"                        [GNU Public License v2]
> 
> So the SPDX string probably does not match the MODULE_LICENSE.

No, ignore the MODULE_LICENSE marking for this, go by what the text at
the top of the file says. See the patch about all of this from Thomas on
lkml yesterday for why this is the case.

So the patch is fine.  If the changelog stuff ever gets fixed...

thanks,

greg k-h
