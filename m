Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeE3J7a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:59:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58756 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeE3J7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:59:22 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180530095919euoutp01db94b29bebcb8ce0b67ec908f620824e~zY7yIJ6-M0372203722euoutp01j
X-AuditID: cbfec7f2-1c1ff70000011644-f4-5b0e75f49c83
Subject: Re: [PATCH 07/12] dt-bindings: tc358754: add DT bindings
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Wed, 30 May 2018 11:59:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2275901.CJI6BsfBlP@avalon>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRj3fX93c+11Uo8f07rWVm2isH23MCbb+0ej5Z+IdPSuTJfc2+XH
        hltip+YcZl1XxCqU2uX6fUNTR0KlQjQUtZE6LGWaH+l6z/Tf5/k8n+fzPJ/t4UhVNrOI25uW
        IerSNKlqRkHVPZjsWDau945fYXkejs90tBE4y+ii8S2LjcZFzg4aP5v4wuDz/WYKf3zbReGz
        gyMk7uysYnF71iiLT58rYbF98AWNexyFDLZ03iXwleE+Clc637C4tLeLwCfvOFlsuTDM4EnH
        ZWq9j1BxuQIJPaYzhNBofcMKBcZ8WrCXn2aE+u8DtNCf20oI1SXHBVNNORK+2ZfGKLYr1iSJ
        qXszRd3ydYmKlLKHRiK93P/QVK2dMKDshTnIiwN+FbRNmqkcpOBU/A0ELTYbKxfjCMa+PPIU
        3xCY6h3sv5Fi14SncR3Bj5p3hFy4EHxw5jBu1Xx+A/SWmWk39uETIedZL+nGJO+gwWXLcGOG
        D4Hf1a9m9BQfBN+Lqyk3XsDHwS3z2Ixeyc+DtvyhGd6LD4bSP4OE7OMP9a5Cj6cf9A0VzRwB
        fAMHWc1ZtDycCR8uORn57Ch40dTuiTAfPrXWePASmGosImQswdhFg8fIgKDgehslNyKhpbVr
        2pSb3hYCNsdymd4AuYZs5KaB94aXrnnyPd5wvi6PlGklGE+pZHUA9LfXkjL2g9KnE4wZqa2z
        UlpnJbPOSmb9v/cKosqRn6iXtMmiFJ4mHgyTNFpJn5Yctme/1o6mf/Pxn9axBjTRvbsZ8RxS
        z1WuiFPGq2hNpnRY24yAI9U+Sv2dufEqZZLm8BFRt3+XTp8qSs1oMUep/ZQJwce2q/hkTYa4
        TxTTRd2/LsF5LTKgmyN9gzGvS+rryF+77v3cWeVbeZsJ9Fq9cc+2J5sG/K9F0FtDTUHRU4HG
        +9ErA4q29NgjAp80LUAndLmmJHtpIG/6GJ3ga4H4uMq1V0Oujh4d7vi8w9Rkj63JC7W+jVrl
        KwhsZNm1r/mdXaeGDkrdYeOWzbkD77Wxhw7MiehbJkSpKSlFEx5K6iTNX9unGmyXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsVy+t/xe7qfS/miDV71cFr0njvJZNHU8ZbV
        YuOM9awW84+cY7W48vU9m8Wk+xNYLF7cu8hi0f/4NbPF+fMb2C3ONr1ht+icuITdYtPja6wW
        l3fNYbOYcX4fk8WCl7dYLNYeuctusfT6RSaL1r1H2C1mTH7JZvFz1zwWBxGPNfPWMHpc7utl
        8tg56y67x+yOmawem1Z1snls//aA1eN+93Emj81L6j36tqxi9Pi8SS6AK0rPpii/tCRVISO/
        uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY+WJDqaCVfIV/7duYmpg
        bJHsYuTkkBAwkVj89it7FyMXh5DAUkaJS/1nWCES4hK7579lhrCFJf5c62KDKHrNKNG65gIT
        SEJYwFHi+soJYA0iAgkSHScngRUxC+xjlVhz5zcTRMdHRom5954yglSxCWhK/N18kw3E5hWw
        k3j7bx6YzSKgKvFt8WYWEFtUIEKiad4adogaQYmTM5+AxTkFNCSW/nsMtplZQF3iz7xLzBC2
        vMT2t3OgbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85
        P3cTIzBVbDv2c8sOxq53wYcYBTgYlXh4DSJ4o4VYE8uKK3MPMUpwMCuJ8Jbu5YkW4k1JrKxK
        LcqPLyrNSS0+xGgK9NxEZinR5HxgGssriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2a
        WpBaBNPHxMEp1cC4Ou/hsTt3muWrw4+tZPfeLhv85YOyhewy569LZ/t/WiItc3z7jLc/f6Xy
        BL47ujt72mKLJfunJE1fKVa28LL6ao6Ut2eY7qpvjhMw9Lm6M75GbZPn1Ot187S0rm/MS352
        Iuy4a3223/En9ye16zV1Ld00scWqYoqTTdhsRWWRbzGzjF6EpNxzUmIpzkg01GIuKk4EAEn4
        x4ErAwAA
Message-Id: <20180530095915eucas1p27f09c8424d0c3c0619d134c5e7319fa3~zY7uP6Y6R1391213912eucas1p23@eucas1p2.samsung.com>
X-CMS-MailID: 20180530095915eucas1p27f09c8424d0c3c0619d134c5e7319fa3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180528094727eucas1p153b8116120cd2195b15b74776f171cbe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528094727eucas1p153b8116120cd2195b15b74776f171cbe
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
        <CGME20180528094727eucas1p153b8116120cd2195b15b74776f171cbe@eucas1p1.samsung.com>
        <1527500833-16005-8-git-send-email-m.purski@samsung.com>
        <2275901.CJI6BsfBlP@avalon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.2018 12:18, Laurent Pinchart wrote:
> Hi Maciej,
>
> Thank you for the patch.
>
> On Monday, 28 May 2018 12:47:11 EEST Maciej Purski wrote:
>> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
>> Bindings describe power supplies, reset gpio and video interfaces.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> ---
>>  .../bindings/display/bridge/toshiba,tc358764.txt   | 42 +++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt new
>> file mode 100644
>> index 0000000..d09bdc2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>> @@ -0,0 +1,42 @@
>> +TC358764 MIPI-DSI to LVDS panel bridge
>> +
>> +Required properties:
>> +  - compatible: "toshiba,tc358764"
>> +  - reg: the virtual channel number of a DSI peripheral
>> +  - vddc-supply: core voltage supply
>> +  - vddio-supply: I/O voltage supply
>> +  - vddmipi-supply: MIPI voltage supply
>> +  - vddlvds133-supply: LVDS1 3.3V voltage supply
>> +  - vddlvds112-supply: LVDS1 1.2V voltage supply
> That's a lot of power supplies. Could some of them be merged together ? See 
> https://patchwork.freedesktop.org/patch/216058/ for an earlier discussion on 
> the same subject.

Specs says about 3 supply voltage values:
- 1.2V - digital core, DSI-RX PHY
- 1.8-3.3V - digital I/O
- 3.3V - LVDS-TX PHY

So I guess it should be minimal number of supplies. Natural candidates:

- vddc-supply: core voltage supply, 1.2V
- vddio-supply: I/O voltage supply, 1.8V or 3.3V
- vddlvds-supply: LVDS1/2 voltage supply, 3.3V

I have changed name of the latest supply to be more consistent with
other supplies, and changed 1.8-3.3 (which incorrectly suggest voltage
range), to more precise voltage alternative.


>
>> +  - reset-gpios: a GPIO spec for the reset pin
>> +
>> +The device node can contain zero to two 'port' child nodes, each with one
>> +child
>> +'endpoint' node, according to the bindings defined in [1].
>> +The following are properties specific to those nodes.
>> +
>> +port:
>> +  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
> This seems pretty vague to me. It could be read as meaning that ports are 
> completely optional, and that the port number you list can be used, but that 
> something else could be used to.
>
> Let's make the port nodes mandatory. I propose the following.
>
> Required nodes:
>
> The TC358764 has DSI and LVDS ports whose connections are described using the 
> OF graph bindings defined in Documentation/devicetree/bindings/graph.txt. The 
> device node must contain one 'port' child node per DSI and LVDS port. The port 
> nodes are numbered as follows.
>
>   Port                  Number
> -------------------------------------------------------------------
>   DSI Input             0
>   LVDS Output           1
>
> Each port node must contain endpoint nodes describing the hardware 
> connections.

Since the bridge is controlled via DSI bus, DSI input port is not necessary.

Regards
Andrzej


>
>> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>> +
>> +Example:
>> +
>> +	bridge@0 {
>> +		reg = <0>;
>> +		compatible = "toshiba,tc358764";
>> +		vddc-supply = <&vcc_1v2_reg>;
>> +		vddio-supply = <&vcc_1v8_reg>;
>> +		vddmipi-supply = <&vcc_1v2_reg>;
>> +		vddlvds133-supply = <&vcc_3v3_reg>;
>> +		vddlvds112-supply = <&vcc_1v2_reg>;
>> +		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		port@1 {
>> +			reg = <1>;
>> +			lvds_ep: endpoint {
>> +				remote-endpoint = <&panel_ep>;
>> +			};
>> +		};
>> +	};
