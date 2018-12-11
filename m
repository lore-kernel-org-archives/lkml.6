Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACEBC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04F32082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="PswYBHwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04F32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLKJR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:17:57 -0500
Received: from mail-eopbgr60122.outbound.protection.outlook.com ([40.107.6.122]:22112
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeLKJR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48YhWk4sxutAPIods7K/u80nKsdoVSxcxNlSagf3ANc=;
 b=PswYBHwrvlaPKhO2uYGZfbKlDcA8eTjdYrsBpSkAzQnOOsJWazlvhG5Z7LA9SHMQtejM5J4wT9PDWNHL+NbhUufNiSeLgL6Wvtdq8tsdhaYViRc7+vjWA5FaD/4FMVECsTIUed1Z0EaBD0DG1ZUJC5SOA5YY0Kz+3B/xrpDk9pQ=
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com (10.170.247.141) by
 HE1SPR01MB13.eurprd07.prod.outlook.com (10.170.251.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.8; Tue, 11 Dec 2018 09:17:52 +0000
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb]) by HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb%2]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 09:17:52 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: [PATCH] MAINTAINERS: add entry for i2c-axxia driver
Thread-Topic: [PATCH] MAINTAINERS: add entry for i2c-axxia driver
Thread-Index: AQHUkTJkr6yQ2gQ9AUqQGXAsxjfjrQ==
Date:   Tue, 11 Dec 2018 09:17:52 +0000
Message-ID: <20181211091733.GA28051@localhost.localdomain>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0214.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::14) To HE1PR07MB3434.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1SPR01MB13;6:IS8alxsIH6R2XHvwvPHMLfWa8Epm3QzOsnn2hs/1VN9+hNywddJe7pELcrqFTlVmyWqbb/Bj3W2+D4y+5q22oZCVI4ltuPGtWLkeNNUGsSOws0ovmXkQC0XalPdEWU8JC+Wo1VRXYMHWf+iXU07q/hRQT0JuvYHF80GqGEtztqQoE3x6rwInthzz0X+pAG0i0Ntif4ENQF5twoJ/hQEvT8MyTtZhxtLTuLR/UlLkxzz7WXRWW176c6pTUftA9uCwmKN1INp6xff3jhaow9cqX6Fd3IbQveSXBRZEP3siKXMzTQj72t488e6axOhrsbmn3zCRf+z9JmFy+WJDzC3w9xyAQsrr4Fyk9BXPi6Cw6+NX7D4WDUmsGfu0C9wwvnmEkyXj4h5RNSpCfIc8Tj4rGjXNTy75MDZs/yNrUb/FOukdsCVE/G8f18o7iisZSVKnlYPacOJ6yodMRKltjOhntQ==;5:mfSMjf+Of4DjRlA9MZ37PGjaTQqjgxz2VFM1p7mo/qnQDFheULfw2FW2OZgl6jiFCaLIRejlk/IekwOua5uISMVIN178Wc3wM5N6jP4qTFTcdh+SmZCn0pP4wO5K8zUbMAmOXdZQlcglcMUZjjtWq6KlzDJgtSXIcQACnr0fdlg=;7:5A2OrOelCS8v5H0Ef675seBm13hSSJWR9gs+5UlGvLN7ss/Do/1a3fOlemea5vbNrBkhsyqEI3cThq4aC8F3oNmrSzrT6kpcVrMXhZ8l/zGbv6CUQI6RLt4hLIUw6AYxpU+TjmQPVKIwYUsbcYR3Hw==
x-ms-office365-filtering-correlation-id: 297987a7-8eba-4d39-73fc-08d65f49873f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1SPR01MB13;
x-ms-traffictypediagnostic: HE1SPR01MB13:
x-microsoft-antispam-prvs: <HE1SPR01MB136C3D1A1B48C29975F784EFA60@HE1SPR01MB13.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231455)(999002)(11241501185)(806100)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1SPR01MB13;BCL:0;PCL:0;RULEID:;SRVR:HE1SPR01MB13;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(25786009)(68736007)(478600001)(1076002)(53936002)(26005)(186003)(8676002)(106356001)(33656002)(2906002)(61506002)(14444005)(256004)(5660300001)(6116002)(86362001)(575784001)(3846002)(6916009)(66066001)(476003)(97736004)(8936002)(486006)(305945005)(9686003)(6512007)(33896004)(6506007)(386003)(4326008)(99286004)(14454004)(7736002)(52116002)(6486002)(81166006)(71200400001)(71190400001)(81156014)(105586002)(107886003)(6436002)(54906003)(316002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1SPR01MB13;H:HE1PR07MB3434.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VyjCvRoSegtZErG9FL4snuoxOZkTAbTcQstVNVh7gP03M4IwLRsKWyFByw8Nhbd8jqwxQ3bqzWthgLZ91blHGtByhVroFKrFSkeRr5d70JOxZz/J7Mp7C/TWTJVX3Xsgr89flwJFnqAuQK5nP4vyPP6XrhIolFBnXduBptQ3/hNnKtJ/9EC9AXBylpQ/yFXjRf1bdftzydNeaedvP6XWhyqJTx8nfVo6hI62qWJsjvG5S1gG3aGV3bYbGVWNhwWm4caIcDQZ44oUMcLhola8cn5d7G7rw0oIU/RdIg9Th1WM9y8Fto1VEy01s24BTfdk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB6064D8B3D89A45A2D1AA3B0E079A5A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297987a7-8eba-4d39-73fc-08d65f49873f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 09:17:52.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1SPR01MB13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create separate entry for i2c-axxia and set myself as maintainer.

Even though I don't work for Intel/LSI who is the manufacturer of this
IP, I do have access to some documentation and the actual hardware using
this driver and I'm familiar with the code.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0767f1d1b579..2961b4d0a8e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2633,6 +2633,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
=20
+AXXIA I2C CONTROLLER
+M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/i2c-axxia.txt
+F:	drivers/i2c/busses/i2c-axxia.c
+
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
--=20
2.17.2

