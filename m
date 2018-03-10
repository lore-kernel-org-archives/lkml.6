Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbeCJFUM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 00:20:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51510 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbeCJFUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 00:20:11 -0500
Date: Sat, 10 Mar 2018 06:20:07 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 4.17
Message-ID: <20180310052007.GA5536@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

It has been two years that Atmel merge with Microchip, rename where
relevant.

This is based on my fixes PR which is already in next/soc. Tell me if
this is not right.

The following changes since commit c8d5dcf122b194e897d2a6311903eae0c1023325:

  MAINTAINERS: ARM: at91: update my email address (2018-02-22 16:22:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.17-soc

for you to fetch changes up to ed08b63c8b3e23dfc8a32f0b450a23a35a3d91b4:

  ARM: at91: Kconfig: Update company to Microchip (2018-02-28 16:21:51 +0100)

----------------------------------------------------------------
AT91 SoC for 4.17:

 - Rename Atmel to Microhip in MAINTAINERS, Documentation and Kconfig

----------------------------------------------------------------
Nicolas Ferre (3):
      MAINTAINERS: ARM: at91: update entry for ARM/Microchip
      Documentation: at91: Update Microchip SoC documentation
      ARM: at91: Kconfig: Update company to Microchip

 Documentation/arm/{Atmel => Microchip}/README | 52 +++++++++++++--------------
 MAINTAINERS                                   | 42 +++++++++++-----------
 arch/arm/mach-at91/Kconfig                    | 14 ++++----
 3 files changed, 53 insertions(+), 55 deletions(-)
 rename Documentation/arm/{Atmel => Microchip}/README (64%)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
