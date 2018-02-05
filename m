Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517856162; cv=none;
        d=google.com; s=arc-20160816;
        b=f2PQqY/QvzusB2517eWEkWYseXu7dRVnvZBwSUIH4hvQvUAIUl1sdQcyaFXowYWhp5
         5ugUScQ6NGo/4z+m/6d9QZ1c6bmzOy2nghWx31OvyISCKmGBhd42Jw20lcB/dMhnj+SQ
         XkYfcF4evh0oKu4Hk4xnbHyMPddmIUjkeFV73aTNh5ThKDG+PEdPcdG/Rw5q5sS8VWyO
         BhI7+LWWusElNgWLeZ2Rtyq8Zw0v6nYG+pEbngPuwU+bALovhaO3ovPtzXwQv6WcDS3N
         JOnZVHteIHFJeZsC8+9C2NpHVVRz4jjSZGhRWoxfym9Usm1nRAKyZqjx0NOHPHSiVxP5
         5JNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=vpJqGuRBmLFZ8KE3Sh+OLlfm1PYktaX4P+HqkDrZREU=;
        b=Xr3q9CK92Yj0kdbBgpF2/wBFkpSsDkV/VUSoTq/vYd3KUZWsEu4PLrihW+2NTnKjXd
         JjawOR0yNLTFN1EmLzlYUZNDCzAt/UjYUy1DsZcFQPcg2gVwF8uH55NQfZo3cl8dPhQ6
         Fii1FE6h4rbOf4j8SLTA/s6+HU3D2rxoodpMjhfh5cZhJolJbvOTk2qM8ZLHvQ+TyP3u
         OHwzdEPUjNnNJqJQMwGyfIZo6tBA26LiKqqTCEje1fTzA4vPzb56rGL0L3P25j+A6zNC
         jH4tblGVnIdvvXPbdRbByU0pOXaGb9lORUpzkW2gbbCbTvZCgZqYdxzoa294/nQYquLP
         RrOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BuhTvwqR;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BuhTvwqR;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x226Qh4xpq30vWjJNdwmDa2PDZ0dNMiX+3aO2nhEdGHTl975fNUS0WpIvvkFVQ7MQXCwrxNqksw==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Feb 2018 10:42:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>,
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
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.16 merge window
Message-ID: <20180205184240.GA5116@roeck-us.net>
References: <20180205102056.GA470@infomag.iguana.be>
 <CA+55aFwX9dqdRghD6sMECf==fdw43u_0Sqm+_cxLp2EPCyLX3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFwX9dqdRghD6sMECf==fdw43u_0Sqm+_cxLp2EPCyLX3A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591555975700214144?=
X-GMAIL-MSGID: =?utf-8?q?1591587544212947153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 09:50:54AM -0800, Linus Torvalds wrote:
> On Mon, Feb 5, 2018 at 2:20 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> >
> >   git://www.linux-watchdog.org/linux-watchdog.git
> 
> Hmm. I really want to know why I should pull this. You have the
> shortlog and the diffstat, but you don't actually have a descriptive
> blurb about _what_ I'm pulling.
> 
> Please give me a summary of what this contains so that I can have a
> good merge message.

How about the following ? It matches Wim's tree, which I pulled and
compared against my own copy. Only difference is the signed tag
with a brief summary on top.

Thanks,
Guenter

---
Subject: [GIT PULL] watchdog updates for v4.16

Hi Linus,

Please pull watchdog updates for Linux v4.16 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-linus-v4.16

Thanks,
Guenter
------

The following changes since commit f3b5ad89de16f5d42e8ad36fbdf85f705c1ae051:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2017-12-16 13:43:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-linus-v4.16

for you to fetch changes up to 592a547adf686dbec7687e816ecdf9101fe227f5:

  documentation: watchdog: remove documentation of w83697hf_wdt/w83697ug_wdt (2018-02-03 11:09:54 +0100)

----------------------------------------------------------------
watchdog updates for v4.16 commit window

- Converted to use watchdog subsystem: sp5100_tco, i6300esb, xen_wdt
- New drivers: Spreadtrum, Realtek RTD1295
- Added r8a77970 support to renesas-wdt
- Added jz4780 support to jz4740
- Removed at32ap700x_wdt driver
- Removed obsolete documentation
- Various bug fixes in watchdog core
- Cleanup and bug fixes in several drivers
- Added Guenter Roeck as co-maintainer

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
