Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFD1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D97120868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 01:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D97120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeKXMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 07:12:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38988 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeKXMMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 07:12:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 79E0814D7588C;
        Fri, 23 Nov 2018 17:26:24 -0800 (PST)
Date:   Fri, 23 Nov 2018 17:26:24 -0800 (PST)
Message-Id: <20181123.172624.1825950133419105065.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     rad@semihalf.com, aleksey.makarov@cavium.com, pombredanne@nexb.com,
        jglauber@cavium.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: cavium: clean up return value check in
 cavium_ptp_probe
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181122132719.8100-1-yuehaibing@huawei.com>
References: <20181122132719.8100-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 23 Nov 2018 17:26:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 22 Nov 2018 21:27:19 +0800

> ptp_clock_register never return NULL, so no need check this
> in cavium_ptp_probe.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
