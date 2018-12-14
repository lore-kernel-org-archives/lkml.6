Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F2EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C71D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeLNWax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:30:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35538 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNWaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:30:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E733914E09826;
        Fri, 14 Dec 2018 14:30:51 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:30:46 -0800 (PST)
Message-Id: <20181214.143046.597375776514311090.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next 0/6] net: hns3: Add more commands to Debugfs
 in HNS3 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181211171330.20592-1-salil.mehta@huawei.com>
References: <20181211171330.20592-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 14:30:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Tue, 11 Dec 2018 17:13:24 +0000

> This patch-set adds few more debugfs commands to HNS3 Ethernet
> Driver. Support has been added to query info related to below
> items:
> 1. Packet buffer descriptor ("echo bd info [queue no] [bd index] > cmd")
> 2. Manager table("echo dump mng tbl > cmd")
> 3. Dfx status register("echo dump reg ssu [prt id] > cmd")
> 4. Dcb status register("echo dump reg dcb [port id] > cmd")
> 5. Queue map ("echo queue map [queue no] > cmd")
> 6. Tm map ("echo tm map [queue no] > cmd")
> 
> NOTE: Above commands are *read-only* and are only intended to
> query the information from the SoC(and dump inside the kernel,
> for now) and in no way tries to perform write operations for
> the purpose of configuration etc.

Series applied.
