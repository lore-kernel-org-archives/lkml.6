Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C907C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8192222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UBQZT2o/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391076AbfBMJAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:00:23 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:5435 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389007AbfBMJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:00:21 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="26652919"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Feb 2019 02:00:20 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 02:00:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnWMi//fxoteWcNRCcHKFgswLnoQIj4FrFPhVBnCBj4=;
 b=UBQZT2o/YYc7/VoaSzWQzTDZq0LyHchVenSjmVQLocTKJmyY+7tPHVOxNfmMTx5pgCzXsEXP0D/rlLYDLn9sS+mRrdLjXCQaisOnCy2XgOE5vU5v9hIsjivWlVR+0vknak7o6OOeYCFwUTpt5qP+MPpMQjrBqK45a90HSo07wPE=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0002.namprd11.prod.outlook.com (10.161.152.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 09:00:17 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 09:00:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 11/11] mtd: rawnand: atmel: switch to SPDX license identifiers
Thread-Topic: [PATCH 11/11] mtd: rawnand: atmel: switch to SPDX license
 identifiers
Thread-Index: AQHUw3qKhla9Kv6B3k629BWTQGhkKw==
Date:   Wed, 13 Feb 2019 09:00:17 +0000
Message-ID: <20190213085930.31578-12-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db5d83b7-984d-4eb9-80bf-08d69191aca5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0002;
x-ms-traffictypediagnostic: BN6PR11MB0002:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIwMDAyOzIzOklKdGg2bnZ0cVQ1NUxzbXFVWmhPNjVROExl?=
 =?utf-8?B?ZHI3Q1dXTktZS0ROdHB5N3Ewb3Q4ZlBmMVRaeTZkZENPMzlYVlladXovT1Ni?=
 =?utf-8?B?a2dMWnNEZFFHQ2tyQXRmWFBtczJZQWl3WnB5UEg1NnpsOXlyRXpTc0NLWS9n?=
 =?utf-8?B?bWRRbFB1Tm0xQUxuZDNQRWU0TnBITGRuNC9LanZ5ejV4ZU5ZNEFKbnNUNE9K?=
 =?utf-8?B?Y2dFVHYxUWRuMjFBdGU1bXkzTnQvUEZCOUtrOTNIazU5ZDBRSTVtbU9udFJF?=
 =?utf-8?B?YUdTTDdZWDFzcnI3dmZuZDhOMW0rTERubUpIeVR6MVFhNmd1MVpLdjhvQTF1?=
 =?utf-8?B?dTJkQ3JiLzdscCtvdWl3Y1JuNG92eHk5OGdSeGNOdHFOcS9Ec0JNOUYxbXZR?=
 =?utf-8?B?cytHVTIzaTBvVVNUT2FUYkI5T0ZpcjlmM0ZCZGd6OHVFaENJNEtydmNYL2Qy?=
 =?utf-8?B?Nmd4bXZOSXVBbE5QZnFqYUZoS0MvbVdpeWJuRFhMUzlqU1ZGR0lMVDRhMmFp?=
 =?utf-8?B?anlpMEphVDgzZjdCeTR6ZWZWZm43alA3VlVBU3ZqVEFDdHJRc0lvZzdRZWtx?=
 =?utf-8?B?QXcvcTRsTjBiVzUzZ01yMFE3NHZYeTZvMGVISk5lQjg0T1U2eWNIZ3lrUllI?=
 =?utf-8?B?ZU9kVCsxVWkwWFprTEVuWDFxa3Q2eDk5WTU3VTlseFZ3aWxwNzNXQzZWSkkx?=
 =?utf-8?B?MzFVR05XcmV0Ykp1bHZxcDV2VnhFTGNTQ3NIcHNjWVMvaU5uZktwUGdhSndo?=
 =?utf-8?B?UExGd2tTRm94UkhDWVN2aHFpN0VuQjRpenVuK2ZFQXdUWXgyYXJRNlNVS280?=
 =?utf-8?B?NHB4bkc2QTBQNkdmZ09OL0RJZmtMMlJaYlR5bUZMQ2hsY1FYTVJQWVVxdnha?=
 =?utf-8?B?ejhWWUxLNFFEZ0J6QXdQOHVCSjBmWjhLaEV5V3dGZmErcytQcDNuenBTeTNQ?=
 =?utf-8?B?Z09TOU9WRmZWT2dPUEVjL3k2MVJ1aEtTdGwxbGQ4WUxGVWVXK2FvZkZ0NzBG?=
 =?utf-8?B?cHVROXM1T3ZUMG5lNUk3ZUZnK2hTa1cvcDFKb2h0cW5EV0I5cjVjT09YKzVv?=
 =?utf-8?B?elplbjBxZVRhZjNpMEhKaTI4R0JhNnhXNmRReWlneFJSWmZ1amNuMHFkblBF?=
 =?utf-8?B?WDh1U3lkVjdHQ0piM003OStoKzcrcVIrYVZaRkhIdURCaDVBd2UzR1pGdWJQ?=
 =?utf-8?B?VXVLUmczWlFMQXpTT3lvNWw4QmRaNG83anhVR0lJdE81L2kvbU94RE5oT3pP?=
 =?utf-8?B?QlpWeDNjb1JSdXExYTQ4Y3ZNeEFXdFNJM20zY2gxUSs4VU9qaDBqNHRxZ2Ni?=
 =?utf-8?B?cEJSTnZ6WjIrZFRmUG1FaldHUm1HdkZDSGdIL01GUTNrTDZEMHRSeXQ3ei9R?=
 =?utf-8?B?d2xpMDZGaXFNdWRWbktVMmtiMlFScFJFWUFaNm5WZVA5c0FSR2VDcEg5Y2FC?=
 =?utf-8?B?R3JBaThrYmxkVFFQOHVFYmpEckdRNC9sTmt1WGpkakQyYjRyeEZjbG5GZkQz?=
 =?utf-8?B?WjJwM00xYjlhUmtKSGxMNzBRNGUrYlJ4bXo3cmY3MHFJZ1E5VlFOWnE1Rmk3?=
 =?utf-8?B?V0NTWFBTekpYZmpOUXRQSVl4Y2ZHZDZINy94dVV0aE1UemR0LzdoRElueVgy?=
 =?utf-8?B?OWYvb243SlVSWUFqdEl4ZEQ4U3RDWC90YWpwRm1SUnRTUWo5Szl5UHhBdnFo?=
 =?utf-8?B?YTRQYjBnWnFPaHQ4NEt6OC9UTWt6Ykh5WHlZbXltekNkMkRoTVhFOVFPV0Qr?=
 =?utf-8?B?ZmNmelJwdzI0VEVlN0dJOHA4cVEyQk82MnhzNDQ5K09JWnR6YktGeGR6SHFI?=
 =?utf-8?Q?LUtyiI5qLHump?=
x-microsoft-antispam-prvs: <BN6PR11MB00022C15B51612F5C42D65BBF0660@BN6PR11MB0002.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(189003)(2501003)(110136005)(54906003)(2201001)(86362001)(3846002)(25786009)(6116002)(105586002)(316002)(106356001)(52116002)(1076003)(97736004)(76176011)(102836004)(99286004)(2906002)(7416002)(36756003)(6506007)(386003)(305945005)(486006)(2616005)(71200400001)(71190400001)(6512007)(81166006)(478600001)(11346002)(446003)(50226002)(7736002)(53936002)(66066001)(26005)(107886003)(186003)(68736007)(256004)(72206003)(14454004)(476003)(6436002)(4326008)(6486002)(8936002)(81156014)(8676002)(2004002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0002;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0QqYcCS2TeKwUarF6scQRj2kr5T7QsDxjue91LP4uaTj5SsFiaMOLwR9Xvi5hIJNmBjjecOXg6kPsdpU9SAD7NQn4/IJNq6/idFVicGjnMexUVA2EgYJggZ4JJ450xRbkK0ikWf1fMpud9AC5AKGLR/jJ8lwu8D6MpSiRP5Bayn/A7YWqqRx3qVOq5i9t6dqNq5Rkt/rcLq2oaYIfqwGRCjvmCrPtCnhEUTD13XH4qh3snmLXmAS+BYAbzoRXNwaSVGpXcDtEiu6NDl/xv/JLToaxQ35ZEFJBHwol/yAbp4kyrybKFcE3VQsl0b9WHvQ/uxPeQ4fI8sZ8WRb4qrGTkO2glPmMyFkoSVNjW7a4RsAedfE09ajN6vUeMdK11KyrwFUx52niNUd1byEeT5jJpc9DCiJSfRdhTQ9i/okNUg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33943D080C7E87409BEBE9682EA68C0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db5d83b7-984d-4eb9-80bf-08d69191aca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 09:00:14.7866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0002
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpBZG9w
dCB0aGUgU1BEWCBsaWNlbnNlIGlkZW50aWZpZXJzIHRvIGVhc2UgbGljZW5zZSBjb21wbGlhbmNl
DQptYW5hZ2VtZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJh
cnVzQG1pY3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5k
LWNvbnRyb2xsZXIuYyB8IDUgKy0tLS0NCiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9wbWVj
Yy5jICAgICAgICAgICB8IDUgKy0tLS0NCiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9wbWVj
Yy5oICAgICAgICAgICB8IDYgKy0tLS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcv
YXRtZWwvbmFuZC1jb250cm9sbGVyLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5k
LWNvbnRyb2xsZXIuYw0KaW5kZXggZmY4NWJlMGUyZGUzLi4zMjA1YjcwNWQ3MzQgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0KKysrIGIv
ZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMNCkBAIC0xLDMgKzEs
NCBAQA0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQogLyoNCiAgKiBDb3B5
cmlnaHQgMjAxNyBBVE1FTA0KICAqIENvcHlyaWdodCAyMDE3IEZyZWUgRWxlY3Ryb25zDQpAQCAt
MjksMTAgKzMwLDYgQEANCiAgKiAgIEFkZCBOYW5kIEZsYXNoIENvbnRyb2xsZXIgc3VwcG9ydCBm
b3IgU0FNQTUgU29DDQogICoJQ29weXJpZ2h0IDIwMTMgQVRNRUwsIEpvc2ggV3UgKGpvc2gud3VA
YXRtZWwuY29tKQ0KICAqDQotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCi0gKiBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KLSAqIHB1Ymxp
c2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KLSAqDQogICogQSBmZXcgd29y
ZHMgYWJvdXQgdGhlIG5hbWluZyBjb252ZW50aW9uIGluIHRoaXMgZmlsZS4gVGhpcyBjb252ZW50
aW9uDQogICogYXBwbGllcyB0byBzdHJ1Y3R1cmUgYW5kIGZ1bmN0aW9uIG5hbWVzLg0KICAqDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvcG1lY2MuYyBiL2RyaXZlcnMv
bXRkL25hbmQvcmF3L2F0bWVsL3BtZWNjLmMNCmluZGV4IDlkMzk5Nzg0MDg4OS4uY2JiMDIzYmYw
MGY3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvcG1lY2MuYw0KKysr
IGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvcG1lY2MuYw0KQEAgLTEsMyArMSw0IEBADQor
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCiAvKg0KICAqIENvcHlyaWdodCAy
MDE3IEFUTUVMDQogICogQ29weXJpZ2h0IDIwMTcgRnJlZSBFbGVjdHJvbnMNCkBAIC0yOCwxMCAr
MjksNiBAQA0KICAqICAgQWRkIE5hbmQgRmxhc2ggQ29udHJvbGxlciBzdXBwb3J0IGZvciBTQU1B
NSBTb0MNCiAgKglDb3B5cmlnaHQgMjAxMyBBVE1FTCwgSm9zaCBXdSAoam9zaC53dUBhdG1lbC5j
b20pDQogICoNCi0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRp
c3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KLSAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQotICogcHVibGlzaGVkIGJ5
IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQotICoNCiAgKiBUaGUgUE1FQ0MgaXMgYW4g
aGFyZHdhcmUgYXNzaXN0ZWQgQkNIIGVuZ2luZSwgd2hpY2ggbWVhbnMgcGFydCBvZiB0aGUNCiAg
KiBFQ0MgYWxnb3JpdGhtIGlzIGxlZnQgdG8gdGhlIHNvZnR3YXJlLiBUaGUgaGFyZHdhcmUvc29m
dHdhcmUgcmVwYXJ0aXRpb24NCiAgKiBpcyBleHBsYWluZWQgaW4gdGhlICJQTUVDQyBDb250cm9s
bGVyIEZ1bmN0aW9uYWwgRGVzY3JpcHRpb24iIGNoYXB0ZXIgaW4NCmRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9wbWVjYy5oIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRt
ZWwvcG1lY2MuaA0KaW5kZXggODA4ZjFiZTBkNmFkLi43ODUxYzA1MTI2Y2YgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9wbWVjYy5oDQorKysgYi9kcml2ZXJzL210ZC9u
YW5kL3Jhdy9hdG1lbC9wbWVjYy5oDQpAQCAtMSwzICsxLDQgQEANCisvKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMCAqLw0KIC8qDQogICogwqkgQ29weXJpZ2h0IDIwMTYgQVRNRUwN
CiAgKiDCqSBDb3B5cmlnaHQgMjAxNiBGcmVlIEVsZWN0cm9ucw0KQEAgLTI4LDExICsyOSw2IEBA
DQogICoNCiAgKiAgICBBZGQgTmFuZCBGbGFzaCBDb250cm9sbGVyIHN1cHBvcnQgZm9yIFNBTUE1
IFNvQw0KICAqICAgICAgICDCqSBDb3B5cmlnaHQgMjAxMyBBVE1FTCwgSm9zaCBXdSAoam9zaC53
dUBhdG1lbC5jb20pDQotICoNCi0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91
IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KLSAqIGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyIGFzDQotICogcHVi
bGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQotICoNCiAgKi8NCiANCiAj
aWZuZGVmIEFUTUVMX1BNRUNDX0gNCi0tIA0KMi45LjUNCg0K
