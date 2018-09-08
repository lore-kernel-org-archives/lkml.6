Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884B8206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 17:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884B8206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIHWRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 18:17:54 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHWRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 18:17:54 -0400
Received: from localhost (unknown [24.18.143.0])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC4D51262C3F7;
        Sat,  8 Sep 2018 10:31:23 -0700 (PDT)
Date:   Sat, 08 Sep 2018 10:31:23 -0700 (PDT)
Message-Id: <20180908.103123.1794683848863750683.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     alexander.h.duyck@intel.com, jeffrey.t.kirsher@intel.com,
        liran.alon@oracle.com, sridhar.samudrala@intel.com,
        stephen@networkplumber.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] failover: Fix error return code in
 net_failover_create
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180906130412.21964-1-yuehaibing@huawei.com>
References: <20180906130412.21964-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 08 Sep 2018 10:31:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 6 Sep 2018 21:04:12 +0800

> if failover_register failed, 'err' code should be set correctly
> 
> Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
