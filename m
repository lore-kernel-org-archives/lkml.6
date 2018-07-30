Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D809BFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9715320857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9715320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeG3SVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:21:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32976 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbeG3SVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:21:00 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ECA0013F7507C;
        Mon, 30 Jul 2018 09:45:09 -0700 (PDT)
Date:   Mon, 30 Jul 2018 09:45:09 -0700 (PDT)
Message-Id: <20180730.094509.1485668550327552421.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     roopa@cumulusnetworks.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, idosch@mellanox.com, dsahern@gmail.com,
        ktkhai@virtuozzo.com, sharpd@cumulusnetworks.com
Subject: Re: [PATCH net-next] fib_rules: NULL check before kfree is not
 needed
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180730130724.20248-1-yuehaibing@huawei.com>
References: <20180730130724.20248-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Jul 2018 09:45:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 30 Jul 2018 21:07:24 +0800

> kfree(NULL) is safe,so this removes NULL check before freeing the mem
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
