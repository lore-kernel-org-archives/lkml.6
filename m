Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585E1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C23D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeLaTdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbeLaTdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:33:03 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339F42073F;
        Mon, 31 Dec 2018 19:33:02 +0000 (UTC)
Date:   Mon, 31 Dec 2018 14:33:00 -0500
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
Message-ID: <20181231143300.51310ce3@gandalf.local.home>
In-Reply-To: <CAHk-=wh9rpBhJ9r_AH=RuvaD8u1V1VKpY8diqZtpqdToYRdCwA@mail.gmail.com>
References: <20181228182813.01ae131a@gandalf.local.home>
        <CAHk-=wh9rpBhJ9r_AH=RuvaD8u1V1VKpY8diqZtpqdToYRdCwA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2018 10:17:41 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 28, 2018 at 3:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> > trace-v4.21  
> 
> No such tag.
> 

Ug!

> > Tag SHA1: bcf1ea7cb12ce702d1d0660dfba0c3462c0b04e1
> > Head SHA1: 3d739c1f6156c70eb0548aa288dcfbac9e0bd162  
> 
> I can see branches with that commit SHA ("for-next" and "ftrace/core")
> but there is no tag with that name or that SHA1.
> 
> Forgot to push out?

Yeah, I did. I just pushed it out.

> 
> Btw, please don't include the whole diff in the same email when it's
> ~seven thousand lines and over 200k in size. Yeah, I'm on a fast
> connection, but that isn't *always* true. Did lkml even take this
> email?

OK, I'll modify my script not to make that diff.

It does appear to have still made it to LKML. I received it in my LKML
folder with:

 X-Mailing-List: linux-kernel@vger.kernel.org

-- Steve
