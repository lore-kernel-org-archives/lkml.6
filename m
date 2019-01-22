Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0FAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581622085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EpWyED9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfAVJJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:09:00 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31918 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfAVJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:09:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; 
   d="scan'208";a="23703829"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Jan 2019 02:08:59 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 22 Jan 2019 02:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZbOEJCR06h7cKqZvXPdQxdlVl2O/rI9c+J+8Zz0obY=;
 b=EpWyED9FJ6QZt0BoZtitbWVuYNyLFwrcGbFNQgTPGhdsL3ysVNs7noKJAb/bMCXq7Pa0buR44508MJYxIaeER949ZQ0HuU4uGJDTbNuomjLQ4BaBJSj3r4bdX4xWpvBqK4jkYG9m5q+ASwTzgbPaQ3qPCmKDzV3tRKxxeXAOQpI=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB2032.namprd11.prod.outlook.com (10.169.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 09:08:54 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:08:54 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC:     <Ludovic.Desroches@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <linux-usb@vger.kernel.org>,
        <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation for
 sama5d3 10/100 interface
Thread-Topic: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation
 for sama5d3 10/100 interface
Thread-Index: AQHUse9Xo4ahb2kgZ0mEDyKh+XWVpqW7AEoA
Date:   Tue, 22 Jan 2019 09:08:54 +0000
Message-ID: <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
 <20190122011014.GA25211@bogus>
In-Reply-To: <20190122011014.GA25211@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0447.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::27) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2032;6:58v2eftVXKlO3Uy+iiFjkLExRUKyDnVVEFKng/ksKjaRiC8Rc/zLKhh1qlLZDsLCs8x8nG629UUXSeekiVkLcXqqw4s+2QLJRr+daQWaUTcBFYEHTm+HsiiZ9Q6iC9DSAFPdhmqXinH6aR++fOtss0GDhSQQqwwcfuXnUqLnHdsuW5pY9TAu3mRHuHbRg9IOFaZvx2wo+XZILw8K2/SGbFTQ0U7vTboajYAM7OaEsGS1Ej2BLtwLauGUHy8Y9rOH44iuzXrMpGvfP1lvOXg2sL+EHLTQdSIA64UbfjquEaxmh+Anlr+Pw6NiBeUeTKjx3suMfxZscJjhvvzUcm60we6yxue2VxoLTJUIk44sdLIR2b7U2EqQvpm7N1fvHFh0Sbj3RIAn5MCSdmGu0q2QmtwBliqoN0QqBd3PpVTSz+Paf25//l738y4gn84xAb8OkSCgWsWHRlhIB16oIQY49g==;5:5YqIyLPiq3qEQ/1JXSgj+M+L5pSlQb4zs+mpGBBN6QsJxg/LgqcPqBCxABx5ImJD2Fe6EuAvGFWF39drNHRuD1IuzKuOJwSrqXQk93xBk3SidnGyL5TLsjnn7QJP8ujObg59m0n9Mz8jCejNReu1c67ZfHVZuDVjy/gWHi2BhRkE2lDMH84YyIC7jUl98J/tAqnFxlPc07CqzPLsWv2+IA==;7:hRR16sZ21YEVSflwLVrSnz4rxuILwkS/5ai1NmxKTCtcKlLqCGnAxv1vs8kawMEvmRb6299yGR0weVGwRcbfYaF+fpJ32iNAeST8lMeRG4jiUUka+5nJEcAH9JJmQKMaKEvkcLXwrW2CDGMal0u3Bw==
x-ms-office365-filtering-correlation-id: 577f9202-4fed-468d-6e41-08d680493b80
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2032;
x-ms-traffictypediagnostic: MWHPR11MB2032:
x-microsoft-antispam-prvs: <MWHPR11MB2032028A94534D6C8DCE4AC6E0980@MWHPR11MB2032.namprd11.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(72206003)(6512007)(6506007)(14454004)(36756003)(53936002)(99286004)(186003)(52116002)(478600001)(6246003)(26005)(386003)(76176011)(102836004)(53546011)(305945005)(7736002)(68736007)(4326008)(25786009)(31696002)(86362001)(66066001)(7416002)(8936002)(229853002)(81166006)(8676002)(81156014)(2906002)(97736004)(105586002)(106356001)(31686004)(316002)(486006)(6486002)(6116002)(476003)(2616005)(71200400001)(71190400001)(11346002)(446003)(54906003)(110136005)(256004)(3846002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2032;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N1Bp3r7xChXyTrBXT96otqp1Ry2AG7UpXGiEOIQCEbbg3etzGRLE7qxlLB0UVaW26XP4SAEoRtK847Ua4nmsDpemqxpvzNRzLWNZFDnIY0h+SBsM+Bf8UqUfkITH7drg0wmChRzle6Tq7kXfzVKuDMUTg+ztzETa2+1+Be2XwSuJ35xkvRvVFUv5aAXb1Sg3EDSVXbc743laZBkszJvngIIxRFhmxK8DpLFk6oYXpP2EtM3ALnLUrndeTWh4x/70YQ3HKb/DQ9k3Ldr2tZ8EOGLilvZFYdt0fwTQ6Ui8HnR42fV7RrYLXBA3NZCghWLzHRJHhBZKAYLLSK+Wc3k+SPHO8SWMNGuK7+sQwGIhr+sU6JTQmsvNwKje7zXnYYBnqU5fyH/ajMMmppPfP+vy0U9fyoJdnYkh//69YwU5T5Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <10FC06FC594F804F9A2F3040F5924E4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 577f9202-4fed-468d-6e41-08d680493b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:08:51.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2032
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMi8wMS8yMDE5IGF0IDAyOjEwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gV2VkLCBKYW4gMTYsIDIwMTkgYXQgMTA6NTc6NDBBTSArMDEwMCwgTmljb2xhcyBGZXJyZSB3
cm90ZToNCj4+IFRoaXMgcmVtb3ZlcyBhIGxpbmUgbGVmdCB3aGlsZSBhZGRpbmcgdGhlIGNvcnJl
Y3QgY29tcGF0aWJpbGl0eSBzdHJpbmcgZm9yDQo+PiBzYW1hNWQzIDEwLzEwMCBpbnRlcmZhY2Uu
IE5vdyB1c2UgdGhlICJhdG1lbCxzYW1hNWQzLW1hY2IiIHN0cmluZy4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9tYWNiLnR4dCB8
IDMgKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9tYWNiLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWFj
Yi50eHQNCj4+IGluZGV4IDNlMTdhYzFkNWQ1OC4uZjVjNDE0YjEwZTI3IDEwMDY0NA0KPj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9tYWNiLnR4dA0KPj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9tYWNiLnR4dA0KPj4gQEAg
LTMsOCArMyw3IEBADQo+PiAgIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiAgIC0gY29tcGF0aWJs
ZTogU2hvdWxkIGJlICJjZG5zLFs8Y2hpcD4tXXttYWNifGdlbX0iDQo+PiAgICAgVXNlICJjZG5z
LGF0OTFybTkyMDAtZW1hYyIgQXRtZWwgYXQ5MXJtOTIwMCBTb0MuDQo+PiAtICBVc2UgImNkbnMs
YXQ5MXNhbTkyNjAtbWFjYiIgZm9yIEF0bWVsIGF0OTFzYW05IFNvQ3Mgb3IgdGhlIDEwLzEwME1i
aXQgSVANCj4+IC0gIGF2YWlsYWJsZSBvbiBzYW1hNWQzIFNvQ3MuDQo+PiArICBVc2UgImNkbnMs
YXQ5MXNhbTkyNjAtbWFjYiIgZm9yIEF0bWVsIGF0OTFzYW05IFNvQ3MuDQo+IA0KPiBXaGVyZSBp
cyAiYXRtZWwsc2FtYTVkMy1tYWNiIj8NCg0KSXQncyBhY3R1YWxseSBhIGNvdXBsZSBvZiBsaW5l
IGJlbG93OiBsaW5lIDEzIG9mIHRoZSByZXN1bHRpbmcgbWFjYi50eHQgDQpmaWxlLiBJdCB3YXMg
YWxyZWFkeSBpbiB0aGUgZmlsZSB3aGVuIEkgcmVtb3ZlZCB0aGUgbGVmdG92ZXJzLg0KDQpEbyB5
b3UgYWR2aWNlIHRvIHRyeSB0byBiZXR0ZXIgc29ydCBlbnRyaWVzIGluIHRoaXMgZmlsZT8gSXMg
dGhlcmUgYSANCmNvbW1vbiBwYXR0ZXJuPw0KDQpCZXN0IHJlZ2FyZHMsDQogICBOaWNvbGFzDQoN
Cj4+ICAgICBVc2UgImNkbnMsbnA0LW1hY2IiIGZvciBOUDQgU29DIGRldmljZXMuDQo+PiAgICAg
VXNlICJjZG5zLGF0MzJhcDcwMDAtbWFjYiIgZm9yIG90aGVyIDEwLzEwMCB1c2FnZSBvciB1c2Ug
dGhlIGdlbmVyaWMgZm9ybTogImNkbnMsbWFjYiIuDQo+PiAgICAgVXNlICJjZG5zLHBjMzAyLWdl
bSIgZm9yIFBpY29jaGlwIHBpY29YY2VsbCBwYzMwMiBhbmQgbGF0ZXIgZGV2aWNlcyBiYXNlZCBv
bg0KPj4gLS0gDQo+PiAyLjE3LjENCj4+DQo+IA0KDQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
