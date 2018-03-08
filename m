Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935427AbeCHIBB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:01:01 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:52819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755077AbeCHIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:00:59 -0500
Date: Thu, 8 Mar 2018 09:00:39 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Matheus Castello <matheus@castello.eng.br>
Cc: linus.walleij@linaro.org, eric@anholt.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <188888639.307907.1520496039100@email.1und1.de>
In-Reply-To: <047e47b4-daf7-2ba2-ea86-0060a59049b7@castello.eng.br>
References: <431699005.307231.1520086916739@email.1und1.de>
 <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
 <821312841.275581.1520423887935@email.1und1.de>
 <047e47b4-daf7-2ba2-ea86-0060a59049b7@castello.eng.br>
Subject: Re: [PATCH v2 0/3] pinctrl: bcm2835: Add brcm,level property
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:/cnuFyQ46pFdOYkUR9eEC9epdczSvyIzre3vUTElj69nDvAd7eY
 VT6vHdHu4drWbSYKxEqNwCUgwC2VCbfJYfjI/J1zorbGWVSBgCF5dsHgrRoLvYF3dFw4FbL
 DpbHeqioGt/8uPjxbrrgRFZ0RqmVIBmEKOjNgpi6ww+IRABlFXR7RlUW5sihiCqL4e5HpKL
 KxxwsvOIw2mwUfCCN8s5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x+1Pi7wWJWg=:UnOyHFRuE1HpgWmbgY+hln
 SVjvldlVzWbvBaPHFtCV7aGztjZ1zIQBJLCW25+MWwFmqCGb8Oc9g/9BfhFlU6CPnkSw+P39D
 KZBkMXb1ZXMc0Je27sRcv13zezW+CLMlyhY5muwBj/Zcu+OJe8vOQ4DPxPF/sAFtu4SxeIy8S
 7rp3nVtGMCEegcXIY0AXxdNVskIggt3LSqnullnbJSAjUUz9y0mOeHTUWJ7VruIQAVpigc20J
 Otu9y/DcLvKcOUgy+hejLLvM+CrxkdI56baldz4XyZ6z45lFRh6lU1CquLC/ZEJOTxBN1gah3
 l00VUqPgWswFnyQdvuA0T0ryTIoWiVRAegEX3wgkGHf+0X+rAVS7RSY2P14tldkUWEWPNI5nP
 JYixbfdogYtjVAtcbZscC1cupaZ/D7krWaTSHAWk5fQJXaoUoORHpoT+4LjOIUMs0f9vrAI7J
 Z2alQJj4ge14Y/QcyIlhcN2EC0bXO2FZceSFRBYEorsT8feOu/Gxui6dSgv9MSDTqISRDQJCz
 ttQlbvwcto+9RVQQXuCXPdRLW6Fq0bA8BQN5AgWH5y++BmQSjwPPpDvDPrZN32eY+PDhg97RQ
 T8k58wgXNDjKcIa51GSC68BxzHosLz+v4/yJsnNXwM6g8Aakojo5ME3n+E11yA6Sy/9zAQV1k
 VoSsIct346bZzbAKs4fmZJQcy8h9lDuc+yWWbNSbrnJpLEnZ4r7fy5s/vARZI8QjOUhTv1W+7
 1QyHokToBJmAK2dhzDbTkkS7tGKGkHb8RZeHuxWHu/x0vWXVpdu+xxidAIA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

> Matheus Castello <matheus@castello.eng.br> hat am 8. März 2018 um 01:12 geschrieben:
> 
> 
> Hi Stefan,
> 
> On 03/07/2018 07:58 AM, Stefan Wahren wrote:
> > Hi Matheus,
> > 
> >> Matheus Castello <matheus@castello.eng.br> hat am 5. März 2018 um 03:29 geschrieben:
> >>
> >>
> >> Hi Linus and Stefan,
> >>
> >> thanks for the tips.
> >>
> >> This series adds support for generic binding for pinctrl bcm2835 driver,
> >> and add the code for set output buffer of a pin using the output-low and
> >> output-high generic properties.
> >>
> >> Tested on Raspberry Pi Zero W, based on bcm2835 SoC.
> >>
> >> Matheus Castello (3):
> > 
> > looks like you missed the changes to the dt binding. Please also add Rob Herring and Mark Rutland to CC. We need a ACK from them.
> 
> are you talking about the .dts files? I add an overlay file for my tests. 
> I was thinking it would be better to start with this changes in the driver and then in another series to convert to the generic style in the .dts.
> If you find it better already add the conversion also in this series let me know.
> 
> I understood that I should put the device tree maintainers in thread only if I were to introduce a new property. As I am using generic properties and not introducing new ones I did not add them.
> Let me know if it is still necessary I stayed in this doubt.

no this is a misunderstanding. You are changing the DT interface because the driver supports new properties (from driver point of view). The DT users usually look at the binding document [1] not the source code. So you need to extend the binding document before changing the source code within a patch series. At the end we need a DT maintainer's ACK for the binding change. Using the generic properties doesn't allow us to skip this, but it increases the chance of an ACK.

Btw it's okay to keep the DTS files.

Stefan

[1] - https://elixir.bootlin.com/linux/v4.16-rc4/source/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt

> 
> Best Regards
> Matheus Castello
> > 
> >>   pinctrl: bcm2835: switch to GENERIC_PINCONF
> >>   pinctrl: bcm2835: Add support for generic pinctrl binding
> >>   pinctrl: bcm2835: Add support for output-low output-high properties
> >>
> >>  drivers/pinctrl/bcm/Kconfig           |  1 +
> >>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 88 +++++++++++++++++++++++------------
> >>  2 files changed, 60 insertions(+), 29 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
