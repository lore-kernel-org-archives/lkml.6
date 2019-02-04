Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7028C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D8A214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfBDIXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:23:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55545 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726727AbfBDIXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:23:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x148MoXB018763;
        Mon, 4 Feb 2019 09:23:24 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qd2ym86k2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 04 Feb 2019 09:23:24 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 681443A;
        Mon,  4 Feb 2019 08:23:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30E082452;
        Mon,  4 Feb 2019 08:23:23 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 4 Feb
 2019 09:23:22 +0100
Subject: Re: [PATCH 4/5] ARM: dts: stm32: add SPI support on STM32F429 SoC
To:     <cezary.gapinski@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
 <1544363636-12161-5-git-send-email-cezary.gapinski@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b370de22-c475-fb09-0e27-bda2adfa8696@st.com>
Date:   Mon, 4 Feb 2019 09:23:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1544363636-12161-5-git-send-email-cezary.gapinski@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cezary,

On 12/9/18 2:53 PM, cezary.gapinski@gmail.com wrote:
> From: Cezary Gapinski <cezary.gapinski@gmail.com>
> 
> This patch adds all SPI instances of the STM32F429 SoC.
> 
> Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 

Applied on stm32-next.

Thanks.
Alex
