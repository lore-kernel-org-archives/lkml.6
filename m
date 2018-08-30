Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3328C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6328E205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6328E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH3Vna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeH3Vna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:43:30 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A7C020835;
        Thu, 30 Aug 2018 17:40:14 +0000 (UTC)
Date:   Thu, 30 Aug 2018 13:40:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/52] Remove rcu_state pointers for
 v4.20/v5.0
Message-ID: <20180830134012.7efc3cce@gandalf.local.home>
In-Reply-To: <20180830171006.GK4225@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
        <20180829220026.3579e9a1@vmware.local.home>
        <20180830032216.GF4225@linux.vnet.ibm.com>
        <20180830041017.GA27378@linux.vnet.ibm.com>
        <20180830114452.309e104f@gandalf.local.home>
        <20180830171006.GK4225@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 10:10:06 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:


> > I would just keep the documentation patches separate.  
> 
> Combining yours and Josh's feedback, I will split the documentation
> updates out of 4ca0508f7870 ("rcu: Remove rsp parameter from rcu_node tree
> accessor macros") and put them into the "doc" series.  Possibly combining
> it with 2ea66b6fce61 ("doc: Update documentation for removal of RCU-bh
> update machinery") and/or 3f38a4626202 ("doc: Update documentation for
> removal of RCU-sched update machinery").  Left to myself, I would merge
> it in to the merger of those two documentation commits.  Having them
> together is probably more convenient anyway, as it would provide a
> summary of the entire RCU-flavor-consolidation change.
> 
> Fair enough?
>

Go for it ;-)

-- Steve
