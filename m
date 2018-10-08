Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8EAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE422089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="EdfuTbb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE422089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJIE3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:29:00 -0400
Received: from mail-ve1eur01on0114.outbound.protection.outlook.com ([104.47.1.114]:37189
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeJIE27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mXZ0hAxyaUVthD4qLBigu+DS2swQOTtj0qA66Doewc=;
 b=EdfuTbb4iiE8chRW7PdY/7b2qQkFkf+HILHYe7UJmRC5h5moYFfAHPuWJRjODIo+bepKT7PPHNPNnmTtLE2eYPUZ7WjsiO+HA65GQIs9bxkqRXm1QZGi99is3y6wgQGGVE4N0ddgi5SLVh38p/CyxyOZ8AqSGzB+Lyt/KI+ntIA=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2047.eurprd02.prod.outlook.com (10.167.207.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 21:15:15 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 21:15:15 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH] mux: adgs1408: use the correct MODULE_LICENSE
Thread-Topic: [PATCH] mux: adgs1408: use the correct MODULE_LICENSE
Thread-Index: AQHUOG4y1HPAkFUvMkyjWASPz3LluKUWJyMA
Date:   Mon, 8 Oct 2018 21:15:14 +0000
Message-ID: <26e5ef75-c649-ba93-0d79-8599c1bdf4ef@axentia.se>
References: <20180820101132.23205-1-peda@axentia.se>
In-Reply-To: <20180820101132.23205-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0136.eurprd05.prod.outlook.com
 (2603:10a6:7:28::23) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2047;6:Vxo/AjcraBTlxcRtKmPTFAaDNFCAOQ7aeSqk9QuW8iRqc4s14HQ3LzvSoZIj3l/SMcSVS4OXL2NlbJSWkMb+GK+fMyhbYiyG1i35B9NDmORi21oJPqgbwqSTIomAdKM7C9aInF6LxcN5RVz/C7noarCvHqKAZE+7oFZTkf+8lFQYozC08NCASZFvf931kmTfcz8/jeJ2lOAp6SJ8gv9eJEe9ZMa6JPmThpEXz7JJuWHl8Yjj0EYh82slqcb3fbqnVvLrR+VxKjtcGUMW1CepaxogDW8KYMPORPjl2tgdbKbFlDUc+xoOf5DO3OW8/01CAtgtXNx3uLUwEvDcRhHbsm4oAj6tHNQOxifu6zZISLr+wMxM4GM50RZeu6OnPbPSLrcCuYLXd2ceFoqjnKt8O4sQhF0c+zaYmoA/wo7EM3056Mku9BL62XwFmqhDlibvSJ1wlrB+V5r4cK4PicGe2Q==;5:x5AVcWy0+HF4s+VnVVu2UhbEImp7c56B0BaOHUuB5JjFgNjPE1T1ikYg/uLCW3h9IyoDgc27cvWopvCwkEWSvxXhntEgAKkOKVSJSyDkngvjISiOPpdPHS1Amsc4h0fJLkT0BB5bk9DTBXLyUziXe3Wvn5FjkDCqRAg0sNowH4g=;7:x6LWJxaYt7LwauQ5Kp8GGZLcnqQIgLeszA/qf5P2M/VjgY7GshHSyA1c9xj7B8jHQmoAEpVvKFzLIap7OelHRSQB56m1xuAfGS/XywSCOlSNLw6G34blt3BAxpcbtS3/RpKydKwyysUoxDZPCdD0Cx9C6+Xa+Vchz0zHi22UK5GeOJFgfbU4nPOjVU/OI2sTwCVb7/H64GUOWMlBRC4qKbx9WG4BloPYpe+52NosTexyZl1FEVLq15wtI3xAEVC4
x-ms-office365-filtering-correlation-id: 75a9ee66-46c8-45f0-9967-08d62d6323c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2047;
x-ms-traffictypediagnostic: VI1PR0201MB2047:
x-microsoft-antispam-prvs: <VI1PR0201MB2047B74C7110462A58F391EBBCE60@VI1PR0201MB2047.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:VI1PR0201MB2047;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2047;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(71190400001)(476003)(71200400001)(99286004)(2906002)(446003)(305945005)(6246003)(6486002)(7736002)(11346002)(2616005)(6436002)(58126008)(229853002)(2501003)(5250100002)(97736004)(486006)(6916009)(102836004)(316002)(5640700003)(558084003)(3846002)(68736007)(53546011)(508600001)(6506007)(25786009)(66066001)(53936002)(2351001)(65806001)(3260700006)(65956001)(65826007)(186003)(14454004)(74482002)(106356001)(6116002)(36756003)(256004)(81166006)(386003)(81156014)(5660300001)(31696002)(31686004)(76176011)(8676002)(6512007)(2900100001)(26005)(4326008)(64126003)(105586002)(52116002)(86362001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2047;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zGE98M3Lk6fiXKdAWU16IgOuKm9s7Vuzyip7sMUn82SDC41KRu1uMfC1ld8Vj6Dior4hCktzRTDKF9hsyk9h4yn6WHg4uoGKdCtHX0lksN7VL24DB94jAQCkRo+dF3wU3owfKM0lPt3AQHZKq831/UqE7z3b0HAyW4sUwxjMfNStxBmQLdlDjBfpaVNOr3ZPBey2JqudpyAowUSM+zpccc8+7VN+A1nOZ6ioHNrjFCK46dM996c64EF48nj0f/PbmnJ9JfhWlznz/ng5XI1wKXULaXDpUF6easHuyPAW/FAAZOmlJiyLNdum4HfNKoWRQcaiIX5VxVwqaYc0dam0gsjpB/32OpbhOMTgpeobowQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7178945758E4C748B686AC9F6F38D024@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a9ee66-46c8-45f0-9967-08d62d6323c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 21:15:14.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0wOC0yMCAxMjoxMSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IFRoZSBmaWxlIGlzIEdQ
TCB2MiBvciBsYXRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4
ZW50aWEuc2U+DQoNCkFwcGxpZWQgdG8gdGhlIGZvci1uZXh0IGJyYW5jaC4NCg0KQ2hlZXJzLA0K
UGV0ZXINCg==
