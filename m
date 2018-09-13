Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D64C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675A82133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675A82133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeIMIme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:42:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42366 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeIMIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:42:34 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8422512DE57F7;
        Wed, 12 Sep 2018 20:35:00 -0700 (PDT)
Date:   Wed, 12 Sep 2018 20:35:00 -0700 (PDT)
Message-Id: <20180912.203500.2285910283555829379.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     claudiu.manoil@nxp.com, tariqt@mellanox.com, saeedm@mellanox.com,
        derek.chickles@caviumnetworks.com, leon@kernel.org,
        jdmason@kudzu.us, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: Use DIV_ROUND_UP instead of
 reimplementing its function
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1536671295-14432-1-git-send-email-zhongjiang@huawei.com>
References: <1536671295-14432-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Sep 2018 20:35:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Tue, 11 Sep 2018 21:08:15 +0800

> DIV_ROUND_UP has implemented the code-opened function. Therefore, just
> replace the implementation with DIV_ROUND_UP.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to net-next, thanks.
