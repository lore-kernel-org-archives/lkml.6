Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21C9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2BD2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2BD2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbeJ3Dzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:55:37 -0400
Received: from sauhun.de ([88.99.104.3]:38560 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbeJ3Dzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:55:37 -0400
Received: from localhost (unknown [87.114.85.207])
        by pokefinder.org (Postfix) with ESMTPSA id 6CB5F2E35DD;
        Mon, 29 Oct 2018 20:05:36 +0100 (CET)
Date:   Mon, 29 Oct 2018 19:05:35 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.20
Message-ID: <20181029190531.GA5319@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

welcome back! I hope the time off was good for you.

I2C has not so much stuff this time. Mostly driver enablement for new
SoCs, some driver bugfixes, and some cleanups.

Please pull.

Thanks,

   Wolfram


The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-4.20

for you to fetch changes up to 84de6e96e036dcfb18dded04a506b1dd72ba0e5b:

  MAINTAINERS: add maintainer for Renesas RIIC driver (2018-10-29 18:53:38 +0000)

----------------------------------------------------------------
Alexandre Belloni (5):
      i2c: designware: use generic table matching
      i2c: designware: move #ifdef CONFIG_OF to the top
      i2c: designware: allow IP specific sda_hold_time
      dt-bindings: i2c: designware: document MSCC Ocelot bindings
      i2c: designware: add MSCC Ocelot support

Biju Das (2):
      dt-bindings: i2c: rcar: Document r8a7744 support
      dt-bindings: i2c: sh_mobile: Document r8a7744 support

Brendan Higgins (1):
      i2c: aspeed: fix invalid clock parameters for very large divisors

Chris Brandt (1):
      MAINTAINERS: add maintainer for Renesas RIIC driver

Fabrizio Castro (1):
      dt-bindings: i2c: rcar: Add r8a77470 support

Florian Fainelli (1):
      i2c: brcmstb: Allow enabling the driver on DSL SoCs

Guenter Roeck (1):
      i2c: aspeed: Acknowledge most interrupts early in interrupt handler

Gustavo A. R. Silva (1):
      i2c: synquacer: fix fall-through annotation

Hans de Goede (2):
      i2c: designware: Remove Cherry Trail PMIC I2C bus pm_disabled workaround
      i2c: designware: Set IRQF_NO_SUSPEND flag for all BYT and CHT controllers

Jae Hyun Yoo (1):
      i2c: aspeed: Handle master/slave combined irq events properly

Jarkko Nikula (1):
      i2c: sh_mobile: Remove dummy runtime PM callbacks

Jun Gao (1):
      i2c: mediatek: Use DMA safe buffers for i2c transactions

Luca Ceresoli (3):
      i2c: mux: pca954x: simplify code to reach the adapter
      i2c: mux: ltc4306: simplify code to reach the adapter
      i2c: mux: mlxcpld: simplify code to reach the adapter

Masahiro Yamada (3):
      i2c: uniphier-f: make driver robust against concurrency
      i2c: uniphier-f: fix occasional timeout error
      i2c: uniphier-f: fix race condition when IRQ is cleared

Rob Herring (1):
      i2c: Convert to using %pOFn instead of device_node.name

Stephen Boyd (2):
      i2c: i2c-qcom-geni: Simplify tx/rx functions
      i2c: i2c-qcom-geni: Simplify irq handler

Wang Xin (1):
      eeprom: at24: fix unexpected timeout under high load

Wolfram Sang (10):
      i2c: aspeed: use proper annotation for "fall through"
      Merge tag 'at24-4.20-updates-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-4.20
      i2c: omap: use core to detect 'no zero length' quirk
      i2c: qup: use core to detect 'no zero length' quirk
      i2c: tegra: use core to detect 'no zero length' quirk
      i2c: zx2967: use core to detect 'no zero length' quirk
      i2c: core: remove outdated DEBUG output
      i2c: core: remove level of indentation in i2c_transfer
      Merge tag 'v4.19-rc7' into i2c/for-4.20
      Merge branch 'i2c-mux/for-next' of https://github.com/peda-r/i2c-mux into i2c/for-4.20-fixed


with much appreciated quality assurance from
----------------------------------------------------------------
Alok Chauhan (2):
      (Rev.) i2c: i2c-qcom-geni: Simplify irq handler
      (Rev.) i2c: i2c-qcom-geni: Simplify tx/rx functions

Andy Gross (1):
      (Rev.) i2c: qup: use core to detect 'no zero length' quirk

Andy Shevchenko (4):
      (Rev.) i2c: designware: Set IRQF_NO_SUSPEND flag for all BYT and CHT controllers
      (Rev.) i2c: designware: Remove Cherry Trail PMIC I2C bus pm_disabled workaround
      (Rev.) i2c: designware: add MSCC Ocelot support
      (Rev.) i2c: designware: allow IP specific sda_hold_time

Biju Das (1):
      (Rev.) dt-bindings: i2c: rcar: Add r8a77470 support

Brendan Higgins (2):
      (Rev.) i2c: aspeed: use proper annotation for "fall through"
      (Rev.) i2c: aspeed: Handle master/slave combined irq events properly

Douglas Anderson (2):
      (Rev.) i2c: i2c-qcom-geni: Simplify irq handler
      (Rev.) i2c: i2c-qcom-geni: Simplify tx/rx functions

Fabrizio Castro (2):
      (Rev.) dt-bindings: i2c: sh_mobile: Document r8a7744 support
      (Rev.) dt-bindings: i2c: rcar: Document r8a7744 support

Geert Uytterhoeven (2):
      (Rev.) dt-bindings: i2c: sh_mobile: Document r8a7744 support
      (Rev.) dt-bindings: i2c: rcar: Document r8a7744 support

Grygorii Strashko (1):
      (Rev.) i2c: omap: use core to detect 'no zero length' quirk

Jae Hyun Yoo (2):
      (Rev.) i2c: aspeed: fix invalid clock parameters for very large divisors
      (Test) i2c: aspeed: use proper annotation for "fall through"

Jarkko Nikula (5):
      (Test) i2c: designware: Set IRQF_NO_SUSPEND flag for all BYT and CHT controllers
      (Test) i2c: designware: add MSCC Ocelot support
      (Test) i2c: designware: allow IP specific sda_hold_time
      (Test) i2c: designware: move #ifdef CONFIG_OF to the top
      (Test) i2c: designware: use generic table matching

Joel Stanley (1):
      (Test) i2c: aspeed: Acknowledge most interrupts early in interrupt handler

Mika Westerberg (1):
      (Rev.) i2c: designware: Set IRQF_NO_SUSPEND flag for all BYT and CHT controllers

Peter Rosin (1):
      (Rev.) i2c: Convert to using %pOFn instead of device_node.name

Rob Herring (1):
      (Rev.) dt-bindings: i2c: designware: document MSCC Ocelot bindings

Simon Horman (2):
      (Rev.) dt-bindings: i2c: sh_mobile: Document r8a7744 support
      (Rev.) dt-bindings: i2c: rcar: Document r8a7744 support

Wolfram Sang (1):
      (Rev.) i2c: sh_mobile: Remove dummy runtime PM callbacks

 .../devicetree/bindings/i2c/i2c-designware.txt     |   7 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |   2 +
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   1 +
 MAINTAINERS                                        |   6 +
 drivers/i2c/busses/Kconfig                         |   7 +-
 drivers/i2c/busses/i2c-aspeed.c                    | 205 +++++++++++++--------
 drivers/i2c/busses/i2c-designware-baytrail.c       |   2 +-
 drivers/i2c/busses/i2c-designware-common.c         |   2 +
 drivers/i2c/busses/i2c-designware-core.h           |   9 +-
 drivers/i2c/busses/i2c-designware-master.c         |   2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c        |  90 +++++----
 drivers/i2c/busses/i2c-mt65xx.c                    |  62 ++++++-
 drivers/i2c/busses/i2c-omap.c                      |   8 +-
 drivers/i2c/busses/i2c-powermac.c                  |  17 +-
 drivers/i2c/busses/i2c-qcom-geni.c                 | 149 +++++++--------
 drivers/i2c/busses/i2c-qup.c                       |  14 +-
 drivers/i2c/busses/i2c-sh_mobile.c                 |  18 --
 drivers/i2c/busses/i2c-synquacer.c                 |   2 +-
 drivers/i2c/busses/i2c-tegra.c                     |   4 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |  59 ++++--
 drivers/i2c/busses/i2c-zx2967.c                    |   8 +-
 drivers/i2c/i2c-core-base.c                        |  43 ++---
 drivers/i2c/muxes/i2c-mux-gpmux.c                  |   4 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c                |   2 +-
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                |   2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |   2 +-
 drivers/misc/eeprom/at24.c                         |  43 ++---
 27 files changed, 450 insertions(+), 320 deletions(-)

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvXWfYACgkQFA3kzBSg
KbY8Ow//QUUMgbmdo5++zaz9B6HRb2rL0LAleXj0BFDFVplzfkus1usTzeTkRppm
lX+MOkML6yJCekNzo9JJIeH86xIXdejUVVHbhzMogTdL5im5qvIn2m92EyO0zSc/
B003xn+4z+cVzkG4iltDXZeof1EZf+72SuVwAUUkiNA9ZYnIjRrKZP9jm93dNLVA
4kAOLUeOaFCKToXzr4DoL/1wUkmuS2OIqAs0IO2LuAUF+aJhCsU1EBw1YUgQHbBK
3eGEFWFZAJP2detXCqnUUXXd9Q2TCTuju4uPUouPm2Lz2OEJtkmqmSit+mwSRxLe
7uvT+seAbgZUG43eu1VeaMY3ywnOknRH8mTgkSzMNATLwPBDr8WRiIuTOD5W+36w
nK/7lMsuVwuszrYQ9qkz7z5BnR7SgAXyFwCijU3hXCr8M18uicYOAq83Wg5Nw2Ui
eq+h7Ka8mYYy0Sf3jcKeHvW71JYRsbiaZzB24wikN5HXRe2asoVQVy63y6FLrMXX
9MMmhxDePRrALxOKQkcsjTXbgRMNVM05+CR0ZqE90LCuqgt/LQ2/TsFMelOU3SD4
FbMOPT+7bVkCQfhaLJ51+0cscywKOd9Gw/vAdZCwOqXHk3e1OpQI2M4jRxJTrxuV
l/nwYj1pc7ah0iLoRl0AOR8tWEK9LxK2GgYPl14O15tcReF//vs=
=46rK
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
