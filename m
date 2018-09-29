Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1E0C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9448206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9448206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeI3AQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:16:07 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56390 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeI3AQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:16:06 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:b5c5:ae11:3e54:6a07])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 630491478ADBC;
        Sat, 29 Sep 2018 10:46:48 -0700 (PDT)
Date:   Sat, 29 Sep 2018 10:46:44 -0700 (PDT)
Message-Id: <20180929.104644.1898007175155937602.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH V2 net-next 00/10] Cleanups, minor additions & fixes
 for HNS3 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180929145622.5448-1-salil.mehta@huawei.com>
References: <20180929145622.5448-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 29 Sep 2018 10:46:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Sat, 29 Sep 2018 15:56:12 +0100

> This patch-set contains cleans-ups, minor changes and fixes to the HNS3 driver.
> 
> Change Summary:
> v1->v2
>   * Fixed Kbuild error due to missed patch in the current submission.
>     For now, replaced HNAE3_REVISION_ID_21 macro with 0x21
>   * Fixed issues identified by Eric Dumazet and spelling mistakes by David Miller
>     Link: https://lkml.org/lkml/2018/9/28/842
> 
> Note:
> Hi David,
> From v1->v2 changes only exists in below patch
>      "net: hns3: Add serdes parallel inner loopback support"

I already applied v1, so you have to send me a build fix for that broken
patch.

Nevermind, I'll do it myself, I can't have my tree broken like this for
days.

In the future, when I've applied your changes, they cannot be reverted.
You must send me relative fixups to what is in my tree already.

Thank you.
