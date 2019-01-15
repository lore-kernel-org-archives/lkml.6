Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9263DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5688720657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fWEY6RyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfAOJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:51:02 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:18612
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728724AbfAOJu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmCJ97trO2PBCCc4PKe+YBPA5OEbJCkFU6++ggrd9zM=;
 b=fWEY6RyShkdcK3L69pninZMxQGbYVIZ34u9H1LoIwGsDV7D1D+m2bquRIbWpz6A+ii0F2IpLuTmoLIoE0C5zBr4Suqb3mE3QnYK2dslHHPtLLAnjcsME/DLsakBzzoW9e6tKw2b+fOlkZjTZDaJ1BImxAPLuK7Cmq8q2rPuWRhI=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5086.eurprd04.prod.outlook.com (20.177.50.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 09:50:54 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:50:54 +0000
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
Subject: [PATCH v7 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Topic: [PATCH v7 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Index: AQHUrLfOw/PzsYHzd0+u+zEatVRAzw==
Date:   Tue, 15 Jan 2019 09:50:53 +0000
Message-ID: <1547545697-4042-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:3:2::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5086;6:Gao+Y7/Y6OybD6PBI8aJhcaFkRoJC+cEvyiK1qv6OhZlA6onj32mQ3IiZPJLzu+sLER9kEj+44AIY0/xFbH24kKjUUbXZ1uZDBRAtymKkKH1d94sj43pc0teh3l4szA3LtShLfzEokBSbPhHcbefHmPcEGAjqehvavoWfi4Np2euYwRMWbQW1ql7QNZoi0Jil0V4oyxu7KdyuI2IR+89XeQk1nJ09jbmGxZ/hUz6pUBGAZejoDarleGHGj/21VP4gQpaNMVcFab1HHeVFWD6OmniTyICd1UyT2NO882hk85N5w7HdJoTA+8KANkhFvvo8kpjOpP/7pFk7h10gXa6L4BBQIfNLfDk3Q66NTGnW9HnME7btzeHL/NKDxbD05dB/ySbjXgY1hQ/VXdUkrftdUql7TNalyQeJ5hHqW7TqP0SdgjTRoGp0/g+uOFPzE/gjG+Gol7KExuHD0AGruQobA==;5:NNj7Gxl+tgie/1HbrUwNeAF+yVvJohqakPfleTot6ArR/lyEEKIGglT4lTebmircyx8kpWgiVQbpX5pukgF+Y1LD0qVwvOLKrftb1pf26Slj3yKmB9EB/yPsZXAAEHZ0LqOkp2LkwDEG4wdTg0qikru/5D3MyYcm7KgNWUaD4/ZR0HRaAmnwuU9Hoa7rtB7WibIn7N99sJ5feolykRr0DA==;7:HdgzoDd+WJcf7N+JD3QL/m1SJ2JkVVvvhH4A6z5zH8TtZFo407Fj7mtq5EbhxIiOncyuXsELlbXF+xYx0YV1Ap+VAKItnmhorZnbLCWT30HDR+8+Cte7gvbav+KEIJC1koOI25QBiL4SxUM+GGenow==
x-ms-office365-filtering-correlation-id: 9dbe501b-0d7a-49b2-b51d-08d67acef061
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5086;
x-ms-traffictypediagnostic: VI1PR04MB5086:
x-microsoft-antispam-prvs: <VI1PR04MB5086B88EF6FE81A9C7954E4199810@VI1PR04MB5086.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(39060400002)(7736002)(305945005)(2501003)(110136005)(99286004)(66066001)(316002)(36756003)(50226002)(8936002)(25786009)(2906002)(486006)(4326008)(478600001)(256004)(54906003)(86362001)(186003)(97736004)(2201001)(55236004)(102836004)(14454004)(26005)(3846002)(7416002)(6116002)(6506007)(386003)(52116002)(106356001)(76176011)(5660300001)(71200400001)(2616005)(78486014)(105586002)(71190400001)(68736007)(11346002)(446003)(6436002)(6486002)(81166006)(53936002)(6512007)(81156014)(8676002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5086;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AxApOWlmEYbKbXI2eVdrFrm/rarciAAhk8gMA8KnUy/KuJ9Ijaj0gyla1FIlvv2gh5i/ruA4J5XezPHrECMs7rw9nh74qMlN9DWMoos0ERGp6ow8lhxiBQEDbLoac7XsASQdAQFaEDojrmGCiNR4axq4B+1cj9zbGAnS/g2JPaAZSHvN+ksm6VDgz+EMt7Sj2qceAUOlmPCDX5vzQvMWtDVFKcLTVoDakK4vzjMKxi61ntUVIHEZISdsgqPfsGxbdQ9K3Z5hdg6T9SeK7U+KWhqVI/s7ALbjq5GKZC9sh6YcKIAal9yjoThs3QeeqojQpF4x/D5qe8+Zgaz1bxfJxpXEiSeaBgOI4jbLqJFmidEoVQWpJcuDcbx4bASNXYaapu8zOaFfnsB2uz+uYYnVLUyoOki53YULgticdiI6jEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbe501b-0d7a-49b2-b51d-08d67acef061
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:50:47.6320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v7:
- None
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

