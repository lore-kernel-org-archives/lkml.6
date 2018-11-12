Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6C3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE604223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE604223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeKLTDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:03:11 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57955 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728740AbeKLTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:03:11 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAC8x1fQ007727;
        Mon, 12 Nov 2018 10:10:32 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nnnp22j8k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 12 Nov 2018 10:10:32 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E22431;
        Mon, 12 Nov 2018 09:10:32 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2B66244B;
        Mon, 12 Nov 2018 09:10:31 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 12 Nov
 2018 10:10:30 +0100
Subject: Re: [PATCH 0/3] ARM: dts: stm32: add dmas to stm32mp157c timers
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f490c7c8-7920-2c28-8e1f-80021516db24@st.com>
Date:   Mon, 12 Nov 2018 10:10:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 10/3/18 5:11 PM, Fabrice Gasnier wrote:
> This series adds dmas description to stm32mp157c device tree file.
> But dmas are kept disabled by default on all boards. They are only
> necessary for PWM capture. So, spare them for other usage by default.
> 
> Fabrice Gasnier (3):
>    ARM: dts: stm32: Add dmas to timer on stm32mp157c
>    ARM: dts: stm32: don't use timers dmas on stm32mp157c-ed1
>    ARM: dts: stm32: don't use timers dmas on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp157c-ed1.dts |  3 ++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts |  7 +++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 58 +++++++++++++++++++++++++++++++++++
>   3 files changed, 68 insertions(+)
> 

Series applied on stm32-next.

Thanks!

Alex
