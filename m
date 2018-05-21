Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeEUNad (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:30:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38449 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeEUN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:29:15 -0400
X-Google-Smtp-Source: AB8JxZpF8gnLxafN2LpXHJXKX3/J1pyou/wFu8BvHz7h1qP7MB3DmHDStr3IXZVUlbnqNQ/l0+ptLw==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org, michal.vokac@ysoft.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
Subject: [PATCH net-next 6/7] net: dsa: qca8k: Replace GPL boilerplate by SPDX
Date: Mon, 21 May 2018 15:28:12 +0200
Message-Id: <1526909293-56377-7-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/net/dsa/qca8k.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 7eba987..c834893 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2009 Felix Fietkau <nbd@nbd.name>
  * Copyright (C) 2011-2012 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  * Copyright (c) 2016 John Crispin <john@phrozen.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #define DEBUG
-- 
2.1.4
