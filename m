Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbeA3XyC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:54:02 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35061 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeA3Xx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:53:59 -0500
X-Google-Smtp-Source: AH8x224o+QRp1XSDPkTXVbZE4KLdKZw5Kfmbnb/9PR8qZ8KeCRz5YcfvVwp1YKwA8/drfygCwlx6yg==
From: Kevin Hilman <khilman@baylibre.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5]  i2c: meson-axg: add I2C controller driver
Organization: BayLibre
References: <20171120145415.6581-1-yixun.lan@amlogic.com>
        <7ho9ltba6c.fsf@baylibre.com>
        <20180124063019.mzq7egwotn2uakr5@ninjato>
Date: Tue, 30 Jan 2018 15:53:54 -0800
In-Reply-To: <20180124063019.mzq7egwotn2uakr5@ninjato> (Wolfram Sang's message
        of "Wed, 24 Jan 2018 07:30:19 +0100")
Message-ID: <7hzi4uc38t.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

>> >   ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
>> >   ARM64: dts: meson-axg: describe pin DT info for I2C controller
>> >   ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker
>> 
>> Once you've merged, I'll take the DT patches through my amlogic tree.
>
> Done now! Have fun with the patches...

Thanks!

The DT patches are now queued in the amlogic tree (branch: v4.17/dt64)

Kevin
