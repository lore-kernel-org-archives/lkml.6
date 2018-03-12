Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeCLNrl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:47:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51841 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeCLNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:47:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180312134736euoutp024c1366e91f8fc2728ff8b9a6e226a2b6~bMFiM3kl_2563125631euoutp020
X-AuditID: cbfec7f4-b4fc79c0000043e4-07-5aa684f3c12e
Subject: Re: [PATCH v2 0/3] drm: Add LVDS decoder bridge
To: jacopo mondi <jacopo@jmondi.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <915d4251-8162-b97f-5449-b4ea42c2202e@samsung.com>
Date: Mon, 12 Mar 2018 14:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312123042.GA12967@w540>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNm5lOh2rJUDHcuGAomiAGQYPJS3CL+jE/JhrjRhQtOoKRtSOI
        YhSRal2AosGl4i6IBVywFWyCylqJiGJdgIhUBWs1VZHFiAu2HYj8ne3e+07yGFKRQU9gtiZs
        59UJqjglLaPuNPx8EtKbVRQZ1mUKx9nNjQTO1Dol+HxdswQ/7/9K4w/tVQTeb+pH2PKrTIo7
        7FkIH8q7IsVWcwGNTY4vBLaVOGlc+KqFwJYTORKsqaqT4iZDu3Qhy5WeK0WcNSeb4Gz5QwR3
        V98h5c5oT0u4odZ3JFduOERzNbVaxFUM2CRc5xELwdmtP2iu4OcAxfWW+y+TR8rmbubjtqby
        6tD5G2WxR3/b6KTskDRj6QsiA9UHHkZeDLDh4HhgkBxGMkbBFiOoutAjFUkfgty8z8OkF4FO
        p5WOjFy+rxs2riK4d01HicSJoNqRT7pT41gMp2orKTf2ZafCdbuVdodI9hYJmjy7x6DZ6fDn
        dhvtxnJ2PmgzSzw6xU6DJ0e6PYvGs2vgYn43EjM+0Hi6y5PxYoMh36jxZEh2ClQ4C4axH7R3
        nSfcx4AtY+DeX61rmHGRJWAvmCpWGAefLMbhOpPg0fGjlIjToe1jJiXOahF0/jpIi0YE1Fpa
        JO49pOvRN8yhojwPipsGCHG9N7Q6fcQneMOxOydJUZaD9oBCTAdA52MTKWI/KHzaT+tQoH5U
        Mf2oMvpRZfT/715AlAH58SlCfAwvzE7gd8wUVPFCSkLMzE2J8eXI9S8f/bX0VSLz7+gaxDJI
        OVYetr8oUiFRpQo742sQMKTSV/56ukuSb1bt3MWrEzeoU+J4oQZNZCilnzwqaE+kgo1Rbee3
        8XwSrx5xCcZrQgZa23W5xPDUf5AZXLx4X9mqBT/0QWMQYZnjaHSsKzJ3Z3kvvZJS7XP9G9+0
        dk1TQ8DZ5Xtjk7dE+LbbOlTG3esf+69Ke+uoTN7UVz854Nng1564PT3RQy/1vWcfvDFqwh7K
        VvTHLH2fm9SWNmfGSvT95iKlsGD1pajuvsLO9CjNxN1Wh5ISYlWzgkm1oPoHOmxqYZMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xu7ofWpZFGXzfbm7Re+4kk0VTx1tW
        i/lHzrFaXPn6ns3i2a29TBbNW78yWhz/vZbd4u7zFkaLzolL2C0u75rDZrH15Tsmiwer37JZ
        LL1+kcni+LQ+VovWvUfYLc6susXuIOCxZt4aRo/Lfb1MHg+m/mfy2DnrLrvH7I6ZrB7/bzxi
        9ti0qpPN49DhDkaP7d8esHrc7z7O5PH88nc2jzk/v7F4fN4kF8AbpWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfR8+cBW0GvbsWWNVeZGhiPKncx
        cnJICJhILN4/gb2LkYtDSGApo8TX5/+ZIBLiErvnv2WGsIUl/lzrYoMoes0o8WL1IUaQhLCA
        hcSMwztYQGwRARWJdc8vgxUxC2xklpi3ax8rRMcnRok5SzaDjWUT0JT4u/kmG4jNK2An0dG0
        GqybRUBV4nz3U7B1ogIREp0r57NA1AhKnJz5BMzmFNCSmLqlFayGWUBd4s+8S1C2vMT2t3Og
        bHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBF
        bDv2c/MOxksbgw8xCnAwKvHwGjQvixJiTSwrrsw9xCjBwawkwntHEyjEm5JYWZValB9fVJqT
        WnyI0RTouYnMUqLJ+cD0lVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+J
        g1OqgdE36iSXypHMa9wHluvVTClNN5ttZSb7lZ9759pfE34+OrfT4e7yKVEH1gS3cfblPv95
        9+aW/ZfbJq5NK13SWRtbHKa7VuNeUc/ClhVVWxvmSEUUWEo8OdH1YK6B6rLTTTe5D9f/EmPZ
        d0u28bV+5Gub3OTWs+5nHmXxfVyjem/TKqe9G6M/+VoqsRRnJBpqMRcVJwIAGxk7sycDAAA=
X-CMS-MailID: 20180312134730eucas1p1b3eb7e526c449dbef04ad91dfbb381ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180312134730eucas1p1b3eb7e526c449dbef04ad91dfbb381ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b
X-RootMTR: 20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b
References: <CGME20180309135207epcas3p32a7d3a0e9c9dae5af8fc855ff3c0e03b@epcas3p3.samsung.com>
        <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
        <81b25fde-63fa-aacc-1bf4-f2a7b60b19ef@samsung.com>
        <20180312123042.GA12967@w540>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2018 13:30, jacopo mondi wrote:
> Hi Andrzej,
>
> On Mon, Mar 12, 2018 at 10:07:27AM +0100, Andrzej Hajda wrote:
>> On 09.03.2018 14:51, Jacopo Mondi wrote:
>>> Hello,
>>>    after some discussion on the proposed bindings for generic lvds decoder and
>>> Thine THC63LVD1024, I decided to drop the THC63 specific part and just live with
>>> a transparent decoder that does not support any configuration from DT.
>>>
>>> Dropping THC63 support to avoid discussion on how to better implement support
>>> for a DRM bridge with 2 input ports and focus on LVDS mode propagation through
>>> bridges as explained in v1 cover letter (for DRM people: please see [1] as why
>>> I find difficult to implement support for bridges with multiple input endpoints)
>>>
>>> Same base branch as v1, with same patches for V3M Eagle applied on top.
>>> git://jmondi.org/linux v3m/v4.16-rc3/base
>>>
>>> Thanks
>>>    j
>>>
>>> v1 -> v2:
>>> - Drop support for THC63LVD1024
>>>
>>> [1] I had a quick at how to model a DRM bridge with multiple input
>>> ports, and I see a blocker in how DRM identifies and matches bridges using
>>> the devices node in place of the endpoint nodes.
>>>
>>> As THC63LVD1024 supports up to 2 LVDS inputs and 2 LVDS outputs, I see only
>>> a few ways to support that:
>>>  1) register 2 drm bridges from the same driver (one for each input/output pair)
>>>     but they would both be matches on the same device node when the preceding
>>>     bridge calls "of_drm_find_bridge()".
>>>  2) register a single bridge with multiple "next bridges", but when the bridge
>>>     gets attached I don't see a way on how to identify on which next bridge
>>>     "drm_bridge_attach()" on, as it depends on the endpoint the current bridge
>>>     has been attached on first, and we don't have that information.
>>>  3) Register more instances of the same chip in DTS, one for each input/output
>>>     pair. They gonna share supplies and gpios, and I don't like that.
>>>
>>> I had a quick look at the currently in mainline bridges and none of them has
>>> multiple input endpoints, except for HDMI audio endpoint, which I haven't found
>>> in use in any DTS. I guess the problem has been already debated and maybe solved
>>> in the past, so feel free to point me to other sources.
>> I think this is is a step in wrong direction, IMHO. Your previous
>> patchset was quite OK, at least bindings, IMHO. Few things needed only
>> polishing.
>> Here we have unmanaged/transparent bridge, which is totally different,
>> what happened to regulators and gpios from previous iteration.
>> I do not have schematics of the board, but I guess respective pins of
>> the bridge must be connected somehow.
>> I think the problem you want to avoid (double bridge) should not be a
>> problem at all.
>> I suppose the most important is to have correct bindings - as they need
>> to be stable.
>> If you really must to do hacks better is to put them into driver.
>>
> I understand. The "transparent bridge" is of no actual use, but I don't see
> how the "double bridge" thing is not an issue if I were to develop
> support for the actual Thine chip.

What is exactly your configuration: single/dual input, single/dual output?
Current bindings suggests single/single, am I right? In such case you do
not need to implement dual link functionality in the driver - since you
even do not have possibility to test it.
But the bindings should support all modes of operation, or at least
should be easy to extend them in the future with backward compatibility.

>
> Please see my reply from yesterday to Archit. I still think having two
> bridges is somehow an issue...

Yes, I agree. But do we have such case? If no - no problem ATM :), if
yes - lets try to implement it and see where is the problem, as Archit
already suggested it would be just a matter of assigning bridge to port
node, instead of device node.

>
> While we clarify that, would it be fine an initial driver version for
> the actualt Thine chip with a single input support[1]? I would ditch this
> transparent bridge and resume working on a THC63LVD1024 driver from
> comments received on v1.

I think, yes: driver with only single input, and full or extend-able
bindings.

>
> Thanks
>   j
>
> [1] Single input support implies a single input port in DT bindings
> even if the chip supports two, and my understanding was that you
> didn't like this.

I am sorry if I was not clear enough, only thing I wanted was complete
or at least consistent/extend-able binding.
So when I saw word "multiple LVDS streams" in bindings I was looking
further to see how these multiple LVDS bindings are defined, and found
nothing :)
Btw I think it may be better to use "Dual Link" instead of "Multiple
streams", it is more precise and quite well established in docs.

Regards
Andrzej

>
>
>> Regards
>> Andrzej
>>
>>> Jacopo Mondi (3):
>>>   dt-bindings: display: bridge: Document LVDS to parallel decoder
>>>   drm: bridge: Add LVDS decoder driver
>>>   arm64: dts: renesas: Add LVDS decoder to R-Car V3M Eagle
>>>
>>>  .../bindings/display/bridge/lvds-decoder.txt       |  42 ++++++
>>>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  31 +++-
>>>  drivers/gpu/drm/bridge/Kconfig                     |   8 ++
>>>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>>>  drivers/gpu/drm/bridge/lvds-decoder.c              | 157 +++++++++++++++++++++
>>>  5 files changed, 237 insertions(+), 2 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lvds-decoder.txt
>>>  create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c
>>>
>>> --
>>> 2.7.4
>>>
>>>
>>>
>>>
