Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA605C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D1520851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rZlxjvn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D1520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeLLSbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:31:36 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7951 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:31:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="24287645"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 11:31:33 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 11:31:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctqfoZCIhb89ULt1gVkwvsLapgJwdtOft8/Wu4yi4hc=;
 b=rZlxjvn+Trfj/QlCdBFeTZpmXAJ+8XMLItu8wl0cPe2bXgW0UcY4RmYKh3fjELRvAGaX0cqfRiU8a+sOU4EiQ2RlU7dzq0RCpp0Koit9QB68fTijqvgXpS4jdijkgvQssBOXOMil4hKa6mzxtpw/mhy2Td6ziYW7F04zg8gVLF8=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2241.namprd11.prod.outlook.com (10.174.113.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 18:31:11 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 18:31:11 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andr3i.stefanescu@gmail.com>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v5 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC driver
Thread-Topic: [PATCH v5 2/3] MAINTAINERS: add maintainer for MCP16502 PMIC
 driver
Thread-Index: AQHUkkjbuhvMHhEt60qF4bGxywRF+g==
Date:   Wed, 12 Dec 2018 18:31:11 +0000
Message-ID: <1544639447-17392-3-git-send-email-andrei.stefanescu@microchip.com>
References: <1544639447-17392-1-git-send-email-andrei.stefanescu@microchip.com>
In-Reply-To: <1544639447-17392-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To BN6PR1101MB2243.namprd11.prod.outlook.com (2603:10b6:405:52::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.233.110.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2241;6:OO6/u+l14o7RlqTffn8kRpcvX++bbu3J+UZ+x1GDZmBX33Kdz15N7AWymktNTPRVhtRogNDsDa2Rm5OWgbEhffc1kZh3YdgAAdaBxiiZ4xbxy4bOUUqTh23F0NnZ5f2DMJGdx1pRIpwN3oH09OTto/DmuOhYV7TilbImugG05rcUMkS2N9cvk24cI5yZx7FZgt+M+zNecwZsTyIsnw763XqUEtRoufeQStBNdEYCwP07KVenL06X3YVeMfocGMWdVH8Q2OkURjXLCJi9iBvK/LHko3BcyuudBvogxjeuQeIsBhLGZiv5S1YVHNdKIW2mMaPOHsHfe9DS7z+GjpuJiy/a5Ubb7+X9rvrfEl1uiXCAu/BeAErIlwR9G5tWpBpaWPN3euKINauEat9yS2IcXcdVZKwTC1W6noNuRLfCJYDI8IC2vAZ5e1G8549i+4CqC7gMeoLrxGcBePieQm+I1Q==;5:2bOIXYCxNXUmVv80D+gVx+p1I9wjJ+Av5Ae+JgquqeUK6dkJcjLBHFIR8UQ/i/EQDgPPt7sHKl0upF10I7SN0TwO1xG31qUHemPumnUPzf3khWqzALEBXw5/V07QdTP2mCQp4rWgTTaEEjCgFdKVPULF6pGYPrOa7HMsIxSY908=;7:l4DdDaLJWJe5Sk1RqNPL4d0KsrbLY6YTqxhU7UjJbkKyz5/mgYxgclu8hW/OXR/uACZ3KZWxUSFEu07nFQmLAwR2pc6EzSpA355Tn9EJoNfhjTcDTj/2El9Jx0OXFSl5N+LEdNZHi1DWUltgZxjnqw==
x-ms-office365-filtering-correlation-id: 1f314f7c-966d-41cf-f829-08d6605ffd6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2241;
x-ms-traffictypediagnostic: BN6PR1101MB2241:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-microsoft-antispam-prvs: <BN6PR1101MB2241330E5F2AF7D0753ED907EDA70@BN6PR1101MB2241.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2241;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2241;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(66066001)(486006)(105586002)(25786009)(71200400001)(4326008)(446003)(106356001)(2906002)(476003)(71190400001)(305945005)(6512007)(2616005)(478600001)(53936002)(11346002)(26005)(76176011)(86362001)(386003)(6506007)(107886003)(72206003)(2201001)(186003)(52116002)(99286004)(110136005)(8936002)(316002)(6486002)(81166006)(256004)(39060400002)(54906003)(2501003)(102836004)(5660300001)(6436002)(6116002)(14454004)(68736007)(7736002)(81156014)(8676002)(3846002)(97736004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2241;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XJqTHjEjUKS5h66Sq7lFWBbgg+lYTkLbzldPFqmyW9W5KbzCo3rZt75VR8b+AsG9fKHVFC74LaPXqjfId3so5o3R/9oHmwiDCXqF0W93IJoA7/VKmd/PfBtb9FeRzPnVmbBTT/c2I9EwXsBUqCjraBNSIfiJtX3SR6M5lc8ZrszD9uVGeaSxtnxycew3uYZriNXeb4fqNiRhxz3jSa1qAvKfrIPM4vv0zu/1cLhp0aMrXGQQbrUrxM037UAqMTHlyKBmGdxdSO2e5X9w8as+JbQ6OeibAgBIFwlIkUWy3/JIBk1YxVN0dVDW9cUnTtEi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f314f7c-966d-41cf-f829-08d6605ffd6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:31:11.4636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2241
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

