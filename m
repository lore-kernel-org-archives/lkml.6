Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbeEBQXW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:23:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53094 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750936AbeEBQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:23:20 -0400
Subject: Re: [PATCH v1 0/2] Add ltdc & dsi support on stm32mp157c
To: yannick fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Kamel Kholti <kamel.kholti@st.com>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>
References: <1524556488-5404-1-git-send-email-yannick.fertre@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f4f45fc9-df55-c094-8b63-35efb31a4069@st.com>
Date: Wed, 2 May 2018 18:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524556488-5404-1-git-send-email-yannick.fertre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On 04/24/2018 09:54 AM, yannick fertre wrote:
> This patch-set adds display controller & DSI controller support to
> stm32mp157c SOC.
> 
> Version 1:
> - Initial commit
> 
> yannick fertre (2):
>    ARM: dts: stm32: add ltdc support on stm32mp157c
>    ARM: dts: stm32: add dsi support on stm32mp157c
> 
>   arch/arm/boot/dts/stm32mp157c.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
Series applied on stm32-next.

Regards
Alex
