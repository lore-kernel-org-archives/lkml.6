Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DDBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33A921473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33A921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeLCJ7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:59:40 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24624 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbeLCJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:59:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB39p7Cp021675;
        Mon, 3 Dec 2018 10:58:56 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3uhmgrvc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Dec 2018 10:58:56 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 51B1838;
        Mon,  3 Dec 2018 09:58:55 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27A4D1325;
        Mon,  3 Dec 2018 09:58:55 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Dec
 2018 10:58:54 +0100
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: enable STM32 analog & timer
 drivers
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <arnd@arndb.de>,
        <mcoquelin.stm32@gmail.com>
CC:     <linux@armlinux.org.uk>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1538577689-22847-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <0e4b96e9-e4de-bd88-ed87-b6a411fdb8fa@st.com>
Date:   Mon, 3 Dec 2018 10:58:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1538577689-22847-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

On 10/3/18 4:41 PM, Fabrice Gasnier wrote:
> This enables drivers for STM32 timer, low power timer and analog hardware
> that can be used on STM32MP1 SoC:
> - Timer & LP Timer MFD core, PWM, trigger & encoder drivers
> - IIO ADC/DAC/DFSDM
> - vrefbuf regu driver (voltage reference buffer).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Applied on stm32-next.

Thanks.
Alex
