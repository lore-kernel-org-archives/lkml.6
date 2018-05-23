Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeEWGPA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:15:00 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51196 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754005AbeEWGO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:14:57 -0400
X-Google-Smtp-Source: AB8JxZqUj78wyQZ1l7clsiaOOxnpqCVS92QJrimFTdrmwCYU3CtxjGf2jrVGCfAkulnzCCcDGt2hiO+RDf94uAUNCxM=
MIME-Version: 1.0
In-Reply-To: <20180522143044.pgwawojiwnk2lzxb@flea>
References: <20180522132228.6564-1-jagan@amarulasolutions.com> <20180522143044.pgwawojiwnk2lzxb@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 23 May 2018 11:44:56 +0530
Message-ID: <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
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

On Tue, May 22, 2018 at 8:00 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
>> Amarula A64-Relic is Allwinner A64 based IoT device, which support
>> - Allwinner A64 Cortex-A53
>> - Mali-400MP2 GPU
>> - AXP803 PMIC
>> - 1GB DDR3 RAM
>> - 8GB eMMC
>> - AP6330 Wifi/BLE
>> - MIPI-DSI
>> - CSI: OV5640 sensor
>> - USB OTG
>
> You claim that this is doing OTG...
>
> [..]
>
>> +&usb_otg {
>> +     dr_mode = "peripheral";
>> +     status = "okay";
>> +};
>
> ... and yet you're setting it as peripheral...

Though it claims OTG, board doesn't have any USB ports to operate(not
even Mini-AB) the only way to use the board as peripheral to transfer
images from host.
