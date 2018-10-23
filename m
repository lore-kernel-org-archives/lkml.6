Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7314FC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56918207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56918207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJWKxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:53:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39860 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:53:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8E601146C93E1;
        Mon, 22 Oct 2018 19:32:26 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:32:25 -0700 (PDT)
Message-Id: <20181022.193225.2114721602911429714.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next 0/7] Adds support of RAS Error Handling in
 HNS3 Driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181019191532.10088-1-salil.mehta@huawei.com>
References: <20181019191532.10088-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 19:32:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Fri, 19 Oct 2018 20:15:25 +0100

> This patch-set adds support related to RAS Error handling to the HNS3
> Ethernet PF Driver. Set of errors occurred in the HNS3 hardware are
> reported to the driver through the PCIe AER interface. The received
> error information is then used to classify the received errors and
> then decide the appropriate receovery action depending on the type
> of error.

Series applied.
