Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C88C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF772087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF772087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeJSHs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:48:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42898 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:48:28 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C610F140C2BC6;
        Thu, 18 Oct 2018 16:45:07 -0700 (PDT)
Date:   Thu, 18 Oct 2018 16:45:07 -0700 (PDT)
Message-Id: <20181018.164507.2304972344742824472.davem@davemloft.net>
To:     xuechaojing@huawei.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wulike1@huawei.com, chiqijun@huawei.com, fy.wang@huawei.com,
        zhaochen6@huawei.com, tony.qu@huawei.com, luoshaokai@huawei.com
Subject: Re: [PATCH v2] net-next/hinic: add checksum offload and TSO support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181018150251.28802-1-xuechaojing@huawei.com>
References: <20181018150251.28802-1-xuechaojing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 16:45:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xue Chaojing <xuechaojing@huawei.com>
Date: Thu, 18 Oct 2018 15:02:51 +0000

> From: Zhao Chen <zhaochen6@huawei.com>
> 
> This patch adds checksum offload and TSO support for the HiNIC
> driver. Perfomance test (Iperf) shows more than 100% improvement
> in TCP streams.
> 
> Signed-off-by: Zhao Chen <zhaochen6@huawei.com>
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
> ---
> v2: made all the local variables from longest to shortest line.

Applied, thank you.
