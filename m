Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65E121479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QuLGx6dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65E121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeKUTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:21:40 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:18347 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeKUTVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:21:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="20639430"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Nov 2018 01:48:00 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 21 Nov 2018 01:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TttZOoUTiT/sYsXKLLP2xeBrTjfewXCI5pqzKlefhUA=;
 b=QuLGx6dQ7e3rwjorrU4jcpIKKEiRa2ra+dhZbmQNbMU8nkUKe7ptDHaTDk4p2WJvDcmcsBug+0QEutK+pQ8bofIsOTiBZL039RhfI81lbnlarmCE0/NrtGxcs45e65YSi5JTiLXAXy2nCqj2Y1tgLsgnkKVO7k5xJIX8w6inArA=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0073.namprd11.prod.outlook.com (10.164.155.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Wed, 21 Nov 2018 08:47:57 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f%3]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 08:47:57 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Cristian.Birsan@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/3] dt-bindings: add vendor prefix for PDA Precision Design
 Associates, Inc.
Thread-Topic: [PATCH 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design Associates, Inc.
Thread-Index: AQHUgXbmwHshox3wV0qlAiTNmT/Pyw==
Date:   Wed, 21 Nov 2018 08:47:57 +0000
Message-ID: <1542789804-4584-2-git-send-email-eugen.hristev@microchip.com>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::31) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB0073;6:EIP6TduM2KTsKVuTlZ3BoSvvG3NhTm51xTtWQYVLeToR1ZQRx1gaPZnDKD+Rb1Jvfo3KXWEQnMnJCQMZ7ar79hnMZpPX4KrP5OnSOlepyDjDcBKPBPJH9N0iYwXQHrVwXyBwLOwFQQ2mhPgivWIIlo9PSOca5hrGLKip83ZH5KYJeENaqgBYXjUu4c1bwuSZBZWBOP/5I14nINmy6MtwBU84+FmVp1UpFvE/7PprqwkYFYSN6WASncnDLwOMRnDqMnQbvz0rZQLUg5gJmoDNWb0maznjnYB2pGqM4ylqZ6z6ub9GqhqUtXJr4W3yTcG1WSXZqfDgQDAW/taV4FgQh3sFN9MSdz0naNfeL7d6cWuP/mAdlAwbXA6P5c1gzSXBnVSXZdVaQQNy3zJm3jaihG0KVAzSpD8i2nveFqlBrFD55KMrA/v4iUs0uRd3imzm4QOWSXMDeKjnkuiy3k2oFQ==;5:FNTTMdpPmeJ8XH9VJLAGXRSjPOZNB2XXQ8zzhUVMXmVUUWdbRPW5Eoc7sdpO24yPE5WfYgYRdvS+Qmhc2ZV7qaUYsJ5t5iu6XBa4HLJ3EuIOueRYcCmTdaFuse+t58FueF9a7mA6Ad2O1Va2zFyg2DFauZR2ZqdSq+Jo2kckJiA=;7:Hf357tTvzLscBJ/CBjsd4BN4u+YQgJMv6y+DUXbzsOOG/cvtvTUJm3LB2a0ve4rCgeYI/z12RUykd1QYkpZ26wtGEuzbnq0w1gMEFVMEsyUgI/ahrEJmmyEFCzPuXDXDiLelBzlnjFrT3S+7kGWYZg==
x-ms-office365-filtering-correlation-id: c6997d46-01fe-4c57-7c82-08d64f8e08d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0073;
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-microsoft-antispam-prvs: <DM5PR11MB007311E7384E227E60C1AC78E8DA0@DM5PR11MB0073.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231442)(944501410)(4982022)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR11MB0073;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB0073;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(52116002)(106356001)(186003)(99286004)(5660300001)(2906002)(26005)(14454004)(7736002)(2501003)(105586002)(102836004)(386003)(6506007)(81156014)(305945005)(76176011)(8936002)(8676002)(71190400001)(71200400001)(68736007)(3846002)(256004)(66066001)(36756003)(72206003)(6116002)(966005)(2616005)(81166006)(478600001)(476003)(6306002)(6512007)(2201001)(6486002)(446003)(11346002)(486006)(6436002)(107886003)(97736004)(39060400002)(4326008)(53936002)(6636002)(2900100001)(316002)(25786009)(110136005)(54906003)(86362001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0073;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GcVJg6FUqGfNPHIu5M28DEVi/+UKRvP+NYA4+k49PbZ+Re9z6+B76RecBHxjF4JS+3ZdW3kfxzCsLHtBM6qy+iwh3bXNxx0zcVHC7MmAFJhe35qkXwEumRp/EAAOzhGoc1PRjkjSgBYMTjYZy1L1znngHOJC+deWmDd9sOFqJzEcPsqZn7LxJdEf7hinO75E3Z0ZrzwEDFdFa+ACd6DX2GlyCXORuJLngX4bVhtmatuDoAnAeOW9UpYQRvhS46vh5Vo5tfhEogWYHeR64Zj0PWpPLPyA778tA7lRyI+jsj9K4gtnO72aJ7x4CnQvbfYBhUF/dhlgvL4fR+S5ympldqnN67HVbBWqD9mv3gOMYjM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6997d46-01fe-4c57-7c82-08d64f8e08d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 08:47:57.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Precision Design Associates, Inc. (PDA) manufactures standard and custom
capacitive touch screens, LCD's embedded controllers and custom embedded
software. They specialize in industrial, rugged and outdoor applications.
Website: http://www.pdaatl.com/

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docume=
ntation/devicetree/bindings/vendor-prefixes.txt
index a2f4451..4e0a81c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -295,6 +295,7 @@ ovti	OmniVision Technologies
 oxsemi	Oxford Semiconductor, Ltd.
 panasonic	Panasonic Corporation
 parade	Parade Technologies Inc.
+pda	Precision Design Associates, Inc.
 pericom	Pericom Technology Inc.
 pervasive	Pervasive Displays, Inc.
 phytec	PHYTEC Messtechnik GmbH
--=20
2.7.4

