Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11833C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D696020C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfB0QVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:21:17 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38778 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbfB0QVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:21:15 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RGBqXJ005085;
        Wed, 27 Feb 2019 17:20:58 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvh3qnej-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Feb 2019 17:20:58 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8A4F3D;
        Wed, 27 Feb 2019 16:20:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AD62A5FB;
        Wed, 27 Feb 2019 16:20:57 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 27 Feb
 2019 17:20:57 +0100
Subject: Re: [PATCH v2 0/2] ARM errata 814220
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e25b2626-231b-28d7-93b0-004a21a3685e@st.com>
Date:   Wed, 27 Feb 2019 17:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/19 9:31 AM, Benjamin Gaignard wrote:
> Implement ARM errata 814220 for Cortex A7.
> 
> This patch has been wroten by Jason Liu years ago but never send upstream.
> I have tried to contact the author on multiple email addresses but I haven't
> found any valid one...
> I have keep Jason's sign-off and just rebase the patch on to v5-rc6.
> 
> version 2:
> - limite help lines to 80 columns.
> - Add  Arnd Bergmann acks.
>    
> Benjamin Gaignard (2):
>    ARM: errata 814220-B-Cache maintenance by set/way operations can
>      execute out of order.
>    ARM: stm32: select ARM errata 814220
> 
>   arch/arm/Kconfig            | 12 ++++++++++++
>   arch/arm/mach-stm32/Kconfig |  1 +
>   arch/arm/mm/cache-v7.S      |  3 +++
>   3 files changed, 16 insertions(+)
> 

Russel,

If you agree, can I take this series in my STM32 soc tree ?
If yes it will be part of my PR for v5.2.

regards
Alex
