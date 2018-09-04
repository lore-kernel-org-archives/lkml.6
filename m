Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E42C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076F520658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076F520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeIDXgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:36:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49453 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727782AbeIDXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:36:18 -0400
Received: (qmail 19288 invoked by uid 500); 4 Sep 2018 15:09:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2018 15:09:49 -0400
Date:   Tue, 4 Sep 2018 15:09:49 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <mingo@kernel.org>, <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <akiyks@gmail.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180904081144.GA4137@andrea>
Message-ID: <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Andrea Parri wrote:
> Heh, your confusion might be the reflection of mine... ;-)  That was
> indeed a long and not conclusive discussion (meaning there're pending
> issues); and I cannot claim to find "arguments" such as:
> 
>   "More than one kernel developer has expressed the opinion that
>    the LKMM should enforce ordering of writes by locking."
> 
> particularly helpful (I do tend to be convinced by arguments rather
> than by opinions).  In fact, you can take the following as my only
> current "constructive argument" against the patch [1,2]:
> 
>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES

Do you have any concrete suggestions (i.e., some actual text) for 
improvements to the patch description?  Earlier in your message you 
mentioned that Will's comment:

	LKMM offers stronger guarantees that can portably be relied upon
	in the codebase.

would make a good addition.  Suitably edited, it could be added to the
description.  I can think of a few other things myself, but I'd like to 
hear your thoughts.  Anything else?

Alan

