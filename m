Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34824C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E920425DFF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E920425DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeGBNu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:50:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50902 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeGBNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:50:55 -0400
Received: from localhost (unknown [59.29.86.96])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FF291264BF3C;
        Mon,  2 Jul 2018 06:50:53 -0700 (PDT)
Date:   Mon, 02 Jul 2018 22:50:52 +0900 (KST)
Message-Id: <20180702.225052.2142045320196394936.davem@davemloft.net>
To:     lipeng321@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com
Subject: Re: [PATCH V2 net-next 0/9] net: hns3: a few code improvements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530517826-69226-1-git-send-email-lipeng321@huawei.com>
References: <1530517826-69226-1-git-send-email-lipeng321@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Jul 2018 06:50:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>
Date: Mon, 2 Jul 2018 15:50:17 +0800

> This patchset removes some redundant code and fixes a few code
> stylistic issues from internal concentrated review,
> no functional changes introduced.
> 
> ---
> Change log:
> V1 -> V2:
> 1, remove a patch according to the comment reported by David Miller.

Series applied, thank you.
