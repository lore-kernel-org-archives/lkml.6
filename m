Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3D2FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C0C20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C0C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeINWfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:35:03 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45228 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727246AbeINWfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:35:03 -0400
Received: (qmail 4516 invoked by uid 2102); 14 Sep 2018 13:19:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Sep 2018 13:19:37 -0400
Date:   Fri, 14 Sep 2018 13:19:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <mingo@kernel.org>,
        <parri.andrea@gmail.com>, Will Deacon <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, <akiyks@gmail.com>
Subject: Re: [PATCH RFC memory-model 0/7] Memory-model changes
In-Reply-To: <20180914163649.GA13942@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1809141315580.1482-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018, Paul E. McKenney wrote:

> 	bf36a3124d04 doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
> 
> 		Small change, needs an ack.  Looks to me like is is
> 		just aligning the documentation with the code, so
> 		should not be controversial (famous last words).
> 
> 		Please take a look and consider giving feedback
> 		and/or a review/ack.

What branch is this commit in?  It doesn't seem to be in the lkmm 
branch.

In any case, the change is trivial and obviously correct.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan

