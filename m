Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755670AbeEaQhA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:37:00 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:20356 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbeEaQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:36:57 -0400
Subject: Re: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
To: Tony Lindgren <tony@atomide.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>, <paul@pwsan.com>, <t-kristo@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com> <20180530150402.GE5705@atomide.com>
 <2361da91-659d-1aaa-0ab8-d1473bc3a71a@ti.com>
 <20180531134507.GK5705@atomide.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <1effa8c0-6749-faf5-3f09-9f51dc55532f@ti.com>
Date: Thu, 31 May 2018 22:08:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180531134507.GK5705@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 31 May 2018 07:15 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180531 10:22]:
>> On Wednesday 30 May 2018 08:34 PM, Tony Lindgren wrote:
>>> Looks good to me except I think the reset won't do anything currently
>>> with ti-sysc.c unless you specfify also "ti,hwmods" for the module?
>>>
>>> Can you please check? It might be worth adding the reset function to
>>> ti-sysc.c for non "ti,hwmods" case and that just might remove the
>>> need for any hwmod code for this module.
>>>
>>
>> If I understand correctly, this involves adding a (*reset_module) in
>> ti_sysc_platform_data and defining a ti_sysc_reset_module() in ti-sysc.c
>> similar to ti_sysc_idle_module(). Right?
> 
> Well try moving "ti,hwmods" to the module level first. Then reset will
> happen with enable.

Ok. Let me try that.

Thanks,
Faiz
