Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075F6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B729420864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B729420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbeGKNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbeGKNdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:33:37 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22F620846;
        Wed, 11 Jul 2018 13:29:14 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:29:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>, Josef Bacik <jbacik@fb.com>,
        daniel@iogearbox.net, davem@davemloft.net,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing/kprobe: Release kprobe print_fmt properly
Message-ID: <20180711092913.353587d7@gandalf.local.home>
In-Reply-To: <20180711222637.2836ee45b4fe3bfa9fb22a0e@kernel.org>
References: <20180709141906.2390-1-jolsa@kernel.org>
        <20180710090417.21423b1b@gandalf.local.home>
        <20180711085429.08437b77@gandalf.local.home>
        <20180711222637.2836ee45b4fe3bfa9fb22a0e@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 22:26:37 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 11 Jul 2018 08:54:29 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > 
> > Masami,
> > 
> > Can you ack this? If I don't hear from you by tomorrow, I'm going to
> > push it to Linus, because I'll be on PTO after that.
> >   
> 
> Sorry for later, yes, it seems correct.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks Masami!

-- Steve
