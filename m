Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B06C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB8121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VkmfEr66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB8121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeK1DYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:24:23 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:40222 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeK1DYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:24:22 -0500
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="20832791"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 27 Nov 2018 09:25:55 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 09:25:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=VkmfEr66Kbt5Mh+8HB7R5uwKs4mLS7Fwu5VjRl/pAxaR8lnUHe5fu+ZP7BytlOydwhQUSA2Sg2Exa8gVU/jL4MPz3jzHm89G3fiwD1mU1RRqWMlbo0oyio031j5QmCzvFXXM0B8g6boxPNFyVU6MqdPor0nLaSO96cu9WJU6Hic=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2163.namprd11.prod.outlook.com (10.174.112.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 16:25:51 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 16:25:51 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v2 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Topic: [PATCH v2 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Index: AQHUhm3cKNNOdCoVNEiKi3Uoo8hsgw==
Date:   Tue, 27 Nov 2018 16:25:50 +0000
Message-ID: <1543335937-12689-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1543335937-12689-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1543335937-12689-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::48) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2163;6:39QVcocGLcce/g5yVK8hNg4MP1XURJ+VaqWvYykXaOlo5IKejbseOSakGp+wQYfm794XJycXwO6iBW8jONEYqNOGNev3f+RzkBYRzyRnGzH0RCpnYz3UJ8IZVyzSIGAlpxtwi0VekkxdPPln+F+pvweUkMLpw8PmEpk1YpWhLqQvMq6nBcd8BqbpSmswxS4ngyF5EV3J8kP29I6s/O9ng19HTHnhPIMVDkUPhVljmcCeCkFNl3MVkcOrJHAQrnqEgHDLfrLRUvE8D6B8DKY3kyvGq7sS2+vNQj72hif9FVwraJ1ZrkH0SExDAZcX0RR5X+U2i78HUIujnwDLdLegfoZgF3ekFVlPmXP1QkFwfthWEUNRwBHQEZiVMllGuYdpHo4DMyE9T+p2nHMeD7+r4Vktd91Va+I9ARm/S5HLvu2gexoEEh1O+5N/1afzTrBB7VyMhO20m7c+nKyw/+9Jfw==;5:5ZW/c1m/5GfJq/SIVz2H8BLtruuvOBUsINpcu2/RYl1r6ao5GdYo+BJz/PqQfCZ4Q7ujOA79kZIQJJ5pVCXzxPeEceSTuyJxjbhvnvTGlqsjk/RL14+iAEuJsGcnXso54I4LdHoShv/uRDytJlj6Vttdd+so6ulWAY9o4fuHt4I=;7:5+Zf3LI5mySuuHb+7gjeDNucBHSJtaXH+DRVaGAuP7YVEVYY6/fjAU7wBiLtHr1krEZ/rkh4ZljGUCV7r2n3WJVRE3F3rt+G6U0UQ27q0cg55lrtKixVkoxWBienl8d2lsd+C+wu4pR9/gZfb7UWbA==
x-ms-office365-filtering-correlation-id: 72abf04c-7fa3-4597-b305-08d65484fea2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2163;
x-ms-traffictypediagnostic: BN6PR1101MB2163:
x-microsoft-antispam-prvs: <BN6PR1101MB2163EE16B8D0AC44C213D3EDEDD00@BN6PR1101MB2163.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231443)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2163;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2163;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(106356001)(105586002)(72206003)(3846002)(6436002)(6116002)(81166006)(478600001)(8676002)(76176011)(6512007)(6506007)(8936002)(186003)(53936002)(102836004)(81156014)(107886003)(26005)(7736002)(316002)(6486002)(86362001)(25786009)(4326008)(36756003)(39060400002)(5660300001)(2616005)(11346002)(446003)(476003)(2906002)(97736004)(6636002)(71200400001)(256004)(71190400001)(14454004)(99286004)(52116002)(305945005)(110136005)(54906003)(66066001)(386003)(2501003)(68736007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2163;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5lKUC49V/FpUc8MLdVjhBZaac5JOXaUjmNHxv3aI6K8Ua77CFA0JAvzWwbIALTJ/s7VlVSv1Q/sOEIOJqpVxYy/zxgUmJcqqYv6p4ostgcUbmhn6uoQnnaHIbCPg7eztoZq1Te1IZp5fejpdnPXfEqVz2Y9Ukt8b7K6JO5+seaP9e9in+2F39vj465fpTjlo1Z0a3cyjXkZFDYRJ5gmnWexZsfvbu+qk4gcKhL8vCLSs7slgLrESaP5OGzhHGIB1Gro8k71Zgk4x2w9Nl6o2ZPStZezKAjqY4Da4cgxLJwOCaCAxFfEcZUbhXJKj5v+ify0NXnE4gn0xytlwxnTEYGffid4AmRMwA+hZW1hsE/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72abf04c-7fa3-4597-b305-08d65484fea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:25:50.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2163
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

