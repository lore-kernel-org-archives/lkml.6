Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeBGQho (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:37:44 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51076 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbeBGQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:37:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180207163739epoutp022a55f9ac88bb469ae8eb876e2f9c867a~RGHmIrGSU1600516005epoutp02h
X-AuditID: b6c32a35-879ff70000001031-6c-5a7b2b53b7aa
Subject: Re: [PATCH 7/8] ASoC: samsung: Add missing #sound-dai-cells
 property documentation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <5d525a1a-b7a7-8b90-97f9-a59c9e361509@samsung.com>
Date: Wed, 07 Feb 2018 17:37:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPc_NUa2worczHpm4VoTY9Do1-Gq4-711kLz7W0qowTeGQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7bCmnm6wdnWUwesfYhZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xcUVX5gc
        eDw2fG5i89g56y67x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbHryzvmgrusFZM/
        zGJpYDzP0sXIySEhYCKx8PdWti5GLg4hgR2MErdOtLNCON8ZJbZffA6U4QCrWnpUDyK+gVHi
        96zHTBDOfUaJVx83s4GMEhaIldiweh4jiC0ioClx/e93sEnMAu+YJM6cusMMkmATMJToPdoH
        VsQrYCex8uIXJhCbRUBV4nPHabBBogIREgunPoWqEZT4Mfke2K2cAsESLxZ+BLOZgRa8+DIJ
        yhaXOHb/JiOELS+xec1bZpDFEgK/2SQunGuBetRFYsaVlewQtrDEq+Nb2CFek5a4dNQWor6f
        UeLEmmZGCGcGo8Sd9glMEA3WEoePX2SF2MAn8e5rDytEM69ER5sQRImHxOS9X6DmO0osfdgH
        DaIOJonnrxYxT2CUm4XkoVlInpiF5IlZSJ5YwMiyilEstaA4Nz212LDAUK84Mbe4NC9dLzk/
        dxMjOBVpme5gnHLO5xCjAAejEg+vwYbKKCHWxLLiytxDjBIczEoivO7s1VFCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeQMCXKKEBNITS1KzU1MLUotgskwcnFINjGw96nq3PY4kp59fwprj2bY6
        duOlJPO4oqs3nn95F3QhNPtxhPfydesldy2seO55/93Ln7M1jWZ4N8w8t9Gs913TjFfFOuzR
        M2vEXzP1HFs1MXbdvLol6lHvDYweazU/SbLbVPHCb4Zz6ZUMt+WSVYquDyYrfDzUI1E0YeWi
        nQoiazaWfT1d/U+JpTgj0VCLuag4EQAUtrJ7QQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e+xoG6wdnWUwc//LBZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xcUVX5gc
        eDw2fG5i89g56y67x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbHryzvmgrusFZM/
        zGJpYDzP0sXIwSEhYCKx9KheFyMXh5DAOkaJHx/ms0E4DxklFp86wghSJCwQK/H+m1UXIyeH
        iICmxPW/31lBapgF3jFJHJh1kRmioYtJov/hUnaQKjYBQ4neo32MIDavgJ3EyotfmEBsFgFV
        ic8dp9lAbFGBCInOlfNZIGoEJX5MvgdmcwoES5x5tZoJZDGzgLrElCm5IGFmAXGJY/dvMkLY
        8hKb17xlnsAoMAtJ9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93
        EyMwarYd1urbwXh/SfwhRgEORiUe3o5NlVFCrIllxZW5hxglOJiVRHjd2aujhHhTEiurUovy
        44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamDMsY6Yu5z53YqlwWuUbsp1
        Skx7JJCvb1hayz7z5nO9hZ0Jv1SqDLZOPVMq07Xk6/Tp2w63tay25hVuPxy6TUNwtuSvbSGJ
        h0/ul93b9PT/q/tOfOaylU8etp6Zw2Ed4hCs9CKEX8w3kW+ZjvCzgr8Ho9Jqwpc23jB30vdo
        3fPQxr2t+P7U/7uVWIozEg21mIuKEwGTGcbalgIAAA==
X-CMS-MailID: 20180207163739epcas1p40a5a43500b10892c5e8f49ca48692a63
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d
X-RootMTR: 20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d
References: <CGME20180205154533epcas2p2d0ed58188cf7f29751c08cd804f6fb0d@epcas2p2.samsung.com>
        <20180205154403.13520-1-s.nawrocki@samsung.com>
        <20180205154403.13520-8-s.nawrocki@samsung.com>
        <CAJKOXPc_NUa2worczHpm4VoTY9Do1-Gq4-711kLz7W0qowTeGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 02:02 PM, Krzysztof Kozlowski wrote:
> On Mon, Feb 5, 2018 at 4:44 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> The #sound-dai-cells property might be helpful in selecting primary
>> or secondary CPU DAI and it's already present in i2s nodes for some
>> exynos SoCs so let's add it to the DT binding documentation.
>
> The description above looks like you are documenting existing optional
> property but you added it as a required property.

Actually, it would be better to have it as a required property, but
that could be done with any new device bindings. For the exisitng ones 
I will move this property to the "Optional SoC Specific Properties"
paragraph.

-- 
Regards,
Sylwester
