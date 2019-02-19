Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C086C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3EA2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfBSVXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:23:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40772 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfBSVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:23:49 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3CCD1087A83D;
        Tue, 19 Feb 2019 13:23:48 -0800 (PST)
Date:   Tue, 19 Feb 2019 13:23:48 -0800 (PST)
Message-Id: <20190219.132348.333357401086026145.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hams@vger.kernel.org
Subject: Re: [PATCH net-next] net: rose: add missing dev_put() on error in
 rose_bind
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190219080622.17312-1-yuehaibing@huawei.com>
References: <20190219080622.17312-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Feb 2019 13:23:49 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 19 Feb 2019 16:06:22 +0800

> when capable check failed, dev_put should
> be call before return -EACCES.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
