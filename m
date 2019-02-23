Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62E3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE5C20855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfBWVqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:46:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42844 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfBWVqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:46:19 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5214414BF04FC;
        Sat, 23 Feb 2019 13:46:18 -0800 (PST)
Date:   Sat, 23 Feb 2019 13:46:17 -0800 (PST)
Message-Id: <20190223.134617.1218977774380552502.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     ktkhai@virtuozzo.com, gregkh@linuxfoundation.org,
        tom@quantonium.net, asmadeus@codewreck.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] kcm: Remove unnecessary SLAB_PANIC for
 kmem_cache_create() in kcm_init
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190222061530.9820-1-yuehaibing@huawei.com>
References: <20190222061530.9820-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Feb 2019 13:46:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Fri, 22 Feb 2019 14:15:30 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> There has check NULL on kmem_cache_create on failure in kcm_init,
> no need use SLAB_PANIC to panic the system.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I'll apply this, thank you.
