Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeBVH5O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:57:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeBVH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:57:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39B596079B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v4 3/4] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>
Cc: devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
 <20180216060503.22006-4-rnayak@codeaurora.org>
 <20180219163651.66936056@why.wild-wind.fr.eu.org>
 <CAD=FV=WgyX-O8haJp3WpzPodV2f1sokL9hW_qe7R8hVYy3v+sg@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <0cfcb7ce-9da8-c49a-7df7-4749d07cd365@codeaurora.org>
Date: Thu, 22 Feb 2018 13:27:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WgyX-O8haJp3WpzPodV2f1sokL9hW_qe7R8hVYy3v+sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/22/2018 04:53 AM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Feb 19, 2018 at 8:36 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> +                     interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
>>
>> Please do not use IRQ_TYPE_NONE, ever. It doesn't exist in the GIC
>> binding. Set it to the actual trigger value.
>>
> 
>>> +                     interrupts = <GIC_SPI 481 IRQ_TYPE_NONE>;
>>
>> Same here.
> 
> Thanks for the review Marc!
> 
> 
> Andy: If I'm reading everything correctly you're the one who would
> collect these patches and apply them.  Is that right?  Do they look OK
> to you in general?  Would you prefer that Rajendra send out a v5 with
> the fixes pointed out by Marc, or would you prefer to fix them up
> yourself when applying?  Is now a good time or would you prefer to
> wait?

I just fixed up to remove all instances of IRQ_TYPE_NONE and sent a v5 out.

> 
> Thanks!  :)
> 
> -Doug
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
