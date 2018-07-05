Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE60AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031B240BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B031B240BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeGEOXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:23:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42900 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753401AbeGEOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:23:01 -0400
Received: (qmail 1959 invoked by uid 2102); 5 Jul 2018 10:23:01 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Jul 2018 10:23:01 -0400
Date:   Thu, 5 Jul 2018 10:23:01 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Will Deacon <will.deacon@arm.com>
cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by release-acquire
 and by locks
In-Reply-To: <20180704121354.GC26941@arm.com>
Message-ID: <Pine.LNX.4.44L0.1807051021510.1697-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Will Deacon wrote:

> On Wed, Jul 04, 2018 at 04:28:52AM -0700, Paul E. McKenney wrote:
> > On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> > > PS: Paul, is the patch which introduced rel-rf-acq-po currently present
> > > in any of your branches?  I couldn't find it.
> > 
> > It is not, I will add it back in.  I misinterpreted your "drop this
> > patch" on 2/2 as "drop both patches".  Please accept my apologies!
> > 
> > Just to double-check, the patch below should be added, correct?
> 
> Hang on, I'm not sure this patch is quite right either. We need to reach
> agreement on whether or not we want to support native RCpc acquire/release
> instructions before we work out what to do with this relation.

Agreed.  Paul, please leave both patches reverted.  I will send 
replacements.

Alan

