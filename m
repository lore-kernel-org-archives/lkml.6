Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4FE208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4FE208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeGPJ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:57:23 -0400
Received: from mout.web.de ([212.227.15.3]:49315 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbeGPJ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:57:23 -0400
Received: from lab-pc05.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M6QBP-1fziOJ0aol-00yPdE; Mon, 16 Jul 2018 11:30:40 +0200
From:   Matthias Wolf <der_wolf_@web.de>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@i4.cs.fau.de, Matthias Wolf <der_wolf_@web.de>,
        Felix Siegel <felix.siegel@stud.uni-hannover.de>,
        Tim Cofala <cofala@stud.uni-hannover.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: fbtft: Fix line over 80 characters
Date:   Mon, 16 Jul 2018 11:29:59 +0200
Message-Id: <1531733420-25438-1-git-send-email-der_wolf_@web.de>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:CcCRpQRvX7csyWgW1yYUA5R1mbGn8EcgBX8WXljI1cHobfMpsw+
 1ET8O1uB5z6XXTGbj45vz/HD6LsoUA3G4MXa1A78w/S4W0DIGQt2HbJK2z+ms12jXcnl873
 /2vVrtU2ijv05pH9Agj3ne2cJi+jedHILOx+qM0MY4LDSTo86n0x8YFIk3wiYM6/a/fh1VE
 rRS0ybWFwSnyeozaec+vQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+cLKC4P7GYs=:PrE3SJPfan8HYTcBNhPG2m
 uD7vZcz9aF3uMM7dQ+emAZzxLuZM4KbkMKFRmi6pmtdCWRczrc806kE9hBRI8mqdV/+TRmm13
 TdO3TKqBood+sZfHZayRmXtbMZm5jpfnnksKdpKauu7eT6XghjjtB2rZmi0nWIzHIJa/mJUxY
 7CDiIXOjFUydvfWfXc2WhWqZhocAErS8veG9DF7acN9ASj6dsiIQdArMQYcYG/HH8eJ0FZ2dA
 w5+7P6Ypk15R7dzR96xKRoMst+XkZfrBwBwHIbwKJ6idBrdwfAyTcD8xFQDFMniv7b6SqYe3W
 Z9+vvenTwzaIKwtrS5eqvob5fVe5EuJt0Smq7jSNVlXha5p+xmGIQgC/qOKCooOS/IY0RP/Wp
 fE7F+CiS0Vq8hqfAWWYXqJctnyJTzLDDvXrFGoVPfjArA97hj2RHmIDvmjOAGSrMBWrWZ90IQ
 8wsk0o8Lars0L5Ojhwy5QtC2Fl3+uhYUavEhgvZZVWh/k5fJoYilGh6dKmBeqlDOiod7RimR0
 CUgdboU56zwA2EqClcAbqeiB3lCh9DcNncD2/vbRG3CHvNBn7LIUcCoXFhuXYY5Dz5wdJ8xPa
 LF3ifHLbIrf4jhMWs9toOlhylytsyrCAe4jld8yHgPDTYwhKPJ2LRkxUU6vmrFGhlMyME4IgK
 ZTMW0p+o87xFwE647loHvSyAnK+YL53/aiZQq+sph4u7qzKHm8eo7OEK9DmfD6RdgHnQF+jvl
 UOyo3Vhr3O7EswDEyLMFMQhVyiIEbw8ADEeF5GocpgTsF/26zvK7HhZM8iE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch line over 80 characters where it seemed appropriate

Signed-off-by: Matthias Wolf <der_wolf_@web.de>
Signed-off-by: Felix Siegel <felix.siegel@stud.uni-hannover.de>
Signed-off-by: Tim Cofala <cofala@stud.uni-hannover.de>
---
 drivers/staging/fbtft/fb_s6d02a1.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/fbtft/fb_s6d02a1.c b/drivers/staging/fbtft/fb_s6d02a1.c
index 7529576..55513a3 100644
--- a/drivers/staging/fbtft/fb_s6d02a1.c
+++ b/drivers/staging/fbtft/fb_s6d02a1.c
@@ -21,20 +21,27 @@ static const s16 default_init_sequence[] = {
 
 	-1, 0xfc, 0x5a, 0x5a,
 
-	-1, 0xfa, 0x02, 0x1f, 0x00, 0x10, 0x22, 0x30, 0x38, 0x3A, 0x3A, 0x3A, 0x3A, 0x3A, 0x3d, 0x02, 0x01,
+	-1, 0xfa, 0x02, 0x1f, 0x00, 0x10, 0x22, 0x30, 0x38,
+	0x3A, 0x3A, 0x3A, 0x3A, 0x3A, 0x3d, 0x02, 0x01,
 
-	-1, 0xfb, 0x21, 0x00, 0x02, 0x04, 0x07, 0x0a, 0x0b, 0x0c, 0x0c, 0x16, 0x1e, 0x30, 0x3f, 0x01, 0x02,
+	-1, 0xfb, 0x21, 0x00, 0x02, 0x04, 0x07, 0x0a, 0x0b,
+	0x0c, 0x0c, 0x16, 0x1e, 0x30, 0x3f, 0x01, 0x02,
 
 	/* power setting sequence */
-	-1, 0xfd, 0x00, 0x00, 0x00, 0x17, 0x10, 0x00, 0x01, 0x01, 0x00, 0x1f, 0x1f,
+	-1, 0xfd, 0x00, 0x00, 0x00, 0x17, 0x10, 0x00, 0x01,
+	0x01, 0x00, 0x1f, 0x1f,
 
-	-1, 0xf4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3f, 0x3f, 0x07, 0x00, 0x3C, 0x36, 0x00, 0x3C, 0x36, 0x00,
+	-1, 0xf4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3f, 0x3f,
+	0x07, 0x00, 0x3C, 0x36, 0x00, 0x3C, 0x36, 0x00,
 
-	-1, 0xf5, 0x00, 0x70, 0x66, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x6d, 0x66, 0x06,
+	-1, 0xf5, 0x00, 0x70, 0x66, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x6d, 0x66, 0x06,
 
-	-1, 0xf6, 0x02, 0x00, 0x3f, 0x00, 0x00, 0x00, 0x02, 0x00, 0x06, 0x01, 0x00,
+	-1, 0xf6, 0x02, 0x00, 0x3f, 0x00, 0x00, 0x00, 0x02,
+	0x00, 0x06, 0x01, 0x00,
 
-	-1, 0xf2, 0x00, 0x01, 0x03, 0x08, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x08, 0x08,
+	-1, 0xf2, 0x00, 0x01, 0x03, 0x08, 0x08, 0x04, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x08, 0x08,
 
 	-1, 0xf8, 0x11,
 
@@ -54,7 +61,8 @@ static const s16 default_init_sequence[] = {
 	-1, 0xf3, 0x00, 0x0f,
 	-2, 50,
 
-	-1, 0xf4, 0x00, 0x04, 0x00, 0x00, 0x00, 0x3f, 0x3f, 0x07, 0x00, 0x3C, 0x36, 0x00, 0x3C, 0x36, 0x00,
+	-1, 0xf4, 0x00, 0x04, 0x00, 0x00, 0x00, 0x3f, 0x3f,
+	0x07, 0x00, 0x3C, 0x36, 0x00, 0x3C, 0x36, 0x00,
 	-2, 50,
 
 	-1, 0xf3, 0x00, 0x1f,
@@ -65,9 +73,11 @@ static const s16 default_init_sequence[] = {
 	-1, 0xf3, 0x00, 0xff,
 	-2, 50,
 
-	-1, 0xfd, 0x00, 0x00, 0x00, 0x17, 0x10, 0x00, 0x00, 0x01, 0x00, 0x16, 0x16,
+	-1, 0xfd, 0x00, 0x00, 0x00, 0x17, 0x10, 0x00, 0x00,
+	0x01, 0x00, 0x16, 0x16,
 
-	-1, 0xf4, 0x00, 0x09, 0x00, 0x00, 0x00, 0x3f, 0x3f, 0x07, 0x00, 0x3C, 0x36, 0x00, 0x3C, 0x36, 0x00,
+	-1, 0xf4, 0x00, 0x09, 0x00, 0x00, 0x00, 0x3f, 0x3f,
+	0x07, 0x00, 0x3C, 0x36, 0x00, 0x3C, 0x36, 0x00,
 
 	/* initializing sequence */
 
-- 
2.7.4

