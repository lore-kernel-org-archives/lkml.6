Return-Path: <Yixun.Lan@amlogic.com>
X-Google-Smtp-Source: AIpwx49lYA00/o3uZeDQwcbtpwni6obR+XPza4oLSz3uXAQ5PCDuEAD4/n7wsyyV+uta/4Vho3XX
ARC-Seal: i=1; a=rsa-sha256; t=1524471911; cv=none;
        d=google.com; s=arc-20160816;
        b=JMfNs1NSjg9z6f63A3OuMdrzXl/XFKjsEIGdmD1pR+OCUoJoQlrblzvd0NVo1EOVeC
         h6Ieglr8LwDkU8x7Qzt0dQJKvjsWoSBQSLVkZBthOdc4Pn8bzLJb4fUcWdnW8zd0OGFA
         85tyYzV7VHY0mcyL2lNsKjOYYR/TNIR3oZyD0qSI8WJU+LgzfHnzKFaBbldaMOxWmuMv
         AK1i0CWTPJ6dzAimTa3fS15/YkbuYC2mEDmttIQGnMY3KVI4smgus8P/H6msXfK7FXLz
         2zTyIF2YZWXdpw8s1ZgRB+pQTAgybjYdQlOhZRxyLmoNBjDOPay7N2gIqrEY0VqZlHao
         kQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qBLWo8lfO1H67mzQI+XjcU9PuVP2DmrbkRIKckCrOZY=;
        b=ectngq9q7L8gZqL3JUSoCHQT2eq3Mzj3eIufqKjEOcRsKBz3dHp7SCG/DQKKSM0VXp
         WzW5+OmHAtcYH1dPAKf/o6Gu/2uGZa8tOKRsCz8zVRtoiTOZZiemorV8Ethx8vxA+jKi
         GxXWKTq6o1xWTTyQoS+1FOrDBGNNX1u5PZLx1sO99f8Lxx7MD+OSkIU6t81dzLMP0wU1
         2+3owkwLZZ1aQTJug0RReD7X051Mn0y1x1lQHHGjK7k15TYSiopLkK+UexeeHXNaNGUY
         eA3WmQgIAV2VkBzFtR0b4r0zDJaf8AiZZCkkahc1yNOPj9OM+cTMw+BW9MI9AP35psfe
         7F+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
From: Yixun Lan <yixun.lan@amlogic.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
	Carlo Caione <carlo@caione.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: reset: fix invalid SPDX license identifier
Date: Mon, 23 Apr 2018 16:25:12 +0000
Message-ID: <20180423162513.4564-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598521231346509320?=
X-GMAIL-MSGID: =?utf-8?q?1598524659181350978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fix invalid SPDX license indentifier, also move it to
first top line according to documentation.

Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1804222108120.6136@nanos.tec.linutronix.de
Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
 Change since v1 at [1]:
  - update the Link URL
  - add Thomas' Reviewed-by

[1] https://lkml.kernel.org/r/20180423152907.5113-1-yixun.lan@amlogic.com
---
 include/dt-bindings/reset/amlogic,meson-axg-reset.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/dt-bindings/reset/amlogic,meson-axg-reset.h b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
index ad6f55dabd6d..4a8e52f68fb7 100644
--- a/include/dt-bindings/reset/amlogic,meson-axg-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  *
  * Copyright (c) 2016 BayLibre, SAS.
@@ -5,8 +6,6 @@
  *
  * Copyright (c) 2017 Amlogic, inc.
  * Author: Yixun Lan <yixun.lan@amlogic.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
  */
 
 #ifndef _DT_BINDINGS_AMLOGIC_MESON_AXG_RESET_H
-- 
2.17.0
