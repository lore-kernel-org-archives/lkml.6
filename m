Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CADC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621FD2189A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621FD2189A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbeHMTbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:31:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54340 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:31:17 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A7A51145A9B37;
        Mon, 13 Aug 2018 09:48:17 -0700 (PDT)
Date:   Mon, 13 Aug 2018 09:48:17 -0700 (PDT)
Message-Id: <20180813.094817.1106654245546978677.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     ganeshgr@chelsio.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] cxgb4: remove set but not used variable 'spd'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180813064851.912-1-yuehaibing@huawei.com>
References: <20180813064851.912-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 09:48:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 13 Aug 2018 14:48:51 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c: In function 'print_port_info':
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:5147:14: warning:
>  variable 'spd' set but not used [-Wunused-but-set-variable]
> 
> variable 'spd' is set but not used since
> commit 547fd27241a8 ("cxgb4: Warn if device doesn't have enough PCI bandwidth")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
