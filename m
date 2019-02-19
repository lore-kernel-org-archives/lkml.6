Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A79C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0A217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfBSAmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:42:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfBSAmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:42:06 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9612C12DE5818;
        Mon, 18 Feb 2019 16:42:05 -0800 (PST)
Date:   Mon, 18 Feb 2019 16:42:05 -0800 (PST)
Message-Id: <20190218.164205.725479384651945854.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] liquidio: using NULL instead of plain integer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190216095310.22544-1-yuehaibing@huawei.com>
References: <20190216095310.22544-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 16:42:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 16 Feb 2019 17:53:10 +0800

> Fix following warning:
> 
> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1453:35: warning: Using plain integer as NULL pointer
> drivers/net/ethernet/cavium/liquidio/lio_main.c:2910:23: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
