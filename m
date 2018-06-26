Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2C4267BC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2C4267BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934408AbeFZJ3K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:29:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38735 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934275AbeFZJ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:29:05 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5Q9OtVU005664;
        Tue, 26 Jun 2018 11:28:19 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2juju8r0gk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 11:28:19 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BB7134;
        Tue, 26 Jun 2018 09:28:19 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E295E2424;
        Tue, 26 Jun 2018 09:28:18 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 11:28:18 +0200
Subject: Re: [PATCH 0/2] Add USB OTG HS support on stm32mp157c
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <be346ccb-908d-0af2-7499-4a45b780692e@st.com>
Date:   Tue, 26 Jun 2018 11:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526572052-17155-1-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amélie

On 05/17/2018 05:47 PM, Amelie Delaunay wrote:
> This patchset adds support for USB OTG HS on stm32mp157c SoC.
> It also enables USB OTG HS on stm32mp157c-ev1 board in Peripheral mode.
> 
> Amelie Delaunay (2):
>    ARM: dts: stm32: add USB OTG HS support for stm32mp157c SoC
>    ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp157c-ev1.dts |  7 +++++++
>   arch/arm/boot/dts/stm32mp157c.dtsi    | 15 +++++++++++++++
>   2 files changed, 22 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
