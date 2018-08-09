Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E8EC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2688721BF3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2688721BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbeHID2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeHID2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:28:45 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A365C21B32;
        Thu,  9 Aug 2018 01:06:32 +0000 (UTC)
Date:   Wed, 8 Aug 2018 21:06:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH RFC ftrace/core] tracing: Directly call tracer and
 lockdep probes
Message-ID: <20180808210631.6ceca48d@vmware.local.home>
In-Reply-To: <CAEXW_YQSRuWVK6jCAnbbepuVwF74VhoASb6rCFduDcv5V0uT0A@mail.gmail.com>
References: <20180808220022.65184-1-joel@joelfernandes.org>
        <CAEXW_YQSRuWVK6jCAnbbepuVwF74VhoASb6rCFduDcv5V0uT0A@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 15:20:22 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Wed, Aug 8, 2018 at 3:00 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >  
> 
> I realize I kept your authorship since I started working based on your patch ;-)
> 
> Well sorry about that, and you could change it to mine or keep it as
> is it is if you want ;-)
> 

Actually I already started testing a second patch that basically does
your extension ;-) I'll post it shortly.

-- Steve
