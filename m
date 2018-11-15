Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD044C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B76121780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B76121780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbeKPDzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:55:38 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42978 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeKPDzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:55:38 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E306714786F15;
        Thu, 15 Nov 2018 09:46:50 -0800 (PST)
Date:   Thu, 15 Nov 2018 09:46:46 -0800 (PST)
Message-Id: <20181115.094646.1234839161454817822.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH V2 net-next 0/5] net: hns3: Add support of hardware GRO
 to HNS3 Driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181115092925.11812-1-salil.mehta@huawei.com>
References: <20181115092925.11812-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 15 Nov 2018 09:46:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Thu, 15 Nov 2018 09:29:20 +0000

> This patch-set adds support of hardware assisted GRO feature to
> HNS3 driver on Rev B(=0x21) platform. Current hardware only
> supports TCP/IPv{4|6} flows.
> 
> Change Log:
> V1->V2:
> 1. Remove redundant print reported by Leon Romanovsky.
>    Link: https://lkml.org/lkml/2018/11/13/715

Series applied, thanks.
