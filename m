Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E7BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9CB20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfAQTX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:23:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAQTX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:23:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DADEB14B94513;
        Thu, 17 Jan 2019 11:23:26 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:23:23 -0800 (PST)
Message-Id: <20190117.112323.992634750178900510.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH 1/1] net-next/hinic: replace
 disable_irq_nosync/enable_irq
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190115174852.22839-1-xuechaojing@huawei.com>
References: <20190115174852.22839-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Jan 2019 11:23:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Tue, 15 Jan 2019 17:48:52 +0000

> In order to avoid frequent system interrupts when sending and
> receiving packets. we replace disable_irq_nosync/enable_irq
> with hinic_set_msix_state(), hinic_set_msix_state is used to
> access memory mapped hinic devices.
> 
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

Applied.
