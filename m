Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeCFIGd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:06:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47477 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCFIGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:06:31 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180306080628euoutp0145f3b804575e2bbe98ce37d7cf60834f~ZRj_ThysS1024810248euoutp019
X-AuditID: cbfec7f5-b45ff700000028a9-43-5a9e4c02e723
Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
 bindings
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Cc: Jolly Shah <jolly.shah@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Bj=c3=b6rn_Andersson?= <bjorn.andersson@linaro.org>,
        sean.wang@mediatek.com, Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>, rajanv@xilinx.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
Date: Tue, 06 Mar 2018 09:06:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURTGuW/em3kOTV0nw4OV1bRQkZlZdKmworBHSAUFxRDppA8N93ku
        aZi51jhtaqWNqS1qJVbilpWTuSOmYpKRubSnlUKKaGhOPZ+C//3O+b7Dud/lsDL1a8aOPRkQ
        wusDdH4auZIuq//T6kC5ZWk31Iw7EEujM2mqHKRJdm0LQzIzUhD51mmmSMuDeIoMd0eRos8d
        DGl/dlNOct+2USQ23pkM9h8lKaP9CmKpKFeQV5mFDOkrsd2JuYKsAsQlNztwT03dCq4o3yDn
        ujoq5Fx1zXnEFedEc/GNlTQ3XGTPmYfH6YNKrXK7F+93MozXO7p4KH2yOzcHtduc+mQ+x5xF
        xfOSkBULeBPcH7pMJSElq8b3EYz1VDGioMbDCHJj1s2YHqbWKyRTHoKU3jdyqfiOoDSxTia6
        5uMDEJtRR4lsg93grikHiSYZHqKhOytPIQpy7ARJA0lykVXYBRKbGqeGabwSbhdf/c8suwAf
        g58TrpLFGsZSe2ixbYUPwUcDEdsyvBW+TSYwEi+B4oIBmcS2EJfwjhbXAs5TQH5HGyMl2AMG
        w2+FxPPhR0PJNC+C9lQjLXE0XBqtpaThCwjM8dcoSdgGNQ1t09vmQkpZ2tQ7AavgfKJasnBg
        SetFEu+C558LaemD6ilI7x9CV5C9aVYe06wQplkhTLNC3EJ0PrLlQwV/b15wDuDD1ws6fyE0
        wHu9Z6B/Efp/aU2TDSPl6MXEiWqEWaSZoyrkMrVqRhcmRPhXI2BlGhvVUccsrVrlpYuI5PWB
        7vpQP16oRgtZWmOrOr76jFaNvXUhvC/PB/H6GZVirezOot1fvSvyjK2XFuIVqh3BaV2ullKj
        541rPddrL2aP3PF1fyms0R2Zu6DKZumKfeEr35OBvoltj47lrN4/+XRxsO9f2b3AqOTmw/ke
        30fT92TurfQKe25s20qHfFj+y7zFZ1RtN3YaBxt/lS9raLbuV9WtOvzEoI/Z/XhjpCWuKveL
        MvqehhZ8dE5rZXpB9w/fnSz/ZQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xa7pMPvOiDJ7/ZrH4f9LY4vT+dywW
        84+cY7WYO3sSo8WzW3uZLM6tbGGy+Hy31mLT42usFpd3zWGzWHr9IpNFU4uxxbuXERaTvr9k
        t/i/Zwe7xZm5G1gtXmwRdxDwWDNvDaPHxLO6Hjtn3WX32LSqk83jzrU9bB6HDncwemxeUu/R
        cnI/i8fnTXIeez//ZgngiuKySUnNySxLLdK3S+DKmH/LtOCySMWjve2sDYyb+bsYOTkkBEwk
        1k4+xt7FyMUhJLCEUWLr8XusEM5zRontD1cyglQJC/hKdB9oA7NFBHwkFs9awghSxCzwjUXi
        elMrE0THMSaJm4/vMYFUsQkYSnS97WIDsXkF7CTaTp9kBrFZBFQlFm6eAmaLCsRITP24kRWi
        RlDix+R7LCA2p0CwxNW/z8FqmAXMJL68PMwKYctLbF7zFiouLtHcepNlAqPALCTts5C0zELS
        MgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiB0bft2M8tOxi73gUfYhTgYFTi4d3g
        MTdKiDWxrLgy9xCjBAezkghvhP68KCHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE0hNL
        UrNTUwtSi2CyTBycUg2M1WeS7XIbuObFzgksf7vPSWCdFWOBmavzhAwBlgV3GVOY3XQ5nYSV
        tq7rbE1fYvlf8+Mlr8nn6pjaRL5WqxUKbt+skTlpi/Vrg7Lwd+4Cz3J765PXi/xz2s9SVlS6
        J2r11W+THh2xuKzir+cg3nHR+uXvyB+nZ+uxXJvCuro6++bMAO433vOVWIozEg21mIuKEwGe
        gyaGugIAAA==
X-CMS-MailID: 20180306080626eucas1p1adc19c697783c45da56c6076caf975ff
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5
X-RootMTR: 20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
        <1519775750-21297-2-git-send-email-jollys@xilinx.com>
        <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
        <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
        <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018-03-06 08:59, Geert Uytterhoeven wrote:
> Hi Rob, Jolly,
>
> On Mon, Mar 5, 2018 at 11:39 PM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Feb 27, 2018 at 03:55:49PM -0800, Jolly Shah wrote:
>>> Add documentation to describe ZynqMP power domain bindings.
>>>
>>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>> ---
>>>   .../devicetree/bindings/power/zynqmp-genpd.txt     | 46 ++++++++++++++++++++++
>>>   1 file changed, 46 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/power/zynqmp-genpd.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
>>> new file mode 100644
>>> index 0000000..25f9711
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/zynqmp-genpd.txt
>>> +This node contains a number of subnodes, each representing a single PM domain
>>> +that PM domain consumer devices reference.
>>> +
>>> +== PM Domain Nodes ==
>>> +
>>> +Required properties:
>>> + - #power-domain-cells: Number of cells in a PM domain specifier. Must be 0.
>>> + - pd-id: List of domain identifiers of as defined by platform firmware. These
>>> +       identifiers are passed to the PM firmware.
>>> +
>>> +Example:
>>> +     zynqmp-genpd {
>>> +             compatible = "xlnx,zynqmp-genpd";
>> What's the control interface for controlling the domains?
>>> +
>>> +             pd_usb0: pd-usb0 {
>>> +                     pd-id = <22>;
>>> +                     #power-domain-cells = <0>;
>> There's no need for all these sub nodes. Make #power-domain-cells 1 and
>> put the id in the cell value.
> That was my first reaction, too...
>>> +             };
>>> +
>>> +             pd_sata: pd-sata {
>>> +                     pd-id = <28>;
>>> +                     #power-domain-cells = <0>;
>>> +             };
>>> +
>>> +             pd_gpu: pd-gpu {
>>> +                     pd-id = <58 20 21>;
> ... until I saw the above.
> Controlling the GPU power area requires controlling 3 physical areas?
>
> However, doing it this way may bite you in the future, if a need arises to
> control a subset. And what about power up/down order?

What about defining 3 separate domains and arranging them in parent-child
relationship? generic power domains already supports that and this allows
to nicely define the power on/off order.

>>> +                     #power-domain-cells = <0x0>;
>>> +             };
>>> +     };

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
