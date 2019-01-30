Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE66C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22650218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548882756;
	bh=Yqt6SM7PMKFBikFCGORlO+/wGTguLWm650gwRlVzdfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o57rVMyVhQlvWc5R09nJuPpuAQTe5FPkbuSUpVtoWhAx93CUPxuYdFzOGBno9COKn
	 4JPQMkNNU7D9xP4kUxJOrBzB19hTFkx8Jsy+9qbksDeywY9LBIuoT9hW798VR94HoD
	 Vrv+cCZ9qzhAsJoY0cxvtV1vfT9efLxntkR1Lt08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfA3VMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfA3VMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:12:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFA2218AF;
        Wed, 30 Jan 2019 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548882753;
        bh=Yqt6SM7PMKFBikFCGORlO+/wGTguLWm650gwRlVzdfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yghME5ROvkceOHz0qC/lzqRWBdIK3ynwBTmFPhftUBoeJ4oe6LuMuWHomuT8Ge3/z
         bgYlJsjY7qcHZdhh7+mL0kLzWYEBXqoWmOsOP9fg5UystRulO4GoO7NGafhU39GlbF
         TTLVtfKucBwB4HrzOLxttDjrN63IPIqEkMi656B8=
Date:   Wed, 30 Jan 2019 22:12:31 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Carlos Henrique Lima Melara <charlesmelara@outlook.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "neil@brown.name" <neil@brown.name>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130211231.GA25919@kroah.com>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
 <20190130152956.GA4195@kroah.com>
 <RO1P15201MB201234F951531D13328C4FF2A8900@RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RO1P15201MB201234F951531D13328C4FF2A8900@RO1P15201MB2012.LAMP152.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:01:13PM +0000, Carlos Henrique Lima Melara wrote:
> On 30/01/2019 13:29, gregkh@linuxfoundation.org wrote:
> > On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
> >> 	This patch fix the checkpatch.p1 warning:
> >>
> >> 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> >> 	+/*
> >
> > Why did you not fix up the indentation that was already mentioned?
> 
> The Warning was about the missing SPDX License Identifier, so I added the 
> identifier according to the "license-rules.rst" for C source that is:

I mean the indentation of the text in your changelog, nothing to do with
the actual change in your patch below, sorry for the confusion.

> >   The SPDX license identifier is added in form of a comment.  The comment
> >   style depends on the file type::
> >
> >      C source:	// SPDX-License-Identifier: <SPDX License Expression>
> >      C header:	/* SPDX-License-Identifier: <SPDX License Expression> */
> >      ASM:	/* SPDX-License-Identifier: <SPDX License Expression> */
> >      scripts:	# SPDX-License-Identifier: <SPDX License Expression>
> >      .rst:	.. SPDX-License-Identifier: <SPDX License Expression>
> >      .dts{i}:	// SPDX-License-Identifier: <SPDX License Expression>
> 
> I think that was the correction needed, right?

Yes.

> Still have a question about the license comment in the "ethtooll.c". 
> 
> > /*   This program is free software; you can redistribute it and/or modify
> >  *   it under the terms of the GNU General Public License as published by
> >  *   the Free Software Foundation; version 2 of the License
> >  *
> >  *   This program is distributed in the hope that it will be useful,
> >  *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> >  *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >  *   GNU General Public License for more details.
> >  *
> >  *   Copyright (C) 2009-2016 John Crispin <blogic@openwrt.org>
> >  *   Copyright (C) 2009-2016 Felix Fietkau <nbd@openwrt.org>
> >  *   Copyright (C) 2013-2016 Michael Lee <igvtee@gmail.com>
> >  */
> 
> It puts 3 spaces between the * and the text, should it be corrected to 
> only one space?

If you really want to, but it's not needed.

All of the "boilerplate" license text can also be removed after the SPDX
line is added, if you want to do that.  But leave the copyright lines,
that needs to stay.

thanks,

greg k-h
