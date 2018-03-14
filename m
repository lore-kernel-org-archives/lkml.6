Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeCNIP4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:15:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50248 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbeCNIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:15:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180314081547euoutp028dcd1b7919950cd079f0366b9392d7ad~bu2ZdCSMc1450114501euoutp02Z
X-AuditID: cbfec7f5-b5fff700000028a9-09-5aa8da31931c
Subject: Re: [PATCH v3 1/3] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <ebe90ad4-60f4-4ac1-c337-df840b754d53@samsung.com>
Date: Wed, 14 Mar 2018 09:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520951425-13843-2-git-send-email-jacopo+renesas@jmondi.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMcRjHfb6/7ltzfLouPX6MOUIhwuxLNG398cU//IF2LC59dzVdceco
        NksNFzIkzZVfy01LjY4rPzqbu3RaaqUWXfqhFcK5kYuEdPfV9N/r83k/z/N+3tvDkrKf9DQ2
        KWW/oE1RJSsYf6qiZqhhcYSzWLl0KDeMy2moJbhMg4vmrlY30FyLx81wb51WgsuyeBDnGC6T
        cNnnbki45oeFDGfp/0xw3bdcDGd62URwjotnaO6YtVrCPS9xStZN5kuvlCK++UwOwXfnjRD8
        A2OHhC8wXKL5kVc9JG8uyWZ4m92A+MrBbprvOuUg+HfN3xm+cGiQ4gfMMzdJlf5rEoTkpAOC
        dknULv/E7nZ6b+/UtM9uI52BvspPIj8W8Ao4ejkLnUT+rAwXIyj+Xkp6BRn+hiDHrhWFAQSP
        +mskYx32b3ZGFG4ieN3XQYkPF4KO9j++9kAcBx8/tdBeQY7LCKh1//BVkTgTwYvaLF8Vg0Ph
        9902xstSHAVv7p/zMYVD4Gi5yEE4Fq7n9SGxJgBqL/VSXvbDGyDfcNrHJJ4Fla5CUuRgcPZe
        JbxmgE0stFjchLh4DAy/LvoXIhA+OO794xlQlysOAnwY2t5nUmKzAUHX8AlGFCLB7mgazcOO
        OoTC7YdLvAh4LVy2rRZxErxyBYgrTILzFfmk+C0Fw3GZOGM2dNVbSJGDwdToYc6iOcZxwYzj
        whjHhTH+t72GqBIULOh1GrWgW54iHAzXqTQ6fYo6fHeqxoxGL7Luj8NzHz3+FW9DmEWKidIJ
        jTeVMlp1QJeusSFgSYVcaplRrJRJE1TphwRt6k6tPlnQ2dB0llIES+MWHFHKsFq1X9gjCHsF
        7ZhKsH7TMlCk2SwfeqbWBnUW5aoZ8kZ6ArM5KlrfXlXepnkb/V5arwyJs1oWrJ8r7y164Gpa
        Fm0Nv7BjX2u83NlzhyzhphxxpjavWlzmmLdtYP4pT+DGyaYw5slTjSnmy5dFVa35aZ+SKsI6
        16zNyfiJF/at3OLcuj22M6DUHHe2IKjVlKGeoqB0iaqIMFKrU/0FZZkouo0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4XV2DWyuiDDaeVbfoPXeSyaKp4y2r
        xfwj51gtrnx9z2bx7NZeJovmrV8ZLY7/Xstu0TlxCbvF5V1z2Cy2vnzHZPFg9Vs2i6XXLzJZ
        HJ/Wx2rRuvcIu8WZVbfYHfg91sxbw+hxua+XyePB1P9MHjtn3WX3mN0xk9Xj/41HzB6bVnWy
        eRw63MHosf3bA1aP+93HmTyeX/7O5jHn5zcWj8+b5AJ4o/RsivJLS1IVMvKLS2yVog0tjPQM
        LS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyHtxmLXgiWfHu/SzWBsZPIl2MnBwSAiYS
        h78cZuti5OIQEljKKLHy2mUmiIS4xO75b5khbGGJP9e6oIpeM0r8/HUFLCEsECfx+s0VVpCE
        iMBaJoknRxYwgzjMAk2MEhNmf2KCaLnLKDFrw2FWkBY2AU2Jv5tvsoHYvAJ2Eg93TASzWQRU
        JRo3QtiiAhESnSvns0DUCEqcnPkEzOYU8JKY3tEDZjMLqEv8mXeJGcKWl9j+dg6ULS5x68l8
        pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBCaGbcd+btnB
        2PUu+BCjAAejEg8vw4XlUUKsiWXFlbmHGCU4mJVEeLfKrIgS4k1JrKxKLcqPLyrNSS0+xGgK
        9NxEZinR5Hxg0soriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cAY
        83jdpNsJ3Kpigusd7TPSmWPtMuoXaRlf/ZR6+krDr6pv/cE5u5ZFFJ2ZuffyIe3qPbvYj9ZP
        +71kX23wddOkbUw/Vx1Jr9XWyn1/dULp/j8Ka77fYLy8onzn6QWL1SfrcTT7LL3fX3vkR96Z
        mW83KcW2/37Sd+LF12Pif/wiy0M+H7j/m9GyXomlOCPRUIu5qDgRAI/YR1IiAwAA
X-CMS-MailID: 20180314081545eucas1p206b055e7289775c51a5f483d2fb8fe10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180314081545eucas1p206b055e7289775c51a5f483d2fb8fe10
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180313143056epcas4p28ad52892b943d0800c6f77337a40f5f0
X-RootMTR: 20180313143056epcas4p28ad52892b943d0800c6f77337a40f5f0
References: <1520951425-13843-1-git-send-email-jacopo+renesas@jmondi.org>
        <CGME20180313143056epcas4p28ad52892b943d0800c6f77337a40f5f0@epcas4p2.samsung.com>
        <1520951425-13843-2-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.2018 15:30, Jacopo Mondi wrote:
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
> index 0000000..5b5afcd
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

I wonder if it wouldn't be better to make them required (at least VCC) -
it is closer to reality.

> +- pwnd-gpios: Power down GPIO signal. Active low.

As I said before, specs[1] says about "/PDWN" pin. Is it your typo, or
different docs?
Moreover there are already bindings for THC63LVDM83D with the same
dichotomy [2].

Out of curiosity I have googled for "pwnd pin" and it looks like some
vendors use this form.
For me both forms are quite misleading: power down signal, active low,
why they couldn't call it just 'enable, active high'.

[1]: http://www.thine.co.jp/files/topics/179_ext_12_0.pdf
[2]:
https://elixir.bootlin.com/linux/v4.16-rc5/source/Documentation/devicetree/bindings/display/bridge/thine,thc63lvdm83d.txt

> +- oe-gpios: Output enable GPIO signal. Active high.
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
> +		pwdn-gpio = <&gpio4 15 GPIO_ACTIVE_LOW>;
And here another variation :), should be pdwn-gpios.

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
