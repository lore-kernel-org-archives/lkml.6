Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29F1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B7A20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B7A20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeKXMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:15:45 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39028 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeKXMPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:15:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 243FA14D75877;
        Fri, 23 Nov 2018 17:29:14 -0800 (PST)
Date:   Fri, 23 Nov 2018 17:29:13 -0800 (PST)
Message-Id: <20181123.172913.1106768772048097984.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V2 net-next 0/8] net: hns3: Adds support of debugfs to
 HNS3 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181122140948.23504-1-salil.mehta@huawei.com>
References: <20181122140948.23504-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 17:29:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Thu, 22 Nov 2018 14:09:40 +0000

> This patchset adds support of debugfs to the HNS3 driver. 
> 
> Support has been added to query info related to below items:
> 1. Queue related ("echo queue info [queue no] > cmd")
> 2. Flow Director ("echo dump fd tcam > cmd")
> 3. TC config ("echo dump tc > cmd")
> 4. Transmit Module/Scheduler ("echo dump tm > cmd")
> 5. QoS pause ("echo dump qos pause cfg > cmd")
> 6. QoS buffer ("echo dump qos pri map > cmd")
> 7. QoS prio map ("echo dump qos buf cfg > cmd")
> 
> NOTE: Above commands are *read-only* and are only intended to
> query the information from the SoC(and dump inside the kernel,
> for now) and in no way tries to perform write operations for
> the purpose of configuration etc.
> 
> Change Log
> ----------
> V1-->V2:
>    * Addressed the comments provided by Jakub Kicinski. 
>      1. Removed the .rej files mistakenly made part of Flow Director patch.
>         Link: https://lkml.org/lkml/2018/11/20/249
>      2. Added command summary in the cover letter
>         Link: https://lkml.org/lkml/2018/11/22/1 

Series applied.
