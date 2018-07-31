Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA6E20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA6E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbeGaSJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:09:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727569AbeGaSJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:09:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2602CC85AE61C;
        Wed,  1 Aug 2018 00:27:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 00:27:55 +0800
Message-ID: <5B608E09.8060702@huawei.com>
Date:   Wed, 1 Aug 2018 00:27:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <longman@redhat.com>, <yang.shi@linux.alibaba.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/sg_pool,debugobjects: remove unnecessary null check
 when free the object
References: <1533052519-34372-1-git-send-email-zhongjiang@huawei.com> <alpine.DEB.2.21.1807311820180.1610@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807311820180.1610@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/1 0:21, Thomas Gleixner wrote:
> On Tue, 31 Jul 2018, zhong jiang wrote:
>
>> kmem_cache_destroy/mempool_destroy has taken null check into account.
>> so remove the redundant check.
> Please split the patch so they can be applied independently by the relevant
> maintainers.
>
> Thanks,
>
> 	tglx
>
> .
>
Ok, will do .

Thanks,
zhong jiang

