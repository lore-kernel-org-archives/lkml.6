Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11726C3E8A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4622087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 00:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfA3AiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 19:38:24 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:46577 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727640AbfA3AiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 19:38:22 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 30 Jan 2019 11:08:19 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1godtS-0000OR-DT; Wed, 30 Jan 2019 11:38:18 +1100
Date:   Wed, 30 Jan 2019 11:38:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20190130003818.GG4205@dastard>
References: <20190130075647.53e86078@canb.auug.org.au>
 <20190129220802.GC4205@dastard>
 <20190130100640.5c2512a4@canb.auug.org.au>
 <20190129234338.GF4205@dastard>
 <20190130110256.41722408@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130110256.41722408@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:02:56AM +1100, Stephen Rothwell wrote:
> Hi Dave,
> 
> On Wed, 30 Jan 2019 10:43:38 +1100 Dave Chinner <david@fromorbit.com> wrote:
> >
> > .... and in replying to correct me demonstrates the exact point I
> > was making - that documenting what configuration should be used to
> > avoid the warning acheives far more than just reporting an error.
> > 
> > i.e. all those people who /don't follow git development/ and have
> > working configs that pre-date the "auto mode" or it being made
> > the default now know the correct way to configure their repository.
> 
> Point taken.  It now says:
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Wonderful!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
