Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C51C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2C020875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2C020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeGIQ2r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:28:47 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40922 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933369AbeGIQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:28:44 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69GOiNI029674;
        Mon, 9 Jul 2018 09:28:39 -0700
Received: from il-exch02.marvell.com ([199.203.130.102])
        by mx0b-0016f401.pphosted.com with ESMTP id 2k2w1gnbhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 09 Jul 2018 09:28:38 -0700
Received: from IL-EXCH01.marvell.com (10.4.102.220) by IL-EXCH02.marvell.com
 (10.4.102.221) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Mon, 9 Jul
 2018 19:28:36 +0300
Received: from IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36]) by
 IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36%20]) with mapi id
 15.00.1210.000; Mon, 9 Jul 2018 19:28:36 +0300
From:   Yan Markman <ymarkman@marvell.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [EXT] [PATCH net-next] net: mvpp2: explicitly include
 linux/interrupt.h
Thread-Topic: [EXT] [PATCH net-next] net: mvpp2: explicitly include
 linux/interrupt.h
Thread-Index: AQHUF5Wn35kWVpC3FUS5PldEhpg58aSHFJGw
Date:   Mon, 9 Jul 2018 16:28:35 +0000
Message-ID: <3c3c15cd3ad84a188df964ba3745e260@IL-EXCH01.marvell.com>
References: <20180709150043.13737-1-antoine.tenart@bootlin.com>
In-Reply-To: <20180709150043.13737-1-antoine.tenart@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.203.130.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=625 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+10


Yan Markman
Tel. 05-44732819

-----Original Message-----
From: Antoine Tenart [mailto:antoine.tenart@bootlin.com] 
Sent: Monday, July 09, 2018 6:01 PM
To: davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; thomas.petazzoni@bootlin.com; maxime.chevallier@bootlin.com; gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Yan Markman <ymarkman@marvell.com>; mw@semihalf.com
Subject: [EXT] [PATCH net-next] net: mvpp2: explicitly include linux/interrupt.h

External Email

----------------------------------------------------------------------
The Marvell PPv2 driver uses interrupts and tasklet but does not explicitly include linux/interrupt.h, relying on implicit includes. This one particularly is included by chance after a long unlogical chain of inclusions. Fix this so we do not get future build breaks.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 81a66cce7fa8..18834619bb3a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -12,6 +12,7 @@
 #ifndef _MVPP2_H_
 #define _MVPP2_H_
 
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/phy.h>
--
2.17.1

