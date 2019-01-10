Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6958E214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfAJPr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:47:27 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:35418 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728196AbfAJPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:47:27 -0500
Received: (qmail 13609 invoked by uid 2102); 10 Jan 2019 10:47:26 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jan 2019 10:47:26 -0500
Date:   Thu, 10 Jan 2019 10:47:26 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     linux-kernel@vger.kernel.org, <linux-arch@vger.kernel.org>,
        <mingo@kernel.org>, <parri.andrea@gmail.com>,
        <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        <willy@infradead.org>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1901101046480.1497-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019, Paul E. McKenney wrote:

> Hello!
> 
> This series contains updates for the Linux-kernel memory model:
> 
> 1-3.	Add SRCU support, courtesy of Alan Stern.
> 
> 4.	Update README for adding of SRCU support.
> 
> 5.	Update memory-barriers.txt on enforcing heavy ordering for
> 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> 	an ack, preferably by someone from Intel.  Matthew Wilcox
> 	posted some feedback from an Intel manual here, which might
> 	be considered to be a close substitute, but...  ;-)
> 
> 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> 
> 6.	Update Documentation/explanation.txt to include SRCU support,
> 	courtesy of Alan Stern.
> 
> 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> 	Luc Maranget.  This needs an ack.

Does this one still need an ack?  If so, you may apply mine.

Alan

