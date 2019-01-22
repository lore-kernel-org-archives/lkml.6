Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784A1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD8F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfAVWzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:55:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37384 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVWzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:55:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CF2A614D46A58;
        Tue, 22 Jan 2019 14:55:04 -0800 (PST)
Date:   Tue, 22 Jan 2019 14:55:04 -0800 (PST)
Message-Id: <20190122.145504.2289973633727411323.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH net-next] hinic: Add pci device ids
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190120221546.24445-1-xuechaojing@huawei.com>
References: <20190120221546.24445-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 22 Jan 2019 14:55:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Sun, 20 Jan 2019 22:15:46 +0000

> This patch adds PCI device IDs to support following cards:
> 
> 1. Add device id 0x0205 for HINIC 100GE dual port mezz card.
> 2. Add device id 0x0210 for HINIC 25GE quad port mezz card.
> 3. Delete device id 0x0201 for HINIC 100GE dual port card, because
> this is used by other product.
> 4. Macro of device id 0x200 is modified for HINIC 100GE dual port card.
> 
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

Applied, thank you.
