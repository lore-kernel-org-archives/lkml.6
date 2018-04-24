Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeDXMZR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:25:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40577 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757725AbeDXMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:25:14 -0400
X-Google-Smtp-Source: AIpwx49S42YUpTZH1mwmOFEwrq3TeeqKCn1TxjqLcxePi4jwxLxt4LO5m2ofmf6siUB2uFxu8/cINg==
MIME-Version: 1.0
In-Reply-To: <20180424121440.qmiubwdgcisn4g4m@flea>
References: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
 <1524570434-17814-3-git-send-email-narmstrong@baylibre.com> <20180424121440.qmiubwdgcisn4g4m@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 24 Apr 2018 20:24:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v65-SOfhf0B-cJhY-9bCWnFuw_r-c19TW0p9kcs7043McQ@mail.gmail.com>
Message-ID: <CAGb2v65-SOfhf0B-cJhY-9bCWnFuw_r-c19TW0p9kcs7043McQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: Add dts file for Libre
 Computer Board ALL-H3-CC H5 ver.
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, clabbe@baylibre.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 8:14 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Apr 24, 2018 at 01:47:14PM +0200, Neil Armstrong wrote:
>> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
>> Pi B+ form factor single board computer based on the Allwinner H2+, H3,
>> or H5 SoCs with the same PCB.
>> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes

The board has 2GB DDR3 SDRAM, provided by 4 4Gb chips. Copy-paste error?

>> and connectors are in the exact same position as on the Raspberry Pi B+.
>>
>> This patch enables the H5 variant using the H3 board definition moved to
>> a common dtsi in an earlier patch. The dts sinmply include the common dtsi

                                              ^ Small typo here.

ChenYu

>> and declares the correct compatible and model of the H5 variant.
>>
>> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
