Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeBWQQn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:16:43 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46525 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeBWQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:16:41 -0500
X-Google-Smtp-Source: AG47ELu1f76oxIJW8r58CT9kXjX6SiMN4O1bV2HZzGi07sOktZ/PZNft7LqTjrfDPkdwL6OuHvFOxU86eYtPKj2ct7s=
MIME-Version: 1.0
In-Reply-To: <7ba335af-3fc5-2afd-8c52-03dca5eba9a4@rock-chips.com>
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com> <CAHp75Vd27mFnSJTOta0ZWhfOGz1WA8ETNgU_GpuxEJ9nnhsR-g@mail.gmail.com>
 <7ba335af-3fc5-2afd-8c52-03dca5eba9a4@rock-chips.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 18:16:39 +0200
Message-ID: <CAHp75VcthggOwOPjQFNX-xMmK44F99oXYOdeBxfO=euT_JvkoQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org,
        Will Deacon <will.deacon@arm.com>, "xuwei (O)" <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 4:19 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2018/2/23 21:27, Andy Shevchenko wrote:
>> On Fri, Feb 23, 2018 at 8:41 AM, Jaehoon Chung <jh80.chung@samsung.com>
>> wrote:
>>>
>>> 'clock-freq-min-max' property had already deprecated.
>>> Remove the 'clock-freq-min-max' property that is kept to maintain
>>> the compatibility.
>>
>>
>> Removing a property without telling the user what to expect is a bad
>> idea and ABI breakage.
>>
>
> What's the general process to remove a property?
>
> I guess we should do:
> 1) deprecate it in the first place and remove it from all upstream DT
> 2) wait some long enough days for expecting the stale of all old DTB
> containing that property
> 3) remove the functionality of the deprecated property from the driver
> but still leave some warning there
> 4) remove the left warning finally

I don't know. Perhaps Rob can shed a light here.
But I would really OK with removal of some of such properties from
some drivers where it's more burden to keep them.

> And for the ABI breakage, we should add something in Documentation/ABI
> /obsolete  or Documentation/ABI/removed ?

-- 
With Best Regards,
Andy Shevchenko
