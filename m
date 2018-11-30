Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8371E20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8371E20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeLAFXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeLAFXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:23:38 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068B820660;
        Fri, 30 Nov 2018 18:13:30 +0000 (UTC)
Date:   Fri, 30 Nov 2018 13:13:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: More fixes for 4.20
Message-ID: <20181130131329.7feb6fa9@gandalf.local.home>
In-Reply-To: <CAHk-=wgVQNNB6XhJQMwyQdc1B5Qh3nMXhixK5uzbdeOOnwOmdw@mail.gmail.com>
References: <20181130031829.268422593@goodmis.org>
        <CAHk-=wgVQNNB6XhJQMwyQdc1B5Qh3nMXhixK5uzbdeOOnwOmdw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 09:41:00 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Nov 29, 2018 at 7:19 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Note, this is on top of a previous git pull that I have submitted:
> >
> >   http://lkml.kernel.org/r/20181127224031.76681fe0@vmware.local.home  
> 
> Hmm.
> 
> I had dismissed that, because the patch descriptors for that series
> had had "for-next" in them.
> 
>     https://lore.kernel.org/lkml/20181122002801.501220343@goodmis.org/
> 
> so I dismissed that pull request entirely as being not for this
> release entirely.
> 
> I went back and merged things, but in general, please try to avoid
> confusing me. I'm easily confused when I get mixed messages about the
> patches and the pull requests, and will then generally default to
> "ignore, this is informational".
>

My apologies. I used my scripts to push them into my linux-next repo,
and it added the [for-next] when doing so in the series. I wanted it to
sit in next for a week (because I modified a bunch of architecture code
that I could only compile test, but not run).

I'll be more careful next time.

Thanks!

-- Steve
