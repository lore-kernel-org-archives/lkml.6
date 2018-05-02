Return-Path: <zajec5@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525270357; cv=none;
        d=google.com; s=arc-20160816;
        b=B3x2A5KGD5C+rF2UkExdFh8HQV09p75ppWRpVvnkjP7M6U/i3O5VxlSdISNX+J24kS
         Al7DCk5KuweOxfAlMweWEBXyuWfzDTDqbCIdtRsgGpEelJ8uFB0rXmeyfElU1d9Ti/U9
         iXh2bIEVHi301mtqFApzJM6a46pgpWxizJnZv+JMafjKaDetG5kVKx6NM0Hm7EjMIUHX
         RoBkrtNKsdPr4DwJgRNik43RgCuY3+FJD6KsWbuRLe/M/X/gk8x+5uPzXZB8HqEE8tgY
         1O7lY9zd+o7nHalR9PQ9NWOn/79c8iMWNbbzM2mp/hCsxC57yiI+0qKVikL1WuUYyhkV
         G8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:arc-authentication-results;
        bh=h2oRIHLlkVFCdyssKZfvkMcMjP2+NxUrF/3DChrd4oY=;
        b=CRCdV6JM8JZrP7h2JBwXiD5z9t2gSEvaIQRli4p0/p8KAK2fVOuR7zbakWIYk8Ko7r
         MqpehaVmva/X8YMMAJKhOq2ExWWrryOFqD1/OM3DK9q+GL39qm9nq2KnDhoLZRyeKLvk
         GesEfu2DRISmXglMP3g78RZBrgHW08f8XWiLiGdzO6RMiKQZ0zncgIsTzYl9oEV4RI9R
         Ff1B2DTAs6jclX5iO6gy9alGWtLjOL2O0EXDLroYPwlBVspKgNk+sbYrbYErmADvMUcm
         xv2gl1QLx6H9/Rpn47d+7Jbe/Cy9DGe8KXiQT9l0q6zm7FyyUVVt8+p3zAWuL1cZSYr+
         Ckzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IsfpLJPB;
       spf=pass (google.com: domain of zajec5@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=zajec5@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IsfpLJPB;
       spf=pass (google.com: domain of zajec5@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=zajec5@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoHbtRjrONfbCkKi2kAzrg5ccoz4S4zkYioSK3KjIWpxBODDXtU+BMOR8w6Nryhu9Cp78uLYg==
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Dan Haab <dhaab@luxul.com>,
	Dan Haab <riproute@gmail.com>
Cc: Jon Mason <jonmason@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] ARM: dts: BCM5301X: Relicense most DTS files to the GPL 2.0+ / MIT
Date: Wed,  2 May 2018 16:11:02 +0200
Message-Id: <20180502141102.31769-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599361889970961407?=
X-GMAIL-MSGID: =?utf-8?q?1599361889970961407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Rafał Miłecki <rafal@milecki.pl>

These files were created and ever touched by a group of three people
only: Dan, Hauke and me. They were licensed under GNU/GPL or ISC.

Introducing and discussing SPDX-License-Identifier resulted in a
conclusion that ISC is a not recommended license (see also a
license-rules.rst). Moveover an old e-mail from Alan Cox was pointed
which explained that dual licensing is a safer solution than depending
on a common compatibility belief.

This commit switches most of BCM5301X DTS files to dual licensing using:
1) GPL 2.0+ to make sure they are compatible with Linux kernel
2) MIT to allow sharing with more permissive projects
Both licenses belong to the preferred ones (see LICENSES/preferred/).

An attempt to relicense remaining files will be made separately and will
require approve from more/other developers.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts        | 13 +------------
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts        | 13 +------------
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts    |  3 +--
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts       |  3 +--
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts       |  3 +--
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts     | 13 +------------
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts      |  3 +--
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts        | 13 +------------
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 13 +------------
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts      |  3 +--
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts      |  3 +--
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |  3 +--
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts       |  3 +--
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts        | 13 +------------
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |  3 +--
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      | 13 +------------
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts    |  3 +--
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts      |  3 +--
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts      |  3 +--
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts      |  3 +--
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts       |  3 +--
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi      |  3 +--
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi      |  3 +--
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi      |  3 +--
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi           |  3 +--
 25 files changed, 25 insertions(+), 120 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
index 4175174e589a..ff2e551b9058 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Asus RT-AC56U
  *
  * Copyright (C) 2015 Rafał Miłecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
index 8fa033fea959..3bcc03788f38 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Asus RT-AC68U
  *
  * Copyright (C) 2015 Rafał Miłecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
index 126ab5867772..6c8f0ad82332 100644
--- a/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
index f591b0f256d8..ebda45fe9ea4 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2016 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index 5efb6f31164d..9dd0e22c906a 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Luxul XWC-1000
  *
  * Copyright 2014 Luxul Inc.
- *
- * Licensed under the GNU/GPL. See COPYING for details.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index bb66cebe0bd8..2642494c97a1 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Netgear R6300 V2
  *
  * Copyright (C) 2014 Rafał Miłecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 83a4c60bb431..e7b09b7b7d25 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X arm platform code.
  * DTS for SmartRG SR400ac
  *
  * Copyright (C) 2015 Rafał Miłecki <zajec5@gmail.com>
- *
- * Licensed under the GNU/GPL. See COPYING for details.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index 0800a964f2fe..16314fcc6e56 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Asus RT-N18U
  *
  * Copyright (C) 2014 Rafał Miłecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index c2af33eb47de..328aa90240ce 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Buffalo WZR-600DHP2
  *
  * Copyright (C) 2014 Rafał Miłecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
index 9b5759849983..5eeac7302329 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2017 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
index ba1c19b1b3eb..da4d9ec62fc6 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2017 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
index 3ed8de42cb48..c94c732188fb 100644
--- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
+++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
index 3d1d9c2c4efc..db744a5e122d 100644
--- a/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
+++ b/arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index f43ab4721456..9e267d38df4c 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for Netgear R7000
  *
  * Copyright (C) 2015 Rafał Miłecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index ec4a50e440f6..f5bf6586ae07 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2016 Rafał Miłecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 7cc7d344fe5b..494dbd39658c 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X ARM platform code.
  * DTS for D-Link DIR-885L
  *
  * Copyright (C) 2016 Rafał Miłecki <zajec5@gmail.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
- * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
- * AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
- * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
- * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
- * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index b6750f70dffb..f47afe36d857 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
index ecd22a246746..a5cef51cfe4f 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2017 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
index 15ffb1abc440..7496aabf8f77 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2017 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index bc1d1e10d4ac..53aaa5212610 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2016 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index 859929973158..0e718edc065a 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright (C) 2016 Rafał Miłecki <rafal@milecki.pl>
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
index 24b099c00f13..c349e8f0afc5 100644
--- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom Northstar NAND.
  *
  * Copyright (C) 2016 Rafał Miłecki <rafal.milecki@gmail.com>
- *
- * Licensed under the ISC license.
  */
 
 #include "bcm5301x-nand-cs0.dtsi"
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
index b4e875df9528..18e25e302b13 100644
--- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2016 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 #include "bcm5301x-nand-cs0.dtsi"
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
index 9a9630ded306..c8e56d30bd6f 100644
--- a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom BCM470X / BCM5301X Nand chip defaults.
  *
@@ -5,8 +6,6 @@
  * and uses 8 bit ECC.
  *
  * Copyright (C) 2015 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Licensed under the GNU/GPL. See COPYING for details.
  */
 
 #include "bcm5301x-nand-cs0.dtsi"
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
index 168495106b82..e5a2d62daf92 100644
--- a/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Broadcom Northstar NAND.
  *
  * Copyright (C) 2015 Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Licensed under the GNU/GPL. See COPYING for details.
  */
 
 / {
-- 
2.13.6
