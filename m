Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeDQMGp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:06:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46190 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeDQMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:06:44 -0400
X-Google-Smtp-Source: AIpwx499+RTGbpzqkj6lhmdlb0soOWN9LO56osWpNa/sUyd7iNIgBtEdWcAdXS25kXAFPGdugMaV8w==
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
To: davem@davemloft.net, bjorn.andersson@linaro.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH] net: qrtr: add MODULE_ALIAS_NETPROTO macro
Date: Tue, 17 Apr 2018 14:03:26 +0200
Message-Id: <20180417120326.11022-1-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure that qrtr can be loaded automatically, when needed, if it is compiled
as module.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 net/qrtr/qrtr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index b33e5aeb4c06..2aa07b547b16 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -1135,3 +1135,4 @@ module_exit(qrtr_proto_fini);
 
 MODULE_DESCRIPTION("Qualcomm IPC-router driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS_NETPROTO(PF_QIPCRTR);
-- 
2.14.2
