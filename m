Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeC0Ig4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:36:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54407 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeC0Igv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:36:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180327083648euoutp02f2ad8f609f73aa96dbddbc79ef7b67f0~fuhdVXSko2490224902euoutp02I
X-AuditID: cbfec7f2-1dbff70000011644-16-5aba029da44b
Subject: Re: [PATCH v6 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder
 driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <8115587a-4925-5602-43db-4285a3de7b0e@samsung.com>
Date: Tue, 27 Mar 2018 10:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVWJhmxXS+mvuwjrCOzurArFurqKwQ2PJD-eRCqbLRAng@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed7bXsXJ40x2SOmyLlakZhd4IRO7fHgJoiI/yMJq5uul6ZTN
        SxbpUqpp2f2Cy9JIMawwNbecDGtaQ0zNVniBVMLUWSvIZopZOV8iv/2e//mfc/4HHpaU6ZnF
        bLImQ9BqVCkKxpsyvZruCrlDWJQbbp1eyxV3thFcvsFFc2WtnTT3zv2N4Ub6rQRX0OBGnH3m
        sYQrvFIh4RyWUoZrcH4luKGHLoar7OkmOPvNizR3xtoq4V5X90u4kecmJgrzj+4+QrzjYjHB
        D934Q/CNxg8S/rahhOb/9H4k+brqQoa3tRgQb54covnB83aCb3LnI37U8ZPhS6cnKX6ibsk+
        X6V3RLyQkpwlaMMij3gn9Xw0StKd+LjjZgGtR00+RciLBbwZfs0OoCLkzcrwAwRTthe0+PiB
        4OWXWtrjkuEJBFdH6X8d1TMOiahXIegpUYvsQmC/k1SEWNYf74VfjYwHF+EQKJ0mPCNJPEXD
        /ZJC0mNn8FqYre9jPCzFkTA82014mMKr4PF457wegGPg3o1PSPT4QVvJMOVhL7wfpq73zMch
        8VIwu0pJkeXQP1w2vwzwMxbMFYPzIQDvgjprghjfH8btTyUiB0H7tQuUyCehbyyfEnsNCAZn
        zjFiYSu02LtpzxxyLnSNJUyUt4HJPUCL432h1+UnRvCFq6ZbpChLwXBWJrqXw2BHAymyHCrf
        uJnLaIVxwWHGBccYFxxj/L+3HFHVSC5k6lITBV24RsgO1alSdZmaxNCjaal1aO5ftv+2f3+G
        3G/jbAizSOEjjWIalTJalaXLSbUhYEnFIqm6ck6SxqtyTgjatMPazBRBZ0OBLKWQSw+tyVXK
        cKIqQ1ALQrqg/VclWK/FenRyZXRcwICt/n3MmrFzCk1xc9iTaKu7/BhvCbbWWLOD17OV+pE9
        uX6ntsc6V6tzzQd2hUfVmi59rjq/I+Cyunh/Rs1Aolm9LehnwXjegWVbiiIT8jaaYy0H5c5I
        Z1dzYGvcpu9fOi6dHlIGNOV9jQikQpt2jkf36YPSzOrdjXt3tCkoXZIqfB2p1an+AlMKMVGT
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYRzGec/ZOTuKk9PUfPHCbNiHkdM5l+/UzIsuToZYRCWG2NCDmm7T
        nfkVRH6Q6EJJMsU5NMpdtJRgNU1NkGmOYVm2SBM0MVOsNMg0PzPnCnb343me38Uf/hQubCAC
        qGyVltWoFLki0pM3/Mc2FarHelLCq6xyVDNix1B51SKBWgdHCPR+5QeJ5ib6MFRhWQHIttnB
        R9V1bXzk6DGQyLKwhKHpx4skMo6NYsjWUEugW32DfPTKNMFHc/2dZDzNtLe0A8ZRW4Mx0/d2
        MKZbP8lnmquaCGZnfAZnzKZqkrEOVAGma3WaYD7dtmFM70o5YOYdv0nGsL7KY5bNgee8U8Sx
        GnWBlg3KUnPak6IrEhQhlsiROCJSLpZIo1KjI2SisLjYDDY3u5DVhMVdFWeNzej5eQt0saOh
        gigFvV464EFBOhKaNh18HfCkhLQRwM75LZ6r8Ie9rYu4i33g1gcd6Rp9A/DtjrOgKB86ES5M
        +jvRlw6FhnXMOcHpLQLulJowpyuka3D4YjvQySQdAreffiSdLKDj4Oz26N6GRx+CHV9H9nI/
        OhlWP2rluTb7oL1pdo896PNwrX6McDJOH4FbLe9wFx+AXYuGf+wPJ2ZbsTtAqHfT9W6K3k3R
        uyn3Ac8EfNkCTpmp5CLEnELJFagyxelqpRns/kTn0Pqz50C3dMEKaAqIvARrP7tThISikCtR
        WgGkcJGvIMe4GwkyFCXXWY06TVOQy3JWINs9rg4P8EtX736YSpsmkUmikFwSJY2SnkAif8Gb
        8JIUIZ2p0LI5LJvHav57GOURUAqMjWUJjZK7U3NfujcOnvG0TP9qj2m8VPp64cbA8PHoCWxZ
        Jrz2Pd+nsOxh8+GhoPGkgGFYdBa3Z/u+1BkfBEsVjf35iQ1FOWM+NsPFtfiBozmfM4pnBJXe
        G0pt+E10KrWtvnKpOvlJ8LJMrjptsO9PLrkcm1QTnKDlWcz2EEGMiMdlKSTHcA2n+Av2hjB2
        KQMAAA==
X-CMS-MailID: 20180327083644eucas1p1ed53c7e19aaad8c8befebff1a191aed9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180327083644eucas1p1ed53c7e19aaad8c8befebff1a191aed9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f
X-RootMTR: 20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
        <1521213399-31947-3-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f@epcas5p3.samsung.com>
        <30381869-9bc8-b6aa-a37a-598d9c8f280d@mentor.com>
        <df124c8f-7c71-7941-9969-977dd19c7d1b@samsung.com>
        <CAMuHMdVWJhmxXS+mvuwjrCOzurArFurqKwQ2PJD-eRCqbLRAng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.2018 09:36, Geert Uytterhoeven wrote:
> Hi Andrzej,
>
> On Tue, Mar 27, 2018 at 9:28 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>>> +static void thc63_enable(struct drm_bridge *bridge)
>>>> +{
>>>> +    struct thc63_dev *thc63 = to_thc63(bridge);
>>>> +    struct regulator *vcc;
>>>> +    int i;
>>> unsigned int i;
>> Why? You are introducing silly bug this way, see few lines below.
>>
>>>> +
>>>> +    for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
>>>> +            vcc = thc63->vccs[i];
>>>> +            if (!vcc)
>>>> +                    continue;
>>>> +
>>>> +            if (regulator_enable(vcc))
>>>> +                    goto error_vcc_enable;
>>>> +    }
>>>> +
>>>> +    if (thc63->pdwn)
>>>> +            gpiod_set_value(thc63->pdwn, 0);
>>>> +
>>>> +    if (thc63->oe)
>>>> +            gpiod_set_value(thc63->oe, 1);
>>>> +
>>>> +    return;
>>>> +
>>>> +error_vcc_enable:
>>>> +    dev_err(thc63->dev, "Failed to enable regulator %s\n",
>>>> +            thc63_reg_names[i]);
>>>> +
>>>> +    for (i = i - 1; i >= 0; i--) {
>> Here, the loop will not end if you define i unsigned.
> True.
>
>> I know one can change the loop, to make it working with unsigned. But
>> this clearly shows that using unsigned is more risky.
>> What are advantages of unsigned vs int in this case. Are there some
>> guidelines/discussions about it?
> Some people consider signed integers harmful, as they may be converted
> silently by the compiler to the "larger" unsigned type when needed.

Wow, it sounds crazy, shall we expect gigantic patchsets, converting all
occurrences of int to "unsigned int" ? :)
I know both types have their pros and cons and can behave unexpectedly
in corner cases, but I do not see why unsigned should be preferred over
signed in general, or in this particular case.
I guess there were somewhere discussion about it, could you point me to
it if possible, to avoid unnecessary noise in this thread.

Regards
Andrzej

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
