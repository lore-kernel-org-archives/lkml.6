Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C06C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD682075D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfBGAVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:21:53 -0500
Received: from ms.lwn.net ([45.79.88.28]:35570 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBGAVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:21:53 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9E0A64FA;
        Thu,  7 Feb 2019 00:21:52 +0000 (UTC)
Date:   Wed, 6 Feb 2019 17:21:51 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jessica Yu <jeyu@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
Message-ID: <20190206172151.56fcce6c@lwn.net>
In-Reply-To: <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
        <20190129130658.GA19205@linux-8ccs>
        <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 15:11:40 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 29 Jan 2019, Jessica Yu wrote:
> > +++ Thomas Gleixner [28/01/19 23:38 +0100]:  
> > > +    "GPL"			  Module is licensed under GPL version 2. This
> > > +				  does not express any distinction between
> > > +				  GPL-2.0-only or GPL-2.0-or-later. The exact
> > > +				  license information can only be determined
> > > +				  via the license information in the
> > > +				  corresponding source files.
> > > +
> > > +    "GPL v2"			  Same as "GPL v2". It exists for historic
> > > +				  reasons.  
> > 
> > Did you mean to say 'Same as "GPL"' here? (as in, "GPL v2" conveys the same
> > information as the "GPL" module license string)  
> 
> Of course. After staring at all this for too long I confused myself and did
> not spot it even if I read through the whole thing several times.

Were you thinking of sending a new version with tweaks?  I can happy apply
this version with this fix if you prefer, let me know...

Thanks,

jon
