Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeCJF0F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 00:26:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51573 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeCJF0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 00:26:04 -0500
Date: Sat, 10 Mar 2018 06:26:01 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 4.17
Message-ID: <20180310052601.GA6294@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Not much this cycle, mainly changes on the Axentia boards from Peter and
a cleanup from Bartosz.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.17-dt

for you to fetch changes up to 6fa65edf87886f85a18680ed7bdedc15cb810065:

  ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9263ek (2018-02-13 17:15:18 +0100)

----------------------------------------------------------------
AT91 DT for 4.17:

 - use 'atmel' as at24 manufacturer
 - device addition and fixes for axentia boards
 - fix sama5d4 pinctrl compatible

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: at91: sam9rl: Properly assign copyright

Bartosz Golaszewski (5):
      ARM: dts: at91: use 'atmel' as at24 manufacturer for sama5d34ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9260ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9g20ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91-sama5d2_ptc_ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9263ek

Peter Rosin (5):
      ARM: dts: at91: nattis: use the correct compatible for the eeprom
      ARM: dts: at91: tse850: use the correct compatible for the eeprom
      ARM: dts: at91: nattis: use up-to-date mtd partitions
      ARM: dts: at91: nattis: add lvds-encoder
      ARM: dts: at91: tse850: make the sound dai cell count explicit

Santiago Esteban (1):
      ARM: dts: at91: sama5d4: fix pinctrl compatible string

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 60 +++++++++++++++++++++--------
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |  2 +-
 arch/arm/boot/dts/at91-tse850-3.dts         |  3 +-
 arch/arm/boot/dts/at91sam9260ek.dts         |  2 +-
 arch/arm/boot/dts/at91sam9263ek.dts         |  2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           |  3 +-
 arch/arm/boot/dts/at91sam9rlek.dts          |  3 +-
 arch/arm/boot/dts/sama5d34ek.dts            |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi              |  2 +-
 10 files changed, 57 insertions(+), 24 deletions(-)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
