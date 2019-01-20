Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD889C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29D120861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfATSzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:55:25 -0500
Received: from ivanoab6.miniserver.com ([5.153.251.140]:41662 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfATSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:55:24 -0500
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1glIFY-00055m-QI; Sun, 20 Jan 2019 18:55:20 +0000
Received: from [192.168.15.6]
        by smaug.kot-begemot.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1glIFT-0001CC-94; Sun, 20 Jan 2019 18:55:15 +0000
Subject: Re: [-next] um: Remove duplicated include from vector_user.c
To:     YueHaibing <yuehaibing@huawei.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     kernel-janitors@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1546485161-142907-1-git-send-email-yuehaibing@huawei.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys Limited
Message-ID: <cff7d34e-7afa-70cc-427d-ebeaa1e65e73@cambridgegreys.com>
Date:   Sun, 20 Jan 2019 18:54:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546485161-142907-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/19 3:12 AM, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   arch/um/drivers/vector_user.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index d2c17dd..b3f7b3c 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -16,14 +16,12 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <fcntl.h>
> -#include <sys/types.h>
>   #include <sys/socket.h>
>   #include <net/ethernet.h>
>   #include <netinet/ip.h>
>   #include <netinet/ether.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> -#include <sys/socket.h>
>   #include <sys/wait.h>
>   #include <sys/uio.h>
>   #include <linux/virtio_net.h>
> @@ -31,7 +29,6 @@
>   #include <stdlib.h>
>   #include <os.h>
>   #include <um_malloc.h>
> -#include <sys/uio.h>
>   #include "vector_user.h"
>   
>   #define ID_GRE 0
> 

Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
