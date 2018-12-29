Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F76C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D8C20869
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeL2QlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 11:41:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45982 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeL2QlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 11:41:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1663C14816515;
        Sat, 29 Dec 2018 08:41:23 -0800 (PST)
Date:   Sat, 29 Dec 2018 08:41:20 -0800 (PST)
Message-Id: <20181229.084120.1873066963650416921.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: =?utf-8?B?562U5aSNOg==?= [PATCH 1/1] net-next/hinic:add
 shutdown callback
From:   David Miller <davem@davemloft.net>
In-Reply-To: <DACA750462785649825D7529120E85A808A8320D@dggemm521-mbs.china.huawei.com>
References: <20181228002040.1256-1-xuechaojing@huawei.com>
        <20181228.214905.2208487974538707696.davem@davemloft.net>
        <DACA750462785649825D7529120E85A808A8320D@dggemm521-mbs.china.huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Dec 2018 08:41:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xuechaojing <xuechaojing@huawei.com>
Date: Sat, 29 Dec 2018 09:20:54 +0000

> Sorry, I didn't explain this patch clearly.
> if there is no shutdown callback, our board will report pcie UNF errors after restarting.
> Attached is our log.

I want you to remove the "dev_info()" call from your patch because it is
inappropriate.
