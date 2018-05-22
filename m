Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEVLRv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:17:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55364 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeEVLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:17:44 -0400
X-Google-Smtp-Source: AB8JxZoMaVDTfpzhLLJdVC5ZwNk5pmMNLPRDUUX8sYduRy5unhWEmqAPqWfF90tHEBy1pXaDS/xrVQ==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, michal.vokac@ysoft.com
Subject: [PATCH net-next v2 2/7] net: dsa: qca8k: Add support for QCA8334 switch
Date: Tue, 22 May 2018 13:16:27 +0200
Message-Id: <1526987792-56861-3-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
References: <1526987792-56861-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the four-port variant of the Qualcomm QCA833x switch.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes in v2:
 - Add commit message.

 drivers/net/dsa/qca8k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 3684e56..6a3ffb2 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -1010,6 +1010,7 @@ static SIMPLE_DEV_PM_OPS(qca8k_pm_ops,
 			 qca8k_suspend, qca8k_resume);
 
 static const struct of_device_id qca8k_of_match[] = {
+	{ .compatible = "qca,qca8334" },
 	{ .compatible = "qca,qca8337" },
 	{ /* sentinel */ },
 };
-- 
2.1.4
