Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8467C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F13721884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13721884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbeHGOh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:37:27 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:65402 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732215AbeHGOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:37:27 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 5296F48CBF;
        Tue,  7 Aug 2018 14:23:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id XPoC5Qg1xsnj; Tue,  7 Aug 2018 14:23:18 +0200 (CEST)
Date:   Tue, 7 Aug 2018 14:23:15 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v4 0/4] seccomp trap to userspace
Message-ID: <20180807122315.q4uxhjxoejv2jg5x@mailbox.org>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180807024442.GA12274@cisco.lan>
 <20180807033043.2esvm5qbhhqvatvy@mailbox.org>
 <CALCETrVR9r4QsKtwK_+tO7V33G+4r4rkB652rq1A1K2XJvTNrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVR9r4QsKtwK_+tO7V33G+4r4rkB652rq1A1K2XJvTNrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:19:04PM -0700, Andy Lutomirski wrote:
> On Mon, Aug 6, 2018 at 8:30 PM, Christian Brauner <christian@brauner.io> wrote:
> > On Mon, Aug 06, 2018 at 08:44:42PM -0600, Tycho Andersen wrote:
> >> Hi all,
> >>
> >> Dinesh Subhraveti has claimed that some part of this series might be
> >> patented. While he has not furnished me with anything to confirm this
> >> claim, I'll put this series on hold.
> >
> > Hey man,
> >
> > Sorry to hear that your faced with such nonsense, Tycho. This is utter
> > bullsh*t of course. If you have more details at some point and feel
> > comfortable doing so it would probably be good to share them here.
> 
> IANAL, but I think it would probably *not* be good to share them here.
> Patent law is seriously fucked up like that.

**ugh**. Yeah, you're probably right. My thought was that in the face of
publicity this nonesense might go away quickly.

Christian
