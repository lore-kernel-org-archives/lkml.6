Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A4AC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FD12183C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FD12183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeHMKRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:17:40 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:17682 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbeHMKRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:17:40 -0400
Received: from localhost (victim.blr.asicdesigners.com [10.193.185.129])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id w7D7aP8S007518;
        Mon, 13 Aug 2018 00:36:25 -0700
Date:   Mon, 13 Aug 2018 13:06:29 +0530
From:   Ganesh Goudar <ganeshgr@chelsio.com>
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dt@chelsio.com
Subject: Re: [PATCH net-next] cxgb4: remove set but not used variable 'spd'
Message-ID: <20180813073628.GA15679@chelsio.com>
References: <20180813065902.5504-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813065902.5504-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 08/13/18, 2018 at 14:59:02 +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c: In function 'print_port_info':
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:5147:14: warning:
>  variable 'spd' set but not used [-Wunused-but-set-variable]
> 
> variable 'spd' is set but not used since
> commit 547fd27241a8 ("cxgb4: Warn if device doesn't have enough PCI bandwidth")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
Thanks, YueHaibing.

Acked-by: Ganesh Goudar <ganeshgr@chelsio.com>
