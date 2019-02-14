Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9762082F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436904AbfBNLih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:38:37 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbfBNLhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:37:35 -0500
Received: from [192.168.1.110] ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3loZ-1guWJV1UVH-000q61; Thu, 14 Feb 2019 12:37:30 +0100
Subject: Re: APUv2/v3 board support V2
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <1550091448-28578-1-git-send-email-info@metux.net>
 <CAHp75VeZSrxoxd298eFiJj-N_MRsCXa2GEAXry5jCUi6twt_Xg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fadb3559-d397-04c9-1bdd-e4d625cce278@metux.net>
Date:   Thu, 14 Feb 2019 12:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeZSrxoxd298eFiJj-N_MRsCXa2GEAXry5jCUi6twt_Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oZwD5K37zGoeWL+XfiDckMfFZdrdCHkrhTVewqRTm5ADJ4EZRo3
 GZXcCa9xGdIknAYfj38tFr8fheqBGgm34P3xafx+NM2ZML/oy1lDBalRVCIhAtPk4D1KZeT
 mzA40Aubbjda5SGyOmiU8ozHzZcSBxwm26NIsUTw29hbNLL4murrL5EEWnKY7iVXEkQqs45
 cp6NFgi56breEIE7J3AUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ANXJI/8w6v4=:7v2GrXRdNZC+AQRtbVmgVg
 zhWTBx/Jzoy64IxmBWSANX+VCV4bEEN3SdCUd7XZKGQ3ktDnSScZg8lzqgDoZnXFMYcT3kf6T
 JNixvLC5DrjCWDxNGuJ+9qWVlv0wDVdcul63POqauxVTZgY1bsdjmRGUmBUQTyp3ptRCNGWPA
 htNt7KyYGdnnPs2eNX6hon83lrzE2z4uhlWRklttHRlC+X/weIv1E0XZQzkcX2vazc7irzKy5
 M/9gt+R0uwYl8UgyVftYiQvt0Yy54cUvYyiD3MZOUnHWS8/zJLVVTlSnHCTZCQEzcYO/bnNLj
 Ksp1oJ51EuiAUQOPgp3SPRCF/OnYczAWqMeTITQSAAOfzLCconXVuByEdMr6kyPignAXRKW8w
 aY9izn+vh+5wJn2WiDFZAaBTS8gpOzbGnd4i5RxzdJ/MG88gBV6Jrv9RHttXrhvWmWpi9nTNd
 NA9t9B/HvHymEsxqMdP5xdoulqNF3Gb5TGgeu7ah8E1nCOBs20AZ4W7/GkLpArq/fzScJX+Lo
 TZkG04Uqg/yfrP/BgVAk8Peofx8ghNKp+WBGno/HjpVn434N6vDiogVFvdeFltLsZVJoggK++
 7XR0RAlrvnWR0J3DYc88RIQNY3vLVVSFe7moMPlDDuv9c9g+wkdB7VoLsDOeiVTGD+jh1v8ay
 dE5fSKZWj10Xvzpy5m0ugKJoQf665CF9i8d4rEA/EIFWjF47R6wsZ4knf1O4r4s8TzFL92l0Y
 BdD1hQu2+sfaxFVVQxHjLKuWEJlzFVw9TzofDVrGU7GsMvzKa+YGP0cXX9c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.19 03:17, Andy Shevchenko wrote:

Hi,

> I dunno how you created this message, I hope you used --cover-letter
> parameter to git-format-patch.

I'm using: git send-email --compose <...>

> Just don't forget to add -v<N>, where <N> is version.

hmm, git send-email doesn't seem to have a corresponding flag :(


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
