Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9B9C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B12206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B12206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeIHOvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:51:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbeIHOvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:51:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC5647B0D80AC;
        Sat,  8 Sep 2018 18:05:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Sat, 8 Sep 2018
 18:05:56 +0800
Message-ID: <5B939F01.7020802@huawei.com>
Date:   Sat, 8 Sep 2018 18:05:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <longman@redhat.com>, <arnd@arndb.de>,
        <yang.shi@linux.alibaba.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/sg_pool: remove unnecessary null check when free
 the object
References: <1533054107-35657-1-git-send-email-zhongjiang@huawei.com> <5B9398CD.1060500@huawei.com> <alpine.DEB.2.21.1809081146010.1402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809081146010.1402@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/8 17:46, Thomas Gleixner wrote:
> On Sat, 8 Sep 2018, zhong jiang wrote:
>> Hi,  Thomas
>>
>> Can you pick up the patch?
> I'm not picking up patches for lib/sg_pool. Why would I?
>
I am sorry for that. I regard you as maintainer for lib/sg_pool mistakely. 
but I can get maintainer information nothing from get_maintainer.pl
The code is not updated since 2016. 

Thanks
zhong jiang

