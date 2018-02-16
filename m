Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935378AbeBPLN7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:13:59 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:35790 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934388AbeBPLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:13:57 -0500
Subject: Re: [RESEND] phy: sun4i-usb: add support for R40 USB PHY
To: Chen-Yu Tsai <wens@csie.org>
References: <20180103084944.3145-1-icenowy@aosc.io>
 <20180115150656.bibc4draok4i4oae@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64DuqTv49CfOMhovdikc9iUGCfLRSmJ+FEeF5ct+-YzEw@mail.gmail.com>
 <993f82ad-befe-05fb-351d-8fd31d8bc132@ti.com>
CC: Icenowy Zheng <icenowy@aosc.io>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e5bcd7dd-1545-189f-82b1-efb77422b936@ti.com>
Date: Fri, 16 Feb 2018 16:43:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <993f82ad-befe-05fb-351d-8fd31d8bc132@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 19 January 2018 01:43 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 19 January 2018 11:55 AM, Chen-Yu Tsai wrote:
>> Hi Kishon,
>>
>> On Mon, Jan 15, 2018 at 11:06 PM, Hermann Lauer
>> <Hermann.Lauer@iwr.uni-heidelberg.de> wrote:
>>> On Wed, Jan 03, 2018 at 04:49:44PM +0800, Icenowy Zheng wrote:
>>>> Allwinner R40 features a USB PHY like the one in A64, but with 3 PHYs.
>>>>
>>>> Add support for it.
>>>>
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>
>>> You may add
>>>
>>> Tested-by: Hermann.Lauer@iwr.uni-heidelberg.de
>>
>> Gentle ping for this patch to be included in 4.16
> 
> Sent the pull request for 4.16 to Greg on Jan 2nd. So this can't be included in
> 4.16. Sorry.

merged now, thanks!

-Kishon
