Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941D2C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D252089E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D252089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbeGZR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:59:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42184 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbeGZR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:59:46 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7381E108D56E0;
        Thu, 26 Jul 2018 09:42:08 -0700 (PDT)
Date:   Thu, 26 Jul 2018 09:42:07 -0700 (PDT)
Message-Id: <20180726.094207.708027987402620701.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linyunsheng@huawei.com, matthias.bgg@gmail.com,
        lipeng321@huawei.com
Subject: Re: [PATCH net-next] net: hns: Make many functions static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180726131958.15532-1-yuehaibing@huawei.com>
References: <20180726131958.15532-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 09:42:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 26 Jul 2018 21:19:58 +0800

> Fixes the following sparse warning:
 ...
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
