Return-Path: <wim@iguana.be>
X-Google-Smtp-Source: AH8x225CpdVOecQ75xEOGuxUpTXYv29hARJ8KawFVmpQ1RMAjoh58teUuFtsGrSP/JHjyk0LxqO3
ARC-Seal: i=1; a=rsa-sha256; t=1518000128; cv=none;
        d=google.com; s=arc-20160816;
        b=eGXB25R2Pfp8eaar1OevyaIDhZPAPAm4KeZ6iLEwDZvpF8O/VHLNpmGU8g+wvKJtyt
         02lrPPxfyhxLFXN/GHx2B/E9ZbidbQF158CuiujGrXG7E4z1why17Nzy1jvucm7vsT+p
         AHYwnK8vd7pve/DbcTAnaTEtxtpiZoWwn0dgR3DVkA1IHY9Z50R/XFLcxqjF1xyKMhyF
         c8dx7D1HQMQQhqqKjubkc26B9XJk+mi4Jrm9e5dI2RHdW6DRyEm6u3+UbkEbXaIKEoPA
         YITQw0flP6RXcJ3A2R9SXnhX8qyWIGwV7Q5ds6RoCCtTSaW6KRU8QihKBPOHjQZNhlem
         T5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=2Wx2THl3qvuAF0gzniddz45mIKcCBmznffC3ovI7tF0=;
        b=FEP9qc4uS4pmvwgt7nq/HiVbRjL0ajJxwjbJhEtbScASGU6L9xlwQ1I0YYwNxZH1mn
         2oL08pHRu2XNxmLjuOhOrWP9NyCsZYyvZ/kc17vGjCnnIQp3VM6HZI/1uOexbJRR6v9L
         RhLdqY05thQJdUKpfd8og2PzuXqomMoIM4jb7pFRb+9KmFj46RH9MdSiQ2JSP40IQtrN
         erTK5pm7PmOdOg+rvekkebQIFobDdslFsqCtaSGvDU7KDuBytX+nrz0+f4747X/1wOFC
         +8HMiTKC3njWkqN4gQF5WnLkuwHdc/9x5wKUrkmN7Ya1qx5REirkP/kLv+UDD9xZryyF
         HWTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of wim@iguana.be designates 185.87.124.46 as permitted sender) smtp.mailfrom=wim@iguana.be
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of wim@iguana.be designates 185.87.124.46 as permitted sender) smtp.mailfrom=wim@iguana.be
Date: Wed, 7 Feb 2018 11:42:07 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Andreas =?us-ascii?B?PT9pc28tODg1OS0xP1E/Rj1FNHJiZXI/PQ==?= <afaerber@suse.de>,
	=?us-ascii?B?PT9pc28tODg1OS0xP1E/QW5kcj1FOT89?= Draszik <git@andred.net>,
	Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Corentin Labbe <clabbe@baylibre.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	David Lechner <david@lechnology.com>,
	Eric Long <eric.long@spreadtrum.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Martin Kaiser <martin@kaiser.cx>,
	Mathieu Malaterre <malat@debian.org>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Michael Grzeschik <mgr@pengutronix.de>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Radu Rendec <rrendec@arista.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [GIT PULL REQUEST] watchdog - v4.16 merge window
Message-ID: <20180207104207.GA25825@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591738502725673664?=
X-GMAIL-MSGID: =?utf-8?q?1591738502725673664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

Please pull the watchdog updates for v4.16 from the following signed tag
        git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-4.16-rc1

This series contains:
* New watchdog device drivers for Realtek RTD1295 and  Spreadtrum SC9860 platform
* Add support for the following devices: jz4780 SoC, AST25xx series SoC and r8a77970 SoC
* Conversion to watchdog framework: i6300esb_wdt, xen_wdt and sp5100_tco
* Several Fixes for watchdog core
* Removal of at32ap700x and obsolete documentation
* gpio: Convert to use GPIO descriptors
* Rename gemini into FTWDT010 as this IP block is generc from Faraday Technology
* Various clean-up and small bugfixes
* Add Guenter Roeck as co-maintainer
* Change of maintainers e-mail address

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit f3b5ad89de16f5d42e8ad36fbdf85f705c1ae051:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2017-12-16 13:43:08 -0800)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git 

for you to fetch changes up to 592a547adf686dbec7687e816ecdf9101fe227f5:

  documentation: watchdog: remove documentation of w83697hf_wdt/w83697ug_wdt (2018-02-03 11:09:54 +0100)

----------------------------------------------------------------
Andreas Färber (2):
      dt-bindings: watchdog: Add Realtek RTD1295
      watchdog: Add Realtek RTD1295

Andrew Jeffery (4):
      watchdog: aspeed: Retain watchdog enabled state
      watchdog: aspeed: Fix 'Apseed' typo in Kconfig
      watchdog: aspeed: Remove specific reference to AST2400 in Kconfig
      watchdog: aspeed: Move init to arch_initcall

André Draszik (2):
      watchdog: mt7621: set WDOG_HW_RUNNING bit when appropriate
      watchdog: mt7621: switch to using managed devm_watchdog_register_device()

Arnd Bergmann (2):
      watchdog: xen: use time64_t for timeouts
      watchdog: hpwdt: fix unused variable warning

Benjamin Gaignard (1):
      watchdog: stm32: Fix copyright

Chris Packham (1):
      watchdog: orion: fix typo

Christophe Leroy (3):
      watchdog: mpc8xxx: use the core worker function
      watchdog: core: make sure the watchdog worker always works
      watchdog: core: make sure the watchdog_worker is not deferred

Corentin Labbe (6):
      watchdog: sunxi_wdt: use of_device_get_match_data
      watchdog: document watchdog_init_timeout() wdd parameter
      watchdog: remove at32ap700x_wdt
      documentation: watchdog: remove documentation of at32ap700x_wdt
      documentation: watchdog: remove documentation for ixp2000
      documentation: watchdog: remove documentation of w83697hf_wdt/w83697ug_wdt

David Lechner (1):
      watchdog: davinci_wdt: add restart function

Eric Long (2):
      dt-bindings: watchdog: Add Spreadtrum watchdog documentation
      watchdog: Add Spreadtrum watchdog driver

Geert Uytterhoeven (1):
      dt-bindings: watchdog: renesas-wdt: Add support for the r8a77970 wdt

Greg Kroah-Hartman (1):
      watchdog: pcwd_usb: remove unneeded DRIVER_LICENSE #define

Guenter Roeck (15):
      watchdog: Fix potential kref imbalance when opening watchdog
      watchdog: Fix kref imbalance seen if handle_boot_enabled=0
      MAINTAINERS: Add Guenter Roeck as co-maintainer of watchdog subsystem
      watchdog: sp5100_tco: Always use SP5100_IO_PM_{INDEX_REG,DATA_REG}
      watchdog: sp5100_tco: Fix watchdog disable bit
      watchdog: sp5100_tco: Use request_muxed_region where possible
      watchdog: sp5100_tco: Use standard error codes
      watchdog: sp5100_tco: Clean up sp5100_tco_setupdevice
      watchdog: sp5100_tco: Match PCI device early
      watchdog: sp5100_tco: Use dev_ print functions where possible
      watchdog: sp5100_tco: Clean up function and variable names
      watchdog: sp5100_tco: Convert to use watchdog subsystem
      watchdog: sp5100_tco: Use bit operations
      watchdog: sp5100-tco: Abort if watchdog is disabled by hardware
      watchdog: sp5100_tco: Add support for recent FCH versions

Gustavo A. R. Silva (9):
      watchdog: advantechwdt: mark expected switch fall-through
      watchdog: alim1535_wdt: mark expected switch fall-through
      watchdog: f71808e_wdt: mark expected switch fall-throughs
      watchdog: pcwd_usb: mark expected switch fall-through
      watchdog: pcwd_pci: mark expected switch fall-through
      watchdog: watchdog_dev: mark expected switch fall-through
      watchdog: wdt_pci: mark expected switch fall-through
      watchdog: eurotechwdt: mark expected switch fall-through
      watchdog: ib700wdt: mark expected switch fall-through

Jerry Hoemann (2):
      watchdog: hpwdt: SMBIOS check
      watchdog: hpwdt: Check source of NMI

Linus Walleij (5):
      watchdog: gpio: Add some local helper variables
      watchdog: gpio: Convert to use GPIO descriptors
      watchdog: gemini/ftwdt010: rename DT bindings
      watchdog: gemini/ftwdt010: rename driver and symbols
      watchdog: ftwdt010: Make interrupt optional

Martin Kaiser (1):
      watchdog: imx2_wdt: restore previous timeout after suspend+resume

Mathieu Malaterre (2):
      watchdog: jz4740: Add support for the watchdog in jz4780 SoC
      dt: watchdog: Document compatibility with JZ4780

Matt Redfearn (1):
      watchdog: indydog: Add dependency on SGI_HAS_INDYDOG

Michael Grzeschik (3):
      watchdog: da9062: Add restart handler support
      watchdog: da9062: Disable and wait before changing timeout
      watchdog: da9062: use protection delay mechanism from core

Oleksij Rempel (1):
      watchdog: dw_wdt: add stop watchdog operation

Radu Rendec (6):
      watchdog: i6300esb: use the watchdog subsystem
      watchdog: i6300esb: support multiple devices
      watchdog: i6300esb: do not hardcode heartbeat limits
      watchdog: i6300esb: remove info message and version number
      watchdog: xen_wdt: use the watchdog subsystem
      watchdog: xen_wdt: remove info message and version number

Rasmus Villemoes (1):
      watchdog: gpio_wdt: set WDOG_HW_RUNNING in gpio_wdt_stop

Tomas Winkler (1):
      watchdog: mei_wdt: don't use of variable length array

Wim Van Sebroeck (1):
      Change my E-mail address.

 .../bindings/watchdog/cortina,gemini-watchdog.txt  |  17 -
 ...ina,gemin-watchdog.txt => faraday,ftwdt010.txt} |  11 +-
 .../bindings/watchdog/ingenic,jz4740-wdt.txt       |   4 +-
 .../bindings/watchdog/realtek,rtd119x.txt          |  17 +
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |   3 +-
 .../devicetree/bindings/watchdog/sprd-wdt.txt      |  19 +
 Documentation/watchdog/watchdog-parameters.txt     |  23 -
 MAINTAINERS                                        |   4 +-
 drivers/watchdog/Kconfig                           |  41 +-
 drivers/watchdog/Makefile                          |   7 +-
 drivers/watchdog/advantechwdt.c                    |   2 +-
 drivers/watchdog/alim1535_wdt.c                    |   2 +-
 drivers/watchdog/aspeed_wdt.c                      |  21 +-
 drivers/watchdog/at32ap700x_wdt.c                  | 433 -------------
 drivers/watchdog/da9062_wdt.c                      |  48 +-
 drivers/watchdog/davinci_wdt.c                     |  38 ++
 drivers/watchdog/dw_wdt.c                          |  18 +-
 drivers/watchdog/eurotechwdt.c                     |   2 +-
 drivers/watchdog/f71808e_wdt.c                     |   4 +-
 drivers/watchdog/ftwdt010_wdt.c                    | 236 +++++++
 drivers/watchdog/gemini_wdt.c                      | 229 -------
 drivers/watchdog/gpio_wdt.c                        |  58 +-
 drivers/watchdog/hpwdt.c                           |  12 +-
 drivers/watchdog/i6300esb.c                        | 377 ++++-------
 drivers/watchdog/ib700wdt.c                        |   2 +-
 drivers/watchdog/imx2_wdt.c                        |  20 +-
 drivers/watchdog/jz4740_wdt.c                      |   1 +
 drivers/watchdog/mei_wdt.c                         |   7 +-
 drivers/watchdog/mpc8xxx_wdt.c                     |  83 ++-
 drivers/watchdog/mt7621_wdt.c                      |  34 +-
 drivers/watchdog/orion_wdt.c                       |   2 +-
 drivers/watchdog/pcwd_pci.c                        |   2 +-
 drivers/watchdog/pcwd_usb.c                        |   5 +-
 drivers/watchdog/rtd119x_wdt.c                     | 168 +++++
 drivers/watchdog/sp5100_tco.c                      | 710 +++++++++------------
 drivers/watchdog/sp5100_tco.h                      |  57 +-
 drivers/watchdog/sprd_wdt.c                        | 399 ++++++++++++
 drivers/watchdog/stm32_iwdg.c                      |   6 +-
 drivers/watchdog/sunxi_wdt.c                       |   7 +-
 drivers/watchdog/watchdog_core.c                   |   1 +
 drivers/watchdog/watchdog_dev.c                    | 125 ++--
 drivers/watchdog/wdt_pci.c                         |   2 +-
 drivers/watchdog/xen_wdt.c                         | 255 ++------
 43 files changed, 1711 insertions(+), 1801 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
 rename Documentation/devicetree/bindings/watchdog/{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} (55%)
 create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
 delete mode 100644 drivers/watchdog/at32ap700x_wdt.c
 create mode 100644 drivers/watchdog/ftwdt010_wdt.c
 delete mode 100644 drivers/watchdog/gemini_wdt.c
 create mode 100644 drivers/watchdog/rtd119x_wdt.c
 create mode 100644 drivers/watchdog/sprd_wdt.c

----------------------------------------------------------------

Kind regards,
Wim.
