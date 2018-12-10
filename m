Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7B0C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B532084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B532084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeLJV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:57:54 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:48981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:57:54 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHoZM-1gi0ws2z1K-00Evbo; Mon, 10 Dec 2018 22:57:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: st: fix Makefile typo
Date:   Mon, 10 Dec 2018 22:57:27 +0100
Message-Id: <20181210215738.2189126-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aCklgsWmFajATfL9OXhRKVRIM4BQ2qONYM6VmJtSxfRcFjVpg+u
 4zlmfqLinLhHdjFwz1YK+grWJwjeaBBvBWYoVT2D0pVChBmibUQt2FTuyieS3B9JTR3vpyN
 rve27C2s7Thk6L1TwD+YO59ksqaMAVGI+XNLdKNyBI/83U3omtiwN9KGKs3dlsIaYXDpwrD
 B1TcYC9I4E2LrUUhugrvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bpj3WJHBVKE=:07AQeksupctM12bRaASjzj
 oetJnv9swfcA/sbKDZuj7QOOfenwX5KXvyxyQxRPj+isgtKB2l6jR4nhpJ0hO94Jw5v0EdO6w
 92SD/gzjefjkU/iBvk5yfDxVUCXBCJCVmOH2vpqa3Le36/n0bhN2Zrhl5Ho0+xJ33o0BVtAPD
 LgzjsAYWmoCKcCPHKmJuKNTt657gJi0xSBuo9SaTHRwm+96KTMm42eBpC9i3pTp42wKCuovIW
 2IjmhzysmzH97hzRLhMDGV4BiNMLADo60hif5i8Z5CwsyRUwZ1vDNM3Vz9NqlBoQjjDwM31wc
 xHESi9vWrGH4TaWF4XxMJVYHcVEbNa2bDTE0QSJCaFeg1sa9eUwdiYNiHOUkQ3XM4UT/onOBN
 QncsIWBFO7cxx870E2NNqxVjlVNcNzw+FJ0/7+ReB7eZmhs4DRt/IMCRSHptX5/BoEH28aHsh
 d03McGdVHDLesMcTxxUCZFOOQR6Hbw/MN6CDdMu9RzWGO8RvHYD91Z0EC4Dzv+Jc/t/1W2qqe
 bVwsh8hx6H6wmkus5VvXLejeG97zu9edYfXhD8T7Yrwhmtoerf/lc0Bh2SmUdLWAqOLEswFKf
 Py66PJFBe20aVqtnNeWS25QpLXqfPaqNR5ymxgPrMcyamOCUHlg1V+/B2fFQOgjX1WBWcHMVr
 dOS+9+Ia+j9X7h8Qrbzykf6daqOOi4e05z2nDH0xsUZpzRKWdDuKisof3u5lSrhvEN+hkiYwC
 4+Fi3VNIi+dAbjTUe4KS6YIV4B1P86ULuxwdlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When STM32_THERMAL is enabled, this overrides all previously
enabled files in the same directory, as seen from this link failure:

ERROR: "st_thermal_pm_ops" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!
ERROR: "st_thermal_register" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!
ERROR: "st_thermal_unregister" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!

The correct syntax in Makefile requires using += instead of :=.

Fixes: 1d6931556073 ("thermal: add stm32 thermal driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/st/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/st/Makefile b/drivers/thermal/st/Makefile
index b2b9e9b96296..243ca7881b12 100644
--- a/drivers/thermal/st/Makefile
+++ b/drivers/thermal/st/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_ST_THERMAL)		:= st_thermal.o
 obj-$(CONFIG_ST_THERMAL_SYSCFG)		+= st_thermal_syscfg.o
 obj-$(CONFIG_ST_THERMAL_MEMMAP)		+= st_thermal_memmap.o
-obj-$(CONFIG_STM32_THERMAL)		:= stm_thermal.o
\ No newline at end of file
+obj-$(CONFIG_STM32_THERMAL)		+= stm_thermal.o
-- 
2.20.0

