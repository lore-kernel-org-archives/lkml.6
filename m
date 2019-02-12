Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77DFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AC6222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="vTNk2ywN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbfBLVA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:00:58 -0500
Received: from mail-eopbgr30095.outbound.protection.outlook.com ([40.107.3.95]:28944
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfBLVA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG72YzmZzeP/+gBKDeefZin74dd87OZJJ70rEWfjRP8=;
 b=vTNk2ywN9RObYU8kQ91T4oJARqAOcD0gfOFxHdkZb+etAEYwd08BH4ImS7q/3MWMxwFRG0W2Atig0T7bKHRQDq2EqGwp7A0KIYr08nBf4IP+Dc086pGRIlyzkd+jq0ICMzun4FrTLg704jKpIU09s2E5D9PIoNJwnnkrjVRRREU=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4750.eurprd02.prod.outlook.com (20.177.201.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 21:00:51 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 21:00:51 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mkarthik@nvidia.com" <mkarthik@nvidia.com>,
        "smohammed@nvidia.com" <smohammed@nvidia.com>,
        "talho@nvidia.com" <talho@nvidia.com>
CC:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Topic: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Index: AQHUwwYdZch4bQ8RokWFFjgVOtcOHqXcpgAA
Date:   Tue, 12 Feb 2019 21:00:51 +0000
Message-ID: <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0901CA0064.eurprd09.prod.outlook.com
 (2603:10a6:3:45::32) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4750;6:SqC+C2YLupJFrCJYDsmm+G5pgev7PDfdmdhE9xh6qanXtVASE0YBRTEgE20vauWIOSKrdqYKLS+BbrpT/7svae02aykhDUOUDK4bsBwa+xAEjlsHlBaCCATER3KDC0MAH7iN5do2Kzls1/URxLGXM2DY7jaNZf8FSk+RP4rsrAac2hdXjo68VIAdGGSEDPjX0AUHISs1JhA5ZcCnwPSMa9rT3JPuAvPGM7uEm7rI0G9vw+UJF0P9d85ntBMgeTHpKgyEexDzix40PuPsa4a4zaWblDYKNtjVKcFFQ0Y+PQBKTwsRg8J6FM199VFZamwvofBW0mVyF1LUgq7fWJMMCd5LbQ3i+migGjwU7lm8ZbLkmU5DXHAmCGn34e/ghYs69+UBCMwoSmj3WvvzXdYjflfXZya02ZfYLiEpnC4xzPuS8uPcGQWPMApE7ZnAZVxqqvuCvkpBqU/Tjh6fIFMFvw==;5:S7ECyCaIY+8IC8SExtI7sO4LXbwU0VNnbLNpMJGv3cyM4VQvL2ctwskdrmdhQ+rdf9Fy0E0DJzkguEznhUPMKS3G6TwKPHk/ZQKo45VRI0AYdXMsIEfVC6ATrf+gCw8YolBaQjNCYqKt7qadfhapTRt8UtlJQepCkFQMi4wTM5e5/TRLF2U8vXYLZjcc0U7Mwrg8Rruzd3SsUc0Fi7oc8g==;7:9HhCJ8PX3hf82Sg+nogcwxFHO1LNVhMTtID6S7/qkk+eVuKM6c8L2rQsbbVQQyGMpenUs/XCEE8yK/aNFFSea5YeVpZ1mVVMMqRnnC+YRZ8x0wufuP6ZcX6ZyT5j2UexCK7WobgAvuzGHiqGppK1GQ==
x-ms-office365-filtering-correlation-id: 9f579aee-d356-4a12-abe8-08d6912d2b59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4750;
x-ms-traffictypediagnostic: VI1PR02MB4750:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR02MB475010D24A1B7C70F9EF8194BC650@VI1PR02MB4750.eurprd02.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39830400003)(366004)(396003)(376002)(199004)(189003)(3846002)(65956001)(2201001)(65826007)(7416002)(476003)(2906002)(74482002)(6486002)(6116002)(6246003)(2616005)(31696002)(486006)(105586002)(11346002)(229853002)(31686004)(106356001)(65806001)(86362001)(68736007)(4326008)(66066001)(446003)(8936002)(6512007)(53936002)(6306002)(6436002)(97736004)(99286004)(2501003)(316002)(305945005)(76176011)(52116002)(508600001)(54906003)(8676002)(25786009)(36756003)(256004)(966005)(26005)(81166006)(81156014)(4744005)(386003)(14454004)(64126003)(102836004)(71200400001)(71190400001)(58126008)(6506007)(53546011)(110136005)(186003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4750;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7mzQZRCSHyecRlHIUNsS0d4TORbTOoMSy/y0GHqLwSviLjkMx0Vrt4GWN9XfHVDluP0CrmAMO6nv0AE7lrZbVqVwkiHfbJ+8GG+LXYvzlA2Zg/C2tH9FEtZcB+9GcnIF4C8SDPST77sLUBSziMudDvEFPviZPsiuEZlgkShV54lMZQ1kGr7vS4A62GnzgPxwZLzgOJoRbea7uLJHGO9rk2qnQbvn1VqXmwWpBdIyYul6Dslnt8R8BT0S5LU2DF41JdJPr0D/sFjZYp11Odrx7iE5JGsgaSDggljy6yun+nmsvNosTPFIbegT3pRFeCUAqUkFFKQwPPSyfBJtMwRyJ4M7qvqPoLWq00ZhmfuT4XVmtSxBvkinehljvWDe7ohy9dkeyYJgRiAjE9BJ8p5cjIBbU5i0Gc3TzuEbQpsWU6M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCDDB3F2B27DCE45B6B60A2DE13E2BFC@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f579aee-d356-4a12-abe8-08d6912d2b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 21:00:49.6770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0xMiAyMDowNiwgU293amFueWEgS29tYXRpbmVuaSB3cm90ZToNCj4gVGhpcyBw
YXRjaCBzb3J0cyBhbGwgdGhlIGluY2x1ZGUgaGVhZGVycyBhbHBoYWJldGljYWxseSBmb3IgdGhl
DQo+IEkyQyBUZWdyYSBkcml2ZXIuDQo+IA0KPiBBY2tlZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRy
ZWRpbmdAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4
QGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU293amFueWEgS29tYXRpbmVuaSA8c2tvbWF0
aW5lbmlAbnZpZGlhLmNvbT4NCj4gLS0tDQo+ICBbVjkvVjEwL1YxMS9WMTIvVjEzL1YxNC9WMTUv
VjE2L1YxNy9WMTgvVjE5XSA6IFJlYmFzZWQgdG8gNS4wLXJjNA0KPiAgW1YzL1Y0L1Y1L1Y3L1Y4
XSA6IFJlbW92ZWQgdW5zdWVkIGhlYWRlcnMgaW4gdGVncmEgSTJDDQoNCiJeIEhlYWRlciByZW1v
dmFsIHNob3VsZCBiZSBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCBJIHRoaW5rLiIN
Ci0gV29sZnJhbSBTYW5nIFswXQ0KDQpDaGVlcnMsDQpQZXRlcg0KDQpbMF0gaHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMTkvMi8xMS8zNzUNCg==
