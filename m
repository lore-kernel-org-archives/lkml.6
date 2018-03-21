Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeCUWuO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:50:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58863 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753691AbeCUWuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:50:13 -0400
Date: Wed, 21 Mar 2018 23:50:01 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 4.17 #2
Message-ID: <20180321225001.GA27480@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

A few DT fixes that came in late in the cycle.

The following changes since commit 6fa65edf87886f85a18680ed7bdedc15cb810065:

  ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9263ek (2018-02-13 17:15:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.17-dt2

for you to fetch changes up to 26f2cacde21b713f7f917d2193a76cc7636ee88e:

  ARM: dts: at91sam9260: pullup rx on usart0 (2018-03-21 21:47:00 +0100)

----------------------------------------------------------------
AT91 DT for 4.17 #2:

Pinctrl fixes, the UART pullups were discussed back in 2016.

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Peter Rosin (3):
      ARM: dts: at91: fixes uart pinctrl, set pullup on rx, clear pullup on tx
      ARM: dts: at91rm9200: pullup rx on uart0
      ARM: dts: at91sam9260: pullup rx on usart0

 arch/arm/boot/dts/at91rm9200.dtsi        | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9260.dtsi       | 24 ++++++++++++------------
 arch/arm/boot/dts/at91sam9261.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9263.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9g25.dtsi       |  2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi       | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9n12.dtsi       |  4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  4 ++--
 arch/arm/boot/dts/sama5d3.dtsi           | 24 ++++++++++++------------
 arch/arm/boot/dts/sama5d3_uart.dtsi      |  8 ++++----
 arch/arm/boot/dts/sama5d4.dtsi           | 28 ++++++++++++++--------------
 13 files changed, 87 insertions(+), 87 deletions(-)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
