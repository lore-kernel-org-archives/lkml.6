Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6ACC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910002089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="hmAw5FQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910002089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJIE3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:29:05 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:16811
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeJIE3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L46NzmoMT9QiK2bjpwz1aulhU/d8K749O4lmlX+3kQQ=;
 b=hmAw5FQnpgbdrbGj7QvmQvVKXbSBwFcKDoE+Hc+ZwQQq3tNsNU43dnUP84hZTVdL1wur8sfqr4kSw6WA/WPzV9O7jq0cHI5jixw9zdBoZ/AtFJJPKNq1EHwfMTp3Sh/WyYh/HfoU8y1kOzmbCdiSCw+FQcrBc7ApaanabaWHKbM=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2047.eurprd02.prod.outlook.com (10.167.207.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 21:15:22 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 21:15:22 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: use the correct location for dt-bindings
 includes for mux
Thread-Topic: [PATCH] MAINTAINERS: use the correct location for dt-bindings
 includes for mux
Thread-Index: AQHUWXvOH2U2unuqqkmiWwoYJFKdhqUV5RCA
Date:   Mon, 8 Oct 2018 21:15:22 +0000
Message-ID: <c0be4a0b-c0fe-18e7-07ea-e9c9e128de13@axentia.se>
References: <20180928220055.30772-1-joe@perches.com>
 <20181001114140.11751-1-peda@axentia.se>
In-Reply-To: <20181001114140.11751-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0129.eurprd05.prod.outlook.com
 (2603:10a6:7:28::16) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2047;6:JKbsfVcO1EyzRfK8PcLweRQk703iCndPcKlSW3Ck1uve15bjnULs0dVz9lQRY4AUqrTZY/5ywqGIA4+uT5WtpzdAUbwukSAJs1ad4FKtknneB359n7DhRrGTclSRI9n8VJZw9mLItY6TVn9dhJ74Hds6IKmWBM6jYUlJC74FyrTBwSRVpRbxMGjqAdLydc7R9dhKNwzneKPMsREvQ2xqYqXx8eAcqu0t91JcBmlayPuDZXSKirfU166IZlCz8Y0O08pf+Nf7JOT/op2La/2EFbtfDxamX8QWE+b69LYn0DeR97W4vW5ycTsWpdvhI6sWhOBp8XtjrmCZGkCzd+T4d0OFFr42ZRMkuMg1nbOvRgj09xXd6ABQ8LZYvDKD5+po+qiDGBm0/SDOQOQWM1ALxYNeI5BnKrgH/juoyxZVK/yfgzQbRMFNvMSuxaO56mN1YOdiKXSuf+kvr7BYoO8UZA==;5:FJ83Jk71th4CZ4q39Jvpl27GvQ9CRC3labsoiJP9VLXkyltuK54ribu9IvlzUJXGCnRk76sbi0RjIBP5R8s1kPX6eo1nwa46jIg4QuXTuuHLpudfUlSGsK90ag3jCfbswfZljytp//8iJsscg1A3RFHURJjxq0BIEL1wMFG3auY=;7:/gdpBtFZ9ShkQdwILT5Syp+GIALctl4KYyH2Jd72Hi3KiLD3GuILAnGADioRFZklcw30RrMcOSMC62BPowxKSbVEMXwRYMmuWhKPFYyMj9d29qOZKnz4a5IvrKjR1dJzdE5/NkicoABM4wG6wVCdSfcV/o79+VJuxS3G7c5NS+kZTIOwFNHQsQTM3stWu/Vl/O7iVHOb/+KszVD78NPCzQb6xXmylA2fYSlxsA9CfJwQRNDc4tSmIeUuBcTMsnd/
x-ms-office365-filtering-correlation-id: 6ee3de43-7908-4150-232d-08d62d632833
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2047;
x-ms-traffictypediagnostic: VI1PR0201MB2047:
x-microsoft-antispam-prvs: <VI1PR0201MB20472854FB85485D64466FB9BCE60@VI1PR0201MB2047.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:VI1PR0201MB2047;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2047;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(71190400001)(476003)(71200400001)(99286004)(2906002)(446003)(305945005)(6246003)(6486002)(7736002)(11346002)(2616005)(6436002)(58126008)(229853002)(2501003)(5250100002)(97736004)(486006)(6916009)(102836004)(316002)(5640700003)(3846002)(68736007)(53546011)(508600001)(6506007)(25786009)(66066001)(53936002)(2351001)(65806001)(3260700006)(65956001)(65826007)(186003)(14454004)(74482002)(106356001)(6116002)(36756003)(256004)(81166006)(386003)(81156014)(5660300001)(31696002)(31686004)(76176011)(8676002)(6512007)(2900100001)(26005)(4326008)(64126003)(105586002)(52116002)(86362001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2047;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CxBZh/RcClorMhpDyy2SaY9s1BQnCf5iZxPJztfDjmp8y13KethKvo8aI5fqnU7pBfp4cyvrq4YVPJLQBiu3KKK1BA/T2Us2XbrISfrRxyCD7OXun2r3vEAd62P1r9sQj44PR0rJXM8e59kAZrsZcIAc8ezGwhWMOHpExypIOkGR0mrLaVjLn7XsrguE+b3wh7p1s+AcjbnLc7hnHf5wG7lx3V1rd75gruBHZiJnzoL1UMEIFVi7Gt5HqoeQVNP3znKd909DQMvCrrjjBDfpqyShvg81t8Sf6oMa/gXuLQV78ckkRbGCCFeARK0Mlg/3oOOm9T2Icm8wgHhDnJvA1xLYa4/F8ZIvrNor4pLUGKA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCC3AB91196BF24188E57ABA38358AA7@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee3de43-7908-4150-232d-08d62d632833
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 21:15:22.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMC0wMSAxMzo0MSwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IEp1c3QgZHJvcCB0aGUg
ImxpbnV4IiBwYXJ0IG9mIHRoZSBwYXRoLCBpdCB3YXMgbmV2ZXIgY29ycmVjdC4NCj4gDQo+IFJl
cG9ydGVkLWJ5OiBKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPg0KPiBGaXhlczogMjU2YWMw
Mzc1MDk4ICgiZHQtYmluZGluZ3M6IGRvY3VtZW50IGRldmljZXRyZWUgYmluZGluZ3MgZm9yIG11
eC1jb250cm9sbGVycyBhbmQgZ3Bpby1tdXgiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBSb3Np
biA8cGVkYUBheGVudGlhLnNlPg0KDQpBcHBsaWVkIHRvIHRoZSBmb3ItbmV4dCBicmFuY2guDQoN
CkNoZWVycywNClBldGVyDQo=
