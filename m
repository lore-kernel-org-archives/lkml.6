Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C410DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8556F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8556F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbeLJUzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:55:32 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbeLJUzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:55:32 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5FxN-1hV42u3Xxl-011BRD; Mon, 10 Dec 2018 21:55:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Wen He <wen.he_1@nxp.com>, Jiaheng Fan <jiaheng.fan@nxp.com>,
        Peng Ma <peng.ma@nxp.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-qdma: add MODULE_LICENSE
Date:   Mon, 10 Dec 2018 21:55:02 +0100
Message-Id: <20181210205520.2956776-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D256dilUAaWc/oYFSmzOsiJ49/FU0K0I9Xw7FN5V7eDE5RB9mfj
 Ica0Y78LPfTTGlokTr9ZevOtQKTuDteswW/uPYVXHfAfvJJOc1v3o3I94JgwNZKkS+N99jc
 1CvuaSGRHkHqQ7gbHI66x7TO6Ix/wC36FFHY5Lvb8AdCiNxzJrZMZOp00/9dn4rNHDtG7N3
 BG9Cblmr60VK+fbs85c+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AW6iALWGgiA=:YnjQgWwLEHCvztXWuNGwXY
 bjliPFrVr7uXxdt6Wu0iL8j7CsClTwvi/GfOgB2lYdCjs3CijMf50PGSSx1YYaHmf+o9UWzNF
 eFNhKWd8ydJ0xgMz3DobN6I5p7x8yjcfHB6TRSQL4b1590IXlRIWEh/Ljb7lyROXLf7PELVmC
 ERe+WZDV5DUdfLWX4TP1R+B5PAL/3Du2dPLnFqv/glddHBL1SvmsdPx+V1Ol9xJVqxs+wMZxr
 VzSkrteNFS9MWdsAQrErJGDr9sYcsyFa2Q0nBVIJmwU6UuoZ7vdA7J/MB7Hq/tk9wnD4OzEIG
 tqvrKMo1ONxDoQCiqYVvrai49w/qYcYDj9QZ7tmH5ZuYTblmzz80Du8RXZWqWsAxrzqv9tU3C
 ClxlBKokm90gtvERhGA6s+qvesUmH6kOfMJRNndzBzvKY90RvJch6Ca17T/JHwioWvXtMtmS/
 rf4hXbpgXcANOg8+zBAptGLRFM50T3cBjBJc5/9oDiK+c8S9nFixXvUNWglOpEBKe16AQkUVo
 cWNool7qATv7GeZ48BJv9E1kQI8mMxRoU8RLuzCt8VFm6nZBafrnYeqF2r6yUDHEXDIT9Vmoy
 HuM7KNZSaWlmIuRsj4uGnDOkCTu0L81koUYO7wKblCOidw89dnY0HDx0j9Zb24/Mr/mh27fJj
 OH+kMcNxDJQRnf5onocEov7sjze24yNakOpo9pYax5NtmSll23iK3S4f1o0djHPHhHJCphdgI
 7TcsxbSktQu/uJTHoIMjkkFWgQpeIYZeWWLlSfuoI4T1L5xUfpLYq0KmmsZbdh/H21xq9t4EO
 TyPa3KDvxIMLrmEKPAwbl288HgAAdbKDyunnJk0v6Ozx0yBDeBhQ/dU6jY+gOeNM9WC324o6i
 DBbY7etzRGbD2eTMONE2vgtg5MkLtOl5ayxau3wlZmziLJaS/mvEQshL9lQxWr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added driver lacks a MODULE_LICENSE tag, which now produces
a warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-qdma.o

Add the license according to the SPDX specifier.

Fixes: 75628c149b0d ("dmaengine: fsl-qdma: Add qDMA controller driver for Layerscape SoCs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/fsl-qdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index c18e3492090b..aa1d0ae3d207 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1255,4 +1255,5 @@ static struct platform_driver fsl_qdma_driver = {
 module_platform_driver(fsl_qdma_driver);
 
 MODULE_ALIAS("platform:fsl-qdma");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("NXP Layerscape qDMA engine driver");
-- 
2.20.0

