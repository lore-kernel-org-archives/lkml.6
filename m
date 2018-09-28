Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7846FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF2220657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF2220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeI2ADR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:03:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39090 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeI2ADQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:03:16 -0400
Received: from localhost (c-24-18-158-142.hsd1.wa.comcast.net [24.18.158.142])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E962A147805E2;
        Fri, 28 Sep 2018 10:38:26 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:38:26 -0700 (PDT)
Message-Id: <20180928.103826.486456665561471777.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next 00/10] Cleanups, minor additions & fixes for
 HNS3 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180926182840.28392-1-salil.mehta@huawei.com>
References: <20180926182840.28392-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Sep 2018 10:38:27 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Wed, 26 Sep 2018 19:28:30 +0100

> This patch-set contains cleans-ups, minor changes and fixes to the HNS3 driver.

Series applied, thank you.
