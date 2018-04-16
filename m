Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbeDPMAS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:00:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48062 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755190AbeDPMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:00:17 -0400
Subject: Re: [PATCH] ARM: dts: stm32: Enable stm32mp1 clock driver on
 stm32mp157c
To: <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1521098327-13958-1-git-send-email-gabriel.fernandez@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <661fd823-d7ba-bafe-3dc9-93fd0cf134fe@st.com>
Date: Mon, 16 Apr 2018 13:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521098327-13958-1-git-send-email-gabriel.fernandez@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG4NODE6.st.com (10.75.127.76) To GPXDAG3NODE5.st.com
 (10.75.127.72)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On 03/15/2018 08:18 AM, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch enables stm32mp1 clock driver.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>


Applied on stm32-next.

Thanks.
Alex
