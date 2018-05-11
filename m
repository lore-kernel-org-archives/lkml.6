Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeEKFu4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 01:50:56 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40662 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEKFuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 01:50:54 -0400
X-Google-Smtp-Source: AB8JxZrDyq3Gx9/ySWR7sfLSWbfL9q9FiV381q4mKtwH7D2JmHIoO5mgD/W6640pzdGUtw5A7bIFog==
MIME-Version: 1.0
In-Reply-To: <20180511054307.3410-1-jagan@amarulasolutions.com>
References: <20180511054307.3410-1-jagan@amarulasolutions.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 10 May 2018 22:50:31 -0700
X-Gmail-Original-Message-ID: <CAGb2v67ZDUqLGiWfocZXzGY54dYcSVUMC-xz87xaJQs88-nqyw@mail.gmail.com>
Message-ID: <CAGb2v67ZDUqLGiWfocZXzGY54dYcSVUMC-xz87xaJQs88-nqyw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: allwinner: a64: Add Amarula A64 Relic initial support
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 10:43 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Amarula A64 Relic is Allwinner A64 based IoT device, which support
> - Allwinner A64 Cortex-A53
> - Mali-400MP2 GPU
> - AXP803 PMIC
> - 1GB DDR3 RAM
> - 8GB eMMC
> - AP6330 Wifi/BLE
> - MIPI-DSI
> - CSI: OV5640 sensor
> - USB OTG
> - 12V DC power supply
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Rename dts name to sun50i-a64-relic.dts which is simple to use

This is subjective. For other users this hardly qualifies to
identify the board. Please keep the vendor / brand name in
the file name.

ChenYu
