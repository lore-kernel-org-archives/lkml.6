Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05379C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3B42081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3B42081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeKKAFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:05:22 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:33453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeKKAFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:05:21 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLiTI-1g3ogk2ihs-00Hbau; Sat, 10 Nov 2018 15:18:50 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-pm@vger.kernel.org, alsa-devel@alsa-project.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 00/17] bcm2835: Treewide switch to SPDX identifier
Date:   Sat, 10 Nov 2018 15:17:56 +0100
Message-Id: <1541859476-6210-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:vwXAb1RZA61Qey00Gkzc0bF6JYfZq3uqSncOpdLeoVwJ0u8nSMB
 nAPM8K5LJrLn9L+4eKw0BdMDjKRULzy+jbwb5lb5qS7FiTIKUMDgQQQjh5XcJGl+++t5ofR
 qqkjxJn4nC4sAJtRs6JcY2tjlkxcMHdKJUMAICREpbzZqWjvCqfT3BtgudV5n/WFQWrIUVz
 GQ4CP/37ULjjX+zpnh6kA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6tDHYhuzJaU=:qcEOkb1mvLUMlQeVQOFtnp
 thdMCgG5xFgbmcJI9X4zx+CTxR1K8bGCgagf7rD86JckdUrzYs/N0KJ3pQW+psRoiNuWh49yQ
 obCms+2F9o3P0kxnPTfiy/AAwfvt6GlIRW83f9h5bUAPe8h6ze3clbZC5MUl+FlK59hJTuwr9
 0H6TSTNjCJdE3MCJwGBwSYhaInFWwzw+4gZdutUL8dZMDkowDziuLrDsetQlImwMZ1aElEyn+
 TTeo/vj44Tr/+tBXnONqZdUhXtgPoBdrmUW2PGLsvuA4+3uyIYHtyexI/2mXQL9N5wP1+HRhW
 1r02RwGcdHBWN5bXKzBxwefEUFTdIA7kc66qa1YGH9EYO2Nlve+guHTRayU1k0txe0P760C75
 uDOdT+FTf/xknQi6gU2JxlxrAT454/wszT2c1Pdi/85YUZAXFpUvLzZ00Kcc/BVrE3WG/BQyr
 W9OJxID24abpcMk+WpqSEyj2UkbHj9VhFKtV8UrrgqLqZ3TofdNsk5jcCp6u7Lnr93bikMNBZ
 MdSTmxwYw1mhbfVHb3Ys+AY60tcWHjkF1LXX8ZD1JB25MTgQIYZFPxMBWrslRZvNu+qjHLCh3
 a2XWKMgHAxXfQIp+xWMf2SopodH2LnY798IuRF/oiVISkE4hE+/24mFgQjLkzNg9Unsjt8kht
 wiLKu1wevnWXYhz0XbrNc/17vzeC9RR6+KaaK59c/0NGZhYGQlbtdOeRb7OGyiKMtKgIRwB0F
 CVrRkUJ0hn+SSBHIvoRa9zRUb1V570G/RsGyyqjzwG+ymRLgwByQNOqbSJKQjE9mt3uBI+yLq
 mA/e+pltGmDt+tx8d2tbOmc3rgGqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After fixing the module license of some bcm2835 drivers in "Fix MODULE_LICENSE
of bcm2835 drivers", we can finally switch all outstanding bcm2835 /
Raspberry Pi drivers to SPDX identifier and drop the unnecessary license text.
I omit the staging area, because there are proposed a lot of changes for
vc04_services. 

I hope it is okay to have the binding header integrated in the tree-wise
patches instead of a separate one. This should avoid conflicts while merging.

Stefan Wahren (17):
  ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier
  ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier
  hw_random: bcm2835-rng: Switch to SPDX identifier
  clk: bcm2835: Switch to SPDX identifier
  clocksource: bcm2835: Switch to SPDX identifier
  dma: bcm2835: Switch to SPDX identifier
  firmware: raspberrypi: Switch to SPDX identifier
  i2c: bcm2835: Switch to SPDX identifier
  irqchip: bcm283x: Switch to SPDX identifier
  mailbox: bcm2835: Switch to SPDX identifier
  mmc: bcm2835: Switch to SPDX identifier
  pinctrl: bcm2835: Switch to SPDX identifier
  pwm: bcm2835: Switch to SPDX identifier
  soc: bcm: Switch raspberrypi-power to SPDX identifier
  spi: bcm2835: Switch to SPDX identifier
  thermal: bcm2835: Switch to SPDX identifier
  ASoc: bcm2835-i2s: Switch to SPDX identifier

 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts      |  8 +-------
 arch/arm/boot/dts/bcm2835-rpi-zero.dts        |  8 +-------
 arch/arm/mach-bcm/board_bcm2835.c             | 11 +----------
 arch/arm/mach-bcm/platsmp.c                   | 10 +---------
 arch/arm/mach-bcm/platsmp.h                   |  6 +-----
 drivers/char/hw_random/bcm2835-rng.c          |  7 ++-----
 drivers/clk/bcm/clk-bcm2835-aux.c             | 11 +----------
 drivers/clk/bcm/clk-bcm2835.c                 | 12 +-----------
 drivers/clocksource/bcm2835_timer.c           | 15 +--------------
 drivers/dma/bcm2835-dma.c                     | 11 +----------
 drivers/firmware/raspberrypi.c                |  5 +----
 drivers/i2c/busses/i2c-bcm2835.c              | 10 +---------
 drivers/irqchip/irq-bcm2835.c                 | 11 +----------
 drivers/irqchip/irq-bcm2836.c                 | 11 +----------
 drivers/mailbox/bcm2835-mailbox.c             |  8 +-------
 drivers/mmc/host/bcm2835.c                    | 13 +------------
 drivers/pinctrl/bcm/pinctrl-bcm2835.c         | 11 +----------
 drivers/pwm/pwm-bcm2835.c                     |  5 +----
 drivers/soc/bcm/raspberrypi-power.c           |  5 +----
 drivers/spi/spi-bcm2835.c                     | 11 +----------
 drivers/spi/spi-bcm2835aux.c                  | 11 +----------
 drivers/thermal/broadcom/bcm2835_thermal.c    | 11 +----------
 include/dt-bindings/clock/bcm2835-aux.h       | 10 +---------
 include/dt-bindings/clock/bcm2835.h           | 10 +---------
 include/dt-bindings/pinctrl/bcm2835.h         |  8 +-------
 include/dt-bindings/power/raspberrypi-power.h |  5 +----
 include/soc/bcm2835/raspberrypi-firmware.h    |  5 +----
 sound/soc/bcm/bcm2835-i2s.c                   | 10 +---------
 28 files changed, 29 insertions(+), 230 deletions(-)

-- 
2.7.4

