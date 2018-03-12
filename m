Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeCLJHi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:07:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32885 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeCLJHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:07:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180312090732euoutp020e58f91ed8286cfa0587c08bab02dbcb~bIRAZWzKd2598725987euoutp02X
X-AuditID: cbfec7f4-713ff700000043e4-67-5aa6435268ae
Subject: Re: [PATCH v2 0/3] drm: Add LVDS decoder bridge
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <81b25fde-63fa-aacc-1bf4-f2a7b60b19ef@samsung.com>
Date: Mon, 12 Mar 2018 10:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0yNYRz2fvfT+vI6Lv3mduYQYirm8jbkOvvGHxlmnE069K2aOjifcl0j
        0nGpuSUdIVMHBytdRMbmhLNczkqGGsol96NNF5LQOd8x/ff8nuf5vb/n2V6B1naxA4V40wbZ
        bDIm6Dk/5srdDte4RXNshrDPdVqS4aqiSKrFzZJTt10sedzWzJF39TcosrOsDRFn5yWe7DmY
        z5PailyOlH38SpHGC26OFDytoYjzaCZL0m7c5skDez0/s7d08eRFJNVmZlBSY9YfSrpmfcFL
        xy05rPTn2WtaKrbv4SRHpQVJ5e2NrNSwz0lJ72u/c1JuRzsjtRQPXSga/KbFyAnxybI5NCLa
        L66j0EGtax60qbA6nduOXvXfizQC4Ilw/d0vdi/yE7T4HAJb/ilKHVoR/M4+w6hDCwL7iQL+
        30pReSWvCmcRdH6y+VxuBEfSPI9phL6YwLHKq16hH75EQVXzD+9A41QEj6p20h4Xh4Ohq6SO
        82ARR0BN2hPvNoOD4GfLT6+nP14Gp7OakOrpA1U5bxkP1uD5sCv/mtdDYx2Uu3N9OBDq36ot
        AJ8XIMOeSanB50JrSQmj4r7wyVnqKzQY7h/e7+O3Qt2HVEZdtiBo6EznVGEqVDprutMJ3ReC
        obAiVKWnQ/mbLNpDAw6AZ+4+aoYAOHQl20eLYNmtVd3DoOFhGa3iQCiobuMOoOHWHs2sPdpY
        e7Sx/r+bhxg7CpSTlMRYWZlgkjeGKMZEJckUG7J6bWIx6v6U9387W6+iil+rHAgLSO8vHisu
        MGhZY7KyOdGBQKD1/cTnwTaDVowxbt4im9euNCclyIoDDRIYfaAYNTrFoMWxxg3yGlleJ5v/
        qZSgGbgdRZ1ImJOGn2xsDTv4XRO03mXS8SGph3tvW159+ea8GRGRk1Py5DulQaGzRsVPeVlP
        WPHC4BFxUdHpkUrTlJhb31zncvyN4fdsyWKvJQtofkDEyK6bX2bHHNI3RQ5paQ8YMGlG9MmO
        sXjxtLDqolhdkc7uv6J0R95SRRueErYwnPmh0zNKnHH8GNqsGP8CDwZhNpADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t/xe7qBzsuiDM4/4bLoPXeSyaKp4y2r
        xfwj51gtrnx9z2bx7NZeJovmrV8ZLY7/Xstu0TlxCbvF5V1z2Cy2vnzHZPFg9Vs2i6XXLzJZ
        HJ/Wx2rRuvcIu8WZVbfYHfg91sxbw+hxua+XyePB1P9MHjtn3WX3mN0xk9Xj/41HzB6bVnWy
        eRw63MHosf3bA1aP+93HmTyeX/7O5jHn5zcWj8+b5AJ4o/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyfq4/xFTwXrpi/YV2tgbGh6JdjJwcEgIm
        Ehu2H2bvYuTiEBJYyijxZ8NBFoiEuMTu+W+ZIWxhiT/Xutggil4zSrRMmMcKkhAWsJCYcXgH
        C0hCRGAtk8STIwuYQRxmgSZGiQmzPzFBtMxllNj/4hTYLDYBTYm/m2+ygdi8AnYSF1uvgY1i
        EVCV+PX5F1iNqECEROfK+SwQNYISJ2c+AbM5BbwkWpbsBKthFlCX+DPvEpQtL7H97RwoW1zi
        1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECEwN2479
        3LyD8dLG4EOMAhyMSjy8MzYtjRJiTSwrrsw9xCjBwawkwntHc1mUEG9KYmVValF+fFFpTmrx
        IUZToOcmMkuJJucD01ZeSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5O
        qQZG30qjX6ctQnS8b6yf6iP1wernoyqXV1fEP87genov6Lkdg0KZYErUHqmN+wyF933uvqPE
        6yQStWqd58HuBWI1cks4O75En1/l2hoaK20q/UmA5927KXsW5zDpffj7Pa9Zd9v+4Kxds99O
        4Vf1+TKtIjBDd3Uab6FcoMcBp60z9Zh1NNdPmHhOiaU4I9FQi7moOBEAjC5YvSMDAAA=
X-CMS-MailID: 20180312090729eucas1p2b99da69a20b0a29d72fdfa261c826945
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180312090729eucas1p2b99da69a20b0a29d72fdfa261c826945
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b
X-RootMTR: 20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b
References: <CGME20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b@epcas3p3.samsung.com>
        <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.2018 14:51, Jacopo Mondi wrote:
> Hello,
>    after some discussion on the proposed bindings for generic lvds decoder and
> Thine THC63LVD1024, I decided to drop the THC63 specific part and just live with
> a transparent decoder that does not support any configuration from DT.
>
> Dropping THC63 support to avoid discussion on how to better implement support
> for a DRM bridge with 2 input ports and focus on LVDS mode propagation through
> bridges as explained in v1 cover letter (for DRM people: please see [1] as why
> I find difficult to implement support for bridges with multiple input endpoints)
>
> Same base branch as v1, with same patches for V3M Eagle applied on top.
> git://jmondi.org/linux v3m/v4.16-rc3/base
>
> Thanks
>    j
>
> v1 -> v2:
> - Drop support for THC63LVD1024
>
> [1] I had a quick at how to model a DRM bridge with multiple input
> ports, and I see a blocker in how DRM identifies and matches bridges using
> the devices node in place of the endpoint nodes.
>
> As THC63LVD1024 supports up to 2 LVDS inputs and 2 LVDS outputs, I see only
> a few ways to support that:
>  1) register 2 drm bridges from the same driver (one for each input/output pair)
>     but they would both be matches on the same device node when the preceding
>     bridge calls "of_drm_find_bridge()".
>  2) register a single bridge with multiple "next bridges", but when the bridge
>     gets attached I don't see a way on how to identify on which next bridge
>     "drm_bridge_attach()" on, as it depends on the endpoint the current bridge
>     has been attached on first, and we don't have that information.
>  3) Register more instances of the same chip in DTS, one for each input/output
>     pair. They gonna share supplies and gpios, and I don't like that.
>
> I had a quick look at the currently in mainline bridges and none of them has
> multiple input endpoints, except for HDMI audio endpoint, which I haven't found
> in use in any DTS. I guess the problem has been already debated and maybe solved
> in the past, so feel free to point me to other sources.

I think this is is a step in wrong direction, IMHO. Your previous
patchset was quite OK, at least bindings, IMHO. Few things needed only
polishing.
Here we have unmanaged/transparent bridge, which is totally different,
what happened to regulators and gpios from previous iteration.
I do not have schematics of the board, but I guess respective pins of
the bridge must be connected somehow.
I think the problem you want to avoid (double bridge) should not be a
problem at all.
I suppose the most important is to have correct bindings - as they need
to be stable.
If you really must to do hacks better is to put them into driver.

Regards
Andrzej

>
> Jacopo Mondi (3):
>   dt-bindings: display: bridge: Document LVDS to parallel decoder
>   drm: bridge: Add LVDS decoder driver
>   arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
>
>  .../bindings/display/bridge/lvds-decoder.txt       |  42 ++++++
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 +++-
>  drivers/gpu/drm/bridge/Kconfig                     |   8 ++
>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>  drivers/gpu/drm/bridge/lvds-decoder.c              | 157 +++++++++++++++++++++
>  5 files changed, 237 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lvds-decoder.txt
>  create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c
>
> --
> 2.7.4
>
>
>
>
