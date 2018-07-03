Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B9FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834A423D37
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834A423D37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeGCOXz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932133AbeGCOXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:23:54 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821C123D49;
        Tue,  3 Jul 2018 14:23:52 +0000 (UTC)
Date:   Tue, 3 Jul 2018 10:23:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 0/7] Centralize and unify usage of preempt/irq
 tracepoints
Message-ID: <20180703102350.38d4e3fc@gandalf.local.home>
In-Reply-To: <20180703141537.GA108396@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180703141537.GA108396@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 07:15:37 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Thu, Jun 28, 2018 at 11:21:42AM -0700, Joel Fernandes wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > This is a posting of v9 preempt/irq tracepoint clean up series rebased
> > onto v4.18-rc2. No changes in the series, just a rebase + repost.
> > 
> > All patches have a Reviewed-by tags now from reviewers. This series has
> > been well tested and is a simplification/refactoring of existing code,
> > along with giving a speed-up for tracepoints using the rcu-idle API.
> > With this our users will find it easier to use tools depending on
> > existing preempt tracepoints since it simplifies the configuration for
> > them.  
> 
> Steve, all patches of this tracing series have been reviewed and/or acked and
> there haven't been additional changes for a couple of reposts. Are you Ok
> with it?
> 

I'm currently chasing down some fires, but I'll try to get to it this
week.

Thanks for the patience ;-)

-- Steve
