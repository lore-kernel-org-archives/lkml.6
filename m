Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeEVLSM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:18:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54828 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeEVLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:17:50 -0400
X-Google-Smtp-Source: AB8JxZqIVYPE5jZ/9pb3SN+nN0ojJZWlP6x/mlhXhrZollmB/L3silOm9PpNDrf3gUfU81q1TKzqdQ==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, michal.vokac@ysoft.com
Subject: [PATCH net-next v2 7/7] net: dsa: qca8k: Remove redundant parentheses
Date: Tue, 22 May 2018 13:16:32 +0200
Message-Id: <1526987792-56861-8-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
References: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning reported by checkpatch.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
 - Fix typo in subject.
 - Add "Reviewed-by" tags from Andrew and Florian.

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
