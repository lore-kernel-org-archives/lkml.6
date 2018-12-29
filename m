Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73550C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478C020866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 20:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeL2UAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 15:00:14 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33048 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeL2UAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 15:00:14 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBTK04Oi016721;
        Sat, 29 Dec 2018 21:00:04 +0100
Date:   Sat, 29 Dec 2018 21:00:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools headers: move the nolibc header from rcutorture to
 tools/include/nolibc/
Message-ID: <20181229200004.GA16717@1wt.eu>
References: <20181229180453.15889-1-w@1wt.eu>
 <20181229182508.GJ4170@linux.ibm.com>
 <20181229183047.GB12726@1wt.eu>
 <20181229195518.GK4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229195518.GK4170@linux.ibm.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 11:55:18AM -0800, Paul E. McKenney wrote:
> On Sat, Dec 29, 2018 at 07:30:47PM +0100, Willy Tarreau wrote:
> > On Sat, Dec 29, 2018 at 10:25:08AM -0800, Paul E. McKenney wrote:
> > > On Sat, Dec 29, 2018 at 07:04:53PM +0100, Willy Tarreau wrote:
> > > > As suggested by Ingo, this header file might benefit other tools than
> > > > just rcutorture. For now it's quite limited, but is easy to extend, so
> > > > exposing it into tools/include/nolibc/ will make it much easier to
> > > > adopt by other tools.
> > > > 
> > > > The mkinitrd.sh script in rcutorture was updated to use this new location.
> > > > 
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > > 
> > > Thank you, Willy!
> > 
> > You're welcome!
> > 
> > > I have queued all four of these.
> > 
> > Thanks!
> > 
> > > Should there
> > > be a MAINTAINERS file entry for the new include/nolibc home for this
> > > library code?
> > 
> > Good idea, I didn't think about it. Yes, I can add one and will
> > send another patch. In case that helps I've created a repo at
> > /pub/scm/linux/kernel/git/wtarreau/nolibc.git
> 
> And I have queued that one as well, thank you!
> 
> I am happy to curate nolibc patches indefinitely, but should some other
> pathway to mainline become better for you, just let me know.

Oh perfect, thank you. I'm always having difficulties with processes,
so having a known working path to mainline is indeed a much appreciated
help!

Thanks,
Willy
