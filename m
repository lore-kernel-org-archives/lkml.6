Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeCUJLW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:11:22 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:50298 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCUJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:11:17 -0400
X-Google-Smtp-Source: AG47ELtPKT0Ddc8IpSunEhAblgXLcf2N8AK3KP4OFBooH9xHDwg9Jji1qXYRRI+fvH0shxf9Bol6Lw==
Subject: Re: [PATCH v2 0/5] update Mediatek MT2712 clock and scpsys support
To: Stephen Boyd <sboyd@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
 <1521526068.13313.8.camel@mtksdaap41>
 <152153061465.254778.3061562183948751301@swboyd.mtv.corp.google.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6c29df1f-f619-5e11-4160-b58e154f6592@gmail.com>
Date: Wed, 21 Mar 2018 10:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152153061465.254778.3061562183948751301@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2018 08:23 AM, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-03-19 23:07:48)
>> On Mon, 2018-03-12 at 15:03 +0800, Weiyi Lu wrote:
>>> This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
>>> Basically, all changes are for the ECO design change of MT2712.
>>>
>>> changes since v1:
>>> - Avoid renumbering clocks. Append new clocks at the bottom of each own subsystem.
>>>
>> Hi Matthias & Stephen,
>>
>> Sorry to bother. Just saw patch 1/2 are already pushed to v4.16-next-soc
>> and patch 3/5 are applied onto clk-next. What about the patch 4(arm64:
>> dts: add clock device nodes of MT2712). Does there any problem remain or
>> it cause some problems? Many thanks.
> 
> Patch 4 can go via arm-soc? I'm not planning to apply that patch.
> 

I can take it through my branch, no problem. But I think it is too late for this
cycle. CCing Arnd to confirm.

Regards,
Matthias
