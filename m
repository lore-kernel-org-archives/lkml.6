Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C674C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B2420883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfARWDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:03:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47898 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfARWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:03:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A2E0B1000537A;
        Fri, 18 Jan 2019 14:03:15 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:03:15 -0800 (PST)
Message-Id: <20190118.140315.2111683750667863105.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     jdmason@kudzu.us, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: vxge: fix indentation issue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190116235910.29277-1-colin.king@canonical.com>
References: <20190116235910.29277-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Jan 2019 14:03:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 16 Jan 2019 23:59:10 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a goto statement that indented too deeply, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
