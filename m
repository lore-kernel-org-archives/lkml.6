Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42FAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608FF27A1A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608FF27A1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755114AbeF2Do6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:44:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45234 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751466AbeF2Do5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:44:57 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 251C8BEA6286;
        Fri, 29 Jun 2018 11:44:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Fri, 29 Jun 2018
 11:44:52 +0800
Subject: Re: [PATCH] lib/string.c: fix a typo in comment: 'iff' -->'if'
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180629033303.13012-1-yuehaibing@huawei.com>
 <a0b2a088-4887-e864-d211-bed0665a0b81@infradead.org>
CC:     <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <mawilcox@microsoft.com>, <kstewart@linuxfoundation.org>,
        <aryabinin@virtuozzo.com>, <gregkh@linuxfoundation.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <22bb151b-d651-597b-21b6-0e6346ac32c9@huawei.com>
Date:   Fri, 29 Jun 2018 11:44:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <a0b2a088-4887-e864-d211-bed0665a0b81@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/29 11:35, Randy Dunlap wrote:
> On 06/28/2018 08:33 PM, YueHaibing wrote:
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  lib/string.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi,
> 
> This isn't a typo.  "iff" means "if and only if".

ok, my poor english, thank you.

> 
>> diff --git a/lib/string.c b/lib/string.c
>> index 2c0900a..23ed944 100644
>> --- a/lib/string.c
>> +++ b/lib/string.c
>> @@ -609,7 +609,7 @@ EXPORT_SYMBOL(strsep);
>>   * @s1: one string
>>   * @s2: another string
>>   *
>> - * This routine returns true iff two strings are equal, treating both
>> + * This routine returns true if two strings are equal, treating both
>>   * NUL and newline-then-NUL as equivalent string terminations.  It's
>>   * geared for use with sysfs input strings, which generally terminate
>>   * with newlines but are compared against values without newlines.
>>
> 
> 

