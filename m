Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9057C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989DD2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989DD2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeJBMji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:39:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbeJBMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:39:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::30d2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C44811693725;
        Mon,  1 Oct 2018 22:58:09 -0700 (PDT)
Date:   Mon, 01 Oct 2018 22:58:08 -0700 (PDT)
Message-Id: <20181001.225808.1703753605069754507.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next 0/7] Support of Flow Director in HNS3 Ethernet
 Driver for HiP08 Rev2 SoC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181001114647.15504-1-salil.mehta@huawei.com>
References: <20181001114647.15504-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Oct 2018 22:58:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Mon, 1 Oct 2018 12:46:40 +0100

> This patch-set adds the support of FD(Flow Director) in the HNS3 PF driver
> for HiP08 Rev2(0x21) SoC of Hisilicon. FD can be used in filtering the flows
> and deciding to drop the flow or forward it to paricular queue.
> 
> Configuration consists of rules with input keys and actions. The rules are
> stored in TCAM.

Series applied.
