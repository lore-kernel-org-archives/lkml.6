Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED766C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9DD21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeLRTrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:47:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeLRTrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:47:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F45558E4F;
        Tue, 18 Dec 2018 19:47:13 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF5CA5D70A;
        Tue, 18 Dec 2018 19:47:09 +0000 (UTC)
Date:   Tue, 18 Dec 2018 14:47:09 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>, stable@vger.kernel.org
Subject: Re: dm: give req_size precisely given by user
Message-ID: <20181218194708.GA24676@redhat.com>
References: <20181218172537.12300-1-jaegeuk@kernel.org>
 <01a60138-63ab-6a9d-c0ba-b8fea551b14e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a60138-63ab-6a9d-c0ba-b8fea551b14e@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 18 Dec 2018 19:47:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18 2018 at 12:45pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 12/18/18 10:25 AM, Jaegeuk Kim wrote:
> > This patch makes dm be aware of io_pages to assign sane req_size for reads.
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> 

I've applied this, see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.21&id=c6d6e9b0f6b4201c77f2cea3964dd122697e3543
