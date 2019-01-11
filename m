Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D463020870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qWdU2ONf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfAKGW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:22:59 -0500
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:10688
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728042AbfAKGW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM/nfZ6PybOd0XAwGhp9tp7Z5xntz021mGBsxZ9pC2Q=;
 b=qWdU2ONfumIhzh0KHOt2th57vgwHtCvBNW5TuIBm4WOsnU9IRu9k6XR/tOnNagWu3U1l5BELHeMKWyexg1rSqY/maZVr3tQ0SEHYCNMHI91J+3YNHfUx5hylDPdA7yFCsAXuWX2LQS7V/qYTaXedcOHzHKTjFlsJv5i296T0Mqk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3788.eurprd04.prod.outlook.com (52.134.72.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 06:22:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 06:22:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 3/3] ARM: dts: imx7ulp: add sim node
Thread-Topic: [PATCH V2 3/3] ARM: dts: imx7ulp: add sim node
Thread-Index: AQHUqXYWg+51IO12n0K+7RQGwoV4PQ==
Date:   Fri, 11 Jan 2019 06:22:55 +0000
Message-ID: <1547187469-14046-3-git-send-email-Anson.Huang@nxp.com>
References: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1547187469-14046-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3788;6:Fz4JrrWxlLg9VdRK06jcYNEMOxuG/OHScfFycAd577I4009HaCxQEKmulnG7SgDPiVEw55zjIx8g9EFp8xK9HHXNxXLgN4Ix1Uvt1JMbv9Qj4vQAZ2773DEmCMIc4+78/ZZvUL2oMUttSEjTFTXj3L5d+lcY8XLMJkQXgsWJFwppYJUCIZAvPazgW4lZjC9r539YbMKNbTpcluXfQ7i3AhmBpp5mUNPNalTQt3RbrDbeg/35LMRqIInUlIlGZ07OXKK6wnTlBds3saKnApx3gAttGp8D4n4dQAgFJevbOSA0DbjQ2N3tCiJgqG6xKJmWbOlxE8CyZFAtsLpUzXjsnXBtV1iVYai58VjBA1mNtxHbznV52MfTnfXJFcBh3TApGwiOzUTUi2I9B5o5Vv9nOqXMt8CQBAs1yV6po3Q/XHBQCdLNVl25KvFgSJAa+N8HZr9W7DyDcxEN1Eb44k7pVg==;5:nPdRl+Pfddcj+cE12yanciPe/UqkH0Dwpn74E0L+CfK49eWqkMmoOuCmDp97VoFUWO4GEK93RWEK2C3OvEhYa6A+xeRpeCjO497ySO2i2ririiLm4Dlx5CDGc3Xp5QjhmTKjOHSHMgs8YxXRtYn4oqC5lyF3BZjkRS8j9VH6LuWMbH8RaQiWrwhq3I0UN72JTqw4H6ON4r1cvJKXlfVMfw==;7:wvL+0cvxmq8IWPqe9avbpo6SSCb1MILrr9T/w8SpS7dEYyXWye/yS08OzanyYKbukoiRt/aQLa8FZ9EKp6IvN4NiJh9EBpdq9vhEkio90u9bv7laefgVMfl6FG0Jvhfpzlls5SEi11qx2agB3AKO7w==
x-ms-office365-filtering-correlation-id: 866d4191-bf4b-41a1-8de2-08d6778d38ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3788;
x-ms-traffictypediagnostic: DB3PR0402MB3788:
x-microsoft-antispam-prvs: <DB3PR0402MB3788F43CE6BAC52F996F4F5CF5850@DB3PR0402MB3788.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(4326008)(486006)(106356001)(105586002)(53936002)(316002)(2616005)(102836004)(2906002)(25786009)(4744005)(26005)(99286004)(186003)(386003)(6506007)(97736004)(6512007)(76176011)(6486002)(52116002)(71190400001)(71200400001)(256004)(2501003)(305945005)(478600001)(7736002)(446003)(36756003)(14454004)(11346002)(6436002)(6116002)(66066001)(476003)(3846002)(5660300001)(81156014)(68736007)(81166006)(8936002)(86362001)(8676002)(50226002)(110136005)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3788;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vyBkHhGgD93yXgXHmSJmaI3BQWxh5npNZ3EYzPTy/xtyyS3Q9qXB43DEsw8SpJeuP4FMu4cQY70Dpw9Cl/UlIoQdn+Dw1522iCOccJ5gPiGZ/XNsVtWAcFeYQtt996BfMEpTWz9AuV0GC81Xc+KmuG84ZL3iZBDyXmzGPzz5TmD5Air9+MXAx/P07h9sXtTZQ4jaqMVbRPKo39A5Ng2CJ6ch2YrUn+z9AKqL2/mINX4BqSeQpiTUOyZ6ITRrRgYPqmVrDh45m164m+VtdgdLEWdkqz7o5I4DBWnxjyS2g5hOEtAdZEO8SvRcoL5GteyzxKC4yM3jBITXM4ysSbEG51AJVxRs3ZgktChfOaES5IbxLwRrny8N/5UO3cuMiK+9JXM8ZEB1ukwRGKzRnnMm3q0J2RdjWfR89wQhmeOZ0ak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866d4191-bf4b-41a1-8de2-08d6778d38ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 06:22:50.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3788
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP SoC revision info is inside the SIM mode's JTAG_ID
register, add sim node to support SoC revision check.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index b86daf7..fca6e50 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -347,4 +347,17 @@
 			gpio-ranges =3D <&iomuxc1 0 96 32>;
 		};
 	};
+
+	m4aips1: bus@41080000 {
+		compatible =3D "simple-bus";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		reg =3D <0x41080000 0x80000>;
+		ranges;
+
+		sim: sim@410a3000 {
+			compatible =3D "fsl,imx7ulp-sim", "syscon";
+			reg =3D <0x410a3000 0x1000>;
+		};
+	};
 };
--=20
2.7.4

