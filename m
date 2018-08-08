Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C1C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16EF21A35
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16EF21A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeHHTCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:02:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39436 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:02:10 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 220D0140B6C61;
        Wed,  8 Aug 2018 09:41:41 -0700 (PDT)
Date:   Wed, 08 Aug 2018 09:41:40 -0700 (PDT)
Message-Id: <20180808.094140.761429037726701844.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     anna.schumaker@netapp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net:mod: remove unneeded variable 'ret' in init_p9
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533640809-1221-4-git-send-email-zhongjiang@huawei.com>
References: <1533640809-1221-1-git-send-email-zhongjiang@huawei.com>
        <1533640809-1221-4-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Aug 2018 09:41:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Tue, 7 Aug 2018 19:20:09 +0800

> The ret is modified after initalization, so just remove it and
> return 0.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to net-next
