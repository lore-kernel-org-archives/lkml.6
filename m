Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046ACC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BDA21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeLaWmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbeLaWmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:42:50 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5D921019;
        Mon, 31 Dec 2018 22:42:48 +0000 (UTC)
Date:   Mon, 31 Dec 2018 17:42:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [GIT PULL] tracing: Update for 4.21
Message-ID: <20181231174246.3a2b2761@gandalf.local.home>
In-Reply-To: <CAHk-=wi49df9EuxeW1949H=KiqTUEVYnsV33j-8ffr9P-ouU+g@mail.gmail.com>
References: <20181228182813.01ae131a@gandalf.local.home>
        <CAHk-=wh9rpBhJ9r_AH=RuvaD8u1V1VKpY8diqZtpqdToYRdCwA@mail.gmail.com>
        <20181231143300.51310ce3@gandalf.local.home>
        <CAHk-=wi49df9EuxeW1949H=KiqTUEVYnsV33j-8ffr9P-ouU+g@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2018 11:50:18 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > OK, I'll modify my script not to make that diff.  
> 
> For small "fixes" pulls, the diffs are nice, and you actually see the
> details of the fixes. But for big things, the full diff is usually
> only a distraction.
> 
> I think the x86 maintainers have a script where it adds the diff if
> it's less than a hundred lines or something like that..
>

I can look into adding a size limit check, or perhaps it may be good
enough to just remove the diff for merge window pull requests, as those
tend to be the big ones.

-- Steve
