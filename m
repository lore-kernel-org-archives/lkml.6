Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979E12174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979E12174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeH0EyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 00:54:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbeH0EyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 00:54:04 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5239296697043;
        Mon, 27 Aug 2018 09:09:41 +0800 (CST)
Received: from [127.0.0.1] (10.63.173.108) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Mon, 27 Aug 2018
 09:09:34 +0800
Subject: Re: [PATCH NET 3/3] net: hns: add configuration constraints for 1000M
 half
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>
References: <1535082143-122281-1-git-send-email-lipeng321@huawei.com>
 <1535082143-122281-4-git-send-email-lipeng321@huawei.com>
 <20180824034119.GA29111@lunn.ch>
 <194ac663-94d8-55e2-0231-a6be53e35f04@huawei.com>
 <20180824132857.GA1999@lunn.ch>
 <7c40c758-2ef2-665d-f429-0cc4e63a7a38@huawei.com>
 <20180825180721.GB23992@lunn.ch>
From:   "lipeng (Y)" <lipeng321@huawei.com>
Message-ID: <e4b9af46-3f16-9cff-41ad-a520f648f13f@huawei.com>
Date:   Mon, 27 Aug 2018 09:08:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180825180721.GB23992@lunn.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.63.173.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/26 2:07, Andrew Lunn wrote:
>> This patch is a  theoretical protect, and the problem does not really
>> happen.
>>
>> I think you really get the point, do you think we need this patch?
> I think it is not needed.
>
> And if it was needed, it would indicate there is a bug somewhere else.
Hi, Andrew

It is a theoretical protect,we can remove  this patch from patchset.

Thanks.

>
>      Andrew
>
> .
>


