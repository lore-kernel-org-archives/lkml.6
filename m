Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932922AbeBLJTd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932955AbeBLJTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:19:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69FD21779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x227Rdmb6rTLdX1nQT5B8EPSkdxkE6sLQ+xdBh8NJzI3UKhLghULsOrs5B7ZgFJii7EF+CgQjBaeE1QpC3IccupY=
MIME-Version: 1.0
In-Reply-To: <67a9f473-0eba-b3d0-ae92-5602658b6958@samsung.com>
References: <CGME20180205154537epcas1p10a9a30a574e3f472358e7dacf3cb0489@epcas1p1.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com> <20180205154403.13520-9-s.nawrocki@samsung.com>
 <CAJKOXPeRFgJQpUTeJeYYo+qqAxkT1iZczSJQzRzn3O3bXmvOZA@mail.gmail.com> <67a9f473-0eba-b3d0-ae92-5602658b6958@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 12 Feb 2018 10:19:27 +0100
X-Gmail-Original-Message-ID: <CAJKOXPezeWHCaHz1PY03_nTFxb0qOCsgPtNjfMC4id0DsrFLqA@mail.gmail.com>
Message-ID: <CAJKOXPezeWHCaHz1PY03_nTFxb0qOCsgPtNjfMC4id0DsrFLqA@mail.gmail.com>
Subject: Re: [PATCH 8/8] ASoC: samsung,tm2-audio DT binding documentation update
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 5:31 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 02/06/2018 02:05 PM, Krzysztof Kozlowski wrote:
>> On Mon, Feb 5, 2018 at 4:44 PM, Sylwester Nawrocki
>> <s.nawrocki@samsung.com> wrote:
>>> This patch documents additional entries of the audio-codec and
>>> i2s-controller properties required for the HDMI audio support.
>>>
>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> ---
>>>  .../devicetree/bindings/sound/samsung,tm2-audio.txt        | 14 +++++++++-----
>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>>> index 94442e5673b3..f5ccc12ddc00 100644
>>> --- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>>> +++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>>> @@ -4,9 +4,13 @@ Required properties:
>>>
>>>   - compatible           : "samsung,tm2-audio"
>>>   - model                : the user-visible name of this sound complex
>>> - - audio-codec          : the phandle of the wm5110 audio codec node,
>>> -                          as described in ../mfd/arizona.txt
>>> - - i2s-controller       : the phandle of the I2S controller
>>> + - audio-codec          : the first entry should be phandle of the wm5110 audio
>>> +                          codec node, as described in ../mfd/arizona.txt;
>>> +                          the second entry should be phandle of the HDMI
>>
>> AFAIU, this property is still optional so the wording should be
>> different. Maybe just add "optional properties" paragraph?
>
> I'd like to keep the second entries required in the documentation,
> and the driver would still be handling the case with just single
> entries.

I understand.
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
