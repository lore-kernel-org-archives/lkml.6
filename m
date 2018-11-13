Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC2AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516AB22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Qq71cIOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516AB22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbeKMV1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:27:17 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24357 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:27:17 -0500
X-IronPort-AV: E=Sophos;i="5.54,499,1534834800"; 
   d="scan'208";a="23215807"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Nov 2018 04:29:34 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 13 Nov 2018 04:29:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aNia5f/fQwRLlpSVE6zl6j14LPm/Zt8jmEvsKJFN8A=;
 b=Qq71cIOEQp8ByDW9XRmecLHiTI8ZAuiaS+YSHK/X1zcGCTFTbbTuYKh+yyNi/Zzt3hBYO0yynXh4KxCJlyehlqMetcMIdA4dI64KMWIOltl3PPYfXCaaCo1ny6FBCIIHsK8+tk/A6rSVlG/+qsMLoovwEYoqz/wudyhbKOBwQr4=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2244.namprd11.prod.outlook.com (10.174.113.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 11:29:31 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::c873:c197:d9d6:3bf6%6]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 11:29:31 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Cristian.Birsan@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Topic: [PATCH 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Index: AQHUe0QlCUA25FEZDUOwluD/qzkCRw==
Date:   Tue, 13 Nov 2018 11:29:31 +0000
Message-ID: <1542108563-10108-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::29) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2244;6:qFn7pxBtMNdyfihasOfRAQe4y2ROfmApfFw6AtmEeDp8F8wOprUaqj6Xxkey/MH7oMVKTo5cC5bvdfl5Q845bQjDRn0ACcEGoWe4zhLknXusMLRyAvpzPCth9+CdN5pehKbQN8nya8ojdRdrG0a1C6ADo3QEqZunoOD+B5J/5/XI6woNEeNpJu8UTf0d18ocqmUHDMdOd8cBBDkKu27dv4cuuWuclE/zp+rGKssga1/fu39sPZqmOSl/97fHWtIuuJ6KIMnN5weyVvrlAuffa8O8j3shGPYsWwcLFFtzA/LmH3GVirS+w34H2jMZhwvkG79UWUqpu2lIg8pne6p5+GbFVQItjvsHznyxEqZxT7Nii5iHvzROQuYqRPT4N6vN9FpU63ZoxfysmchPo+KCJ8BuYEWnsdVk6Jh6HbmOilMXWEw/TDocqiEOMnWTfhFR7oORcCQGVJoqjS/nf8jhtw==;5:sE+n57WwcHwbESmhDfkPePP+/O7q5AXSRQExwQWsENlqdtJyefPKnIuVire5lPJ1nDurL0VUu0T+r+Vir9Ce67SgvvplHCfx8VBRwIoTnAYynzjzEslF9c0D5WP3kPrWBjfs8gaopgmBtBX2fHSTDzvuW6/Vx4MDuPjoTjsXSCE=;7:8hOS/Blkp8iH4M7wp5it2PiY/wWEFM50Bz9zEB12JEnrHxVayE9HFXhULFi/4weX/OEQaLNaX9orkVmGfnEk3qgSA+kgBxFgTI02z/VAHJKLW2QF7o7V89bxNAIgG8Cwa2ol6IHnckIJM5G+LFR1Rg==
x-ms-office365-filtering-correlation-id: 0cf61f5a-29d8-42a3-57fc-08d6495b477d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2244;
x-ms-traffictypediagnostic: BN6PR1101MB2244:
x-microsoft-antispam-prvs: <BN6PR1101MB22449EB4BA867CA62C76D8DEEDC20@BN6PR1101MB2244.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2244;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2244;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(105586002)(52116002)(54906003)(110136005)(386003)(316002)(6512007)(6506007)(7736002)(8936002)(102836004)(2906002)(76176011)(99286004)(53936002)(81156014)(305945005)(26005)(8676002)(25786009)(106356001)(81166006)(36756003)(186003)(5660300001)(478600001)(6486002)(6116002)(72206003)(256004)(68736007)(66066001)(14454004)(97736004)(6436002)(2900100001)(2501003)(446003)(486006)(86362001)(4326008)(2616005)(476003)(71190400001)(6636002)(107886003)(71200400001)(11346002)(3846002)(39060400002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2244;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iMypqO5Y4LF0rluRRkWSEkUpNwPT/PwMpaiHZ5XqmNR7/utWxXFN6oFUSJasT0m5avUm7gFEESkzD96/mDf9x43vMQjzuSk3e4Z+7UJmDGb4/jKngSHdEa41q/E0976Qwy7UJQXTREcixuCKdo/wf0+W66yivasRWr2MRZyssWVsuvMjpn51VMypjDsuGEq7s3Jmh5//qZlVJ/B1dxPzgvT4hy/UlMZ7vgHOvkzPmBqmKhRXgOdxDADg7nrEtITN3uEd2tHvdnpn9OZRgG4H3ld0lCHB9qLymqMiC2JsyXOjBYLKsPJSCywAqxPdsFGSDJqohwxTa0Qwe3pM/k3mUZRTnTE6+1bTcrc49zqvcPU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf61f5a-29d8-42a3-57fc-08d6495b477d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 11:29:31.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2244
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
index f485597..edfad02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9723,6 +9723,13 @@ M:	Ludovic Desroches <ludovic.desroches@microchip.co=
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

