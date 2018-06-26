Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33A9266CE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33A9266CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeFZI0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:26:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752506AbeFZI0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:26:09 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CA39A60DE75E6;
        Tue, 26 Jun 2018 16:25:53 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Tue, 26 Jun 2018
 16:25:52 +0800
Subject: Re: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
To:     John Stultz <john.stultz@linaro.org>, Ryan Grachek <ryan@edited.us>
References: <20180613151305.17240-1-ryan@edited.us>
 <CANcMJZASEDRxaXwdG96nNeEDPrDm_ap5MjhXonEcg=yHZ8F=qg@mail.gmail.com>
 <CALAqxLWjJKsU+XJmANzx-aO2ruszwbBnPV2yV5WoyVStO+5K0A@mail.gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eyal Reizer <eyalr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B31F888.7010403@hisilicon.com>
Date:   Tue, 26 Jun 2018 09:25:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWjJKsU+XJmANzx-aO2ruszwbBnPV2yV5WoyVStO+5K0A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2018/6/25 22:56, John Stultz wrote:
> On Wed, Jun 13, 2018 at 11:30 AM, John Stultz <john.stultz@linaro.org> wrote:
>> On Wed, Jun 13, 2018 at 8:13 AM, Ryan Grachek <ryan@edited.us> wrote:
>>> These properties are required for compatibility with runtime PM.
>>> Without these properties, MMC host controller will not be aware
>>> of power capabilities. When the wlcore driver attempts to power
>>> on the device, it will erroneously fail with -EACCES.
>>>
>>> Signed-off-by: Ryan Grachek <ryan@edited.us>
>>
>> Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
>> Tested-by: John Stultz <john.stultz@linaro.org>
>> Acked-by: John Stultz <john.stultz@linaro.org>
>>
>> Wei Xu: This fixes a functional regression with wifi on the HiKey
>> board that was introduced in 4.18-rc with commit 60f36637bbbd
>> ("wlcore: sdio: allow pm to handle sdio power").
> 
> Wei Xu: Just wanted to follow up to make sure this wasn't missed for
> 4.18-rc, as I haven't seen it upstream or in -next, and it fixes a
> recently introduced regression.

Thanks!
I will send out the fix pull request in these two days if no problem.

Best Regards,
Wei

> 
> thanks
> -john
> 
> .
> 

