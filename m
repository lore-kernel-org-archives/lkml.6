Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77FC2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548771139;
	bh=8ulksRhjsVkMkrrdYCunxbwodo9oHxsqIazhDJdb/e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OGidVkGW+NCr+4/6dAHkSBCyk1XmRZEUSCplqNertUfNQx/BqJmWYzNXxMERpL7kH
	 luf/KJjbec00vDRg3eK6EMarbEYAZ6xTjJAxnQ+qoQofxnxoDxc9WfQDcACZ8u+0KP
	 e8XxbKuy7vyjgx/syGO0EHnSW4EEk2M8xPmtmnCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfA2OMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfA2OMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:12:17 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32AFD20823;
        Tue, 29 Jan 2019 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548771137;
        bh=8ulksRhjsVkMkrrdYCunxbwodo9oHxsqIazhDJdb/e8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aCxJtXXYMp7+a250ixn/s8KqSzd5CMQFUapfhl0UChY3rQAe9baZmhyerHownTRwy
         xDLhK4AUzfI31gErd5j3q8l4R6pp0Hu9JBe2coU0S604RjunSXxyVnTN0uQ5X0go6q
         wtoS2EiKNf+KEccS/a8kkbWlUL0bzD7Lr9HyJPLs=
Date:   Tue, 29 Jan 2019 15:12:09 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: linux-next: manual merge of the mtd tree with Linus' tree
Message-ID: <20190129151209.16bf37f4@bbrezillon>
In-Reply-To: <20190129111700.7d50e369@canb.auug.org.au>
References: <20190129111700.7d50e369@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 11:17:00 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the mtd tree got a conflict in:
> 
>   drivers/mtd/mtdpart.c
> 
> between commit:
> 
>   2b6f0090a333 ("mtd: Check add_mtd_device() ret code")
> 
> from Linus' tree and commit:
> 
>   2c24c9af0f38 ("mtd: rework partitions handling")

I dropped this patch for now. I'll merge -rc2 before applying them next
time.

Thanks for the report.

Boris
