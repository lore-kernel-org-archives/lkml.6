Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655C7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8B220827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VTCb7f5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8B220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbeKFSn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:43:57 -0500
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:43731
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFSn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5MPHMu8u+vLL8PMHnHMI9/ONI7OX7LH2N+IkS4W+mU=;
 b=VTCb7f5xXWZ74l508TBA+WHxrKVCsM42O6e6V0+WLg17GR2iABowQr2gPyvINuzwCmRozTUdTMqSC+WgLVSSguqxfvGnw4HTrdrrjoZ7y0yuAx6VAXKMnP4L4aQPG7mPVtE02GC0lf3AHgPvbRm+RxRWPnNChY+aCEMAZTxJ/xw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Tue, 6 Nov 2018 09:19:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 09:19:37 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6sll: remove unused property in gpc node
Thread-Topic: [PATCH] ARM: dts: imx6sll: remove unused property in gpc node
Thread-Index: AQHUdbHWYC/+VFjzbUa/nu9Z5udSsg==
Date:   Tue, 6 Nov 2018 09:19:36 +0000
Message-ID: <1541495675-14706-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:sJGB5w34a1dhyqo4ZfF/H/AtdmlfWXUS1edI21/5SRBDGuPs3yRbcmZnk7HzENPtHN2m+nrYWZ2Qpm2QWVzWBL02MPLODguVuyvV8PScsK3nFDv82XW51H01dHIRxu19yCORxoJ6KMVDrbky2VkegLgufqrDTiQJFy21xh9tlniqaW5gEOD1A9WMPYVOgQnAPofingUXnLUj01w9vCF/71ELzWWp7KqwvtIYqQ2T9yEHk4ScOKBF/BiOdX1siGhNVOohILBlIRLiG+8SX0jbU0uDCqaqI35mg0BOzatvOdyjoTaC6LI73ZHLk4dfKBTSSUXer4XgrZSQE+sVwNNkZlVrAvB+eSOtFb3Jx4ee/F4aJCK6Bi9RcG37r41yV9OAcLjWvqeDuxe/dVPz5ZlXJGks0zscEVqTGwlH10q05ywfocwWAq6kfQVj/pu3WCRYq/vuJMKUN57WadKndGYl4g==;5:gGwPBIqPW4Y9W7wy2TenjKVKJvCxEWQpbEV0Ih+ld5BXOUHGgLVPzIN1R3CdRXSSdrzvVkNd58EVIzFhiI5hbVZQllih/gfkCXnqK0T18VdMWz+YQsWabns8Mb0Wf2FdrKQ+K9bvWOSloOw2S34uVL4hwEXPRJZeLzVovFefx14=;7:VHmBDBR5ocS4FnZnUaaQJVzp/NCB/P2qrvd+XRr5wybU8ZWVEoSu+0s9KSzu5jxWAOl4L+ePGhciaw4Wkj3wfw0AGhPiPkxC9hPY3wU1SlwKzeOvmTNuFvRBSnlaNDtr1wtRDSgnnn8BlEscanoXOA==
x-ms-office365-filtering-correlation-id: c1e7ae2b-29a6-4430-aaef-08d643c8f898
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB39463F26AF3CA8BA17A0420FF5CB0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(3846002)(256004)(81156014)(478600001)(486006)(71200400001)(2900100001)(97736004)(8676002)(7736002)(71190400001)(6486002)(53936002)(102836004)(68736007)(81166006)(66066001)(316002)(2616005)(6116002)(186003)(6512007)(476003)(2906002)(6436002)(86362001)(110136005)(26005)(106356001)(2501003)(5660300001)(4326008)(105586002)(14454004)(52116002)(25786009)(386003)(6506007)(2201001)(14444005)(1857600001)(305945005)(50226002)(36756003)(8936002)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LYvIGRXYbIBO8bDtEL2BqzMNs/YGMN/eh/vRV5jz0PTNX6oHsB8oQAjHpQIKUhA+133cMeQCBOVeFNrfcQnFAJ/bCd8dc4dwEhKiVPusc2K9fVPt8mZYuZF8wRS2NJaXcqTROFIUFLuksKZ6GRWeaOEYNeuAKof2ZqkPx/40OZohqcr6WbWPewvLnrevS5dOS3ahiSb3XwJDsdGLZsk3yNCkMWduJ0+zrosYrkEZ5EZVFpDFyMiFens6Y3p+60xMtZDeRTet8S+aHDjJS26yxR4tAilZwnJtxpfVVt5RKHVaoqE8ZV3fWlKn1OpBG17L7R6IZG6JIS2XXGh7KmUYciY61M7cRG1iyLT0G6OosMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e7ae2b-29a6-4430-aaef-08d643c8f898
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 09:19:36.9653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fsl,mf-mix-wakeup-irq" is ONLY used as a temporary
solution in NXP's internal tree for Mega/Fast Mix off
feature after suspend, upstream kernel does NOT need it,
remove it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dts=
i
index 5ff4b99..62847c6 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -593,7 +593,6 @@
 				#interrupt-cells =3D <3>;
 				interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent =3D <&intc>;
-				fsl,mf-mix-wakeup-irq =3D <0x7c00000 0x7d00 0x0 0x1400640>;
 			};
=20
 			iomuxc: pinctrl@20e0000 {
--=20
2.7.4

