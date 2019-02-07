Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8770DC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549CC21916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMxsBvcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfBGPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:18:47 -0500
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:4854
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfBGPSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8vCXcx/ALS8BQhIjYb21a2pUbhUZsgRorOHda/gm2g=;
 b=SMxsBvcwo+LtQy1aWasuPUBg4zaaU0mvwMw/Wm6pcpOeLeeJYvgqeCmXgTIOqIzRlZ6yMd1zAZ/doPO+8jn204CCNqCVHaEc1CmvF8mXiNUsDW3cowTqMK8WutrIhq0Ud1ViNeas47L2jsMEc5coZvk/INR2rVdc7yAIUNqtZ68=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3846.eurprd04.prod.outlook.com (52.133.29.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 15:18:42 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::6c94:4ad8:e9f3:cf1%4]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:18:42 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 4/4] ARM: dts: imx6qdl-sabresd: remove reg_sensors'
 regulator-always-on
Thread-Topic: [PATCH 4/4] ARM: dts: imx6qdl-sabresd: remove reg_sensors'
 regulator-always-on
Thread-Index: AQHUvvho//YvBabVVE2M3kSRJbTJsw==
Date:   Thu, 7 Feb 2019 15:18:42 +0000
Message-ID: <1549552397-22798-4-git-send-email-Anson.Huang@nxp.com>
References: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549552397-22798-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3846;6:x63PrktDUhhCNwlQSt3qj63MNScNKoZBVvt3Kb2hM5Q7FgJjLc1DJcotN4fPayxAuFKkpmpBItUdr4X8+9hU7UNwmDaAzn4MQJ3jr+zSk7hRjKD+tOzsIpmnlTRy6B6MAoWr1/e8Bo3a059+Zrh1dB3jsQxE3PFIS8VB6orthYF/O8s8HiA5nwMO4/DbNbLLcJbYkCp6ltEXXLSQ666/3DD7+nSdLHlMdaRrpDhPcz7WbwL8DmF6u+ch314bpYhZ6FU5ZIEx5VMV9Xgi1ZBINHq9Qi4XoqrYJc1BGBq0vf1mQHuEUnKfX1V49V4cWeuWJzLe/Ln6GUvIQpzTWeCxl38P7DEL7dtgogKyPtHcsoYbDLgBPSivDmHRIcdnIAIbbmeUI4TMrVsZnX1+/jkx+hkttr5YbF1P4qRDRD8n6lxiV+UBN38vOKeTtWzwCpWHBB6iwAC3yRkYQeWp0pWOuA==;5:975E3sYHHV7rSAzKCjP0PuC+A05S6vNd8XBTWrZIDmFHXlOvIwZ23P4YKIRZbHfOLvNB0U1IAyBxlyWdk5hfeci7pKW8xTz1A8+f3gsr2OLUptdm3nlZxgNwdu/FrI/olTytQT0hVOB34eCQvkBJOl8tfLKdbDIL/IfusNi7YY1/IeYu1CSRiBE/biH1rqnHCXFIUnCnCLd+BSUJqp7Z0w==;7:BjqBBwpFbpbmUwSw3Nh7M3hYWsQLpQ5xDUUHowL2r4bGl6hv88SftEK8urohT8vMfiEwpOSOqCFBLcyIPkpF8egAipG/TgmvGMYYDJVCLmb9FJClWYiW2yWWqljkHUBFlyTlScscRRTf0vHuUxgjsQ==
x-ms-office365-filtering-correlation-id: 9d0cd316-0cae-40fc-610c-08d68d0f8b26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3846;
x-ms-traffictypediagnostic: AM6PR0402MB3846:
x-microsoft-antispam-prvs: <AM6PR0402MB384621AE01424A18A51B06EBF5680@AM6PR0402MB3846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(2616005)(476003)(6486002)(86362001)(11346002)(446003)(2501003)(110136005)(2201001)(76176011)(52116002)(486006)(81156014)(26005)(81166006)(186003)(8676002)(6512007)(256004)(4744005)(7736002)(14444005)(305945005)(68736007)(316002)(386003)(8936002)(102836004)(478600001)(71190400001)(6436002)(6116002)(71200400001)(6506007)(50226002)(3846002)(4326008)(36756003)(105586002)(25786009)(14454004)(2906002)(106356001)(66066001)(53936002)(99286004)(97736004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3846;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zu+vFKAP44LKHFNzWtKIN0+zZboHvV6nL7TJDUVnXAQ0k+mIJb59H6CYRjVBC5acklg064KldZCiCfYAr+QICN2p2UO6XcZB2RnGYxgG0gv1Vit9A/9Y18fMIOM1Xsz/+mF052W/qPZjF5kk1J0LpCYU8wiX28rdsWmf03WN+vhM5ga38ULF1JG3Xc9P2GsjCCUWyk0raZWSVT7kfZjqiu7VaQyD1sWWaYHmWKI4h726rN//wZIdVGhz6m6Khomc43OTUbvqTJV/LxFFrXg3RiMan2cSk2vr0sIMtPJ4XwWn3VN/rNW/arufF7ip9OoMm7hxSJnklJhy1hcJbA5aOGO98SbuV0d+xh6SbG9FV1tydtCuug/+zPyIHhU5hk/u+NgGxEhTtJFZwdqnbqKYZC0igIfDVMVo1VLM2DspPJU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0cd316-0cae-40fc-610c-08d68d0f8b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:18:38.6335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all sensors supplied by reg_sensors have supported
regulator control, reg_sensors does NOT need to be always ON,
remove "regulator-always-on" to save power.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx=
6qdl-sabresd.dtsi
index 80b9901..a070506 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -64,7 +64,6 @@
 		regulator-max-microvolt =3D <3300000>;
 		gpio =3D <&gpio2 31 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 	};
=20
 	gpio-keys {
--=20
2.7.4

