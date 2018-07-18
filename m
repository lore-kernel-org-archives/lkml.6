Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E617CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91BA2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91BA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbeGRV3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:29:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43322 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeGRV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:29:10 -0400
Received: from localhost (179-64-212-66.spl.org [66.212.64.179])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 849231479FDAB;
        Wed, 18 Jul 2018 13:49:32 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:49:32 +0900 (KST)
Message-Id: <20180719.054932.1455425820671963886.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     jon.maloy@ericsson.com, ying.xue@windriver.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next] tipc: remove unused tipc_group_size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180717141123.9684-1-yuehaibing@huawei.com>
References: <20180717141123.9684-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Jul 2018 13:49:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 17 Jul 2018 22:11:23 +0800

> After commit eb929a91b213 ("tipc: improve poll() for group member socket"),
> it is no longer used.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
