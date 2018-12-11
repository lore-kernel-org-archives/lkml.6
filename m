Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E504EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955C62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="O9Gbw9Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955C62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeLKKJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:09:17 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10661 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeLKKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:09:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="25097113"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 03:09:12 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 03:09:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=O9Gbw9NseX4FwAx41FPF1vDCZ0RIyGutVHlhfwYBubOw3p255zFoA2VtIMJzwYhUbigO1R8/gt79CBQpaI6YpuH/eWqDUTRQCLEID/1ejGNxd+8ptONz/T8MUyC8Q55IAbvt8gO8sC9KKwuW0vUeUBzjPJVWhObsTEodRgcEm4k=
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com (10.174.105.17) by
 DM5PR1101MB2123.namprd11.prod.outlook.com (10.174.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 10:09:11 +0000
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb]) by DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 10:09:11 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [RESEND PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Topic: [RESEND PATCH v3 2/3] MAINTAINERS: add maintainer for MCP16502
 PMIC driver
Thread-Index: AQHUkTmPpOCYWu9VZkOCBK/g0N76cg==
Date:   Tue, 11 Dec 2018 10:09:11 +0000
Message-ID: <1544522876-15967-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To DM5PR1101MB2249.namprd11.prod.outlook.com
 (2603:10b6:4:52::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR1101MB2123;6:fZNcCt05rznqV0h0xw3ePkVFlU2WgdzwVpI4RzFTIpXexG0y2onlSAX9WvCopH4BkgaQLFxSijS88DijNwHWKa5OdAMvOUw2tiIkzNjbBZSVCg7KaXxEKvEfa3q5R5p5sKgHh56SnaLKvbEiztPFPz1ZlFuXi3OKmbpvbXOK7sGaJqr6wHuzHFEkp2CL5VyVkRvERTgv3MFNo5kUOagO7J54yS05TSfkAutzacWnY9B5klRjM8nJ/dtEi/SZoLy61IwAAAtO2vKRU+GsQ5/nDcWB+ayETLMKLtoxucJFsk59gwDmbLVm4vfJesRmcagcVAj7fcw3XHfOB9SqGGC+g9jGqjYarbu6jsRETf9tyvDjjamgtNiwuIa8SGFqNDTlHtoxzpGlX1o3HMm4GP2YomI+DhG2oAWyyTfwr1iR5QHk6hEWOH1WmZxnfEwU2WXlYoShzbjzTfVKZC0Qs/hEfA==;5:EBnuUIjuZdL1L0b4A7jVnUi4q5O2Swa/KXLfG53HxR5L4Ykoeh4/ROkc3kkg4EqiOT7XKIAOv3HH41XBIvETqso6PW5msyuXo2gH9DY1LJn+gZ0bW7s6oacIu+tT5QiNSNTuDum32mamVNOCbsMw8XxAltYuM5MsO29Qx/Qd/yo=;7:vdy/5pRTnt+PE5ppM/PEfTLSYun1pAGsvfWdsGj3IL4PQccmrsftjSvK+2imK7wSoW4euW1m9Ga+htckK/9tyZCUdjK2A7nIjo2ZIy2+jzbvdYmblCnyXRv6n+5HoitK77OvMqRn7AHAsPZsgtQjvg==
x-ms-office365-filtering-correlation-id: a463a7ef-eaea-4b01-9d89-08d65f50b235
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR1101MB2123;
x-ms-traffictypediagnostic: DM5PR1101MB2123:
x-microsoft-antispam-prvs: <DM5PR1101MB2123398E2BEC1C98AB3D8BF3EDA60@DM5PR1101MB2123.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR1101MB2123;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1101MB2123;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(256004)(217873002)(486006)(97736004)(446003)(2906002)(81166006)(2501003)(8676002)(81156014)(11346002)(8936002)(71200400001)(71190400001)(86362001)(68736007)(72206003)(25786009)(36756003)(6512007)(2201001)(7736002)(53936002)(478600001)(6486002)(14454004)(316002)(54906003)(3846002)(76176011)(110136005)(66066001)(107886003)(106356001)(105586002)(305945005)(39060400002)(99286004)(2616005)(476003)(102836004)(5660300001)(386003)(6116002)(6436002)(186003)(6506007)(4326008)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1101MB2123;H:DM5PR1101MB2249.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fEw+CeE7j7JjBcElNKZzYTr1eL2JBwixonRYtfj1iJg4kRc0u8p/QJB3+j0uPVcCpmC63N1GNKDD8yWvzy0OXkuSr6B36QKglTtrfeohCUMGF125hPwrAhZgsKsLRsSqAXMkap8dh8vv2JKEVb7Am7silptGD2FTmK+pSQ995oPae2Q6JEtI8C/Nv5c0XT4/VyIgHdv3PJi/zgfmzDV3zN0rAINAykDbiYtg5LnZHS/3kgHfOiuYgyl0gLOFeRwZ71dZ8F8D4zYlhSh73M3P7UZOvq8BXTchZL2eIuR//hxzRB2/f0wU+hIVY87zRV1K
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a463a7ef-eaea-4b01-9d89-08d65f50b235
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 10:09:11.5067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2123
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

