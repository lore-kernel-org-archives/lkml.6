Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeEUNaK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:30:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39209 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeEUN3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:29:16 -0400
X-Google-Smtp-Source: AB8JxZrzWARvNCUf2r0lnpvlapkBAPjpQF25FdQ0mHXx/reIK9JUbfZjxSVgFBGO3m0RftgZ8rhNgw==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org, michal.vokac@ysoft.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
Subject: [PATCH net-next 7/7] net: dsa: qca8k: Remove rudundant parentheses
Date: Mon, 21 May 2018 15:28:13 +0200
Message-Id: <1526909293-56377-8-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
References: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning reported by checkpatch.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/net/dsa/qca8k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index c834893..c0da402 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -513,7 +513,7 @@ qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable)
 	pr_debug("qca: port %i set status %i\n", port, enable);
 
 	/* Port 0 and 6 have no internal PHY */
-	if ((port > 0) && (port < 6))
+	if (port > 0 && port < 6)
 		mask |= QCA8K_PORT_STATUS_LINK_AUTO;
 
 	if (enable)
-- 
2.1.4
