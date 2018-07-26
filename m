Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8714C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5E220685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5E220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeGZFct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:32:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeGZFct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:32:49 -0400
Received: from localhost (unknown [172.58.43.249])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6EA14128F4EA7;
        Wed, 25 Jul 2018 21:17:57 -0700 (PDT)
Date:   Wed, 25 Jul 2018 21:17:45 -0700 (PDT)
Message-Id: <20180725.211745.300687134570660573.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] amd-xgbe: use dma_mapping_error to check map
 errors
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180726015127.8740-1-yuehaibing@huawei.com>
References: <20180726015127.8740-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 21:17:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 26 Jul 2018 09:51:27 +0800

> The dma_mapping_error() returns true or false, but we want
> to return -ENOMEM if there was an error.
> 
> Fixes: 174fd2597b0b ("amd-xgbe: Implement split header receive support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
