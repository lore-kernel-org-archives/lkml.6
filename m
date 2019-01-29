Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC0AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2433B2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfA2WIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:08:06 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:11825 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbfA2WIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:08:06 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 30 Jan 2019 08:38:04 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gobY2-0000Dh-Gm; Wed, 30 Jan 2019 09:08:02 +1100
Date:   Wed, 30 Jan 2019 09:08:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20190129220802.GC4205@dastard>
References: <20190130075647.53e86078@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130075647.53e86078@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 07:56:47AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   4ea899ead278 ("iomap: fix a use after free in iomap_dio_rw")
> 
> Fixes tag
> 
>   Fixes: ff6a9292e6 ("iomap: implement direct I/O")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long

Might be worth adding this to the boiler plate code:

	This can be fixed by adding the following to your ~/.gitconfig file:

	[core]
		abbrev = 12

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
