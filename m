Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15455C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9442064A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9442064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJQAvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:51:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53396 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeJQAvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:51:49 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3426E12DE580D;
        Tue, 16 Oct 2018 10:00:30 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:00:29 -0700 (PDT)
Message-Id: <20181016.100029.479753992434244882.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     igor.russkikh@aquantia.com, nikita.danilov@aquantia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        yana.esina@aquantia.com, andrew@lunn.ch
Subject: Re: [PATCH net-next] net: aquantia: make function
 aq_fw2x_update_stats static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181016105056.16452-1-yuehaibing@huawei.com>
References: <20181016105056.16452-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Oct 2018 10:00:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 16 Oct 2018 18:50:56 +0800

> Fixes the following sparse warning:
> 
>  drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c:282:5: warning:
>   symbol 'aq_fw2x_update_stats' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
