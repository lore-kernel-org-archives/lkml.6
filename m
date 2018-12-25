Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8A2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A194421720
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLYVIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 16:08:13 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49396 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeLYVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 16:08:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 815DE6091845;
        Tue, 25 Dec 2018 22:08:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8PVxG5s67H9D; Tue, 25 Dec 2018 22:08:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 326DA6091848;
        Tue, 25 Dec 2018 22:08:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gWAUxWnFcSCp; Tue, 25 Dec 2018 22:08:10 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B4EDB6091845;
        Tue, 25 Dec 2018 22:08:09 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     zhangjun <openzhangj@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hsiangkao@mail.ru,
        kirill.shutemov@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] ubifs: Get/put page when changing PG_private
Date:   Tue, 25 Dec 2018 22:08:09 +0100
Message-ID: <39657760.jfV4gqXEqu@blindfold>
In-Reply-To: <b9def265-5e93-a451-0f7b-91c0edac0b00@gmail.com>
References: <20181215150130.19381-1-richard@nod.at> <386368225.TvJUPtmGVW@blindfold> <b9def265-5e93-a451-0f7b-91c0edac0b00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 25. Dezember 2018, 03:42:37 CET schrieb zhangjun:
> Hello,richard
> 
> 
> Before fully understanding this regression, in order to fix the bug of 
> cma_alloc(),
> submit a conservative patch that modifies count in iomap_migrate_page().
> Can you consider merging first?

No. There is no need to rush.
As it looks like the iomap regression is trivial, Christoph pointed out
that a case was forgotten.
But Dave is currently (like almost all of us) on vacation to confirm.

Thanks,
//richard




