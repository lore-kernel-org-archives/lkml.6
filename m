Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeEOQCO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:02:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56002 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbeEOQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:02:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180515160205euoutp01dc022edb764f3e013df2657c8760b30f~u3NOmjWgO0895308953euoutp01I
X-AuditID: cbfec7f5-b45ff700000028a9-ce-5afb047c9e5a
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: exynos: fix type of thermal trip points for
 Exynos7
Date: Tue, 15 May 2018 18:02:02 +0200
Message-id: <66371602.d1UHUK4g0h@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87o1LL+jDHZuE7F4MG8bm8X58xvY
        LTY9vsZqcXnXHDaLz71HGC1mnN/H5MDmsWlVJ5vH5iX1Hn1bVjF6fN4kF8ASxWWTkpqTWZZa
        pG+XwJXx+9kxpoKXLBUtHRtZGxg/MncxcnJICJhIrD/8jKWLkYtDSGAFo8SPd01gCSGBz4wS
        i1bGwBTdeD6dBSK+jFHi8IpyiIbfjBKt9+ewgSTYBKwkJravYgSxRQQ0Ja7//c4KUsQscI1R
        4unE/2DdwgJhElv77oMVsQioSpyYshrM5hXQkjjXdJEVxBYV8JLYsq+dCcTmFAiW6P+7kBWi
        RlDix+R7YHOYBeQl9u2fygph60icPbaOEWSZhMAaNomDh6awQZztIvHg4A12CFtY4tXxLVC2
        jERnx0EmiIZmRolvO/ZAA2MCo8Se9UIQtrXE4eMXoTbwSUzaNh2ohgMozivR0QZV4iFxefEr
        VgjbUWL6843MkGA5wiix4EAT8wRG2VlIDp+F5PBZSA5fwMi8ilE8tbQ4Nz212DgvtVyvODG3
        uDQvXS85P3cTIzAlnP53/OsOxn1/kg4xCnAwKvHwVl7/FSXEmlhWXJl7iFGCg1lJhHe30c8o
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxxGnVRQgLpiSWp2ampBalFMFkmDk6pBsbbGk4q97dN
        Obbj3XGh9hxn++WvN4a2RlReL9LPfFv34MRcw/N8c/p13A6+bK6/t75khbP74t2s/AFfnXa1
        Rnn2TL3ZJ/rGS/TxRw7h9osL+K3mymvtmJByOe/9r+g7VvxP+DUZts3JijRRaffe9H3/zdnW
        Jw5/zupKc5z9/UB/Vtga7y1yy+yUWIozEg21mIuKEwFKCUU/BQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xa7rVLL+jDB7OV7B4MG8bm8X58xvY
        LTY9vsZqcXnXHDaLz71HGC1mnN/H5MDmsWlVJ5vH5iX1Hn1bVjF6fN4kF8ASxWWTkpqTWZZa
        pG+XwJXx+9kxpoKXLBUtHRtZGxg/MncxcnJICJhI3Hg+naWLkYtDSGAJo8SSrQfYIJy/jBJv
        TzewgVSxCVhJTGxfxQhiiwhoSlz/+50VpIhZ4BqjxIUX91hAEsICYRJb++6DFbEIqEqcmLIa
        zOYV0JI413SRFcQWFfCS2LKvnamLkYODUyBYYs8jTohlxxglTjy6wQpRLyjxYzLETGYBeYl9
        +6eyQthaEut3HmeawMg/C0nZLCRls5CULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY
        uNuO/dy8g/HSxuBDjAIcjEo8vBXXf0UJsSaWFVfmHmKU4GBWEuHdbfQzSog3JbGyKrUoP76o
        NCe1+BCjNAeLkjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVANjyYNzonuDv5k9dnBkvda8Yd15
        zY069o6mrw7uzJp25R57v9nT1ad+acvueHBaV+PFIusd5QnFU+90iW8rl89ddzzEtid0y3vB
        Leev+Hb47jcPW/ptffqXipVPWt66Mj9ZsUiy+1dk8M15ddeX8Ryf/acgRFqnmMu49Y/l46dZ
        O6w6jvJxO3ZdVGIpzkg01GIuKk4EAPg5TQ1YAgAA
X-CMS-MailID: 20180515160203eucas1p1a5cc7f7a797a31aef0ab764736c941df
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1
X-RootMTR: 20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1
References: <CGME20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1@eucas1p2.samsung.com>
        <1702366.qL959G52Hi@amdc3058>
        <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 15, 2018 02:59:33 PM Krzysztof Kozlowski wrote:
> On Tue, May 15, 2018 at 2:37 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > Currently Exynos thermal driver treats as "active" all specified
> > trip points before reaching maximum number of hardware supported
> > trip points.
> 
> The trip point type describe the way how system should act - use
> active or passive cooling. It is independent of thermal driver. I do

OK, I see it now. Please disregard this patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
