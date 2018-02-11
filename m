Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeBKLRW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:17:22 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41555 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBKLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:17:20 -0500
X-Google-Smtp-Source: AH8x226CNmaTFq1hFNpPsV4OseiGbyWNJPQDypi4oQik5Mg6d0OWRl34vzDRrz3srNgtJUSdgxsx9g==
Subject: Re: [PATCH v2 5/7] watchdog: mtk: allow setting timeout in devicetree
To: Sean Wang <sean.wang@mediatek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20180210091911.3644-1-marcus.folkesson@gmail.com>
 <20180210091911.3644-5-marcus.folkesson@gmail.com>
 <1518261002.9025.36.camel@mtkswgap22> <20180210124328.GB744@gmail.com>
 <20180210201207.GC744@gmail.com>
 <5449674d-2812-c9b5-9c06-af2fbfa72737@roeck-us.net>
 <1518335184.9025.43.camel@mtkswgap22>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <80a95963-7bd9-a350-d899-3b0cf2d646fc@roeck-us.net>
Date: Sun, 11 Feb 2018 03:17:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518335184.9025.43.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 11:46 PM, Sean Wang wrote:
> On Sat, 2018-02-10 at 17:52 -0800, Guenter Roeck wrote:
>> On 02/10/2018 12:12 PM, Marcus Folkesson wrote:
>>> Hello Sean,
>>>
>>> On Sat, Feb 10, 2018 at 01:43:28PM +0100, Marcus Folkesson wrote:
>>>> Hello Sean,
>>>>
>>>> On Sat, Feb 10, 2018 at 07:10:02PM +0800, Sean Wang wrote:
>>>>>
>>>>> Hi, Marcus
>>>>>
>>>>> The changes you made for dt-bindings and driver should be put into
>>>>> separate patches.
>>>>
>>>> I actually thought about it but chose to have it in the same patch because I
>>>> did not see any direct advantage to separating them.
>>>>
>>>> But I can do that.
>>>> I will come up with a v3 with this change if no one thinks differently.
>>>>
>>>
>>> When looking at the git log, I'm not that convinced it should be
>>> separate patches.
>>>
>>> For example, I found a4f741e3e157c3a5c8aea5f2ea62b692fbf17338 that is
>>> doing the exact same thing as this patch.
>>>
>>> There is plenty of patches that mixes the code change and dt bindings
>>> updates.
>>> Could it not be useful to overview both the implementation and
>>> dt-mapping change in one view?
>>>
>>> If you or anyone else still think it should be separated, please let me know and I will
>>> come up with a v3.
>>>
>>
>> If we were talking about something new, specifically new and unapproved DT bindings,
>> it should be separate patches. However, that is not the case here. The DT bindings
>> are well established. Sure, we could be pedantic and request a split into two
>> patches. However, the only benefit of that would be more work for the maintainers,
>> ie Wim and myself (including me having to send this e-mail). I don't really see
>> the point of that.
>>
>> I have already sent my Reviewed-by:, and I don't intend to withdraw it.
>>
> Hi, both
> 
> Sorry for that if I caused any inconvenience to you. I didn't really
> insist on if the patch is needed to split into two, which totally
> depends on whether dt maintainers like it.
> 
> The change for dt-binding is usually added as a split patch with
> dt-bindings as a prefix. This way I thought dt maintainers is not
> easy to miss those patches and also can give some useful feedback
> for them.
> 

With all the trouble this one-line change is making, I feel inclined to drop
the patch for this driver.

Guenter
