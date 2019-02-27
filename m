Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9729C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A112D21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfB0IhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:37:20 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:46028 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfB0IhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:37:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1A43B608A395;
        Wed, 27 Feb 2019 09:37:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id E0kfswpANZ-E; Wed, 27 Feb 2019 09:37:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C5FE6608A397;
        Wed, 27 Feb 2019 09:37:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lOYmBQ4EgMUr; Wed, 27 Feb 2019 09:37:17 +0100 (CET)
Received: from blindfold.localnet (213-225-15-230.nat.highway.a1.net [213.225.15.230])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 1A7E5608A395;
        Wed, 27 Feb 2019 09:37:16 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, kernel-janitors@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [-next] um: Remove duplicated include from vector_user.c
Date:   Wed, 27 Feb 2019 09:37:15 +0100
Message-ID: <5780390.ocBjdziHdJ@blindfold>
In-Reply-To: <3691363f-84b1-b5ab-8637-132fdc4cbd81@huawei.com>
References: <1546485161-142907-1-git-send-email-yuehaibing@huawei.com> <cff7d34e-7afa-70cc-427d-ebeaa1e65e73@cambridgegreys.com> <3691363f-84b1-b5ab-8637-132fdc4cbd81@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. Februar 2019, 06:46:35 CET schrieb YueHaibing:
> 
> Friendly ping:
> 
> Who can take this, please?

The winner takes it all. ;-)
Just kidding, Anton and I take care.

Thanks,
//richard


