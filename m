Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF96D21755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF96D21755
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbeHNA3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:29:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNA3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:29:30 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LilTh-1gRPYB07Yr-00d0ra; Mon, 13 Aug 2018 23:45:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, HS Liao <hs.liao@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mailbox: mediatek: add module license
Date:   Mon, 13 Aug 2018 23:44:49 +0200
Message-Id: <20180813214500.3398337-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:hqHznes4npi04TlPsREEsuj1x6L+B281y2RlEmAWKCHwCY4OBdv
 T2udbAzeXfDl2/UctNu7zLK+OIzLw7+glpdFKJabWSTv277wdOE61uyqAD2mU1Ez6dkWinn
 6vJq0pvKH7j4aOf+Gg3SxU+nd6mpxbM9MsWOFaM06UMnYhINWOi8D29r8k/coqEAqmt1v5r
 yCnajXnfLk6HHlZ0yhkwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3ue6j7xZsKQ=:ZMPLm01bkXvnYToRdHZHMb
 tva8oO50rkK4w6O/bBlq1FL3LEg1RAwUcy0YMvAkC9VrcEZPM7AXkoLHbSUN3yadwzW6OUEj5
 P01JtAMVDZavoQBy/UR9amQKY2q/4/l7LlV6U/gJ2E9Vgi7wsBbN0IjOBNVWUmcp8mVKNSK5q
 WcOEALNvJj4GrEKs16AIggWL+kbilAKKqxwylNmlsPuIMrNEXgxEUSgMpdU3dss/NiJXu5/GN
 H2MjkSSd2KSvX+gf/uFF+FI9EtKoCBIlfGv1jrDo9ZN8rpCdhkqhvJGMyH8B0TVeARak31Nyh
 BBWqogwz3kKsew46orKOs5MDlNNdCtBkayq8UCsQ3VaB1YNWe8uPub48eHjHCQo3VS2NtNt9b
 DnHIP3dqhU/OnWdIRXNK7LJnbpUvVs7qgi55ie1POXCa8LKv4xSV5DUw1Vol95Ii0iEhkKtR3
 yLO+kwTMoQH1PwHbO4RYfi1cLNGJW9BHNQU+IjvB+jRY5kzLGgRrlBwLJV6jZS8xc6/5s3mZT
 qXYfi5lk6wyyBIidqrl8QhDwrlwvlr8JmAcC/NceZioTn6kOAlyhU4/2xVm21OR5SU/6ZUTRN
 fNnogwgQKpG/70UvJelMjC26IbRw5dZZjC4q1oMHNnuUnKArRGrVemUiPUK65UKy/AJ6o5gKm
 QZImRZwkbpLkm8OoSsKheJYIyJL/U0mPCHSGzei0zF6mkDYbTi8xmGr6AN7QfHWiAW10=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The missing license tag in the new driver causes a compile-time warning,
and may result in the module being unusable if it calls EXPORT_SYMBOL_GPL()
functions:

WARNING: modpost: missing MODULE_LICENSE() in drivers/mailbox/mtk-cmdq-mailbox.o

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 6f92c5ee12f7..aec46d5d3506 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -567,3 +567,5 @@ static void __exit cmdq_drv_exit(void)
 
 subsys_initcall(cmdq_drv_init);
 module_exit(cmdq_drv_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

