Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD73C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4542075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4542075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeIETiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:38:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46492 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeIETiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:38:04 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D322513D34BE1;
        Wed,  5 Sep 2018 08:07:27 -0700 (PDT)
Date:   Wed, 05 Sep 2018 08:07:27 -0700 (PDT)
Message-Id: <20180905.080727.1056631946163689091.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: lan743x_ptp: make function
 lan743x_ptp_set_sync_ts_insert() static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180905122437.19756-1-yuehaibing@huawei.com>
References: <20180905122437.19756-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Sep 2018 08:07:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 5 Sep 2018 20:24:37 +0800

> Fixes the following sparse warning:
> 
> drivers/net/ethernet/microchip/lan743x_ptp.c:980:6: warning:
>  symbol 'lan743x_ptp_set_sync_ts_insert' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
