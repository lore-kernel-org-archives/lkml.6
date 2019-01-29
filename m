Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEDBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59A320881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfA2Xnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:43:42 -0500
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:53661 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbfA2Xnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:43:41 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 30 Jan 2019 10:13:39 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1god2Y-0000KO-Qg; Wed, 30 Jan 2019 10:43:38 +1100
Date:   Wed, 30 Jan 2019 10:43:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20190129234338.GF4205@dastard>
References: <20190130075647.53e86078@canb.auug.org.au>
 <20190129220802.GC4205@dastard>
 <20190130100640.5c2512a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130100640.5c2512a4@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:06:40AM +1100, Stephen Rothwell wrote:
> Hi Dave,
> 
> On Wed, 30 Jan 2019 09:08:02 +1100 Dave Chinner <david@fromorbit.com> wrote:
> >
> > Might be worth adding this to the boiler plate code:
> > 
> > 	This can be fixed by adding the following to your ~/.gitconfig file:
> > 
> > 	[core]
> > 		abbrev = 12
> 
> Actually, since git v2.11 (released Nov 29, 2016), abbrev = auto (which
> is the default) means that the default scales with the size of the
> repository.  For Linus' tree, that currently produces 12 digit commit
> SHA1 abbreviations, but will probably soon become 13.  So the best
> currently, is to *not* set core.abbrev (or set it to something above 12
> (for future robustness).
> 
> See
> https://lore.kernel.org/lkml/20181220000112.24891-1-avarab@gmail.com/

.... and in replying to correct me demonstrates the exact point I
was making - that documenting what configuration should be used to
avoid the warning acheives far more than just reporting an error.

i.e. all those people who /don't follow git development/ and have
working configs that pre-date the "auto mode" or it being made
the default now know the correct way to configure their repository.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
