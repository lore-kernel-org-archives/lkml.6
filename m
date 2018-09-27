Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D931C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF20A21708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF20A21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeI1Chy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:37:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1Chx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:37:53 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0435A101A;
        Thu, 27 Sep 2018 20:17:50 +0000 (UTC)
Date:   Thu, 27 Sep 2018 22:17:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180927201748.GA17445@kroah.com>
References: <20180927182432.GA11505@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927182432.GA11505@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:24:32PM -0600, Jason Gunthorpe wrote:
> Hi Greg,
> 
> Second rc pull request
> 
> This has a few fixes for smaller regressions introduced this cycle and
> the usual various driver oops fixes.
> 
> There is one long standing race bug in the comp_channel that Steve was
> able to reproduce, track down and fix.
> 
> I believe the HFI1 driver regression breakage has been fixed in
> Bjorn's tree and I'm currently expecting the lingering ipoib issue to
> be fixed in the netdev tree, but patches are still delayed due to
> various holidays this month.
> 
> Thanks,
> Jason
> 
> The following changes since commit 8f28b178f71cc56eccf2a6e2c0ace17c82f900d7:
> 
>   RDMA/mlx4: Ensure that maximal send/receive SGE less than supported by HW (2018-09-06 13:16:12 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

Now pulled, thanks.

greg k-h
