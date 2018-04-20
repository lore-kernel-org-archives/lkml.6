Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeDTJSq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:18:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42998 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754193AbeDTJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:18:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180420091840euoutp01dc0200242244b664e22a1f45406c505d~nGk25DWKr0268502685euoutp014
X-AuditID: cbfec7f2-1c1ff70000011644-6b-5ad9b06eaf19
Subject: Re: [PATCH v9 0/2] drm: Add Thine THC63LVD1024 LVDS decoder bridge
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        vladimir_zapolskiy@mentor.com, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <eaa9df5f-99af-69f0-dff0-c03869d7571b@samsung.com>
Date: Fri, 20 Apr 2018 11:18:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524062429-325-1-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH932e557nKV37dpX7hImzNonEYs9Qs7F5zGb+8Ifdhk49q6a7
        2j1CGO1CV10UC51WTMmSWPSTYpd1K4kK3UVKcmG7NDnE/Ojp0fTf6/v5fN7f9+e9fVhSdZye
        wyYa9glGgy5JQ3tTta0TT5YZbjm1Ec1jFJfb2UZwJrNbwZU87FRwzzyfaM7V10RwGTUexNl/
        3mC4rPxShutpLKK5mg+jBDd43U1zZb1dBGc/d0rBnWh6yHAdFX0M53pQS6/HfGVxJeJ7TuUS
        /GDBH4JvsPYz/EVzoYL/4xgi+eqKLJq3tZgRX/d1UMEP5NgJ/q7HhPiRnm80XzTxleLHq+dv
        89V6r4sTkhL3C8bl0THeCdWVpYqUodkHcy45iXTU65eNvFjAkfD8hYfORt6sCl9DcPVVPiM1
        VPgLgqrLkTKPI7BXHZ0WpI/3kbKgHMHIWNk/tRuB5Z2dlKb88RbIKXQhqRGAOwkocVcx0oPE
        JgTdbRlTUzQOhV+3nbTEShwNjoZyJDGFQ6A9I0shcSDeAaaRCUae8YO2wmFKYi/MQ/m7e1N1
        EgdDnbuIlFkNfcMlhGQGuJ6F4tE6Ql58IxQ/naBl9oeP9juMzPPg0VkLJfNhcL43UbLYjGDg
        Z+Y/wVposXdNbsROOoTCzcblEgKOgszPgoy+4HD7ySv4wpna86RcVoL5pEr+YyEMPK4hZVZD
        2VMPnYcWWWcEs84IY50Rxvrf9hKiKpBaSBX18YK4wiAcCBd1ejHVEB8em6yvRpO3+ei3/XM9
        8nTvsSHMIo2PcqzKoVUpdPvFNL0NAUtqApQxq51alTJOl3ZIMCbvNqYmCaINzWUpjVq5a/FR
        rQrH6/YJewUhRTBOdwnWa046Ch6+sz1qwbH5YXuD+l1Rgf5H3vqUrSne2bv0eZE7NntWQYGo
        spSePByVdyVi1crR4YQQV9qV63X5Fze8D/meGXZIvGBbFzh4OvCYpjXScnCRNmLl/dNDlvwW
        fc+tvCdB2pKgHw6qIr1d/bLr9abkN6Rv8Nrxjhqv5mWb6blb02J2DsVqKDFBt2IJaRR1fwGN
        FduflwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec/ZOZvi5DhvLxJWo3s43bzsNUwMAg8YFARdlqUHPajkNtnZ
        NINAJpo6NCW6OJf6QTOmhZjTbIml1rBkWlbqKjUzo2IaXgktc87Ab7+H///HwwOPABcZiSBB
        hkrLalRMppj05L36axsLUTaPKsIWprxRqb0PQ/oiJ4Fqeu0Eers4S6JpRyeG8i2LANlW7vNR
        cUUdHw09NpHI8n0GQxONThLVD7/GkO1mGYEKOnv5qN/s4KPpp21kHEU3VTcBeqisFKMnbqxh
        dIfxE5+uKqok6LWRSZxuMReTdHdPEaDblyYIetxgw2jroh7Q34aWSdr0e4lHz7cEn/BWSGI0
        ap2W3ZGu5rSHxeekSCaRRiOJLCJaIg2Xnz8kixSHxsakspkZ2awmNDZZkt7SVEdkTQZcMtSO
        Ynlg2KcEeAggFQHz5h14CfAUiKh6AK2DVtIdBEJrjRN3sy9cfV9Cuks/Aax7dpdwBb5UAjRU
        TgNX4EfZMWgqsPNcA07pASyvmsPcShWANX36DYWk9sM/D0c3dgipWDjS0QBczKN2w5f5xRsd
        f+oMHBuY2+z4wL7KKZ6LPSgaNnx9wncxTu2Fq9VvcDdvh+1O0yYHQsdUDVYORMYtunGLYtyi
        GLcotYBnBn6sjlOmKTmZhGOUnE6VJklRK1vA+l+0vfjd+giUzJzsBpQAiL2Evx6MKEQEk83l
        KrsBFOBiP2Fy1KhCJExlci+zGnWSRpfJct0gcv24CjzIP0W9/mUqbZI0UipH0VJ5uDw8CokD
        hQNhuQoRlcZo2Yssm8Vq/nuYwCMoD9yad7bGXTB/jN9nC7ArMqueGybehf7o7/c0JBYzB9GX
        AjTYWJR4xW/BYqpcPC7IUfuErX4emONRK+WWHNx6dCp4W/PZBNlObd4pBxvV27A6r/GyMHJw
        Tbhr/Fhh/JGFKKKry7FH1Tunl9zjX11OunP7w3WduWf2NG4dDwkoFPO4dEZ6ANdwzD/tgn1y
        LQMAAA==
X-CMS-MailID: 20180420091837eucas1p2a606670d735978e14a9190215e16bfaa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180420091837eucas1p2a606670d735978e14a9190215e16bfaa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180418144054epcas5p3ec7816f76cd84d4c429b47e23331ee7d
X-RootMTR: 20180418144054epcas5p3ec7816f76cd84d4c429b47e23331ee7d
References: <CGME20180418144054epcas5p3ec7816f76cd84d4c429b47e23331ee7d@epcas5p3.samsung.com>
        <1524062429-325-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.2018 16:40, Jacopo Mondi wrote:
> As I have another series which is based on this one + Eagle board display
> support, I'm re-sending this one to fix the small issue I pointed out in my
> reply to v8.
>
> Simon: no changes to Eagle DTS series, so the last one sent is still the good
> one.
>
> DRM: I have collected several reviewed-by tags both on driver and bindings.
> Can I send out incremental patches on this series and consider this one to
> be ready to be collected?

Queued to drm-misc-next.

Regards
Andrzej


>
> Thanks
>    j
>
> v8 -> v9:
> - Put 'remote' OF node after usage not just in error path during device
>   tree parsing routine
> - Add Rob's Reviewed-by tag to the device tree bindings documentation
>
> v7 -> b8:
> - Make 'vcc' supply mandatory
> - Use 'oe' property name to describe "OE" pin
> - Minor fixes as suggested by Laurent on bindings and driver
>
> v6 -> v7:
> - Use semi-standard names for powerdown and output enable GPIOs as suggested
>   by Rob and Vladimir
> - Use 'regulator_get()' not the optional version, and list only 'vcc' as
>   requested supply
> - Addressed Laurent's review comments and removed Eagle display enablement patch
>   to be sent separately
>
> v5 -> v6:
> - Drop check for CONFIG_OF as it is a Kconfig dependency
> - Add Niklas Reviewed-by tags
> - List [3/3] depenencies below commit message to ease integration
>
> v4 -> v5:
> - Fix punctuation in bindings documentation
> - Add small statement to bindings document to clarify the chip has no
>   control bus
> - Print regulator name in enable/disable routines error path
> - Add Andrzej Reviewed-by tag
>
> v3 -> v4:
> - Rename permutations of "pdwn" to just "pdwn" everywhere in the series
> - Improve power enable/disable routines as suggested by Andrzej and Sergei
> - Change "pdwn" gpio initialization to use the logical output level
> - Change Kconfig description
>
> v2 -> v3:
> - Drop support for "lvds-decoder" and make the driver THC63LVD1024 specific
> -- Rework bindings to describe multiple input/output ports
> -- Rename driver and remove "lvds-decoder" references
> -- Rework Eagle DTS to use new bindings
>
> v1 -> v2:
> - Drop support for THC63LVD1024
>
> Jacopo Mondi (2):
>   dt-bindings: display: bridge: Document THC63LVD1024 LVDS decoder
>   drm: bridge: Add thc63lvd1024 LVDS decoder driver
>
>  .../bindings/display/bridge/thine,thc63lvd1024.txt |  60 ++++++
>  drivers/gpu/drm/bridge/Kconfig                     |   6 +
>  drivers/gpu/drm/bridge/Makefile                    |   1 +
>  drivers/gpu/drm/bridge/thc63lvd1024.c              | 205 +++++++++++++++++++++
>  4 files changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>  create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c
>
> --
> 2.7.4
>
>
>
>
