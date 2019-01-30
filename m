Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D8DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F922184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfA3VGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:06:03 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45896 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfA3VGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:06:03 -0500
X-Greylist: delayed 1179 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 16:06:02 EST
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x0UKmmrr003270;
        Wed, 30 Jan 2019 20:48:48 GMT
Date:   Wed, 30 Jan 2019 20:48:48 +0000
From:   Alan Cox <alan@llwyncelyn.cymru>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jessica Yu <jeyu@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20190130204848.19fc6912@alans-desktop>
In-Reply-To: <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
        <20190129130658.GA19205@linux-8ccs>
        <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de>
Organization: is over-rated
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +    "GPL and additional rights"   Historical variant of expressing that the
> > > +				  module source is dual licensed under a
> > > +				  GPL v2 variant and MIT license. Please do
> > > +				  not use in new code.

Actually it was a historic fix for the fact that some slimeballs were
going to use a proposed "BSD" tag and just ship binaries only whilst
claiming that they were totally compliant with the BSD licence.

Alan
