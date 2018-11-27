Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D74EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCFD2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a2iU1Z68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCFD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeK0Wy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:54:57 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:65068 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbeK0Wy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:54:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="23556018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 27 Nov 2018 04:57:15 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 04:57:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN1Dg3nIpUQbfLfV7zTXkz/v8csDo2gqNaWQinGdKVo=;
 b=a2iU1Z68tsK0/mLFwkPZ+Ew9NrmnkVOaWizjnAJ9uyfDS4g4FLevVaQLZJwBmHuDg2JoMA1njw1j2Fs8xbfVli8MJHSmeWR5DWjLZXZ5tXzh6q9sQeTOxGYfbdYMPCDuB5K3zUi0AOVnHV+OOfJ+kosVWF0fOmCAAibcaRxEvIQ=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0582.namprd11.prod.outlook.com (10.163.159.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Tue, 27 Nov 2018 11:57:13 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 11:57:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 2/5] regulator: act8945a-regulator: fix line over 80 chars
 warning
Thread-Topic: [PATCH v2 2/5] regulator: act8945a-regulator: fix line over 80
 chars warning
Thread-Index: AQHUhkhVV4sGUc660UaCDKsfQNlA5g==
Date:   Tue, 27 Nov 2018 11:57:13 +0000
Message-ID: <1543319801-19100-3-git-send-email-claudiu.beznea@microchip.com>
References: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0582;6:UuE+b5WSQmbd92nw2oS+eEtPWjNZv62DQrD9SEPl91oMUDcuFvacy8tlt9HSk2O0gkCduFpqsSL0weAlTuchCV4pDyyO4THv5Cbv+UqR4dvN6djyIS5Zu7D17oCh/Or98aq0vpeJnYeAhFhgdCEu2fjVmAICy0ndNB/Rd176g5DxsLIhxjkVGoCiqrQW5C+XA6ZxY39FNuuZEETsn6K80I6AL4HNStK4eO+PT40BdZvm/8o4FFk67xqtYo+pX4IT+GxSV5LMC3T8iXQnCh95DSnSdLHWIqKma2NBbhBk4OG5VN+UTM7ReW6akyF5LvBF3+3JXoyAZOnmvAKJewIp4+WMP56BqWAV2gW0ChSZVTi0D4g2fOtmhO4LGWzHANKnBU2K6k5HZGe6aOwOCmPde+likyY5IuL3QTX84Nkyv7WlaeZHfk/Qfiik3UsJlQgz3ztVk/3Q+Z8qVSFFicyTBEW+WI2enhqTYtrCTEBjufE=;5:k43d3sJ/w39oxtMlL8KXPlJa9t17TPxUnENLsasfEU9vunFlsWPOfiJN1TKhO65H77cMf12lWKO1l1mDwOcoMhjpU3guEn2LUD+nKitkPpGybRcrVGuFQ+T1K3XZwT+LSTy7AWssHjgu2v1wXmJAsY7Z7p6h7SX/XyYlXpUlaLY=;7:/l/tyr77y4Le1MefAtqIfVzG6FF9fexc64gYEdmquSHZB4UBS1ej3b5gimsf434dWdspvbKBVf+3bs+p7HT2sINeaYq9UuytoBLXMCURYIuswtOQV6lSBBnq+M/zI+jHDqgKzHFjUgI5aHFtkOfTVA==
x-ms-office365-filtering-correlation-id: 01019c6f-a6d3-40bf-b711-08d6545f77ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0582;
x-ms-traffictypediagnostic: BY2PR11MB0582:
x-microsoft-antispam-prvs: <BY2PR11MB05821CA9945D1B93EF96670D87D00@BY2PR11MB0582.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0582;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0582;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(4326008)(66066001)(106356001)(86362001)(5660300001)(97736004)(186003)(39060400002)(99286004)(6486002)(52116002)(26005)(105586002)(478600001)(36756003)(256004)(14444005)(2501003)(110136005)(54906003)(386003)(6506007)(107886003)(72206003)(7736002)(102836004)(305945005)(6116002)(3846002)(76176011)(71200400001)(68736007)(14454004)(71190400001)(6636002)(2906002)(476003)(2616005)(6436002)(25786009)(446003)(53936002)(316002)(8936002)(8676002)(11346002)(486006)(81156014)(6512007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0582;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gNpQlt65JEGkjFVz08dpEEev7z8n4zlkIDzAr3sD8p7FMjWwfK6UpoKMEUl4s/iOTsH6pIg15WExo6sTmNp8ZHmxc+JFKo5BjS74NFLYuF4kiHGxuYHGijyIsCjHvPRstdXcYGcIexS48Tre5Sl1IC58GmjCRun9AqA6S7jviW2KfdW79/fry5+IcRvvCCq4z307UTR7YfiQVe+3OlM1Ls0WY+PJgnPxd/LYkHKgaQ4M0+R7jmH6IutMaqR0ny/71d3flx8AvrD8NTTZp5qezDI3pM8X6lDzDP64NiOnW42N7fal9Dk+s3uSUd5XXdjUVeKfvHXb5fwofW1d5nKp5opaboLgVgIYgsjQ7d78AIE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 01019c6f-a6d3-40bf-b711-08d6545f77ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 11:57:13.5116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0582
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Fix line over 80 chars checkpatch.pl warning.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/act8945a-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act=
8945a-regulator.c
index f37d1a860407..f4d60743efb3 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -310,7 +310,8 @@ static int act8945a_pmic_probe(struct platform_device *=
pdev)
 	config.dev->of_node =3D pdev->dev.parent->of_node;
 	config.driver_data =3D act8945a;
 	for (i =3D 0; i < num_regulators; i++) {
-		rdev =3D devm_regulator_register(&pdev->dev, &regulators[i], &config);
+		rdev =3D devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev,
 				"failed to register %s regulator\n",
--=20
2.7.4

