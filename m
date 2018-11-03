Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AAD20685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AAD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeKDHzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 02:55:08 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 02:55:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 78860144A2F83;
        Sat,  3 Nov 2018 15:42:28 -0700 (PDT)
Date:   Sat, 03 Nov 2018 15:42:27 -0700 (PDT)
Message-Id: <20181103.154227.2202855234462473260.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     huangdaode@hisilicon.com, xuwei5@hisilicon.com,
        liguozhu@hisilicon.com, Yisen.Zhuang@huawei.com,
        john.garry@huawei.com, linuxarm@huawei.com, salil.mehta@huawei.com,
        lipeng321@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: Fix for out-of-bounds access when
 setting pfc back pressure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541074363-98630-1-git-send-email-linyunsheng@huawei.com>
References: <1541074363-98630-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 03 Nov 2018 15:42:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 1 Nov 2018 20:12:43 +0800

> The vport should be initialized to hdev->vport for each bp group,
> otherwise it will cause out-of-bounds access and bp setting not
> correct problem.
 ...
> Fixes: 67bf2541f4b9 ("net: hns3: Fixes the back pressure setting when sriov is enabled")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Applied, thanks.
