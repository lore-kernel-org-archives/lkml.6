Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001D2218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEJq3LFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfAHJZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:25:14 -0500
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:13074
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728498AbfAHJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFAEV0RFWhGdUvaALR0eBh8gIZYdKeg2n4QZo71m0Vc=;
 b=PEJq3LFr8/D1BkVA2PsBMNoKh0mQgAcfLc+rWUOH7Rl4BRnDsLREz8/uWMsIZ+N2BSekfXGyNYAb4WALzLYX+ZMpYYz1mCfdpRJEoLZMMCkth2/gdazRn1x1/p/g4t46E67mR1iXypRewgARmZ4MevdMzCRzQxGjR+2anp9RHFY=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4494.eurprd04.prod.outlook.com (20.177.54.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 09:25:08 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:25:07 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v6 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Topic: [PATCH v6 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Index: AQHUpzQL3q65wb9HBUaFyHp9lkoAyA==
Date:   Tue, 8 Jan 2019 09:25:07 +0000
Message-ID: <1546939346-20181-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4494;6:lt8buCGYVzoDPmPnSCVfvmZOCbFchm9oGaqt7c65Dwy10OS6HcFsuacrcvGKg0L5xbIpLh3Hpx4DXBDLMmRk6ey6AaX0B+wpKKsfPRzezWdvlrEYCuF5hlUN34e9kbuZCa10n1FIkKcUXp3Dym7uhb8sGkEYdwWRnQcNFal+Ik7zVH6KOASH85xK9WGuBRtWKztNMD75u2MjdD7I+zYVNEjNEMq2o2wxovSpHMO8e6Vq5EqqLj92pjyWcgGqLwHj66cGWrv8jl3exREJS5U5popC9bG8F09azCMEhbOip4hSOGwB/1oMefRggdtBxaJTJo6AAHo47Cui00j9X/W08YM73Z1sK37YB3OrsKvWCEARYvK+0t0BPqrR1pj2IOzHeItuzOZylNaFSwjsFUe12XP12OmBrZMIuPXVN/mHwh67rFRYDifrh6kG2eOjqZLXUK+qNqjj0nUorJUiw9gsGg==;5:bTwyYez9RFy699u/A7lh+BTJNwTFEl16Q/+lFNeFqfDlF1i5ECdT4AZfCiUvpw55eIu3BfHKE5hAogieFGc3YJWWTuxUK+vDSLPwgyIG82R/EqZddg43k0UxCt6o1mHzSyM8kfDAonG5vkq1FZRAxGjShTnjCeB1MWFjEBXDwVJNi8DjhjGCgxck7xlLJrp+lG6pWJ77iZpGC48yTXojPg==;7:sxAqi6eQuX+56jclmtJTh87fGKlucUILlbRYWcXrEC7+5VuGZy1ECATSncrxaWNe90oU459ScIFeRHKcs6r2O+19vemweMgIL5nbO/AAMedM+9/CtHRkfQttcbiGFxrhpICYa4U7QXRhNkStVZjpmw==
x-ms-office365-filtering-correlation-id: 64f7cbd1-7188-40ca-f465-08d6754b2dfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4494;
x-ms-traffictypediagnostic: VI1PR04MB4494:
x-microsoft-antispam-prvs: <VI1PR04MB449483FD365A0AB5E1D89A4E998A0@VI1PR04MB4494.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4494;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4494;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(71200400001)(71190400001)(6486002)(78486014)(2501003)(76176011)(105586002)(106356001)(7416002)(6512007)(7736002)(6436002)(52116002)(486006)(5660300001)(53936002)(305945005)(66066001)(97736004)(8676002)(8936002)(81166006)(81156014)(54906003)(50226002)(14454004)(110136005)(36756003)(99286004)(68736007)(316002)(3846002)(6116002)(2906002)(186003)(86362001)(386003)(256004)(6506007)(39060400002)(2201001)(11346002)(446003)(26005)(476003)(55236004)(102836004)(25786009)(4326008)(2616005)(478600001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4494;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N2EOlZwLwRkY5Jt7S8wglqVeUQtZLpW6d5md1QJsrybJxmr64gmV5wmElyDuKMFsT1i8Pj2raOCWFeCJ5Uok2UARzsacbg0AqPsRG9uDpRGfrj/0jn1cuGdpXPEM/RiyX0Jc5mzqkwlPlRIeeXH/eGK05x2zR+THnfznrXQV//CJyHXZ5Glo09e06YO6bDsied7RyTCp2DGrMt9oo3N4CN80avgQo4BIumupagFNJNwulsTzdK3fkZjqOnHJUxSWAptbPFGW3w7BIG2GMRRHRxEoWoNu4DpN92KvmljdluqKhBi4gqA7F7apWLpxBLhw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f7cbd1-7188-40ca-f465-08d6754b2dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:25:01.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- None
Changes for v5:
- Add maintainers for binding file
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b6c0d454d7e..c393b590e56d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10927,6 +10927,13 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 F:	include/linux/objagg.h
=20
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
--=20
2.17.1

