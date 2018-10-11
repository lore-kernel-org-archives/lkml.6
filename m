Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F52AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD45420835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD45420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeJKNZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:25:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49328 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeJKNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:25:03 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 22E9712139FF0;
        Wed, 10 Oct 2018 22:59:21 -0700 (PDT)
Date:   Wed, 10 Oct 2018 22:59:20 -0700 (PDT)
Message-Id: <20181010.225920.1970816507651871098.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next 0/4] Adds support of RSS to HNS3 Driver for
 Rev 2(=0x21) H/W
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181010190537.20972-1-salil.mehta@huawei.com>
References: <20181010190537.20972-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Oct 2018 22:59:21 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Wed, 10 Oct 2018 20:05:33 +0100

> This patch-set mainly adds new additions related to RSS for the new
> hardware Revision 0x21. It also adds support to use RSS hash value
> provided by the hardware along with descriptor.

Series applied.
