Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9128AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CAC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bQNTDouU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405980AbfBMSns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:48 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:10419 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405939AbfBMSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:42 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190213184340epoutp03d5229fe998b4db7188a3da61dbd265fc~DAKiKfMmy1818718187epoutp032;
        Wed, 13 Feb 2019 18:43:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190213184340epoutp03d5229fe998b4db7188a3da61dbd265fc~DAKiKfMmy1818718187epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083420;
        bh=vxCSWIaDE4hI6Ma9KubXpekIN8D1ajLOf3n1WhvNJ24=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=bQNTDouU2EnCVoPiiJipPpRnD5A+LOtXyVa7Al3PVaDtjEYQ6EJECSSLDfUXwbZPZ
         7KpSX4HVmXkCiw9BQ9q2aIIVToA7no3M1TWblWyJ/hh31OKjOHuBjPBp21XSAcUn82
         +p0qXCMEJrSH4HFvceR1CBdKkWhuuICIEIaKrf4c=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184339epcas2p3d0e75210c439814022c6e7a408e33bae~DAKhj2sGf0253402534epcas2p3_;
        Wed, 13 Feb 2019 18:43:39 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.3E.04093.B55646C5; Thu, 14 Feb 2019 03:43:39 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190213184338epcas2p4a0384a9160084df777c92dd5bf55f04a~DAKghPCYJ2631326313epcas2p4S;
        Wed, 13 Feb 2019 18:43:38 +0000 (GMT)
X-AuditID: b6c32a48-173ff70000000ffd-74-5c64655b2726
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B9.ED.03689.A55646C5; Thu, 14 Feb
        2019 03:43:38 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:38 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 13/13] ASoC: samsung: i2s: Convert to SPDX License
 Indentifier
Date:   Wed, 13 Feb 2019 19:42:12 +0100
Message-id: <20190213184212.5473-14-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmuW50akqMwaP9JhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6ML42vmAsOc1Ss+XOcpYGxk72LkZND
        QsBEov/+CuYuRi4OIYEdjBLPblxkgnC+M0rc2neTtYuRA6zq551iiPgGRom/k44zg3QLCfxi
        lFiwUQTEZhMwlOg92scIYosIiEncntMJNpVZoIVJYs7cpWANwgLBEleedrOC2CwCqhIHZ04H
        i/MKWEt8nryEGeIkeYnVGw6A2ZxA8X9rn0OduoRNYtrRGAjbRWLlhR5GCFta4tmqjVB2tcSu
        7d1giyUEOhglWi5shxpqLXH4+EWwxcwCfBIdh/+yQ3zGK9HRJgRR4iGx5d4lFogv+xglOk91
        sk4A+o+RYRWjWGpBcW56arFRgYlecWJucWleul5yfu4mRnAMannsYDxwzucQowAHoxIPb4VQ
        SowQa2JZcWXuIUYJDmYlEV69KKAQb0piZVVqUX58UWlOavEhRmkOFiVx3ofSc6OFBNITS1Kz
        U1MLUotgskwcnFINjKfrqqbI/i984Lf1h2pLv7Iaa4tRqOpz46xnU7edF9IzuV3apJZW11y3
        3mpThLreXV+Fz+lLJP49P/rccHvJv3/GHpfY4553/F4omyA6xfundtvDOrswm7xYj/IaMbfs
        yl1WYQduF2T35s2Vualn+G5h4n3JrsLCBgcjX6HL+YKz28QvH/2jxFKckWioxVxUnAgAS6Ya
        n70CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQd2o1JQYg74JRhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6ML42vmAsOc1Ss+XOcpYGxk72LkYND
        QsBE4ued4i5GLg4hgXWMEq/vnmKEcH4xStzc/w+oiJODTcBQovdoHyOILSIgJnF7TiczSBGz
        QBOTxK7bF8GKhAWCJa487WYFsVkEVCUOzpzODGLzClhLfJ68BMyWEJCXWL3hAJjNCRT/t/Y5
        WK+QgJXExA+XmCcw8ixgZFjFKJlaUJybnltsVGCUl1quV5yYW1yal66XnJ+7iREYZNsOa/Xv
        YHy8JP4QowAHoxIPb4VQSowQa2JZcWXuIUYJDmYlEV69KKAQb0piZVVqUX58UWlOavEhRmkO
        FiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkGxmMCoRN4PKcKZp8VeDUlpI/v+6tfP/55dx5y
        3HT7Mm93p5tdV5VLef3kxWE5ctyv9aP3uX89rnXLoffCloVpG/xP7olNVeRPUSurydm36XLT
        +xPn2/+a14pemVPo/zl9Zpx62ofah1dsjnpP15Vb9qrwzcTmXd9P7Zl15pugI/fNO3dYJ6gV
        aSixFGckGmoxFxUnAgDI0fJDLgIAAA==
X-CMS-MailID: 20190213184338epcas2p4a0384a9160084df777c92dd5bf55f04a
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213184338epcas2p4a0384a9160084df777c92dd5bf55f04a
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184338epcas2p4a0384a9160084df777c92dd5bf55f04a@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0 license statements with SPDX license identifier.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4f13b514d9ce..5ffeb0129712 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1,13 +1,9 @@
-/*
- * ALSA SoC Audio Layer - Samsung I2S Controller driver
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassisinghbrar@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Audio Layer - Samsung I2S Controller driver
+//
+// Copyright (c) 2010 Samsung Electronics Co. Ltd.
+// 	Jaswinder Singh <jassisinghbrar@gmail.com>
 
 #include <dt-bindings/sound/samsung-i2s.h>
 #include <linux/delay.h>
-- 
2.17.1

