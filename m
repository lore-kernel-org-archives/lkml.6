Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A53C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BD621019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BD621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeK3CfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:35:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57923 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbeK3CfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:35:08 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5F384191706F;
        Thu, 29 Nov 2018 23:29:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 29 Nov 2018
 23:29:18 +0800
Subject: Re: [PATCH 0/5] Add Pinctrl and GPIO support for HI3670 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
 <CACRpkdbMSYt5aH9fwRijtO=VG1nLAnfxTsfxGza+_Z2iGj2+-A@mail.gmail.com>
 <20181112071708.GA6689@mani>
CC:     <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Amit Kucheria" <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5C0005C8.2020202@hisilicon.com>
Date:   Thu, 29 Nov 2018 15:29:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181112071708.GA6689@mani>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On 2018/11/12 7:17, Manivannan Sadhasivam wrote:
> On Wed, Oct 31, 2018 at 10:43:00AM +0100, Linus Walleij wrote:
>> On Tue, Oct 23, 2018 at 9:07 PM Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:
>>
>>> This patchset adds Pinctrl and GPIO support for HI3670 SoC from HiSilicon
>>> found in the HiKey970 developement board. Also, the remaining UARTs are
>>> enabled and GPIO line names are added based on the Schematics and the
>>> 96Boards Consumer Edition spec.
>>>
>>> Note: These patches are based on the below common clk patches pushed
>>> earlier:
>>>
>>> arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
>>> arm64: dts: hisilicon: Source SoC clock for UART6
>>
>> All looks good to me.
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> for the series.
>>
> 
> Hi Wei,
> 
> Any update on this patchset?

Sorry for the late reply!
Series applied to the hisilicon soc dt tree with minor changes
in the subject.
Thanks!

Best Regards,
Wei

> 
> Thanks,
> Mani
>  
>> Yours,
>> Linus Walleij
> 
> 

