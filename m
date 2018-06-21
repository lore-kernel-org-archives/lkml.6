Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0379C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF755208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF755208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeFUNZ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932704AbeFUNZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:25:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5FD20883;
        Thu, 21 Jun 2018 13:25:23 +0000 (UTC)
Date:   Thu, 21 Jun 2018 09:25:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>,
        Julia Cartwright <julia@ni.com>,
        Byungchul Park <byungchul.park@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] softirq: reorder trace_softirqs_on to prevent
 lockdep splat
Message-ID: <20180621092521.62ed3076@gandalf.local.home>
In-Reply-To: <20180621130848.GA10037@gmail.com>
References: <20180607201143.247775-1-joel@joelfernandes.org>
        <20180621130848.GA10037@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 15:08:48 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks a lot Ingo!

> 
> Steve, wanna queue this up? Splat should only occur with tracing AFAICT.

Yeah, I'll take this in my tree.

-- Steve
