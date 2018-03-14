Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCNKds (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:33:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:48242 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeCNKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:33:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180314103343epoutp03967fb30b82f66aa5328a680bb38d2f82~bwu1WiK5A2291522915epoutp03k
X-AuditID: b6c32a46-3c1ff70000001029-7c-5aa8fa870974
Subject: Re: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
To: Inki Dae <inki.dae@samsung.com>
Cc: krzk@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <21459bbe-befc-da77-5c34-c821db74ae8d@samsung.com>
Date: Wed, 14 Mar 2018 11:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <5AA5CE4F.6050807@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7bCmhW77rxVRBv9OyllsnLGe1WL+kXOs
        FpPuT2Cx6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y+7A6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEsVlk5Kak1mWWqRvl8CV0fF9JktBD0fFqdvGDYxn2boYOTkkBEwknsz6xN7FyMUh
        JLCDUWLV7NNsEM53RoldL3azwFRd3fWZGSKxm1Fi/qmdzCAJIYH7jBL9jx1AbGGBJIkPj+aD
        xUUElCVW7WsHG8ss8IhRYl/nbnaQBJuAoUTv0T7GLkYODl4BO4mPzyxBwiwCqhIHn01gBbFF
        BSIkFk59yghi8woISvyYfA/sCE4BbYmn59eAjWEW0JR48WUSC4QtLnHs/k1GCFteYvOat2CH
        SgjcZpNYuuIhE8QHLhK9d04xQtjCEq+Ob2GHsKUlnq3aCBWvluhs62KHaG5hlPgz7RI0kKwl
        Dh+/yAqxgU+i4/BfdpAHJAR4JTrahCBKPCT6Dp6GhpajxITbH5kgodXGJHH920bmCYxys5A8
        NAvJE7OQPDELyRMLGFlWMYqlFhTnpqcWGxUY6RUn5haX5qXrJefnbmIEJxcttx2MS875HGIU
        4GBU4uGNuLQ8Sog1say4MvcQowQHs5II71aZFVFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVsD
        XKKEBNITS1KzU1MLUotgskwcnFINjCLx095Hf/n18sJ9yb71Sw3dbxhFyV7g1PoVtXWiToUg
        u9nDZJHsArHzQgf8avgn6rR+sb22ttzqx505Lc17rE8bZ3bcZzx/bcNJEZdCgbvL/Fx9i4sn
        8zJauUk2yQSnRBY9ueunaLRQRbptyY13lX4+d15kLb2REtyR3VI102T28Sm/pS9fUWIpzkg0
        1GIuKk4EAFsts+cqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t9jAd22XyuiDK5uVLDYOGM9q8X8I+dY
        LSbdn8Bi0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl92B02PTqk42j81L6j36tqxi
        9Pi8SS6AJYrLJiU1J7MstUjfLoEro+P7TJaCHo6KU7eNGxjPsnUxcnJICJhIXN31mbmLkYtD
        SGAno8Tt79+ZIJyHjBI77h8AqxIWSJLofTUFzBYRUJZYta+dHaSIWeARo8S8matYIDramCSW
        TVsJVsUmYCjRe7SPsYuRg4NXwE7i4zNLkDCLgKrEwWcTWEFsUYEIic6V81lAbF4BQYkfk++B
        2ZwC2hJPz69hB2llFlCXmDIlFyTMLCAucez+TUYIW15i85q3zBMYBWYh6Z6F0DELSccsJB0L
        GFlWMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefnbmIExsK2w1r9OxgfL4k/xCjAwajEwxtx
        aXmUEGtiWXFl7iFGCQ5mJRHerTIrooR4UxIrq1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8s
        Sc1OTS1ILYLJMnFwSjUw9opEdfiK/NY0/ObyNK9z+5bjbXo6HkLTn2k8l2yUyC//LcbWeSwy
        ZgPrkef/alZOCXr1Xqn8uaw7l1Of2trbTy48dt651+mdo4vmhnmLFG48nf+/XfP10+7OyROT
        z235ZD711Jce6W/8v5xO/RIUWsKvM2HOv8erXSYlTA25nDeLXSHqTaZxvRJLcUaioRZzUXEi
        AM2ZZqWBAgAA
X-CMS-MailID: 20180314103342epcas2p1bd2889280033d882c1cee411f1b948cd
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
X-RootMTR: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
        <20180307172711.15697-1-s.nawrocki@samsung.com>
        <5AA1F41B.5080104@samsung.com>
        <39965bce-a6f2-6202-5c3f-97e4446e97eb@samsung.com>
        <5AA5CE4F.6050807@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Inki,

On 03/12/2018 01:48 AM, Inki Dae wrote:
> Thanks for explanation. By the way, who binds '#sound-dai-cells' property?.
> This patch adds this property to hdmi device node which will be bound by 
> HDMI driver fo Exynos DRM but I don't see any place to bind '#sound-dai-cells' 
> property in this driver.
> So I think some driver like Odroid XU3/4 audio driver(sound/soc/samsung/odroid.c) 
> or ASoC simple audio card driver(sound/soc/generic/simple-card.c) should exist 
> and this property should be placed to such device node.

The *-cells property is supposed to be in a node that a phandle points to,
and in this case the phandle entry in 'sound-dai' points to the hdmi node.
>From the DT bindings perspective it not that important how Linux parses
the bindings, it's more a matter of describing the HW configuration.

There is even a related check in dtc:

$ grep -n sound scripts/dtc/checks.c
1208:WARNING_PROPERTY_PHANDLE_CELLS(sound_dai, "sound-dai", "#sound-dai-cells");

-- 
Regards,
Sylwester
