Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33900C6778A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27A5208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27A5208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeGKBqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeGKBqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:46:48 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8055208EC;
        Wed, 11 Jul 2018 01:44:58 +0000 (UTC)
Date:   Tue, 10 Jul 2018 21:44:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/irqtrace: only call trace_hardirqs_on/off when
 state changes
Message-ID: <20180710214457.480826ab@vmware.local.home>
In-Reply-To: <20180502101214.746650bc@roar.ozlabs.ibm.com>
References: <20171116161506.19691-1-npiggin@gmail.com>
        <20180501144620.1e832a09@gandalf.local.home>
        <20180501191951.GJ12217@hirez.programming.kicks-ass.net>
        <20180501153840.7281022a@gandalf.local.home>
        <20180501194838.GK12217@hirez.programming.kicks-ass.net>
        <20180501160059.6df6aae4@gandalf.local.home>
        <CAEi0qNkbjrdx8A4rfNCJd-1BGMUXZRbbLJEkZuVab+oprWhcDQ@mail.gmail.com>
        <20180502101214.746650bc@roar.ozlabs.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018 10:12:14 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> > I have mixed feelings about this patch, I am Ok with this patch but I
> > suggest its sent with the follow-up patch that shows its use of this.
> > And also appreciate if such a follow-up patch is rebased onto the IRQ
> > tracepoint work: https://patchwork.kernel.org/patch/10373129/
> > 
> > What do you think?  
> 
> I'll try to dig it up and resend. Thanks for the feedback on it.

Joel,

With your latest patches, is this obsolete?

-- Steve
