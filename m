Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBHPFl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:05:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13513 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750929AbeBHPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:05:39 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Philippe Ombredanne <pombredanne@nexb.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, "Heiko Stubner" <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Mickael REULIER <mickael.reulier@st.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
Thread-Index: AQHTk9kKuHanPDlyuEWBuDIkKLGSi6OBMJ4AgADbsQCAGJj6gf///qOA
Date: Thu, 8 Feb 2018 15:05:03 +0000
Message-ID: <58c9435f-a0ca-d59f-c316-ea13f442b539@st.com>
References: <20180122102608.12565-1-philippe.cornu@st.com>
 <3169703.7pajs7FEnH@avalon> <2bf185e2-9b02-3632-dc9a-baf8f4109b44@st.com>
 <2205915.z0ubSpqczI@avalon>
 <CA+M3ks4kCpcNfd1NyVLDtPOKmDniteXw2-iUqUikeicRdRAa6A@mail.gmail.com>
 <CAOFm3uFZeMNBGnvAtPMiMMXuV-3tFTbxH-Y1cv-hAgZ4dUmA=A@mail.gmail.com>
In-Reply-To: <CAOFm3uFZeMNBGnvAtPMiMMXuV-3tFTbxH-Y1cv-hAgZ4dUmA=A@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D75428059041EB48B170A37EFEFCF3C3@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w18F5jux007002

Hi Laurent, Benjamin & Philippe,

I sent an updated version of the patch following your comments
Big thank you,

Philippe :-)

On 02/08/2018 03:09 PM, Philippe Ombredanne wrote:
> Benjamin,
> 
> On Wed, Jan 24, 2018 at 9:57 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>> 2018-01-24 0:32 GMT+01:00 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
>>> Hi Philippe,
>>>
>>> On Tuesday, 23 January 2018 12:25:51 EET Philippe CORNU wrote:
>>>> On 01/23/2018 12:30 AM, Laurent Pinchart wrote:
>>>>> On Monday, 22 January 2018 12:26:08 EET Philippe Cornu wrote:
>>>>>> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
>>>>>> host controller driver.
>>>>>>
>>>>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>>>>> ---
>>>>>>
>>>>>>    drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>>>>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>>>> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
>>>>>> 46b0e73404d1..e06836dec77c 100644
>>>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>>>>> @@ -1,12 +1,8 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>
>>>>> According to Documentation/process/license-rules.txt this would change
>>>>> the existing license. The correct identifier is GPL-2.0+.
>>>>
>>>> You are right, I did not put the correct identifier :(
>>>>
>>>> After reading more spdx.org, I wonder if the correct value should be
>>>> GPL-2.0-or-later instead of GPL-2.0+
>>>>
>>>> https://spdx.org/licenses/GPL-2.0-or-later.html
>>>> https://spdx.org/licenses/GPL-2.0+.html
>>>>
>>>> What is your opinion?
>>>
>>> I agree in principle, and I've even asked for that before, but I've been told
>>> that we should stick to the license identifiers defined in Documentation/
>>> process/license-rules.txt. The file might get updated to use GPL-2.0-or-later
>>> and GPL-2.0-only later, and kernel sources will likely then get patched in one
>>> go.
>>
>> + Philippe O. to check what I'm writing just below.
>>
>> In -next branch I only see reference to GPL-2.0+ identifier so for me
>> it fine to use it here.
>> Is that right ? or should we use GPL-2.0-or-later keyword ?
> 
> 
> Sorry for the late reply!
> IMHO it is essential to stick to what is in the kernel doc, meaning
> that you should not use the GPL-2.0-or-later identifier until it is
> part of the kernel doc. Otherwise this is going to be a mess ;)
> Consistency matters a lot.
> 
