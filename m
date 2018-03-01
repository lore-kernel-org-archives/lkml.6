Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031137AbeCAOFE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:05:04 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57046 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030876AbeCAOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:05:02 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w21E4o0h022827
X-Nifty-SrcIP: [209.85.213.48]
X-Google-Smtp-Source: AG47ELt5v5tgCRRr/od/s1IjmJtn7qi4+r6lVvQuTPQFchusfyBA+j/EpeKurlh2b3BZsmB/f1bZTQiF+aW1NvwOfxY=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJKc=-qyeiQuPy_fnEQ0xUV0Cem=5nwjKn-KQrqH_X-ow@mail.gmail.com>
References: <20180228233249.26281-1-robh@kernel.org> <20180228233249.26281-3-robh@kernel.org>
 <CAK7LNAQSJ1uzgmta76rJwDpi08SB5gwcRPxu_TPw0u0XzgGaJA@mail.gmail.com>
 <CAK7LNAT+_0t4PQxW911a0xL-f54WHGbF8t3rEq2Pfngr3J7BOQ@mail.gmail.com> <CAL_JsqJKc=-qyeiQuPy_fnEQ0xUV0Cem=5nwjKn-KQrqH_X-ow@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 23:04:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASCbTg1qSzyBQJ7LXGf1ZPOKZvWrOMXLWA+vc=sDjgHpA@mail.gmail.com>
Message-ID: <CAK7LNASCbTg1qSzyBQJ7LXGf1ZPOKZvWrOMXLWA+vc=sDjgHpA@mail.gmail.com>
Subject: Re: [PATCH 2/6] kbuild: add dtc as dependency on .dtb files
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 22:28 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Wed, Feb 28, 2018 at 11:45 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-03-01 13:33 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>> 2018-03-01 8:32 GMT+09:00 Rob Herring <robh@kernel.org>:
>>>> If dtc is rebuilt, we should rebuild .dtb files with the new dtc.
>>>>
>>>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>
>>>
>>> Hmm, I am not 100% sure about this.
>>>
>>> Is there a case where resulted DTBs
>>> depend on DTC version?
>>>
>>>
>>> If I understand correctly,
>>> DTS and DTB are 1:1
>>> Unlike CC, there is no room for optimization.
>>
>>
>> Maybe I was wrong.
>>
>> Is there room for optimization
>> in 'DT strings' section?
>
> Not sure.
>
>> I guess it is optimized enough to avoid string duplication,
>> but there could be different results
>> without changing the specification.
>
> What I care about is rebuilding so new warnings get emitted especially
> when developing those checks. Right now I have to manually delete the
> dtb files each time.
>

Fair enough.
Probably, it is better to make sure all DTB are compiled
by the latest DTC.

Please go ahead.
Seemed already queued up  :-)


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
