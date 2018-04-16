Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbeDPMry (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:47:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40449 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeDPMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:47:52 -0400
X-Google-Smtp-Source: AIpwx4+K+nhim1yidAFPpyVBLT2r+IRJc/wCVh48WjwNqhGno+omSimJ3veBoPk9fFzViCv8PSFTjg==
Subject: Re: [PATCH 03/14] thermal: exynos: Read soc_type from match data
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maciej Purski <m.purski@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
 <1523873525-23718-4-git-send-email-b.zolnierkie@samsung.com>
 <09824e4e-b60a-13eb-36a5-a6f2172b5539@linaro.org>
 <CGME20180416124129eucas1p1545c737e0feb0f9f2c327b8597c46bce@eucas1p1.samsung.com>
 <5369056.eM2qptIOQZ@amdc3058>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <09325238-a050-951a-a5ee-ffcb19813e3e@linaro.org>
Date: Mon, 16 Apr 2018 14:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5369056.eM2qptIOQZ@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 14:41, Bartlomiej Zolnierkiewicz wrote:
> On Monday, April 16, 2018 02:19:30 PM Daniel Lezcano wrote:
>> On 16/04/2018 12:11, Bartlomiej Zolnierkiewicz wrote:
>>> From: Maciej Purski <m.purski@samsung.com>
>>>
>>> Device context's field data->soc is currently obtained by comparing
>>> of_compatible's. Provide soc_type as .data field in device's match
>>> table, as it is done in most drivers.
>>>
>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Zhang & Eduardo are Thermal Maintainers (+ I'm Maintainer for
> Samsung Thermal) so I assume you meant "Reviewed-by:"?

I meant Acked-by :) I don't have to be a subsystem maintainer to ack a
patch. The reviewed-by has a stronger statement than the acked-by.

The patch looks good to me.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
