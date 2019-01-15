Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0E2205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390297AbfAOVMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:12:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732985AbfAOVMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:12:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09D21A4056;
        Tue, 15 Jan 2019 21:12:18 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 051D82B9CC;
        Tue, 15 Jan 2019 21:12:02 +0000 (UTC)
Date:   Tue, 15 Jan 2019 16:12:02 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Joe Thornber <ejt@redhat.com>
Subject: Re: linux-next: Fixes tag needs work in the device-mapper tree
Message-ID: <20190115211201.GA10746@redhat.com>
References: <20190116080251.17ba9771@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116080251.17ba9771@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 15 Jan 2019 21:12:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15 2019 at  4:02pm -0500,
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> [I am experimenting with checking the Fixes tags in commits in linux-next.
> Please let me know if you think I am being too strict.]
> 
> Hi all,
> 
> Commit
> 
>   fc4d02aa0331 ("dm thin: fix passdown_double_checking_shared_status()")
> 
> has a malformed Fixes tag:
> 
>   Fixes: 00a0ea33b49 ("dm thin: do not queue freed thin mapping for next stage processing")
> 
> It should show at least 12 digits of the SHA1.

Fixed, thanks.
Mike
