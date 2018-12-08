Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D58C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D3B2054F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D3B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeLHADb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:03:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40586 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:03:30 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A530F126C17E3;
        Fri,  7 Dec 2018 16:03:29 -0800 (PST)
Date:   Fri, 07 Dec 2018 16:03:29 -0800 (PST)
Message-Id: <20181207.160329.213257287260601741.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next 00/14] net: hns3: Additions/optimizations
 related to HNS3 H/W err handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181207210811.23844-1-salil.mehta@huawei.com>
References: <20181207210811.23844-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 07 Dec 2018 16:03:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Fri, 7 Dec 2018 21:07:57 +0000

> This patch set primarily does following addtions and optimizations
> related to error handling in HNS3 Ethernet driver:
> 
>  1. Name changes for enable and process functions and minor loop
>     optimizations. [PATCH 1-6]
>  2. Modify query and clearing of RAS errors using new set of commands
>     because modules specific commands for clearing RCB PPP PF, SSU are
>     obselete. [PATCH 7]
>  3. Deletes logging 1-bit errors for RAS in HNS3 driver as these never
>     get reported to the driver. [PATCH 8]
>  4. Add handling of NIC hw errors reported through MSIx rather than
>     PCIe AER channel. [PATCH 9]
>  5. Add handling for the HW RAS and MSIx errors in the modules MAC, PPP
>     PF, MSIx SRAM, RCB and SSU. [PATCH 10-13]
>  6. Add handling of RoCEE RAS errors. [PATCH 14]

Series applied, thank you.
