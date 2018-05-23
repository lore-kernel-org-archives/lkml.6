Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeEWK1J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:27:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40504 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932437AbeEWK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:27:06 -0400
X-Google-Smtp-Source: AB8JxZoYITJwbWBTXF8K/AW22N5S0f+H/sykfbGP4iB8j0djLeY5F3cRX0jpArBi3kUqm9De0Wt4s8zpIss3CQD66hM=
MIME-Version: 1.0
In-Reply-To: <20180523081830.4ly6sj34reabbttn@flea>
References: <20180522132228.6564-1-jagan@amarulasolutions.com>
 <20180522143044.pgwawojiwnk2lzxb@flea> <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
 <20180523081830.4ly6sj34reabbttn@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 23 May 2018 15:57:05 +0530
Message-ID: <CAMty3ZC-N-6WzYg+kYd2+V3wbQdQmvU706Nog_Urd_EUaWnQjQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: allwinner: a64: Add Amarula A64-Relic initial support
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 1:48 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Wed, May 23, 2018 at 11:44:56AM +0530, Jagan Teki wrote:
>> On Tue, May 22, 2018 at 8:00 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
>> >> Amarula A64-Relic is Allwinner A64 based IoT device, which support
>> >> - Allwinner A64 Cortex-A53
>> >> - Mali-400MP2 GPU
>> >> - AXP803 PMIC
>> >> - 1GB DDR3 RAM
>> >> - 8GB eMMC
>> >> - AP6330 Wifi/BLE
>> >> - MIPI-DSI
>> >> - CSI: OV5640 sensor
>> >> - USB OTG
>> >
>> > You claim that this is doing OTG...
>> >
>> > [..]
>> >
>> >> +&usb_otg {
>> >> +     dr_mode = "peripheral";
>> >> +     status = "okay";
>> >> +};
>> >
>> > ... and yet you're setting it as peripheral...
>>
>> Though it claims OTG, board doesn't have any USB ports to operate(not
>> even Mini-AB) the only way to use the board as peripheral to transfer
>> images from host.
>
> I'm not sure what you mean here. If there's no USB connector, why do
> you even enable it?

I'm saying there is no host port on board. Board has connector
header[1] comes with few pins includes USB D+, D-, ID, VBUS, GROUND,
UART0 TX, RX etc. we have to connect wires to these pins to make
pluggable USB to host pc. and here USB pins used for transferring data
from host pc to target board like in peripheral mode.

Hope you understand.

[1] https://www.digikey.com/product-detail/en/molex-llc/5016451420/WM6074-ND/1787775

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
