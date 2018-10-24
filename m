Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F6ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B7820831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B7820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJYFz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:55:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41612 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeJYFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:55:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98CA91444BA42;
        Wed, 24 Oct 2018 14:26:15 -0700 (PDT)
Date:   Wed, 24 Oct 2018 14:26:14 -0700 (PDT)
Message-Id: <20181024.142614.177934927090724876.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, dan.carpenter@oracle.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, shiju.jose@huawei.com
Subject: Re: [PATCH net-next] net: hns3: Fix for warning uninitialized
 symbol hw_err_lst3
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181024143218.4204-1-salil.mehta@huawei.com>
References: <20181024143218.4204-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Oct 2018 14:26:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Wed, 24 Oct 2018 15:32:18 +0100

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> This patch fixes the smatch warning,
> 
> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c:700
> hclge_log_and_clear_ppp_error() error: uninitialized symbol
> 'hw_err_lst3'
> 
> Link: https://lkml.org/lkml/2018/10/23/430
> 
> Fixes: da2d072a9ea7 ("net: hns3: Add enable and process hw errors from PPP")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Applied.
