Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21875C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA972208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA972208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeIZH5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:57:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbeIZH5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:57:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4F58F91F9682F;
        Wed, 26 Sep 2018 09:46:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Wed, 26 Sep 2018
 09:46:39 +0800
Message-ID: <5BAAE4FE.4010506@huawei.com>
Date:   Wed, 26 Sep 2018 09:46:38 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <haver@linux.vnet.ibm.com>, <gpiccoli@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: card_utils: remove duplicated include file
References: <1537419842-30220-1-git-send-email-zhongjiang@huawei.com> <20180925182027.GA10085@kroah.com>
In-Reply-To: <20180925182027.GA10085@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/26 2:20, Greg KH wrote:
> On Thu, Sep 20, 2018 at 01:04:02PM +0800, zhong jiang wrote:
>> delay.h and dma-mapping.h have duplicated include. hence just remove
>> redundant file.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/misc/genwqe/card_utils.c | 2 --
>>  1 file changed, 2 deletions(-)
> Wrong subject :(
:-[ ,  corret it and repost.  thanks.

Sincerely,
zhong jiang

