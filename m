Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203CDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F83222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbfBKPTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:19:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:46046 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404067AbfBKPTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:19:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 304DD2F3;
        Mon, 11 Feb 2019 15:19:12 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:19:10 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Jessica Yu <jeyu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Christoph Hellwig <hch@lst.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
 bogosity
Message-ID: <20190211081910.2effaf8f@lwn.net>
In-Reply-To: <alpine.DEB.2.21.1902101957040.8784@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901282105450.1669@nanos.tec.linutronix.de>
        <20190129130658.GA19205@linux-8ccs>
        <alpine.DEB.2.21.1901291510060.1513@nanos.tec.linutronix.de>
        <20190206172151.56fcce6c@lwn.net>
        <alpine.DEB.2.21.1902081649290.2144@nanos.tec.linutronix.de>
        <CAOFm3uE9DakoBsPv6GrSfeHMQOoGsFBj61o-p0YfxmEvjYRsvg@mail.gmail.com>
        <alpine.DEB.2.21.1902101957040.8784@nanos.tec.linutronix.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 19:58:11 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 9 Feb 2019, Philippe Ombredanne wrote:
> > > + * Both "GPL v2" and "GPL" (the latter also in dual licensed strings) are
> > > + * merily stating that the module is licensed under the GPL v2, but are not  
> > 
> > Nit: did you mean merely (as mere/just) ? or merily/merrily (as in
> > cheerfully/happily) ? :D  
> 
> Bah. merely of course.
> 
> Jon, want me to resend?

Nah...I merily made the tweak while adding Jessica's ack.

Thanks,

jon
