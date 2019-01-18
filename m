Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54221C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270372086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfARUAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:00:36 -0500
Received: from ivanoab6.miniserver.com ([5.153.251.140]:41138 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfARUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:00:35 -0500
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gkaJc-0005P5-OR; Fri, 18 Jan 2019 20:00:33 +0000
Received: from [192.168.15.6]
        by smaug.kot-begemot.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gkaJa-0001jn-4F; Fri, 18 Jan 2019 20:00:32 +0000
Subject: Re: [PATCH] um: Remove duplicate headers
To:     Richard Weinberger <richard@nod.at>
Cc:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        yuehaibing@huawei.com, jdike@addtoit.com,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        jrdr.linux@gmail.com, brajeswar.linux@gmail.com
References: <5c41e99b.1c69fb81.f240b.506a@mx.google.com>
 <dfdf5e70-f782-d90e-1059-a524a5e72b7d@cambridgegreys.com>
 <4621128.kXzvTGAT2u@blindfold>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <d9f525fb-847f-312e-43e7-c80b65936680@cambridgegreys.com>
Date:   Fri, 18 Jan 2019 20:00:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4621128.kXzvTGAT2u@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2019 19:42, Richard Weinberger wrote:
> Am Freitag, 18. Januar 2019, 20:23:07 CET schrieb Anton Ivanov:
>>
>> On 18/01/2019 14:58, Sabyasachi Gupta wrote:
>>> Remove sys/socket.h and sys/uio.h which are included more than once
>>>
>>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>>> ---
>>>    arch/um/drivers/vector_user.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
>>> index d2c17dd..c863921 100644
>>> --- a/arch/um/drivers/vector_user.c
>>> +++ b/arch/um/drivers/vector_user.c
>>> @@ -23,7 +23,6 @@
>>>    #include <netinet/ether.h>
>>>    #include <linux/if_ether.h>
>>>    #include <linux/if_packet.h>
>>> -#include <sys/socket.h>
>>>    #include <sys/wait.h>
>>>    #include <sys/uio.h>
>>>    #include <linux/virtio_net.h>
>>> @@ -31,7 +30,6 @@
>>>    #include <stdlib.h>
>>>    #include <os.h>
>>>    #include <um_malloc.h>
>>> -#include <sys/uio.h>
>>>    #include "vector_user.h"
>>>    
>>>    #define ID_GRE 0
>>>
>>
>> Hi Sabyasachi,
>>
>> I believe we have an identical patch enqueued already from a couple of
>> weeks back.
> 
> Hmm, did I miss that one in patchwork?
> 
> Thanks,
> //richard
> 
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 
https://patchwork.ozlabs.org/patch/1020163/

A.
