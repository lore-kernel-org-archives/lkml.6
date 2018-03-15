Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeCONOi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:14:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49091 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbeCONOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:14:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180315131433euoutp01eea403695610c53e47c91fe830bfe262~cGkiYWR6N1547715477euoutp01k
X-AuditID: cbfec7f4-6f9ff700000043e4-7d-5aaa71b7bcfc
Subject: Re: [PATCH v4 1/3] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <ee9a65b5-28ca-7404-36e2-29732e9ddfb8@samsung.com>
Date: Thu, 15 Mar 2018 14:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521111391-3515-2-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z/bjtLquJS9dJMmXSFLkThQWUEfTlDhhwqZUC09zMiZbd4q
        6KJpy/CSpMNpaZlly3WxbZZp1BLXKC2zmVuXSZndXFJeUrJs20ny2+99n+fh/7zwp3HJODmL
        3pOcyquTFUkyKpCwtI49Xdaw3yBfUZojY/Pb7RibpfWQbGVLO8m+GB6g2D5XM8Zmm4cRa/tl
        FLEnT18UsZ2NFRRr/vwNY3uueii25mUHxtpKC0g2p7lFxD4xuETrZnB15+oQ11mQj3E9JRMY
        d0f/RsSVa8tIbqL7Hc7VG05SnPWhFnENIz0k5z5lw7iPnT8prmJshOAG6+fFiOWBqxP4pD3p
        vHp59K7AxPauejLlT0hmoeMrdRR1B+WhABqYKDBpLYSPJUwtgnzdtjwU6OUhBK7qQkwYBhH0
        X/GgycRrxyguCJcR1LwtEgmDx+squ+93zWR2gNFiI31CMGPEwD4wSvgGnMlC8NyejftcFLME
        ft9yUj4WM9HwoXnMnyaYBfD0nhPzcQgTC+dLPiDBEwT2sl5/2wBmI5T0lpI+xplQyDaX4wJL
        wdVb6S8OTA0NbVXfRULxDWDIaSIFnglfbKZ/+zkwcacSE/gQOD9lEUJYi8D96wQlCKvgoa3D
        G6a9LyyB643LhfUacJr6/GtgpkO3J0joMB2KLTpcWItBmysR3PPB3WbGBZZCzbNhqgiF6adc
        pp9yjX7KNfr/71YhwoCkfJpGpeQ1kcl8RrhGodKkJSvD4/ep6pH3Tz7+Yxu6jRrHd1sRQyPZ
        NHF32BW5hFSkaw6orAhoXBYs3pRikEvECYoDB3n1vp3qtCReY0WzaUImFe9YfFguYZSKVH4v
        z6fw6kkVowNmHUVR9nB7er68OmHuoLZfJ3IqqxsWbW/yjEV0FWTc31AXMUSG/LCJtzlqt15z
        xH+52VW78PatuNHdiXlu47H1cblSveneq7vKUHSmKirs0nt1cervI3TbsxurdDEyS3AdWdvf
        URi5MjZ08FFm/OZ3Oe+PX10rbTp7wbR4S2ZpX+uD6CoZoUlURCzF1RrFXxTh7/CPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYRzGec/ZOZvi6jgdvnhhsihJ8Oj82muYeCUn9EIIIhapQw9quc12
        pqRXphjT/LxQcIrzIkWXi5zOLDVkSkOSaS51mtYwM0o0MT/RNOcKvPvB8/z+8IdHgIvqiEBB
        rkrLalSKPAnpzXt/bPsc1v/QKI+YObqAqu3jGCrVrRPIMGYn0MedXyRaXRjGUJllByDboYmP
        Kuqf8ZHjTQuJLD82MOR6vk6i9rkPGLI11hCofHiMjyaMC/zEi0x3azdgHDXVGONqOMGY1/ol
        PtOsayKYE+cyzpiNFSRjHdUB5tWui2C+PLVhzHfHHsm0HOzymN/moFShnI7XqAu0bHCOmtPe
        kNyVokhaGofoyOg4Wholu3c9MkYSnhCfxeblFrKa8IQMOsc+aybyj8WPamfWyBLg9K0EXgJI
        RcPFmX28EngLRFQ7gBP1VXxPEAAHDeu4h/3g0Wwl6SmtAWhY3DoL/Kg0aOq3Ee7AnzJhcGWs
        7ewUTpUCWNe8hXmUTwB29oyQboWkrsE/vfNnLKQS4LfhA+BmHnUFTr6dx9wspu7Aii4Dz9Px
        heNNK2fsRd2EDSuNhJtxKgQetU7jHr4EyyzN/zgALqwYsDog0p/T9ecU/TlFf05pAzwj8GcL
        OGW2kpPSnELJFaiy6Uy10gxO19D/7qB3AEz33LICSgAkPkLn5S65iFAUckVKK4ACXOIvTMk3
        ykXCLEVRMatRp2sK8ljOCmJOn6vHA8WZ6tNtqbTp0hipDMVJZVGyqFgkCRBORhTJRVS2Qss+
        YNl8VvPfwwRegSWAC7T7VYWPJKvClVOxFY6v96dribU0cevG6pjG916HNjipJM+70rDdO2QW
        ds4M7UfMxTpGizeDnck/B3W7y6aRvj7rcMaS6MlI2OZiUBudune7PMtySLyo3w7eaTGpUkOP
        vTAftTmkb+CkY8jYPK4NSCKnXC8Tr+Ip9OPSKgmPy1FIQ3ENp/gLHmt/byMDAAA=
X-CMS-MailID: 20180315131430eucas1p1143b894791e02b3054a7d2c51a59d49f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180315131430eucas1p1143b894791e02b3054a7d2c51a59d49f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180315111511epcas3p41569bd909fe6916429f3a016b0b88f57
X-RootMTR: 20180315111511epcas3p41569bd909fe6916429f3a016b0b88f57
References: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180315111511epcas3p41569bd909fe6916429f3a016b0b88f57@epcas3p4.samsung.com>
        <1521111391-3515-2-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 11:56, Jacopo Mondi wrote:
> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../bindings/display/bridge/thine,thc63lvd1024.txt | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> new file mode 100644
> index 0000000..0936bde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> @@ -0,0 +1,63 @@
> +Thine Electronics THC63LVD1024 LVDS decoder
> +-------------------------------------------
> +
> +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS streams
> +to parallel data outputs. The chip supports single/dual input/output modes,
> +handling up to two two input LVDS stream and up to two digital CMOS/TTL outputs.
> +
> +Required properties:
> +- compatible: Shall be "thine,thc63lvd1024",
> +
> +Optional properties:
> +- vcc-supply: Power supply for TTL output and digital circuitry
> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
> +- lvcc-supply: Power supply for LVDS inputs
> +- pvcc-supply: Power supply for PLL circuitry
> +- pdwn-gpios: Power down GPIO signal. Active low.
> +- oe-gpios: Output enable GPIO signal. Active high.

Nitpick: different lines ends differently: period, dot, nothing.
Another thing if there will be next iteration it would be good to
emphasize converter has no control bus.
Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> +
> +The THC63LVD1024 video port connections are modeled according
> +to OF graph bindings specified by Documentation/devicetree/bindings/graph.txt
> +
> +Required video port nodes:
> +- Port@0: First LVDS input port
> +- Port@2: First digital CMOS/TTL parallel output
> +
> +Optional video port nodes:
> +- Port@1: Second LVDS input port
> +- Port@3: Second digital CMOS/TTL parallel output
> +
> +Example:
> +--------
> +
> +	thc63lvd1024: lvds-decoder {
> +		compatible = "thine,thc63lvd1024";
> +
> +		vcc-supply = <&reg_lvds_vcc>;
> +		lvcc-supply = <&reg_lvds_lvcc>;
> +
> +		pdwn-gpio = <&gpio4 15 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				lvds_dec_in_0: endpoint {
> +					remote-endpoint = <&lvds_out>;
> +				};
> +			};
> +
> +			port@2{
> +				reg = <2>;
> +
> +				lvds_dec_out_2: endpoint {
> +					remote-endpoint = <&adv7511_in>;
> +				};
> +
> +			};
> +
> +		};
> +	};
