Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473DAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A692217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbeLPUHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:07:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47270 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbeLPUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:07:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 90D5B14EEF714;
        Sun, 16 Dec 2018 12:07:51 -0800 (PST)
Date:   Sun, 16 Dec 2018 12:07:48 -0800 (PST)
Message-Id: <20181216.120748.854645363557020308.davem@davemloft.net>
To:     lipeng321@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com
Subject: Re: [Patch net 00/10] net: hns: Code improvements & fixes for HNS
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
References: <1544846009-50276-1-git-send-email-lipeng321@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Dec 2018 12:07:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>
Date: Sat, 15 Dec 2018 11:53:19 +0800

> This patchset introduces some code improvements and fixes
> for the identified problems in the HNS driver.
> 
> Every patch is independent.

Series applied, thank you.
