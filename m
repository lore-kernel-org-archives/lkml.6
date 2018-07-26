Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E8C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E5520883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E5520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbeGZWYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:24:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbeGZWYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:24:25 -0400
Received: from localhost (unknown [172.58.43.154])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 48329108CAEAC;
        Thu, 26 Jul 2018 14:05:49 -0700 (PDT)
Date:   Thu, 26 Jul 2018 14:05:48 -0700 (PDT)
Message-Id: <20180726.140548.1793684947549084221.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next] tipc: add missing dev_put() on error in
 tipc_enable_l2_media
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180725100049.20244-1-yuehaibing@huawei.com>
References: <20180725100049.20244-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 14:05:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 25 Jul 2018 18:00:49 +0800

> when tipc_own_id failed to obtain node identity,dev_put should
> be call before return -EINVAL.
> 
> Fixes: 682cd3cf946b ("tipc: confgiure and apply UDP bearer MTU on running links")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to net-next, thank you.
