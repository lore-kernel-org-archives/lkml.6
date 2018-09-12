Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D126C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E0F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E0F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeILS35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:29:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbeILS35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:29:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56547F8FF43C5;
        Wed, 12 Sep 2018 21:25:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 21:25:18 +0800
Message-ID: <5B9913BE.1040807@huawei.com>
Date:   Wed, 12 Sep 2018 21:25:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     <edumazet@google.com>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
References: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com> <20180911.235417.1481257495387934935.davem@davemloft.net>
In-Reply-To: <20180911.235417.1481257495387934935.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/12 14:54, David Miller wrote:
> From: zhong jiang <zhongjiang@huawei.com>
> Date: Mon, 10 Sep 2018 22:38:02 +0800
>
>> The if condition can be removed if we use BUG_ON directly.
>> The issule is detected with the help of Coccinelle.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> You keep asking if this is worthy to do.
>
> I think the most worthy thing to do is actually build test your
> patches.
 I am sorry for that.  :-[

Thanks,
zhong jiang

