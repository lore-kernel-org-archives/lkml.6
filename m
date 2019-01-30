Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C82CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B923204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="CKW2Rx5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfA3B5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:57:09 -0500
Received: from mail-eopbgr690115.outbound.protection.outlook.com ([40.107.69.115]:28173
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbfA3B5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-os-amperecomputing-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZrKCsAglAIYtZxyPbSzb7vYte9IHoCxVxMdqSNAy+Y=;
 b=CKW2Rx5CYGWnc6vNCHarTZeeGaTmayLMhp+Pqt13zL4M/HEAwLQy8N9nqChzAIJzW5QDAiVvOF6f4OCoLoKOK3gYE7pql5VrBrYgPUMP7eqdqOyVzXY7nzLJ+A8Ir3D4cuWOpoGEI2ANdhi9YoHvMAFUCXDkPFzWR1ElG9qawZo=
Received: from BYAPR01MB5494.prod.exchangelabs.com (20.179.63.220) by
 BYAPR01MB5495.prod.exchangelabs.com (20.179.63.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Wed, 30 Jan 2019 01:56:25 +0000
Received: from BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::c885:e520:4558:4ea2]) by BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::c885:e520:4558:4ea2%4]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 01:56:25 +0000
From:   Khuong Dinh <khuong@os.amperecomputing.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Open Source Submission <patches@amperecomputing.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>
Subject: [PATCH v2] MAINTAINERS: Update Ampere email address
Thread-Topic: [PATCH v2] MAINTAINERS: Update Ampere email address
Thread-Index: AQHUuD8Bl3rwJw87K0qY0JPytNqJ0w==
Date:   Wed, 30 Jan 2019 01:56:24 +0000
Message-ID: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR0601CA0041.namprd06.prod.outlook.com
 (2603:10b6:910:89::18) To BYAPR01MB5494.prod.exchangelabs.com
 (2603:10b6:a03:121::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khuong@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR01MB5495;6:MPGSQz/JaIJouY+V06rcSVGeQJ9xexGmlBUQW73f1IJO8I1xQUO4rBh/8ClhIEH6W4xyF8SKWVNaE+Yf4iTxb139nMQw2LN3V9hS2YtsBYPBymW4uZFYhrswmCES/vcbHXksIXohfF52JTwLqNrkbAxFpE/MqQrRS6SSXcMylfeGP4VSMtJsh3yY+OTtnSQh2tokEGPWZkO1k1MOub3FkzXZiiUjnJfs7qnKCWJpQZ0YashVFAdRo7K/d1fJZHJ628yMQsSq+KGROWpPLxg8KFV1ixTlMmiirNXDIehEMLSeXcbv3AV8eZ+roYqDhJ8izpk9UfX/GGp82e9hpZ57Y0wEpdQ2VwTe/p6v6eZK9J7InHLjdQR6U/3zdxSMZNq4NO7NeeQV1RaDODj/57qVvSI2yAOc2+Oc5i1TAw05mdrY2r8mPPHO79p0bfen//fz9A2mFBRG91eNwVydQadk4Q==;5:V8QgPNXoSKdoNbB6T/o71Dujhy9eDiDERESggiAMI9/sRnJ/hJ+bH69daSRpbDMvD+5yfMN79r7/qfI3ArxGD7Rr7fZHmZkiIUcq2sZ8MOWeR3UlNUuR7bNv/Vrembs1uUIxp60MAj+VFF/rnQ1ib5yk/Xcusc0cvHlWJz9r/XcXzMf+DZCNTH6OQL2G8SZNBXlkvNHE1T8dFf03MvAARQ==;7:PfANn715RnY4+GBNJ9886oCopQ+0EBGydHIzmb2fv7bk4KFo2rduy/wZJFOvplAeiJTQT/58Z5R0br0FfwMHYcmAv7zfAZcF9WYMIoFujS86ue+VreyV1dQr0A7Tqx1K5NEd7+v9fS22/7Vbqtdy1Q==
x-ms-office365-filtering-correlation-id: cf50aec3-4393-4e83-eb21-08d6865623e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR01MB5495;
x-ms-traffictypediagnostic: BYAPR01MB5495:
x-microsoft-antispam-prvs: <BYAPR01MB54950DE5FFDEA971707EF8D3E9900@BYAPR01MB5495.prod.exchangelabs.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(39840400004)(396003)(189003)(199004)(186003)(53936002)(6436002)(2501003)(7736002)(102836004)(14454004)(6512007)(54906003)(66066001)(71190400001)(316002)(478600001)(110136005)(2906002)(486006)(71200400001)(97736004)(6486002)(386003)(4326008)(2616005)(68736007)(52116002)(6116002)(476003)(3846002)(15650500001)(50226002)(99286004)(6506007)(2201001)(81166006)(256004)(106356001)(81156014)(305945005)(26005)(14444005)(8936002)(25786009)(105586002)(86362001)(4720700003)(107886003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB5495;H:BYAPR01MB5494.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WbILXrH+VqpnYPDgB4Tf1ZcBcJK6z2YmlgBQCuPIUyVFPW5oXD+2+7BO0PCQkpIALsVFCX8NEl3b9ce8fhnI2LLM0y6kH3YDQDtdRsTzyls0h101TApFYyRnnS/CAYKzotsNrZlQ9Dhp8009y3kIVxL4O7lA19slRMOumsDb9n2AgW3rb40Un/fnTptS2WUoodjWTfIw9w1yQUxayC9NEqbqcVHF/GEeODeNBdVlFQ+g+/BmHP2mh1UTsI8QgS7Y6SS3fXpEQIeg9LNGnrWprKCJg+R9rHmCX0zzeR7n5b+Cl6zkbmSuAsX+II2t779lf1C9c/uQT365KfjCbVJgYhrrXDWVbdd5hJYFvUKJYWXHQ5wHMTMrw1d4aGctbtD5L+HAr3s1E1L0/rG7sOhxKs/RiaGAtziACyOGxTl3Qx4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf50aec3-4393-4e83-eb21-08d6865623e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 01:56:24.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates all APM email addresses to Ampere new email
addresses.

Signed-off-by: Khuong Dinh <khuong@os.amperecomputing.com>
---
v2:
 - Update new domain email address
v1:
 - Initial version
---
 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c27cd7..1cf0801 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1036,26 +1036,26 @@ F:	drivers/net/appletalk/
 F:	net/appletalk/
=20
 APPLIED MICRO (APM) X-GENE DEVICE TREE SUPPORT
-M:	Duc Dang <dhdang@apm.com>
+M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
 F:	arch/arm64/boot/dts/apm/
=20
 APPLIED MICRO (APM) X-GENE SOC EDAC
-M:	Loc Ho <lho@apm.com>
+M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
 F:	drivers/edac/xgene_edac.c
 F:	Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
=20
 APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
-M:	Iyappan Subramanian <isubramanian@apm.com>
-M:	Keyur Chudgar <kchudgar@apm.com>
+M:	Iyappan Subramanian <iyappan@os.amperecomputing.com>
+M:	Keyur Chudgar <keyur@os.amperecomputing.com>
 S:	Supported
 F:	drivers/net/ethernet/apm/xgene-v2/
=20
 APPLIED MICRO (APM) X-GENE SOC ETHERNET DRIVER
-M:	Iyappan Subramanian <isubramanian@apm.com>
-M:	Keyur Chudgar <kchudgar@apm.com>
-M:	Quan Nguyen <qnguyen@apm.com>
+M:	Iyappan Subramanian <iyappan@os.amperecomputing.com>
+M:	Keyur Chudgar <keyur@os.amperecomputing.com>
+M:	Quan Nguyen <quan@os.amperecomputing.com>
 S:	Supported
 F:	drivers/net/ethernet/apm/xgene/
 F:	drivers/net/phy/mdio-xgene.c
@@ -1063,7 +1063,7 @@ F:	Documentation/devicetree/bindings/net/apm-xgene-en=
et.txt
 F:	Documentation/devicetree/bindings/net/apm-xgene-mdio.txt
=20
 APPLIED MICRO (APM) X-GENE SOC PMU
-M:	Tai Nguyen <ttnguyen@apm.com>
+M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
 F:	drivers/perf/xgene_pmu.c
 F:	Documentation/perf/xgene-pmu.txt
@@ -11639,7 +11639,7 @@ F:	Documentation/devicetree/bindings/pci/altera-pci=
e.txt
 F:	drivers/pci/controller/pcie-altera.c
=20
 PCI DRIVER FOR APPLIEDMICRO XGENE
-M:	Tanmay Inamdar <tinamdar@apm.com>
+M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
@@ -11817,7 +11817,7 @@ F:	Documentation/devicetree/bindings/pci/altera-pci=
e-msi.txt
 F:	drivers/pci/controller/pcie-altera-msi.c
=20
 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
-M:	Duc Dang <dhdang@apm.com>
+M:	Toan Le <toan@os.amperecomputing.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
@@ -14763,7 +14763,7 @@ S:	Maintained
 F:	drivers/tty/serial/8250/8250_dw.c
=20
 SYNOPSYS DESIGNWARE APB GPIO DRIVER
-M:	Hoan Tran <hotran@apm.com>
+M:	Hoan Tran <hoan@os.amperecomputing.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-dwapb.c
--=20
1.8.3.1

