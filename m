Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBA8ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB8E214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB8E214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeIQN6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:58:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29566 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbeIQN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:58:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8H8TEp0031127;
        Mon, 17 Sep 2018 10:31:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mgqust5mc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 17 Sep 2018 10:31:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4470931;
        Mon, 17 Sep 2018 08:31:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 119C625C9;
        Mon, 17 Sep 2018 08:31:57 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Sep
 2018 10:31:56 +0200
Subject: Re: [PATCH] MAINTAINERS: Update stm32 entry
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180917082441.31979-1-benjamin.gaignard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a8343476-a8d7-253b-ea29-c968533dbed9@st.com>
Date:   Mon, 17 Sep 2018 10:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917082441.31979-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/17/2018 10:24 AM, Benjamin Gaignard wrote:
> Add mailing list for stm32 architecture.
> Add "stm" pattern to not miss some drivers/directories when asking for maintainers.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---

Thanks Benjamin!

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..237e7012f3ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2085,10 +2085,12 @@ F:	include/linux/remoteproc/st_slim_rproc.h
>   ARM/STM32 ARCHITECTURE
>   M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
>   M:	Alexandre Torgue <alexandre.torgue@st.com>
> +L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
>   N:	stm32
> +N:	stm
>   F:	arch/arm/boot/dts/stm32*
>   F:	arch/arm/mach-stm32/
>   F:	drivers/clocksource/armv7m_systick.c
> 
