Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C25C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3172D207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bq7fMYYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3172D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeJWRTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:19:47 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:40784
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728372AbeJWRTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC5MqRa1cB8ifXhOON6/aCvbWrBB/c3geYEe6rjxLJk=;
 b=Bq7fMYYACABU0DfP7Rz1XnL7oFtydd0kvRHpA8SwLns1vArHxyYd0WqNgAKbxGmZXAlhqyLHTUPwoDgCFtdAroR78VblsKnHngwRBXGi44RZWhad2c2rWwniEjURwA7GEIaYhPJxQP9/J5zNjqm3Ac5k5bHQCtQBrtd15tKgiZ8=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4367.eurprd04.prod.outlook.com (52.134.123.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:57:14 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 08:57:14 +0000
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
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH RESEND v4 5/5] MAINTAINERS: add maintainers for the NXP
 FlexSPI driver
Thread-Topic: [PATCH RESEND v4 5/5] MAINTAINERS: add maintainers for the NXP
 FlexSPI driver
Thread-Index: AQHUaq5kaPtnHHkZxUu8ATnCZr5fBw==
Date:   Tue, 23 Oct 2018 08:57:14 +0000
Message-ID: <1540284888-32307-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18)
 To VI1PR04MB1038.eurprd04.prod.outlook.com (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4367;6:83+8YclKRxrDaog7CS0nrF+p5yI/VGoK74LmnvQEO5pp2bLyTYmXmAFBDV7pvSqJGK7BJ6hEUtj+PgkFPJ+mKuC3N/EweLNLGqg18b9JqxM4VBdhadigrKHLxKjl0g6oeiC3zr4Uo/1pNn4Isvp4QSlSMe7DmLpii7T/UT42GRqM+CrZhsWl+K6DEotoLLDJTldf7PRoWlKqBAI6bDUfUAxmjOnNAxc2wb1S57Fr6y4YZ4DrxkFJnG4gYmFXdvue0tEnmllunsuxeYNOXdJURDuXREGtVs3UB8gn02wczYdSZtMBvk5smfsnNf8IzmCjBv+OxeldMzA597Tw0skuIWxxTJeIbvVRxzwl3qhr1H3rB2/T6lJ5CO6EgjLOqTTo90YZahiXU6faSa8Fl5A1UPGqQrXk7jcb6f0LBU8HPm2wuUDp9HfQXt8fMmJDfg8+IMccFOaUFlxi0BySbTixTA==;5:FJ2U94WW+D86221GMsPx7oUmXD/9S37VFA0bxBAdJi48JNJTDoxkSaINt+QPpnoPZzHRGlsRS5ERVeaRI1fBKNnfodbSsFMjXsufE+S91jzXbRW4VNSKCF6ivozmXGlKjDOlQEOXKBDZ+DHRHOPQ7BgHoig8nM6aRig0hs/TwIg=;7:BYMcpUUG0J60eExA3sVGYGALgdqp8bbSud/yGI7WxOKKX/WYaZp2u8VbWCt3id00Xd9bVcZFieuZWP7wz6BUILTvQlkwm7GHU3unlApFZjPvEyw78SYPL6nDQCEf/9E4PbyOCqtto2Bsv915YBwZwwsWJJEJT7MOpHy4jyluaAr8rjCOzLXG9K7UtV2GJa+7NuYTA8hF4gbJAMomRBLjxlW3m+zPxGgtfykiCthdablgjxKrinL1SeofnWV+zxUU
x-ms-office365-filtering-correlation-id: 7ef398ca-2f07-4070-397c-08d638c586b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4367;
x-ms-traffictypediagnostic: VI1PR04MB4367:
x-microsoft-antispam-prvs: <VI1PR04MB4367D651B3A74281D2C6BCE899F50@VI1PR04MB4367.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(162533806227266)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4367;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4367;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(2906002)(7736002)(52116002)(66066001)(71200400001)(71190400001)(76176011)(186003)(305945005)(3846002)(54906003)(6116002)(110136005)(2501003)(217873002)(14454004)(8936002)(68736007)(316002)(2616005)(7416002)(105586002)(476003)(11346002)(25786009)(53936002)(446003)(6512007)(5250100002)(2900100001)(97736004)(486006)(39060400002)(102836004)(36756003)(81156014)(478600001)(55236004)(81166006)(6486002)(8676002)(106356001)(6506007)(386003)(5660300001)(2201001)(4326008)(26005)(99286004)(86362001)(6436002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4367;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6qoR4Ic5bgcSiQCHYgU1o8gWJtcC/iNhCuzzy93pEo2YlPGw2aUM6MZQoE7TOkjhUAIthhKBXcpSFlWN0k5aovjdTe65CUIKyWtUsANtUPQSmnWSxSzFKbR6Tcw8Geauw2YHCiX+G9LeModhbRaptHbQEfiwCobGljPL6kz/GYIroYDwJAIqxY9rMAEGt7J3oAFmONoenAt26BKIv4Yzm/p0g2M6y6/vzoJCQgS+gnDaufTVHM2ZQztnwC3O9ddm0RjL1j/ZQ0evkcFscVY9EQdyzAt1HVvrIajP1LWLHQs4SW1WvSfZSCGq/+Z/2gzmTCJkW7IAqIyuKpPYWQOYAJHm2KQXmCla2PjVzvbjdfc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef398ca-2f07-4070-397c-08d638c586b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:57:14.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff..2696898 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10228,6 +10228,12 @@ L:	linux-nfc@lists.01.org (moderated for non-subsc=
ribers)
 S:	Supported
 F:	drivers/nfc/nxp-nci
=20
+NXP FSPI DRIVER
+M:	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-nxp-fspi.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@redhat.com>
 M:	Peter Zijlstra <peterz@infradead.org>
--=20
2.7.4

