Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB94C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5742098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5742098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeIYWEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:04:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeIYWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:04:50 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3CF2C37;
        Tue, 25 Sep 2018 15:56:41 +0000 (UTC)
Date:   Tue, 25 Sep 2018 17:56:39 +0200
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Char/Misc driver fixes for 4.19-rc6
Message-ID: <20180925155639.GA8368@kroah.com>
References: <20180925142344.GA26980@kroah.com>
 <20180925145410.GA2747@kroah.com>
 <CAK8P3a2uRUerniKg7cZ+OuX8QLq+9f+SQKzXO9m6-Li6AYXJMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2uRUerniKg7cZ+OuX8QLq+9f+SQKzXO9m6-Li6AYXJMA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 05:31:03PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 25, 2018 at 4:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 25, 2018 at 04:23:44PM +0200, Greg KH wrote:
> > > [Yes, the oddity of sending a pull request to myself is not lost on me...]
> >
> > And, I totally messed this up.  Ugh, what kind of idiot does something
> > like this!  It's not like I haven't been doing this for years!  I should
> > know better...
> 
> Ah, I was wondering about that. I even found the char-misc-4.19-rc6 tag,
> but it didn't add up. If you want the signoff chain to make more sense,
> you can add my
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> when you pull in your own tag. The resource handling in
> drivers/hwtracing/intel_th/core.c does look a bit odd, which
> confused me for a bit, but that was already the case before
> the patches.

Thanks for the review.  Yeah, that code is "odd" but then again, all of
the hwtracing code is strange :)

I've already pulled this tag into Linus's tree, I though I would be
passive-aggressive and not tell myself that it was done...

thanks,

greg "this is strange" k-h
