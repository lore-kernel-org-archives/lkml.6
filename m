Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A1EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F4F208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 12:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F4F208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936773AbeFQMlE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 08:41:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:34267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933380AbeFQMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 08:41:02 -0400
Received: from longitude ([109.91.33.105]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lg0sd-1g1Ppv0ChX-00pcQf; Sun, 17
 Jun 2018 14:40:52 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] genirq: Fix editing error in a comment
Date:   Sun, 17 Jun 2018 14:40:18 +0200
Message-Id: <20180617124018.25539-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nvWsJ5rreD77e1efKvxVlXwdDMsQ+YDjFLDd3r023Bvw5cWm7YE
 hrvtvUlnnmaPhY20o1YgopBWJWfmMWE7XHrrIqnbXL4JTw8Xp7f01NSVuZajYLKeRZiXO9J
 HSzMdtz+yCmzO/06FP8sMv55DqTlVVEvgcxcaCjQBljuHcTzLGTrSkJ/nVaVhMmdyLsmzP/
 BZ/LE95iSpQpZpbukpR2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8PZ/n8o1VDI=:im3AkAbRbnKKMoSkEj3fQA
 pNCcoLrWH7hWSOOSeuZHZD1ZY4zZSF59NZOFqemZm9QUqDcUB1AyXffUB5nbRU5ZbjRBkBr7M
 BDyvgPKxhmXDYvK0e6WD9V+PZ0vn+NnZeL+9Xbt/XjO1Xt2CTA1Z6Movh7fkoG9zetTV5N1s8
 pyFwrgXH+Gh6tSJha24Pi70lyxCOM7bQuLSGYniO3RosvWB/lNp3+0FyGWXyKKn8iR4LPnJ8U
 iIQWCTCG4WLTPQMiAD3KwrP5yJrCd6STNoB6NIkiZDlYKvQwzBahRChbzsarndtYAEKQW4Hsw
 hBJWDey00jFcwAoLocpJOFzPWLkDlIv76OujGVNTupQSaM0+A+JjiyhHI4AP/I49BF1MUNhSG
 OZj8RtwCAOQWXmpG3CjTFlPvxGs5v8KM7ZPwbsnIl63Y4h4ss1Ig6uW+JEoxf+EAGwalXeqMO
 BILRKQpy3tn5tMJZ+/Y2GBkkTVlyjhsTQLS9ozUrWObzFOQXc53sDN6VuNYK/PLjTocCSOnkk
 aiEPW6Cthky4Zm9BGIi5F2tKIPdWQf2eVnOkOuDegPnDGdPeg7ylCoHQd1D0tII3qy335dMY4
 2Xe7z/D0JGKwjtI80SGZARSPF8w6nRaySb2RAsewBXuoFPXQBJyBzK8F0v7ycPdlovAB4f2ki
 fr6v4g09M6kY4trnn2/2A/ejmLWYzvZDQa5C2WmBK1h6/2a6LYkYc3iYNqpur+0mGHkOvCcXe
 a9suPLjJTuo6Zf7zw7drAI4TpO8S4mQtI2qviNx0J7PBEiKy8Pt/xeuJuUZnLWwrYPMPLJV16
 g0NPAsY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the comment was reflowed to a wider format, the "*" snuck in.

Fixes: ae88a23b32fa ("irq: refactor and clean up the free_irq() code flow")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index daeabd791d58..591cfe901162 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1638,7 +1638,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 * is so by doing an extra call to the handler ....
 	 *
 	 * ( We do this after actually deregistering it, to make sure that a
-	 *   'real' IRQ doesn't run in * parallel with our fake. )
+	 *   'real' IRQ doesn't run in parallel with our fake. )
 	 */
 	if (action->flags & IRQF_SHARED) {
 		local_irq_save(flags);
-- 
2.17.1

