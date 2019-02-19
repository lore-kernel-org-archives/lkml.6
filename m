Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A084C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE1D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfBSBup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:50:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57298 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbfBSBup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:50:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4E7EC108DDD17;
        Mon, 18 Feb 2019 17:50:44 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:50:43 -0800 (PST)
Message-Id: <20190218.175043.680335546060661473.davem@davemloft.net>
To:     m-karicheri2@ti.com
Cc:     w-kwok2@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netcp: Fix ethss driver probe issue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190218201051.19623-1-m-karicheri2@ti.com>
References: <20190218201051.19623-1-m-karicheri2@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 17:50:44 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Mon, 18 Feb 2019 15:10:51 -0500

> Recent commit below has introduced a bug in netcp driver that causes
> the ethss driver probe failure and thus break the networking function
> on K2 SoCs such as K2HK, K2L, K2E etc. This patch fixes the issue to
> restore networking on the above SoCs.
> 
> Fixes: 21c328dcecfc ("net: ethernet: Convert to using %pOFn instead of device_node.name")
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Applied and queued up for -stable, thanks.
