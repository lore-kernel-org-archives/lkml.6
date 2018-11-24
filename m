Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD27C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8203620865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 18:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8203620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeKYFaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 00:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeKYFaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 00:30:35 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B732082F;
        Sat, 24 Nov 2018 18:41:33 +0000 (UTC)
Date:   Sat, 24 Nov 2018 13:41:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, frederic@kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>, mark.rutland@arm.com,
        kernel-team@lge.com
Subject: Re: [RFC][PATCH 02/14] fgraph: Have set_graph_notrace only affect
 function_graph tracer
Message-ID: <20181124134131.637eca25@gandalf.local.home>
In-Reply-To: <CAM9d7chQf8iETU6Lm4tN5CBR3VUOtYm1w76bhrbcNoK9pT43xg@mail.gmail.com>
References: <20181122012708.491151844@goodmis.org>
        <20181122012802.894046175@goodmis.org>
        <20181123000118.GB25952@sejong>
        <20181123123732.0dd3c237@vmware.local.home>
        <CAM9d7chQf8iETU6Lm4tN5CBR3VUOtYm1w76bhrbcNoK9pT43xg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2018 14:49:34 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> On Sat, Nov 24, 2018 at 2:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 23 Nov 2018 09:01:18 +0900
> > Namhyung Kim <namhyung@kernel.org> wrote:
> >  
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>  
> >
> > Thanks Namhyung!  
> 
> It'd be nice if you cc me for the whole patchset (and other tracing
> patches) next time.
> 

Bah, Sorry, that was an oversight. You were one of the people I planned
on Cc'ing the entire patch set to, but in the process of adding names I
was more focused on who was at Plumbers that I talked to, and trying
to remember everyone that asked to be Cc'd. I didn't mean to leave you
off. That was a mistake.

-- Steve
