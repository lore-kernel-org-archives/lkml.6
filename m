Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBSJcK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:32:10 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:42897 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752073AbeBSJcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:32:07 -0500
Subject: Re: [PATCH v3 6/7] arm64: tegra: Add Tegra194 chip device tree
To: Philippe Ombredanne <pombredanne@nexb.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20180215145206.24775-1-mperttunen@nvidia.com>
 <20180215145206.24775-7-mperttunen@nvidia.com>
 <CAOFm3uHvbut7w5eBuggNg0NnW-UvBsRjifsJxGuj3L34vCjEHA@mail.gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <eb5cde8c-7d21-2542-261b-23f94bacf85e@kapsi.fi>
Date: Mon, 19 Feb 2018 11:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAOFm3uHvbut7w5eBuggNg0NnW-UvBsRjifsJxGuj3L34vCjEHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.209.167.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.2018 14:33, Philippe Ombredanne wrote:
> Mikko,
>
> On Thu, Feb 15, 2018 at 3:52 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>> Add the chip-level device tree, including binding headers, for the
>> NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
>> are initially available, enough to boot to UART console.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>
>> Notes:
>>     v3:
>>     - added hypervisor-related apertures to GIC node
>>     - removed GPL boilerplate in favor of SPDX and harmonized
>>       copyright headers
>
> Thanks for this boilerplate removal! but see a few nits below.
>
> <snip>
>
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/tegra194-clock.h
>> @@ -0,0 +1,653 @@
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>
> The proper style should be this for a .h header on the first line per [1]

I see -- I'll fix this in v4 (or if there are no further issues maybe 
Thierry can fix this while applying?:)

Mikko

>
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
>> + *
>> + */
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
>
> <snip>
>
>> --- /dev/null
>> +++ b/include/dt-bindings/gpio/tegra194-gpio.h
>> @@ -0,0 +1,64 @@
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>> +
>
> <snip>
>
> Same as above
>
>> --- /dev/null
>> +++ b/include/dt-bindings/power/tegra194-powergate.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>
> <snip>
>
> Same as above
>
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/tegra194-reset.h
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>
> <snip>
>
> Same as above
>
