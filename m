Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB1220665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeK2GNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:13:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36628 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeK2GNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:13:07 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ACB6114E0F727;
        Wed, 28 Nov 2018 11:10:26 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:10:26 -0800 (PST)
Message-Id: <20181128.111026.490482201236586536.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     subashab@codeaurora.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: qualcomm: rmnet: remove set but not used
 variables 'ip_family, fc_seq, qos_id'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181128123142.25348-1-yuehaibing@huawei.com>
References: <20181128123142.25348-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 28 Nov 2018 11:10:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 28 Nov 2018 20:31:42 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:26:6:
>  warning: variable 'ip_family' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:27:6:
>  warning: variable 'fc_seq' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:28:6:
>  warning: variable 'qos_id' set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction in commit
> ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
