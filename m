Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967735AbeCALQJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:16:09 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:31870 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967592AbeCALQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:16:05 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180301111603epoutp0235ee1e1483319fa9bdafeb2775dd1c26~Xx7Fj1Lti0247702477epoutp02M
X-AuditID: b6c32a37-433ff70000001029-1b-5a97e0f3ab7d
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_bk3710: clarify license version and use SPDX header
Date: Thu, 01 Mar 2018 12:16 +0100
Message-id: <1760511.OZqiSOBhjW@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCmvu7nB9OjDL7NUrLY9Pgaq8WxHY+Y
        LC7vmsNmsb93A5PFr+VHGR1YPTat6mTz2Lyk3uP4je1MHp83yQWwRHHZpKTmZJalFunbJXBl
        fNi4kK3gO0fFgTUb2BoY17N3MXJySAiYSDTP+MbcxcjFISSwg1Hi3M1ZTBDOd0aJv/suscBU
        fXr9igUisZtRYl1DO1hCSOAro0TnCUcQm03ASmJi+ypGEFtEQFbiyrSHjCANzAKNjBL3lk0E
        axAW8JTY8f8MK4jNIqAkcXDVcjCbV0BTou/EK2YQW1TAS2LLvnYmiLigxI/J98B6mQXkJfbt
        n8oKYetInD22DmyBhMAENom/i34zQpzqIvFq+142CFtY4tXxLUCPcgDZ0hKXjtpC1DczSnzb
        sYcZomYCo8Se9UIQtrXE4eMXoRbwSbz72sMK0csr0dEGVeIhMWtPMyuE7Sgxq30dWImQQKzE
        yTVSExhlZiG5ehaSq2chuXoBI/MqRrHUguLc9NRiwwJjveLE3OLSvHS95PzcTYzgWNcy38G4
        4ZzPIUYBDkYlHt4ZB6dFCbEmlhVX5h5ilOBgVhLhPb0dKMSbklhZlVqUH19UmpNafIhRmoNF
        SZw3IMAlSkggPbEkNTs1tSC1CCbLxMEp1cAYLPpBW0OfaUf1XoP4tUuP+VY+L5H/+dNvI6un
        re3cE+9KufUmZ7VeWdC8pM/g8OPw2/xnpzPJbX7mJ/mPZw2PoF6xhXDN/YRlZY2SBhW51u5q
        ro8PasueiT28/65JC4dP3OejH4wmJ8qmvTjdsb5QeVuAxvdI5Zlta8QyrzwRl3xaG/3a8r8S
        S3FGoqEWc1FxIgDTywLF8QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsVy+t9jAd1PD6ZHGVzdbWGx6fE1VotjOx4x
        WVzeNYfNYn/vBiaLX8uPMjqwemxa1cnmsXlJvcfxG9uZPD5vkgtgieKySUnNySxLLdK3S+DK
        +LBxIVvBd46KA2s2sDUwrmfvYuTkkBAwkfj0+hVLFyMXh5DATkaJS/eWMEM4Xxklbp9+zApS
        xSZgJTGxfRUjiC0iICtxZdpDRpAiZoFGRon+pbvARgkLeErs+H8GrIFFQEni4KrlYDavgKZE
        34lXzCC2qICXxJZ97UwQcUGJH5PvsYDYzALyEvv2T2WFsLUk1u88zjSBkXcWkrJZSMpmISlb
        wMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMBC3Hdbq28F4f0n8IUYBDkYlHl6H
        /dOihFgTy4orcw8xSnAwK4nwnt4OFOJNSaysSi3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJ
        anZqakFqEUyWiYNTqoHR2tv0xjf9+h2qrxZlFbqq3Hj1sOtLvw4D1xTBP2GHTjixydyP99wV
        FeFydO71jrLn2j9loz+UMgdmJ0oceFB03HtNDdcaW962QJaNN5ZYfrSXOaP7renZrE2+HbKN
        f7WM/n3peh98xLHM+YO0ga2KCZN/6ltdU6Wj/EaiR9OP8WheOX5swmklluKMREMt5qLiRABp
        E8eJQAIAAA==
X-CMS-MailID: 20180301111603epcas1p20d8448be4c055efdc39e23551bd7f68e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180301111603epcas1p20d8448be4c055efdc39e23551bd7f68e
X-RootMTR: 20180301111603epcas1p20d8448be4c055efdc39e23551bd7f68e
References: <CGME20180301111603epcas1p20d8448be4c055efdc39e23551bd7f68e@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- clarify license version (it should be GPL 2.0)
- use SPDX header

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_bk3710.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_bk3710.c
===================================================================
--- a/drivers/ata/pata_bk3710.c	2017-11-22 14:11:06.120729358 +0100
+++ b/drivers/ata/pata_bk3710.c	2018-03-01 12:10:36.293559718 +0100
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 /*
  * Palmchip BK3710 PATA controller driver
  *
@@ -8,10 +10,6 @@
  *
  * Copyright (C) 2006 Texas Instruments.
  * Copyright (C) 2007 MontaVista Software, Inc., <source@mvista.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/ata.h>
@@ -379,4 +377,4 @@ static int __init pata_bk3710_init(void)
 }
 
 module_init(pata_bk3710_init);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
