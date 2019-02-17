Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F93206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBQXor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:44:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42850 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfBQXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:44:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2BB0712339A63;
        Sun, 17 Feb 2019 15:44:46 -0800 (PST)
Date:   Sun, 17 Feb 2019 15:44:45 -0800 (PST)
Message-Id: <20190217.154445.737483847766718221.davem@davemloft.net>
To:     khoroshilov@ispras.ru
Cc:     sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] net: mv643xx_eth: disable clk on error path in
 mv643xx_eth_shared_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1550265654-6626-1-git-send-email-khoroshilov@ispras.ru>
References: <1550265654-6626-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 17 Feb 2019 15:44:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 16 Feb 2019 00:20:54 +0300

> If mv643xx_eth_shared_of_probe() fails, mv643xx_eth_shared_probe()
> leaves clk undisabled.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied with undisabled changed to enabled.
