Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E463121852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfB0Fqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 00:46:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbfB0Fqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 00:46:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C3C033B10274A5248E5D;
        Wed, 27 Feb 2019 13:46:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 13:46:36 +0800
Subject: Re: [-next] um: Remove duplicated include from vector_user.c
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
References: <1546485161-142907-1-git-send-email-yuehaibing@huawei.com>
 <cff7d34e-7afa-70cc-427d-ebeaa1e65e73@cambridgegreys.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-um@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <3691363f-84b1-b5ab-8637-132fdc4cbd81@huawei.com>
Date:   Wed, 27 Feb 2019 13:46:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <cff7d34e-7afa-70cc-427d-ebeaa1e65e73@cambridgegreys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Friendly ping:

Who can take this, please?

On 2019/1/21 2:54, Anton Ivanov wrote:
> 
> 
> On 1/3/19 3:12 AM, YueHaibing wrote:
>> Remove duplicated include.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   arch/um/drivers/vector_user.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
>> index d2c17dd..b3f7b3c 100644
>> --- a/arch/um/drivers/vector_user.c
>> +++ b/arch/um/drivers/vector_user.c
>> @@ -16,14 +16,12 @@
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>>   #include <fcntl.h>
>> -#include <sys/types.h>
>>   #include <sys/socket.h>
>>   #include <net/ethernet.h>
>>   #include <netinet/ip.h>
>>   #include <netinet/ether.h>
>>   #include <linux/if_ether.h>
>>   #include <linux/if_packet.h>
>> -#include <sys/socket.h>
>>   #include <sys/wait.h>
>>   #include <sys/uio.h>
>>   #include <linux/virtio_net.h>
>> @@ -31,7 +29,6 @@
>>   #include <stdlib.h>
>>   #include <os.h>
>>   #include <um_malloc.h>
>> -#include <sys/uio.h>
>>   #include "vector_user.h"
>>     #define ID_GRE 0
>>
> 
> Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

