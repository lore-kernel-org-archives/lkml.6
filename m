Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeCIIBf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:01:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39947 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCIIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:01:32 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180309080129euoutp018ca2bc72509da99e62c8980ce273ba7f~aMbe5zuRl2594025940euoutp01Q
X-AuditID: cbfec7f4-713ff700000043e4-f3-5aa23f57c528
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: Document THC63LVD1024
 LVDS decoder
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <41900058-274f-c533-f744-17e495a3beb2@samsung.com>
Date: Fri, 9 Mar 2018 09:01:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520522643-11756-2-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUgUcRTmNzM7My6tjavlo5M2o1s7YegOiob+yj8iD6hWnTQ8tna0tKBE
        qTZrF0usnMY28zYlsiwTLNgVt9XSNgMPit2iGzaj1EpTc/dX5H/f+973ju/xWFL7WzWDPZiW
        LhrT9Ck6Wk3da/3VsXzP5hsxK1yjOt7c4ST4HJNXxVtbOlT8i8F+mn/f10zwuQ2DiHeM1DH8
        2QtlDN/VpNB8w6cvBO+56aX58m4XwTsuWVT8qeYWhn9S08dsmSrUXqtFQpfFTAiewnFCeCC/
        YoSrpiKVMN7zhhTqa87Sgs1uQsL9IY9KcJ9zEMKHrh+0oPwaooTv9XN2aWLUGxLElINHRGPE
        pv3qpO6+AuaQGTKV8SomG9UG56EAFrg14LJdJPOQmtVyVQjOjcg0DgYQXCoboHDwHcEjuVKV
        h1h/iZKrwXwlAjn/FIMDL4K20V7k6xvMxUJ7eY4/EcLVEeDs/+lvRXI5CJ47c0mfiuYWw+id
        XtqHNdwmGDO3MD5McWFQU/uS8uFpXBSUFL5DWBMEzqK3fj6A2wn51bK/luTmwn2vQmIcCn1v
        rYRvGHB1LJR23qaw1W3Q+OoFgXEwfHbcZTCeBe0F5/9qjkPvxxwKF5sQuEfO0DixHuwOl/8A
        5MTWt5oiML0RPNkuGt8lEHq8QXiHQLh47zKJaQ2YTmuxeh64nzaQGIdC+bNBOh/Nlyc5kye5
        kSe5kf/PvY6oGhQqZkipiaK0Kk08Gi7pU6WMtMTweENqPZr4yfYxx0AjavodZ0Mci3RTNJ6t
        JTFalf6IlJVqQ8CSuhBNW/UEpUnQZx0TjYZ9xowUUbKhmSylC9XsXXQiRssl6tPFZFE8JBr/
        ZQk2YEY22jE7xGW3HihRhw+UuiNcH9Yt7S+YXulJlDd/DbJEcQ/DFsTtLFkeP9/KDNub1/YM
        iYRt7KQYa9dFn3htXRiyOj5y+2vDGcOGwgw0UlQhRQ4XK4fZ68V7MzuHV5njWvOHKhTLsoAr
        0axBtzu5TVEs6el3XFffOd2dtm/rAnse6ygpSb9yCWmU9H8A7hzDA48DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Pd0w+0VRBldPi1n0njvJZNHU8ZbV
        Yv6Rc6wWV76+Z7N4dmsvk0Xz1q+MFsd/r2W36Jy4hN3i8q45bBZbX75jsniw+i2bxdLrF5ks
        jk/rY7Vo3XuE3eLMqlvsDvwea+atYfS43NfL5PFg6n8mj52z7rJ7zO6Yyerx/8YjZo9NqzrZ
        PA4d7mD02P7tAavH/e7jTB7PL39n85jz8xuLx+dNcgG8UXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ129NZi/olaiY838FewPjGuEuRg4OCQET
        iTnNvF2MXBxCAksZJVrXXmTpYuQEiotL7J7/lhnCFpb4c62LDaLoNaPEmpPbGEESwgLREqeX
        NrGDJEQE1jJJPDmygBnEYRZoYpSYMPsTE0TLXUaJtuYdYC1sApoSfzffZAOxeQXsJP71HmEH
        sVkEVCRWrbkDtltUIEKic+V8FogaQYmTM5+A2ZwCXhITVs4C62UWUJf4M+8SM4QtL7H97Rwo
        W1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECEwM
        24793LyD8dLG4EOMAhyMSjy8DxwXRgmxJpYVV+YeYpTgYFYS4T21EijEm5JYWZValB9fVJqT
        WnyI0RTouYnMUqLJ+cCklVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+J
        g1OqgXGe2/LC+R4LXn/NrHgqIs2jb/pez7VVfK3+YnvN3LnaamunMe6wvLWK5W+nqvre98r9
        y7Mddsw8GqpzJWbjp8eMdvWHnsw8eiJF68AuseOl3qcENk4Q37wiT3FXqJPXMZ6Zxhy7VZ9x
        s7c38S2YquQ142u1lvWsv7oaD4Q/VnKs5mhaZvXS212JpTgj0VCLuag4EQDlq97aIgMAAA==
X-CMS-MailID: 20180309080126eucas1p2e08fe4d362c52f87cbbade947a4a5ace
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180309080126eucas1p2e08fe4d362c52f87cbbade947a4a5ace
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180308152434epcas2p273cdc2c4bfe226a0f3dd55c15993bef5
X-RootMTR: 20180308152434epcas2p273cdc2c4bfe226a0f3dd55c15993bef5
References: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180308152434epcas2p273cdc2c4bfe226a0f3dd55c15993bef5@epcas2p2.samsung.com>
        <1520522643-11756-2-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.2018 16:24, Jacopo Mondi wrote:
> Document Thine THC63LVD1024 LVDS decoder.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../bindings/display/bridge/thine,thc63lvd1024.txt | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> new file mode 100644
> index 0000000..53b6453
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> @@ -0,0 +1,59 @@
> +THine Electronics THC63LVD1024 LVDS receiver
> +--------------------------------------------
> +
> +The THC63LVD1024 is an LVDS receiver designed to convert multiple LVDS streams
> +to digital CMOS/TTL parallel data.

You say multiple streams, but bindings describe only one stream.
> +
> +Required properties:
> +- compatible: Shall be one of the following:
> +  "thine,thc63lvd1024",
> +  "lvds-decoder"
> +
> +Optional properties:
> +- supply-vcc: Power supply for TTL output and digital circuitry
> +- supply-cvcc: Power supply for TTL CLOCKOUT signal
> +- supply-lvcc: Power supply for LVDS inputs
> +- supply-pvcc: Power supply for PLL circuitry
> +- pwnd-gpio: Power down GPIO signal. Active low.

Specs [1] uses "/PDWN" name for the pin, moreover gpios suffix is preferred.

Another issue I see is two possibly contradicting conventions:
1. Properties should be named according to specs - so here it should be
named pdwn-gpios.
2. The bindings tries to be generic for lvds decoders, in such case
probably preferred name should be more generic, maybe power-gpios.

Personally I would prefer 1, in such case generic lvds-decoder driver
should look for gpio names according to compatible string.

[1]: http://www.thine.co.jp/files/topics/179_ext_12_0.pdf

> +- oe-gpio: Output enable GPIO signal. Active high.

oe-gpios

> +
> +The THC63LVD1024 has two video ports, whose connections are modeled according
> +to OF graph bindings specified by Documentation/devicetree/bindings/graph.txt
> +
> +- Port@0: LVDS input port
> +- Port@1: Digital CMOS/TTL parallel output

According to specs it has two lvds input and two parallel output ports,
maybe it would be good to describe all here.

Regards
Andrzej

> +
> +Example:
> +-------
> +
> +	lvds_decoder: decoder-0 {
> +		compatible = "thine,thc63lvd1024";
> +
> +		vcc-supply = <&reg_lvds_vcc>;
> +		lvcc-supply = <&reg_lvds_lvcc>;
> +
> +		pwdn-gpio = <&gpio4 15 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				lvds_dec_in: endpoint {
> +					remote-endpoint = <&lvds_out>;
> +				};
> +			};
> +
> +			port@1{
> +				reg = <1>;
> +
> +				lvds_dec_out: endpoint {
> +					remote-endpoint = <&adv7511_in>;
> +				};
> +
> +			};
> +
> +		};
> +	};
