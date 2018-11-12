Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0F5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0512F2243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0512F2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeKMDyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:54:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeKMDyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:54:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29853A78;
        Mon, 12 Nov 2018 09:59:42 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C69133F5A0;
        Mon, 12 Nov 2018 09:59:40 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Add reviewer for CoreSight sub-system
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        davem@davemloft.net, akpm@linux-foundation.org
Cc:     nicolas.ferre@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <1542042347-12389-1-git-send-email-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fa47727b-26f3-e86a-0b34-5a981d8d6a86@arm.com>
Date:   Mon, 12 Nov 2018 17:59:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542042347-12389-1-git-send-email-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2018 17:05, Mathieu Poirier wrote:
> On top of providing useful review and comments, Suzuki has done good work
> in the CoreSight sub-system over the past couple of years.  As agreed
> during a recent face-to-face converstation, adding him as a reviewer to
> lessen the maintenance workload.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0abecc528dac..4f93b877c4eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1426,6 +1426,7 @@ F:	arch/arm/mach-ep93xx/micro9.c
>   
>   ARM/CORESIGHT FRAMEWORK AND DRIVERS
>   M:	Mathieu Poirier <mathieu.poirier@linaro.org>
> +R:	Suzuki K Poulose <suzuki.poulose@arm.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   F:	drivers/hwtracing/coresight/*
> 

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


