Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1C2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C268B20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NEldMv18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C268B20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeGQHry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:47:54 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:11520
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727600AbeGQHrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+I6iv+fppVnOIemVOdwkjZJLZIW1TsbIrRV8gvCaSw=;
 b=NEldMv18r022EhDswD7Lb551AKOOaCcWU9S7XnRqy6JcS0eoA9kXARIIEsLeODMmwEvJBxXKugCjMb+Lzksy1oqOgXJ0PM7BORcyO8m9Hg8KMEpnHfVH/eOUFngl0mMVZqPuHcNjU1A5Bfkqmd5HMN/K4dGk39QppQPYphi+pGg=
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com (52.133.39.11) by
 AM0PR0402MB3796.eurprd04.prod.outlook.com (52.133.39.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.21; Tue, 17 Jul 2018 07:16:40 +0000
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13]) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13%4]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 07:16:40 +0000
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: phy: fix phy-fsl-usb.c's copyright issue
Thread-Topic: [PATCH] usb: phy: fix phy-fsl-usb.c's copyright issue
Thread-Index: AQHUHZkVNVDoGufEXEuHwGEaFVR2YaSS/4hA
Date:   Tue, 17 Jul 2018 07:16:40 +0000
Message-ID: <AM0PR0402MB3747D31A9362E2DDDDA93030F45C0@AM0PR0402MB3747.eurprd04.prod.outlook.com>
References: <1531808756-989-1-git-send-email-pengbo.mu@nxp.com>
 <20180717064043.GB1789@kroah.com>
In-Reply-To: <20180717064043.GB1789@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3796;7:w+NGyKPo3wbADDxTX1c+P37twYlYyC0JJxWcXuOMB6q/uhqQwdyKz4UhgCmvqp9fYUZeY1bdv4wMO1o+AszHrZzP0EfPBeNNGyMjH3tXHDXUyXN7f7H4x5Wob3mojqaiXYJA+N5+wejsxD7+lnDUQllfJtlkR44TxG5jxwUI7AHAgE8cHlo9ai712SnEx8oCNoJEbv9gROLGrPDKfp3mqGaxgDEW9pGpyHbZ5WMB+TwyWdyULKLLHtaxZ0Mg6R2l
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 579ea783-c03c-4698-16da-08d5ebb53ddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3796;
x-ms-traffictypediagnostic: AM0PR0402MB3796:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pengbo.mu@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR0402MB379659A6637BE4157DAA8B07F45C0@AM0PR0402MB3796.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3796;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3796;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(54534003)(13464003)(199004)(189003)(5250100002)(102836004)(478600001)(54906003)(97736004)(53936002)(6116002)(4326008)(2906002)(25786009)(86362001)(106356001)(66066001)(6246003)(3846002)(99286004)(105586002)(53546011)(26005)(186003)(81156014)(55016002)(7696005)(9686003)(486006)(76176011)(44832011)(476003)(33656002)(8676002)(14454004)(81166006)(256004)(316002)(68736007)(6916009)(229853002)(7736002)(6436002)(11346002)(5660300001)(2900100001)(446003)(305945005)(6506007)(8936002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3796;H:AM0PR0402MB3747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +m9bfCykz5nOVTLneEQP325h6fukvi/7VFOvv69U9/dEJggZjkT/mKOlz5oVoMzmnZF3NJh53WT0u6eSUMhf0QR4qkkVSoqfqsqky8xnwV9209hKl7KoQlknMxsRaO/3v+hVhXMY5ahVYlxQZoTSq71CB3MRHsTyi9mXC1v+g91K8fxYXgFH4BFDBKlD9s0e+TsxBUufqVcvmvQU/HB9h5vXpyefh2F7ucNJ5Rmr1ve575eDkVHsUyjasxeIXw0L2/vfVUVdVX0dcWkp6jm4EkzNYSol8mAWxm4WI4f0wXUbAXB7wNrYU1Q0vFK4vm0eEWHAU7SQ9aBHV/HbRyXpQAlvIcPQWCtApK70xttAGMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579ea783-c03c-4698-16da-08d5ebb53ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 07:16:40.1337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZ6OsDQoNClNvcnJ5IGZvciBtaXNzaW5nIHRoZSBjaGFuZ2Vsb2cgdGV4dCAmIHNpZ24g
Lg0KQlRXICwgaXQncyBteSBmaXJzdCBzZW5kIGVtYWlsIHRvIHVwc3RyZWFtLiANClRoYW5rcyBm
b3IgeW91ciBhZHZpY2VzLg0KDQpSZWdhcmRzLA0KUGVuZ2JvIE11DQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gW21haWx0bzpncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZ10gDQpTZW50OiAyMDE4xOo31MIxN8jVIDE0OjQxDQpUbzogUGVuZ2Jv
IE11IDxwZW5nYm8ubXVAbnhwLmNvbT4NCkNjOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5v
cmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnOyBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0g
dXNiOiBwaHk6IGZpeCBwaHktZnNsLXVzYi5jJ3MgY29weXJpZ2h0IGlzc3VlDQoNCk9uIFR1ZSwg
SnVsIDE3LCAyMDE4IGF0IDAyOjI1OjU2UE0gKzA4MDAsIFBlbmdibyBNdSB3cm90ZToNCj4gRnJv
bTogInlpbmJvLnpodSIgPHlpbmJvLnpodUBueHAuY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
eWluYm8uemh1IDx5aW5iby56aHVAbnhwLmNvbT4NCg0KQWxzbywgeW91IG5lZWQgdG8gc2lnbiBv
ZmYgb24gaXQsIF9hbmRfIHdlIG5lZWQgYSB2YWxpZCBuYW1lIGhlcmUgZm9yIHRoZSBhdXRob3Ig
YW5kIHNpZ24tb2ZmLg0KDQp0aGFua3MsDQoNCmdyZWcgay1oDQo=
