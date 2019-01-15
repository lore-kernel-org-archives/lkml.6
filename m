Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2146C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAFA20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZImPGVKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfAOMAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:00:51 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:23552
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729353AbfAOMAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMJutvrRVqU2G+NfW0oaXPrSQ5NzlJs0ZhFbwpFfsdw=;
 b=ZImPGVKZSLy11hnPAQzbBJOSfPOv+lk9zF5Si3wJ8JF2TsKgV6Rnw7FMK2Sb+3Go2Yueg6Nrl/mrCkMrGi+cO+tVHkl28Jf/rZiiTp0sdDbKjGOvG4+Z5mq+zfBDCxLQfZ1uLo1vt5iFCsZPNCpKz96ffvY8sKpnqDxQJeNxhnw=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 12:00:37 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:00:37 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
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
Subject: [PATCH v8 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Topic: [PATCH v8 5/5] MAINTAINERS: add maintainers for the NXP FlexSPI
 driver
Thread-Index: AQHUrMntyt8t2ONyEEG1Za+L0xz/Xw==
Date:   Tue, 15 Jan 2019 12:00:37 +0000
Message-ID: <1547553487-9936-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4301;6:zcFQ/19p3w27u2o4hC5SICz0wtnGHGPRj3Ik3tToqcpPRkKH9F08p2m/LB1XRnPXwFMbH2cjJE7LMz1i2km69C5978SdQYUIVwR8LEcTa6GgnFcCFlB6kFWiqFFUelWjdbJRWj6nvdTSs9OW8fh61j0IuS6pISUzq4cKKgMp0VwrMv/3JToGFiaxTTLqLuizkYegs1BnEiDqj8cPDEzWb3x0XUVz9ym6baxqUmibvoorcLyd7IIR6ZiEzl48ylTEfOKFV44rWLXqejC9siZwJv1TlUMo7o3LVm95mM9yaw7D/CvbiIgrECuTB7ob0KIjT1U4SMgmimYPKu68wfR4eHapBbfRoPI7vQZA7AXrobrnUAgr+oe0/Vd/VOJ6dLratt1U6T307t7RV6l7ELj+etZILCLQLWvnzP868DzB2bVk+Nf41BwPqTYwMbpbfsbbjFjMfPsfNBkDN5ZbDVaj3g==;5:LTnEatdKp/UeGVA2STc+1PSz1+iFcagY+pLL7jjXqt4fDUHODOKCLfb3swPFF50ed8loNToBEJp3ooZ7pZMSFhPA+na3SDNCifQwik1/ayWimvZxiyUmwsrejZl2auPU/11GypdxVRwr2/w7SVetzKmEfC3CAXjKixFoE5CTUaotRe9yzYzMI8GwzAMUGw+kgKAhosT+BvC7LX9BIOSAWA==;7:aCvSNRsm3Z3foSVpslgfxMDMdOHvmQytWUepRMmDdBjwJ/qH2RBbigiy5M7s6SOARrxML2ER6kK+HJbl7hyPkH1rn3H4fQ+pa7hXkqaxoh6VKS+LSYbVz2iruMvEiAOBi6FEvsLowElJUuzqGLwk8Q==
x-ms-office365-filtering-correlation-id: 31cf3676-7443-4f6b-8d37-08d67ae10fc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
x-ms-traffictypediagnostic: VI1PR04MB4301:
x-microsoft-antispam-prvs: <VI1PR04MB4301915063D8A38DFBB7515499810@VI1PR04MB4301.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(26005)(102836004)(6512007)(25786009)(4326008)(105586002)(2201001)(86362001)(478600001)(186003)(52116002)(6436002)(53936002)(476003)(14454004)(4744005)(106356001)(50226002)(8676002)(81156014)(81166006)(8936002)(7736002)(305945005)(486006)(316002)(68736007)(36756003)(7416002)(110136005)(54906003)(3846002)(6116002)(97736004)(78486014)(2906002)(6486002)(256004)(14444005)(446003)(6506007)(386003)(11346002)(39060400002)(2616005)(2501003)(5660300001)(55236004)(76176011)(66066001)(71200400001)(71190400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wx+gb2gHW6x6p41yTmKPBNa9pDglUBcuA/U65ir70XzW+7SgM5vl9auEiZabBTj+FRyydBMnGyZ/PAsURODBU/8qZOOaDc+u1Viv4bwwBdmZZQ38FPgkrK3+5uc7ahrrD+xOGMaxPj+h8r1H6hP+ha/BGcWEZpJUUndJ80V9DCFu8Hvf7tSrgQeRL9HOmI1dejPA7D65s8Z1DHTVGCOizP0QGkh9PIpAZen8uReKF5Es5egstVKkMHayJy38wWiMKpSG3h+9zVFCMYN12xzvosjp0Y+schrv2Y4fA3+iTLrUEZ/Ui+GatwpYkEgakVxL43yXWr2ymh4XKB6WQNN4rXMHZSNEVMwdnxPk7N+VLw6tKnNQ9A9FkDvINRMNQyptfgw6W+HubcrM+DjAxs+f79LpppaJ6/cyufeA3Uo+oqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cf3676-7443-4f6b-8d37-08d67ae10fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:00:32.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for the NXP FlexSPI driver

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v8:
- Update entry for NXP FlexSPI maintainers name
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

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b6c0d454d7e..5e7ec7cda3bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10927,6 +10927,14 @@ F:	lib/objagg.c
 F:	lib/test_objagg.c
 F:	include/linux/objagg.h
=20
+NXP FSPI DRIVER
+R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
+M:	Ashish Kumar <ashish.kumar@nxp.com>
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

