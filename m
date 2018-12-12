Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC6C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D9820849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="od9m1k9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D9820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLLHmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:42:13 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:32111 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLHmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:42:11 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="23822055"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 00:42:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 00:42:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=od9m1k9e9mnOZgIXvGC5qkmUSKfJu5ZymZaxAxSWEjCopfIaW8Z03dw0HGb8J/Nxs7eSP9h352D7DNuHriLuAW3uBAypgSdGdJ9QOCEai90TscvrdECnpW5vBa5A7m1APsvjshjhiBXug8kdgF+7VxJropfDAkkH2126tkBphN0=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2321.namprd11.prod.outlook.com (10.173.198.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 07:42:09 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:42:09 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v4 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Topic: [PATCH v4 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Index: AQHUke4vl62lUWQaqkaFoKtt+hvTFA==
Date:   Wed, 12 Dec 2018 07:42:08 +0000
Message-ID: <1544600485-17586-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1544600485-17586-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544600485-17586-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0267.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::40) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2321;6:5aCxj7BqiNEnIiRA5WL3VsTvImI4D0z1woCUKix98vb21HG7a7WMdcON1H+NCX5UWCOXxjCwbecRKGRcW4WzyPni7hmfdbLU05KSTLG4QegCiii6Jlux7/ictMn03v/yMpZ1btMddPTgusOsZopQwNM9FuOtaDvSNda/AxXldNMzjO0obmCEVxGRjGbY+N4adR4l1Gxe0wLgGyUjFKCPLjLcZthFJdb+sq1scRyi8+9502WSngH1TOLljWtR1YIl/cdDkT6w26pY0pZYQ0NPv5LOGTuwSf8zaBfEoD2caTliNxs8Kg0RyTsE8OP8LC4linpPnUnK6yC7s3ITgd8x7d2VJ/6oTggIJ0igDjAE3+G9PvGxGxEw7z+EnEXnnOAW1s1gj/NvHrWkYAcpL/Kcs6ei9ys5kuGaW/XVAiledEmDH8up+arMWYddkfG0OGxSumF9QXD9l7vqUepTK7kU3g==;5:56a5w2pBC2FezmEjtaHrrmV4N6k6+fq6zvfOzJw2Xt/1btgbRoiwOhQZ5wL3lCVYWDLU+6TMevtNtpsGL4GCsVEeliu1sGnZfXIivptPHdqzxfLWLKbYoqGRowxIGeYCAhsvkK09fxwTtMbV/Gsw5ayR+rdj/84/8peUim4omb0=;7:ht0WWVZrBnPIZuDjrgIN9pPsNys5+omQ4IrtqH1D6yTvs7JA64loEDClHpPDwibxGX6e7hhe+Ly8645Ub6ZeSoBbiVjPT46AkqQmG9qe7T/mL8n71ouVfo2VzKhZnkZFVUvMjzUHBLXjMwu89q+O0A==
x-ms-office365-filtering-correlation-id: ca5d9917-1d67-4342-06c2-08d660055202
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2321;
x-ms-traffictypediagnostic: BN6PR1101MB2321:
x-microsoft-antispam-prvs: <BN6PR1101MB232105D8C57C225A910D0071EDA70@BN6PR1101MB2321.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2321;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2321;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(2501003)(107886003)(53936002)(110136005)(54906003)(316002)(2906002)(486006)(97736004)(5660300001)(68736007)(7736002)(305945005)(72206003)(25786009)(4326008)(478600001)(66066001)(6512007)(39060400002)(36756003)(3846002)(6116002)(2201001)(81156014)(106356001)(105586002)(6436002)(14454004)(71200400001)(52116002)(2616005)(6506007)(446003)(71190400001)(476003)(26005)(81166006)(76176011)(256004)(386003)(186003)(6486002)(86362001)(8936002)(102836004)(8676002)(11346002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2321;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x3fl+7VJ/3ShNlTEqNs7e4Pxj8QKXhLc7gWm5ZSd90XWER/K2plKHXvOfCF6CMwRMpVXZdyhp6YtsDsElojCPpMwf1amS+guKuQ4QHE3ZMz5rb6X6jR4gdxz5m2Qf+gMogoNthDAPSbC7kuu4apFW2KXMr0AQYFjtb7bin/R5py4TJi6RR5mQtTfBefgWGm58iSePzGf1ZWtQKZ0JYVyYB/6ZAZML1tBaUlQBQcnnHMTqduNqPmYcI6064di1BRlRbCbr9zorirl+0E6aHzL9F7I4MGt/nZ3d6sad8PRC4DEbp3sO1FItzM3XsNf2taK
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d9917-1d67-4342-06c2-08d660055202
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:42:08.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2321
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a maintainer for the MCP16502 PMIC
driver.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b755a89..6a74a65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9730,6 +9730,13 @@ M:	Ludovic Desroches <ludovic.desroches@microchip.co=
m>
 S:	Maintained
 F:	drivers/mmc/host/atmel-mci.c
=20
+MICROCHIP MCP16502 PMIC DRIVER
+M:	Andrei Stefanescu <andrei.stefanescu@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
+F:	drivers/regulator/mcp16502.c
+
 MICROCHIP MCP3911 ADC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 M:	Kent Gustavsson <kent@minoris.se>
--=20
2.7.4

