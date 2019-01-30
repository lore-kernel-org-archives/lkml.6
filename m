Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA086C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDEE20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbfA3VsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:48:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfA3VsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:48:03 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goxiB-0006Nl-Qx; Wed, 30 Jan 2019 22:48:00 +0100
Date:   Wed, 30 Jan 2019 22:47:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alan Cox <alan@llwyncelyn.cymru>
cc:     Jessica Yu <jeyu@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH][RFC] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
In-Reply-To: <20190130204848.19fc6912@alans-desktop>
Message-ID: <alpine.DEB.2.21.1901302243040.8200@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de> <20190129130658.GA19205@linux-8ccs> <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de> <20190130204848.19fc6912@alans-desktop>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Alan Cox wrote:

> > > > +    "GPL and additional rights"   Historical variant of expressing that the
> > > > +				  module source is dual licensed under a
> > > > +				  GPL v2 variant and MIT license. Please do
> > > > +				  not use in new code.
> 
> Actually it was a historic fix for the fact that some slimeballs were
> going to use a proposed "BSD" tag and just ship binaries only whilst
> claiming that they were totally compliant with the BSD licence.

Ah, that is valuable information. I spent quite some time NOT to find it :)

Thanks,

	tglx


