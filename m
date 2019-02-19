Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1EDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA864217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbfBSBph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:45:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732665AbfBSBpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:45:34 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 22176108DE85D;
        Mon, 18 Feb 2019 17:45:34 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:45:33 -0800 (PST)
Message-Id: <20190218.174533.1821639443595554040.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH net] net: hns: Fixes the missing put_device in positive
 leg for roce reset
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190218174032.22972-1-salil.mehta@huawei.com>
References: <20190218174032.22972-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 17:45:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Mon, 18 Feb 2019 17:40:32 +0000

> This patch fixes the missing device reference release-after-use in
> the positive leg of the roce reset API of the HNS DSAF.
> 
> Fixes: c969c6e7ab8c ("net: hns: Fix object reference leaks in hns_dsaf_roce_reset()")
> Reported-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Applied, thanks Salil.
