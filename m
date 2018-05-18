Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeERGay (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:30:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50050 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeERGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:30:52 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180518063050euoutp0144aeec08a36f2f951a8ab9932c47edb2~vqWUaxmJ31114211142euoutp01f
X-AuditID: cbfec7f2-1dbff70000011644-92-5afe731848dd
Subject: Re: [PATCH 1/2] dt-bindings: power: Add ZynqMP power domain
 bindings
To: Jolly Shah <JOLLYS@xilinx.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Bj=c3=b6rn_Andersson?= <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <be5cecb2-3d0d-22f8-48a2-f94ed9546e04@samsung.com>
Date: Fri, 18 May 2018 08:30:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <SN1PR02MB37588BFF357865F4C9628D99B8910@SN1PR02MB3758.namprd02.prod.outlook.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOzo7L2XEWe8pLtKi0UjMz3rKkDwaHiMoPQS2zZh50pMt2
        tBt0s2E6otQ0bWpesIyQkimlopmXuURXzfBCKESpqOWEtOxCK+fR8tvveZ7///0/D7w0IR8S
        r6A12iROp1XHKykp+bTtx2t/4B2qTVU1gfhPezDuaLSTuKj1lRgX5mchPPyuQYQnBy5i08ce
        MX5bV0Dh+702EU7RB2P76CGcNT0qwX/qayS4s7BSjEeqFbuWsBX3KhCbafVna40DEtb0KJ1i
        +3vqKba5JQ2xVWWXWX17I8lOmnzYhslf5AGpSrojhovXnOF0gWHHpXFXrcOiRNuSc01V2eQV
        VLDYgFxoYLZAf913ZEBSWs48RGD+PEUKxRQCa2U/JRSTCCxNtaJ5y3SOWSIMyhF0/8yYKyYQ
        1OTlUE6VB7MfUvLNs46ljBYelLSJnCKC6SOhOzcTOQcUEwSGccOsQcaEwU/HFOFkklkDg/YP
        s+ZlTCTcudcrEjTu0H53kHSyC3MUzC05YicTzEp4Nl5ACKyAd4NFc6um0zBWEidwOFh72iiB
        PWDMUi0R2As6bt8gBb4MN6dbZxcF5gaCBn3O3EOh0GKxzYTRMwF+8KQuUGjvhO6+YtLZBsYN
        +sbdhRXcIOtpLiG0ZZCWKhfUa8FoefwvtelNF5GBVhsXHGZccIxxwTHG/7nFiHyEFFwynxDL
        8UFa7mwAr07gk7WxASdOJZjQzOfrcFi+1KCvXdHNiKGR0lU2kvlbJRerz/DnE5oR0IRyqWx7
        iEMll8Woz1/gdKeO6ZLjOb4ZedKkUiGL8r2kkjOx6iTuJMclcrr5qYh2WXEFeb/ceVqVjbd5
        Bods1R8qVfptLIvcG/tp3fXEoYGo1FD7bgo8hu09vhpZEl9eXti7YYv468RzhSa6Pag6nIzQ
        V5VU7Jny8eY3Ryw3rFpk8vCeOBh5q3PZ1t73R2z55sNulzRe2xwOa+m1b5YW7wrPGE1eeMig
        p22fNUL+4lkKdlWSfJw6aD2h49V/ASUVUWt4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7rixf+iDH7P0LH4f9LY4vT+dywW
        84+cY7WYO3sSo8WzW3uZLD7frbXY9Pgaq8XlXXPYLJZev8hk0dRibPHuZYTFpO8v2S3+79nB
        bnFm7gZWixdbxB34PdbMW8PoMfGsrsfOWXfZPTat6mTzuHNtD5vHocMdjB6bl9R7tJzcz+Lx
        eZOcx97Pv1kCuKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0MhrPPmMquMhfcXDzFJYGxjncXYycHBICJhLfpx5l72Lk4hASWMooseHGBBaIhIzE
        yWkNrBC2sMSfa11sEEVvGSXOdE4FKxIW8JXoPtDGCGKLCORJ9Kw4yAJSxCxwi0Xi8ewNTFBj
        WSROrj/EBFLFJmAo0fUWZBQnB6+AncSvf1+YQWwWAVWJJ+8egdWICsRI/DjaxQJRIyhxcuYT
        MJtTIFbi6OGpYCcxC5hJzNv8kBnClpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZ
        VjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG+7ZjPzfvYLy0MfgQowAHoxIP74uJf6OEWBPL
        iitzDzFKcDArifBamf6LEuJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YCLKK4k3NDU0t7A0
        NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXA6HVMYPr5TQt9Xdf03KnNeiqnurdp
        gdO6K4wqUlVCYmtkPnL/LDSPPR34Pvg280aPF0dlTse6+ZtZTddo779guWeWpnnRLAn2A5M8
        uN/avHlgr2qtmp4i3vlfLDWum3XLj1OeIk0Tt1wTeeoYoTiJJ9Pob57LVSP2x5evuVy8+Fqh
        58fRAMa1SizFGYmGWsxFxYkA1TdS2wwDAAA=
X-CMS-MailID: 20180518063048eucas1p24f6e0abf2fcb2449cf64b1508670cc6d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180518063048eucas1p24f6e0abf2fcb2449cf64b1508670cc6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5
X-RootMTR: 20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5
References: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
        <1519775750-21297-2-git-send-email-jollys@xilinx.com>
        <20180305223905.65nnunv63fyg7bye@rob-hp-laptop>
        <CGME20180306075954epcas5p2bbfb21f146ab879b60d004b73187a5e5@epcas5p2.samsung.com>
        <CAMuHMdVpWciek2xow1Y1W7jga6BEbAZ7OhnyviRsXK39vYGyXw@mail.gmail.com>
        <d47ed37f-057f-b510-de70-1140dad1b7ad@samsung.com>
        <DM2PR0201MB07670C06F504F97EF4E4BAD4B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
        <SN1PR02MB37588BFF357865F4C9628D99B8910@SN1PR02MB3758.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jolly,

On 2018-05-17 23:10, Jolly Shah wrote:

>>>>>> +Example:
>>>>>> +     zynqmp-genpd {
>>>>>> +             compatible = "xlnx,zynqmp-genpd";
>>>>> What's the control interface for controlling the domains?
>>>>>> +
>>>>>> +             pd_usb0: pd-usb0 {
>>>>>> +                     pd-id = <22>;
>>>>>> +                     #power-domain-cells = <0>;
>>>>> There's no need for all these sub nodes. Make #power-domain-cells 1
>>>>> and put the id in the cell value.
>>>> That was my first reaction, too...
>>>>>> +             };
>>>>>> +
>>>>>> +             pd_sata: pd-sata {
>>>>>> +                     pd-id = <28>;
>>>>>> +                     #power-domain-cells = <0>;
>>>>>> +             };
>>>>>> +
>>>>>> +             pd_gpu: pd-gpu {
>>>>>> +                     pd-id = <58 20 21>;
>>>> ... until I saw the above.
>>>> Controlling the GPU power area requires controlling 3 physical areas?
>>>>
>>>> However, doing it this way may bite you in the future, if a need
>>>> arises to control a subset. And what about power up/down order?
>>> What about defining 3 separate domains and arranging them in
>>> parent-child relationship? generic power domains already supports that
>>> and this allows to nicely define the power on/off order.
>>>
>>>>>> +                     #power-domain-cells = <0x0>;
>>>>>> +             };
>>>>>> +     };
>> I agree it should be arranged in as parent child order to control subset or control
>> order. Will incorporate those changes in next version.
>
> As suggested, I tried out parent, child approach. However what I found is Genpd core takes care of parent child dependencies for power on off routines only. In our case, We need them in attach-detach routines too. In that case, we need to handle dependencies manually for those routines. Please suggest better approach, if any.

What do you mean to handle attach-detach?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
