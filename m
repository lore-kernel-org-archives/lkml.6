Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2206C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733B32229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="igMd9g90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437939AbfBNJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:39:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:24114 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437891AbfBNJjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:39:03 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190214093859epoutp0169f682315b14b13ee26826156372b8cd~DMYPyZncL0371703717epoutp01i;
        Thu, 14 Feb 2019 09:38:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190214093859epoutp0169f682315b14b13ee26826156372b8cd~DMYPyZncL0371703717epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137139;
        bh=uOOFlaZ/AaritXHNmHt5SGdfNUm7J0x01Do3VV/NLqI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=igMd9g905ANw8x+VLm4q62GmvBCFe1qQ+RqnTjIRPMBAxNT8sde5BcxOTk0UfLkBS
         maA7LyRBf9OHYQRGTs6Bd6/8/cI/SqdAHkaaC6K+9Yx4G18XhZqnr1IR1xl+TAq6C7
         VajrEabSP9NN6qP7pLMM8Vz8a2CYL/Mk8b9bFbjs=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093859epcas2p2b012587960bff377cd135df1d23e4db0~DMYPlGbEI1885718857epcas2p2i;
        Thu, 14 Feb 2019 09:38:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.F0.04136.337356C5; Thu, 14 Feb 2019 18:38:59 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093858epcas2p10993b30cf39b6c12d3fe0a4dfd20f6e8~DMYPGqP530693006930epcas2p1u;
        Thu, 14 Feb 2019 09:38:58 +0000 (GMT)
X-AuditID: b6c32a46-2a7ff70000001028-4c-5c653733f5bc
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id DE.52.03689.237356C5; Thu, 14 Feb
        2019 18:38:58 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:58 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 13/13] ASoC: samsung: i2s: Convert to SPDX License
 Indentifier
Date:   Thu, 14 Feb 2019 10:37:47 +0100
Message-id: <20190214093747.2414-14-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCmua6xeWqMweqHPBZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8bBiXuYCj5zVMxf8ZS5gXErexcjJ4eEgInE5K4uti5GLg4hgR2M
        Eos717NAON8ZJZp3nmWEqTr2+iBUYgOjxM1fs1ghnF+MEifvzwabxSZgKNF7tA+sQ0RATOL2
        nE5mkCJmgZWMElv2bWIDSQgLREnceDgXrIFFQFXi2dk3zCA2r4C1xI41P5gg1slLrN5wACzO
        CRSfuWk7I8ggCYEeNol5a5cCreYAclwk7h0qhaiXlni2aiPUqdUSu7Z3M0PUdzBKtFzYzgyR
        sJY4fPwiK4jNLMAn0XH4LzvEHF6JjjYhiBIPidYd99khPutjlOhecoJtAqPEAkaGVYxiqQXF
        uempxUYFRnrFibnFpXnpesn5uZsYwZGm5baDcck5n0OMAhyMSjy8FUIpMUKsiWXFlbmHGCU4
        mJVEeC8apcYI8aYkVlalFuXHF5XmpBYfYpTmYFES530oPTdaSCA9sSQ1OzW1ILUIJsvEwSnV
        wHiTb/3N9XMumJ95XfVkx70dqXtcFnU84Otyma9QPq/Y1WW+oFHai+wlZtyxb46b77tTYv7a
        SGLLh4L6c7GWUben5mWxcIu9ez/l7p8rkzmu60sHTL70z2zGc+b2Yr2uzw0G90PNDZn6m4sq
        uANd/4hsW3Uon1nj4eoQYe/FP+Yzt4pLBvw2rVJiKc5INNRiLipOBABzkmlqsAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xoK6ReWqMQddRLYsrFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK+PgxD1MBZ85KuaveMrcwLiVvYuRk0NCwETi2OuDLF2MXBxCAusY
        Jb62rWCGcH4xSmzubGYFqWITMJToPdrHCGKLCIhJ3J7TCVbELLCSUeLI91VgCWGBKIkbD+eC
        jWURUJV4dvYNM4jNK2AtsWPNDyaIdfISqzccAItzAsVnbtoO1MsBtM1KYt2h8gmMPAsYGVYx
        SqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgSG0bbDWv07GB8viT/EKMDBqMTDWyGUEiPE
        mlhWXJl7iFGCg1lJhPeiUWqMEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2amp
        BalFMFkmDk6pBsaG4tdruO86BTJ6a0wKFvujXpIo5M6tlprUNuVfvd4MufRpkxr1wiew/z5d
        GMp2VmrNYtaHEpJ7tmbNky85tV89IMKqXi/tgGVV7eqXDtN+MHJEfDx+8dKCx759Yov+BsdF
        szJfvvlI/mL85O0+T4++ubr2HUfY4merutYz7T66dS3/yz8OD2crsRRnJBpqMRcVJwIAVChT
        gh8CAAA=
X-CMS-MailID: 20190214093858epcas2p10993b30cf39b6c12d3fe0a4dfd20f6e8
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214093858epcas2p10993b30cf39b6c12d3fe0a4dfd20f6e8
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093858epcas2p10993b30cf39b6c12d3fe0a4dfd20f6e8@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0 license statements with SPDX license identifier.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4f13b514d9ce..304b3138b3ff 100644
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
+//	Jaswinder Singh <jassisinghbrar@gmail.com>
 
 #include <dt-bindings/sound/samsung-i2s.h>
 #include <linux/delay.h>
-- 
2.17.1

