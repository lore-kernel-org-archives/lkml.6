Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9478B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FsNw8ONu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9478B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeLLMtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:49:17 -0500
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:2662
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeLLMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8J7MDbwyvn3G+y11I56ZhGeAOn2/VV+7CP4p+CLu0I=;
 b=FsNw8ONuSfKXO8cnAPDaSzcUPut3mfZCU5R59VFQ1Am9NwZ9tuZqMKkAMJbYiVDZQClgSqe1FZqjg4AeGz8GpouF140FEBr23GQLFrShmkRMj7NagjACexAHp6xtCeFCSSgac59KRcm2momwx4Pl/Tqeq4/jnVZSiZqSbmSffkE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3914.eurprd04.prod.outlook.com (52.134.71.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Wed, 12 Dec 2018 12:49:11 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 12:49:11 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Thread-Topic: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Thread-Index: AQHUkFeMq54w2saSI0m5D7dfdmdMWaV4nioAgAAlXHCAAOVZgIAA+eGwgABVyoCAABjvMQ==
Date:   Wed, 12 Dec 2018 12:49:11 +0000
Message-ID: <96906A60-5318-46E5-B302-207C1FC7578B@nxp.com>
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
 <20181210232358.GA11621@bogus>
 <DB3PR0402MB3916E1651ABC07F6F788B265F5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAL_Jsq+sP_fsQaoT6FpZNRxjhPAhCcE8e-0xffUUxShcC2LuHw@mail.gmail.com>
 <DB3PR0402MB39164538D3969FE51C649B65F5A70@DB3PR0402MB3916.eurprd04.prod.outlook.com>,<CAOMZO5DXNpn18pzngmAt+hyiWNtfwckafxCzbJ17EgndjABwWg@mail.gmail.com>
In-Reply-To: <CAOMZO5DXNpn18pzngmAt+hyiWNtfwckafxCzbJ17EgndjABwWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3914;6:kq5Bq40U6+i3DLvsW8Ve6yFqAiTh9yvLLZemVcUMCIMTQ8TuFhjj1wyjkUxIOHf6Cq6Id8yhuSKKZTCsxH3EUGFATs0WDKOV5w4SirHTTH6SdjLO3kCBpjNN23oC5tQpWm7i/C+FaAA7CNnBkmAu5S5gaFYmWE9WXLmJ9iBa3XgGmprvAdpYtvGy36xVJ9vUaD/ocR/PfpQjEecx9nhh3RYuGiVs0CUMGBC8+ogOOTB+vfqCMPgY2OwPgC+PHoqtnaEJ34cxcEkreOyfmx0uKDuXL86JELMOKi4m/zrnz0S4Xr15MRr4QWfNiiYmQiIqpQeePVkfkiggdMdIMKgl5tNFBqS+AWWAP5bpAZoyotvc4ltd3ah+Dhl//pvekyZTCYTwoGkptiKA4MI4RtUIA5Yt58s0oP8Z45qBthKJOBfCSsebr1rXdT+S2LoyDM5vfDkXAm/BR2PzAHQDivvEXA==;5:dFAgsRmR0uZnXJ2n/nxf31lSWecVuSRft/FzJdIYxrB4D5xvWHpxoH2wyY1Ny7JBeiVoblmwIz0dfHD0Koa8CbPiHhtiay/oqZL4QLVlixFfqGb8bz3iBO56W9AZrm+Ki4/+dKS7mqlxLu3PLs7lb5DYvhTj7vEh4N8rZlxOAhg=;7:aI3WYo6kCQkM0Rri9vuGY++DLyi4RSmoJUsE/ZDL1ev8RjKBX0q2zzAjJL68/lsNJL7K5IdGjtaRX04ZziLOWmNfpQpPM/tZSjHO9i4Q06e8yRzKyF8BipUnzxEEkL971Y25bSHEQSmdTergu4RkgQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 70589ef9-1775-4c8d-8907-08d6603036d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3914;
x-ms-traffictypediagnostic: DB3PR0402MB3914:
x-microsoft-antispam-prvs: <DB3PR0402MB39142E05933393331CC60F50F5A70@DB3PR0402MB3914.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3914;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3914;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(376002)(396003)(189003)(199004)(71200400001)(476003)(6512007)(6506007)(102836004)(186003)(229853002)(86362001)(7416002)(26005)(7736002)(53936002)(8676002)(8936002)(68736007)(6486002)(6436002)(66066001)(36756003)(81166006)(76176011)(105586002)(305945005)(446003)(106356001)(2906002)(478600001)(97736004)(99286004)(256004)(81156014)(6116002)(3846002)(1411001)(39060400002)(93886005)(11346002)(6916009)(33656002)(44832011)(316002)(5660300001)(2616005)(14454004)(6246003)(54906003)(82746002)(83716004)(25786009)(71190400001)(4326008)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3914;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: J9bnSEW47xLQwWbEazrnWyrUQQ10NyRzQZZNMib57H+gniB+JOzRACNzG2tkRapJtJPveAN/OH9wJAR/O8QB11++FeNX0H4lsNnZXpdwrmhjyVXe5MlncDwPtJvNzwNqgqrwkA646kxYDb55NUI7Tqjsq+ptIDxuvW7uy20++e5qZf0md72JAI5LgRd4K7YczslVyOScsuBqXVkfe8d98T7vkbhg5VrZt6kl+aMcCpuMkmz0sLSbGWYnRp3nmakfpvbvsX8qTsQmb1xb348n6ZcGtcI5KU0mpuaq+MGzZi82k2vQmpy2NZxHfykCv9Dh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70589ef9-1775-4c8d-8907-08d6603036d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 12:49:11.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3914
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkZyb20gQW5zb24ncyBpUGhvbmUgNg0KDQo+IA0KPiBXZSBzaG91bGQgbm90
IGJyZWFrIGV4aXN0aW5nIGR0YnMsIHNvIGluIHRoaXMgY2FzZSBqdXN0IGtlZXAgdGhlDQo+IGV4
aXN0aW5nIHN1cHBseSBuYW1lIGFuZCB5b3UgY291bGQgYWRkIHRoZSBuZXcgb3B0aW9uYWwgdmRk
YSBzdXBwbHkgYXMNCj4gcGVyIHRoZSBkYXRhc2hlZXQuDQoNCiAgICAgICAgU2luY2UgdGhlIGRh
dGFzaGVldCBvZiBpc2wyOTAxOCBzdGF0ZXMgdGhlIHZkZGEgYW5kIHZkZGQgTVVTVCBiZSBzaG9y
dGVkIGV4dGVybmFsbHksIGFuZCB0aGUgbGF0ZXIgY2hpcHMgZXZlbiByZW1vdmUgdmRkYSwgT05M
WSBoYXMgdmRkIG9uZSBzdXBwbHksIHNvIEkgdGhpbmsgYWRkaW5nIHZkZGEgZG9lcyBOT1QgbWFr
ZSBlbm91Z2ggc2Vuc2UuIExvb2tzIGxpa2UgdGhlIHZjYyB0aGV5IGFkZGVkIGlzIGp1c3QgZm9y
IHByZXBhcmUsIHRoZSBkcml2ZXIgZGlkIE5PVCBzdXBwb3J0IHJlZ3VsYXRvciBvcGVyYXRpb24g
YXQgdGhhdCB0aW1lLiBTbyBjYW4gd2UganVzdCB1c2UgdmNjIGluIGRyaXZlciBhY2NvcmRpbmds
eT8gRG8gd2UgaGF2ZSB0byB1c2UgdGhlIG5hbWUg4oCcVkRE4oCdIGluIGRhdGFzaGVldCBmb3Ig
cmVndWxhdG9yIG5hbWU/DQoNCkFuc29uLg==
