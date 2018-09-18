Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB57ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DAC214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DAC214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeIRHBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:01:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeIRHBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:01:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFFDBEF1F568C;
        Tue, 18 Sep 2018 09:31:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 09:30:59 +0800
Subject: Re: [PATCH net-next] net: fix return type of ndo_start_xmit function
To:     David Miller <davem@davemloft.net>
References: <20180915081906.23816-1-yuehaibing@huawei.com>
 <20180917.080945.1667529660601929619.davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dev@openvswitch.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <59b2a729-b30b-e73e-1869-703edf2770d7@huawei.com>
Date:   Tue, 18 Sep 2018 09:30:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180917.080945.1667529660601929619.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/17 23:09, David Miller wrote:
> 
> Please don't do this.
> 
> The hard part of fixing this is not what you are doing, changing the
> return type.
> 
> The hard part is fixing each and every function to actually return
> values which are members of the netdev_tx_t enumeration.
> 
> Please fix each and every function properly.

Ok, I will do it, thank you for review.

> 
> Thank you.
> 
> .
> 

