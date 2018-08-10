Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD7C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E7921C16
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E7921C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeHKANw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:13:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57864 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeHKANw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:13:52 -0400
Received: from localhost (c-73-240-71-155.hsd1.or.comcast.net [73.240.71.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 92A2514310525;
        Fri, 10 Aug 2018 14:42:13 -0700 (PDT)
Date:   Fri, 10 Aug 2018 14:42:12 -0700 (PDT)
Message-Id: <20180810.144212.1211120405355462030.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jiri@mellanox.com, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: core: remove unnecessary function
 mlxsw_core_driver_put
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810023730.13140-1-yuehaibing@huawei.com>
References: <20180810023730.13140-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Aug 2018 14:42:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 10 Aug 2018 10:37:30 +0800

> The function mlxsw_core_driver_put only traverse mlxsw_core_driver_list
> to find the matched mlxsw_driver,but never used it.
> So it can be removed safely.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
