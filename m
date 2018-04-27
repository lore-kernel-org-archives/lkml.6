Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757503AbeD0HLV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:11:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54465 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757397AbeD0HLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:11:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180427071114euoutp020f76656c2bca97e31d921d248a41c162~pOWmvlzZu1663716637euoutp02w
X-AuditID: cbfec7f2-1c1ff70000011644-99-5ae2cd11d670
Subject: Re: [PATCH 00/24] device link, bridge supplier <-> drm device
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <25d8e621-b3f8-094f-32a2-d22efc2163a4@samsung.com>
Date: Fri, 27 Apr 2018 09:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjOd853Lu0sORRNvzg3ti5maiKOSZPPqUAys539MS7Zj6UxzqMe
        kMhtPZaNLROsykovjktUbInIhjrMjKTIrcIwXaBUVhgwcThLmZLV4irzAoqIW9uzRf497/M8
        b97nffOypHqUXs7m5O8XDflCrpZWwtbeuYG1if5b+rd6aldj+4CPwCZzhMImz1UaH7zcyuBf
        Z6ZpXBvyA9wx4WZwVbACYmu5mcJ3xocg/ub2XRIPDjYx2G/6i8HllQ0Mdt0epXBlt5/BI+5a
        Go8cGgK4JXyPwDWDPxK4/n4LxD/0JuD+sxdJbDq8HgfG+yDu8tQBPDU5Q+FQ/RMSB5qiA2uq
        wzT++doVmJnMH7/iZHhn6RDkR47aCX4hdB3y7YEGwFsfeki+wxGIquaTFO86X07zN0c7ab5t
        doLiT/k+5INWL8E3N5Twh33dkO+o6iK2LdMrN+0Rc3OKRMO69J3KvY8H5slC/8rP7RfKyVLg
        XGEBLIu4NBQ4JlmAklVz3wP0Z8UjxgIU0eIRQKd7tsvCQ4AazzqJmBBrmL3xN5CFcwA9b6si
        5CIC0DN3AMRcSdx7qHn+CB3DS7kMdGw0HDeRXJkCPXkcpGICza1GC81jcZOKS0eeXnuch9xK
        ZO1rjfPLuI+RKTTHyJ5E5Ds5CWNYwemQzV0T50kuGbVFakkZa9CNybr4MMQ5Fch37Rkp596C
        6q7aKBknoSnvJUbGK1B/tQ3K+Es0dscE5WYzQMH5r2lZ2Ih+8g5RsYuR0dQX3etkejOy35wD
        8iET0G+RRDlDAqpqPUHKtAqZy9Sy+3UU9Lf8l0aDzvwyQ1eANxyLNnMs2saxaBvHi7mnATwP
        NKJRyssWpdR88bMUSciTjPnZKbsL8lwg+u39z70P2sHM8C4P4FigXaLqu/uHXk0JRVJxngcg
        ltQuVbX/HqVUe4TiL0RDwScGY64oecDLLNRqVDtWHdCruWxhv7hPFAtFw/8qwSqWlwJjcf9L
        qTo43RnZebw6a2xfeEOjdaFx7tvxA9c7myzGtKbqrVvCurT3FYZMU3eKbrim/rWsAXfPxvUZ
        WcPz7yj/sY1NlPXqujRTmRc+/UhKfvur2ekda71pZHqJy3arPeM7S46wZFNI/2rhm/cOldiK
        PnjFJZzY8O7TAnuplHSuvtKrhdJeIXUNaZCEfwG985hm6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH931+3dWcPU63vgvDbRjjuK7cJ1P8g8dfGDbCODy7ortrz3OZ
        zCaHrd+USV3ppDD5XeSq82M30sl1q1Qjd0KWnAiTmpjrytZ/r70/79c++2wfKSn30xHSRKOZ
        F4y6JCUTSjX9fepbxLrfxS/pG5gLOc0uAizp/TRYnM8YOFpfI4EXP78yUNLrRlDbXSeB/Den
        KMjKSKfho6+FgpPv/SR4PLck4LZ8lkBGXoUEqt530JD30C2BtroSBtqOtSC42/eFgELPAwLK
        vt2l4FrDZGi6dJMEy3ENeH2NFNx32hB86vlJQ2/ZEAneW4GFhaf7GHje/ohaOZMreFQs4YrT
        WiiuLTeH4P70dlKc3VuBuKwfTpKrtXoD0/QimquqzGC41x0Ohrs32E1zpa4N3JuspwRXXXGE
        O+56SHG1+feJ9Yp41XLBlGLmZyWYRHOscpsaIlXqGFBFRsWo1BrtjmWR0crFccv38kmJB3hh
        cdwuVcKv5t9ksnvOwZzrGWQaKp6eiUKkmI3Cg68GUCYKlcrZiwg7O89QY4NwXG/rJ8d4Kh7p
        yGTGSn6EB24OBktT2dW4+vcJZpTD2BX4TEcfMVoi2dwQ3Pzr5biRjnD25XZ6tMWw8/Gf6pdB
        Q8bGYWdDTjCn2Dk4q7EmmCvYLdjn+T7emYJdRT3BbSFsNM6uK5SMMsnOwyOlreQYz8T3+kvG
        ORy/6rERp5DcOkG3TlCsExTrBOU8oipRGJ8iGvQGUa0SdQYxxahX7TEZqlDg0WoahqvtqPX2
        RidipUg5Sdbofxsvp3UHxFSDE2EpqQyT2bsCkWyvLvUQL5h2CilJvOhE0YHj8sgIxR5T4G2N
        5p3qaLUWYtRajVazFJThMs+S1Hg5q9eZ+f08n8wL/z1CGhKRhvizjO2B/fBmY5eeWTf7dPZW
        lz32S9egw7tpxVqmIL88dp/Vof/aTRj/LiyZm3l2+NC5G0dmzPdppNvXdDJF2fuHhKKrubGK
        pYkVC9ZdqNIlNlkq/eW7hag7ioJrV5tcrn0jV0I/rIl4t8VcPqX+8xNN7TKb1vHYP620lXcs
        Cm1cpaTEBJ16ASmIun80gneNfgMAAA==
X-CMS-MailID: 20180427071112eucas1p297fe827a1692146a739b42a217d411f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180427071112eucas1p297fe827a1692146a739b42a217d411f8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180426223215epcas2p38fe3b0b7b1ea1c8190805f9e2a89e11e
X-RootMTR: 20180426223215epcas2p38fe3b0b7b1ea1c8190805f9e2a89e11e
References: <CGME20180426223215epcas2p38fe3b0b7b1ea1c8190805f9e2a89e11e@epcas2p3.samsung.com>
        <20180426223139.16740-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 27.04.2018 00:31, Peter Rosin wrote:
> Hi!
>
> It was noted by Russel King [1] that bridges (not using components)
> might disappear unexpectedly if the owner of the bridge was unbound.
> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
> came up with using device links to resolve the panel issue, which
> was also my (independent) reaction to the note from Russel.
>
> This series builds up to the addition of that link in the last
> patch, but in my opinion the other 23 patches do have merit on their
> own.
>
> The last patch needs testing, while the others look trivial. That
> said, I might have missed some subtlety.

of_node is used as an identifier of the bridge in the kernel. If you
replace it with device pointer there will be potential problem with
devices having two or more bridges, how do you differentiate bridges if
the owner is the same? If I remember correctly current bridge code does
not allow to have multiple bridges in one device, but that should be
quite easy to fix if necessary. After this change it will become more
difficult.

Anyway I remember discussion that in DT world bridge should be
identified rather by of_graph port node, not by parent node as it is
now. If you want to translate this relation to device owner, you should
add also port number to have full identification of the bridge, ie pair
(owner, port_number) would be equivalent of port node.

Regards
Andrzej


>
> Cheers,
> Peter
>
> [1] https://lkml.org/lkml/2018/4/23/769
> [2] https://www.spinics.net/lists/dri-devel/msg174275.html
>
> Peter Rosin (24):
>   drm/bridge: allow optionally specifying an .owner device
>   drm/bridge: adv7511: provide an .owner device
>   drm/bridge/analogix: core: specify the .owner of the bridge
>   drm/bridge: analogix-anx78xx: provide an .owner device
>   drm/bridge: vga-dac: provide an .owner device
>   drm/bridge: lvds-encoder: provide an .owner device
>   drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an .owner device
>   drm/bridge: nxp-ptn3460: provide an .owner device
>   drm/bridge: panel: provide an .owner device
>   drm/bridge: ps8622: provide an .owner device
>   drm/bridge: sii902x: provide an .owner device
>   drm/bridge: sii9234: provide an .owner device
>   drm/bridge: sii8620: provide an .owner device
>   drm/bridge: synopsys: provide an .owner device for the bridges
>   drm/bridge: tc358767: provide an .owner device
>   drm/bridge: ti-tfp410: provide an .owner device
>   drm/exynos: mic: provide an .owner device for the bridge
>   drm/mediatek: hdmi: provide an .owner device for the bridge
>   drm/msm: specify the .owner of the bridges
>   drm/rcar-du: lvds: provide an .owner device for the bridge
>   drm/sti: provide an .owner device for the bridges
>   drm/bridge: remove the .of_node member
>   drm/bridge: require the .owner to be filled in on drm_bridge_attach
>   drm/bridge: establish a link between the bridge supplier and consumer
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
>  drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
>  drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
>  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
>  drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
>  drivers/gpu/drm/bridge/panel.c                     |  4 +---
>  drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
>  drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
>  drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
>  drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
>  drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
>  drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
>  drivers/gpu/drm/drm_bridge.c                       | 23 +++++++++++++++++++++-
>  drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
>  drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
>  drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
>  drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
>  drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
>  drivers/gpu/drm/sti/sti_hda.c                      |  1 +
>  drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
>  include/drm/drm_bridge.h                           |  8 ++++----
>  27 files changed, 51 insertions(+), 33 deletions(-)
>
