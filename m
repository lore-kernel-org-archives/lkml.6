Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3CBC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70B521A05
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70B521A05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeHKXAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:00:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46848 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeHKXAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:00:49 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 72165144499C4;
        Sat, 11 Aug 2018 12:06:46 -0700 (PDT)
Date:   Sat, 11 Aug 2018 12:06:45 -0700 (PDT)
Message-Id: <20180811.120645.2187038036923096085.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jdmason@kudzu.us, keescook@chromium.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gustavo@embeddedor.com, bhelgaas@google.com
Subject: Re: [PATCH net-next] vxge: remove set but not used variable
 'req_out','status' and 'ret'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810060837.14756-1-yuehaibing@huawei.com>
References: <20180810060837.14756-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 11 Aug 2018 12:06:46 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 10 Aug 2018 14:08:37 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/neterion/vxge/vxge-config.c:1097:6: warning:
>  variable 'ret' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/neterion/vxge/vxge-config.c:2263:6: warning:
>  variable 'req_out' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/neterion/vxge/vxge-config.c:2262:22: warning:
>  variable 'status' set but not used [-Wunused-but-set-variable]
> drivers/net/ethernet/neterion/vxge/vxge-config.c:2360:22: warning:
>  variable 'status' set but not used [-Wunused-but-set-variable]
>   enum vxge_hw_status status = VXGE_HW_OK;
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
