Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B045C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4812229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kLJidmYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfBLSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:52 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40229 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfBLSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:49 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212180547epoutp0156f9b3a2f62a32407ff6ce068408803b~CsAKt5CeU1587815878epoutp01O;
        Tue, 12 Feb 2019 18:05:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212180547epoutp0156f9b3a2f62a32407ff6ce068408803b~CsAKt5CeU1587815878epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994747;
        bh=HCP/HOvIqfJnCB1JzhPJMtblSFmTHvuIraOFg1C02fk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=kLJidmYp8kIdmF6vEgq+iZsFnr9A5lG+c2pTjTeHNDwM7nx67Q70LwltUJzX+5RYO
         pSyxMD72cLONp5hTWRhGYCCLR795sEGSOwKzTUpGIOKsUphAKGOvfZKGMPh9Lny8U9
         bro9vd4EJIFBWcxr7lsFDmCWA/upLwOebac/TVv4=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180547epcas1p2a158ec5a5a8c78c15e127eb0083ea944~CsAKar4TQ1314613146epcas1p2r;
        Tue, 12 Feb 2019 18:05:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.FC.04173.AFA036C5; Wed, 13 Feb 2019 03:05:46 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180546epcas1p1df261edb23d09dd0b33697f4a279cbd0~CsAJrhzKa0084400844epcas1p1k;
        Tue, 12 Feb 2019 18:05:46 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-7c-5c630afa134c
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F6.11.04015.AFA036C5; Wed, 13 Feb
        2019 03:05:46 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:46 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 19/21] ASoC: samsung: i2s: Convert to SPDX License
 Indentifier
Date:   Tue, 12 Feb 2019 19:03:40 +0100
Message-id: <20190212180342.32040-20-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCmnu4vruQYg0evrS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZv3+HFRzmqGhdcZy9gbGTvYuRg0NC
        wERi247ELkYuDiGBHYwSL3r6mSGc74wSr39dYYYpav8aDxHfwCixddsCNgjnF6PE5CMHGbsY
        OTnYBAwleo/2gdkiAmISt+d0gk1iFmhhkpgzdykzSEJYIFhi/a6zYFNZBFQlTi5gBwnzCthI
        vH3+HsyWEJCXON+7DszmBIo/W/iNBaJGUOLH5HtgNjNQzcErz1lA5ksIHGGT2PT1IxNEs4tE
        y5E1TBBXS0tcOmoLEa6W2LW9mxmivoNRouXCdmaIhLXE4eMXWSGG8km8+9rDCtHLK9HRJgRR
        4iHx9vxvaKj0M0o8P/mWcQKj1CwkN81CctMCRqZVjGKpBcW56anFhgVGesWJucWleel6yfm5
        mxjB8a1ltoNx0TmfQ4wCHIxKPLwrjibFCLEmlhVX5h5ilOBgVhLhTWNOjhHiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOu97BOUZIID2xJDU7NbUgtQgmy8TBKdXAeOTXzKlBvL1xC96LhuzebbpQ
        qSfo5gT1rXHG2TpOnEvrTZdVPQy/knHcSbNtcWp0Keted5mGvd8nl5bt6jo1z7WLjdf9l2ub
        n4Hv3d2q/yNEi0zWb9r9OvCoammKx6Iftx5k3Fdqfvss9N6c39ZvfvJe3W265se9NzP+KUv3
        RH4vbTm3ZZ/qWiWW4oxEQy3mouJEAAHOmXzrAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsVy+t9jQd1fXMkxBg/WcltcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyfv8OKzjMUdG64jh7A2MnexcjB4eE
        gIlE+9f4LkYuDiGBdYwS++Z1MkI4vxgldrT+Zepi5ORgEzCU6D3axwhiiwiISdye08kMUsQs
        0MQksev2RXaQhLBAsMT6XWeZQaayCKhKnFwAFuYVsJF4+/w9mC0hIC9xvncdmM0JFH+28BsL
        SLmQgLXElU22EOWCEj8m32MBsZmByg9eec4ygZFvFpLULCSpBYxMqxglUwuKc9Nzi40KDPNS
        y/WKE3OLS/PS9ZLzczcxAsN322Gtvh2M95fEH2IU4GBU4uFdcTQpRog1say4MvcQowQHs5II
        bxpzcowQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjIu/
        mpwLeX7Yuu29hsPBReX2wl8Nvnct8/165OX1Y+VLin5/CIw/2HB3I8PmP8VxEaoHEyZv9K38
        IJuVZX9XuO7Vw8i9jJuXeXN4e3h94GELmdWjk39k7oZtc1mYLr6c0x/un39vZ8qRuIPXMwId
        +b4Gv/2d1ejzTWoL0+lZd7hvKD/5E/Py8xQlluKMREMt5qLiRACytOegWwIAAA==
X-CMS-MailID: 20190212180546epcas1p1df261edb23d09dd0b33697f4a279cbd0
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180546epcas1p1df261edb23d09dd0b33697f4a279cbd0
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180546epcas1p1df261edb23d09dd0b33697f4a279cbd0@epcas1p1.samsung.com>
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
index 77c0f70beab1..e820d95a86be 100644
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
2.20.1

