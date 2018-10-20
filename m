Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6BEC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386912159F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="uhmtelEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386912159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJUC5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 22:57:31 -0400
Received: from mail-eopbgr710094.outbound.protection.outlook.com ([40.107.71.94]:6127
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbeJUC5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 22:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccibqWEYTVZbM0VcuK6nuvWwfoQC9PZqLaIydpnCeSM=;
 b=uhmtelEOFgg6NoM0Eow4xNLhNQDya7NL/r/kIjcSuxtR8zSshPPbWke4F1ZjaroXQIsDVpEw/2WBs/bRncMlZaVBzphUQoE4dKQqWChoUuvfVhu6kXjMNXu41QNmc6dhTijnP8voRbY47tWEUnyuHr2hLqs/e7TtGXhtSpdYPfo=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2381.namprd13.prod.outlook.com (52.135.94.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.15; Sat, 20 Oct 2018 18:45:27 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475%3]) with mapi id 15.20.1273.012; Sat, 20 Oct 2018
 18:45:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "mishi@linux.com" <mishi@linux.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the contact
 email address
Thread-Topic: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
 contact email address
Thread-Index: AQHUaKURATNWngxKN0OLCyFirMeCPg==
Date:   Sat, 20 Oct 2018 18:45:27 +0000
Message-ID: <dfabf8b10d3e825c9a7f6c110e042dc72e50217d.camel@hammerspace.com>
References: <20181020134908.GA32218@kroah.com>
         <20181020135118.GG32218@kroah.com> <20181020192845.48b8b860@alans-desktop>
In-Reply-To: <20181020192845.48b8b860@alans-desktop>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.40.195.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2381;6:YDQ1Mlb1/8ICLxSmb7t43zVXF5nF99ZsYtRhh6lJqBIgONkyYajsZEYjCBNrgrKPtedJeX7VD96Ml73Vs5QKY5fpFRXOqQhPoHjHSZuIRPYsacIcE65CXeYkVKO+Q0PvnRfajMYaDq0sg4+yxpV+Twzi9uRdUXaLSmUf6ZTwqxw95/3eP/5DcGTiOO6EBJzOLgIA2JFL0kyexTcGk7qkptTCU55xK8PkBbOPMJWY5XYY2rwAz8SspL4TPamd37KUl6T6JgZPhi74L7yB6QFv1K2hgh8xqUkYXIn5cqam67z98HL2CC9T8ZdYeH4grt6QK9+YkDoPQrLOVJGPRGJfzZshhEWDJ8l/JG3IBR0J5+tnBTw26Rxv01aw2ZdWCYVQ/oZ4RixU5e+4DHDNBPy271ITLQJrzGe6gpkRBxns1Sjb7+If8zdyPGljCJf+tKuhTb+uS0o9BGD6T9AXaUfGfA==;5:df30dTxaldCw8c5if1iEOmmGWWYax7DfdfUQL7R2TlD1bJ3PzMxLc6esYzXijkugyINxWg21oHN4DlfduEIEeKIc3rc0Jq+PSd5ovsXU+gBAzfvaMtGSR3QsAb+OEAx/zDXcu24Ss+CICkOKqweREr30c9JAbeUbJHrUx7GiljI=;7:CUpPQSvtRGRVPEfKAyTkIsAVVktLnaDM5meWYWhbyK5xYYPPq5DWaWWIS1HIe885xhFQdy1F/hwLXK+vm6/pVq740L3HsXTXoCNZevo7ByR2vyYT3QXFEkJMFZFkLtDmfg41fbLrtuaxtX6gmf6F59OelXJftJwh8Sj5xpI65BOLHGe7NG9/NGgdzbgnC3SP+c3HBSMan9ckXh/u++m+mx5IlaqwKI3JUOka18KfQnGbTFjlPGZF6v81aj05AnZp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e4a00e34-a5e1-4e38-4bc3-08d636bc343a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2381;
x-ms-traffictypediagnostic: SN6PR13MB2381:
x-microsoft-antispam-prvs: <SN6PR13MB238190B6C33DF860565EC74BB8FA0@SN6PR13MB2381.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(20558992708506);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN6PR13MB2381;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2381;
x-forefront-prvs: 0831C25939
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(476003)(6246003)(229853002)(25786009)(4001150100001)(76176011)(53936002)(97736004)(5250100002)(105586002)(11346002)(6436002)(86362001)(305945005)(486006)(106356001)(2900100001)(6486002)(2501003)(6512007)(446003)(5660300001)(256004)(71200400001)(8676002)(81156014)(26005)(81166006)(6506007)(102836004)(8936002)(6346003)(316002)(71190400001)(36756003)(66066001)(2616005)(110136005)(6116002)(4326008)(99286004)(7736002)(14454004)(54906003)(3846002)(186003)(118296001)(2906002)(478600001)(223583001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2381;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-microsoft-antispam-message-info: kZ73TedlKfRNA0sumr/CVoj9vAla16r16mRxTUsk/v5t+z+STZtoJsqkhIIGZ4GZCyMFsLM9vgPJ1pd96YdFJGk+zMMjq5OZHWh+6rXT1Ih5ZSLxlFJkhcdKz6SMAeB5XVZmFWVoGSR9O/v5K0QJGFzWSLmEcizKZPE6uBi0yitNBPT3m51ZLZKksH6dLEAMmp14Fjp1ddSuF0FsPEuTcTIVnMUGMJgEnVmWXAqJeJwbidwD65CBcbOJl70lF+2VsSipwAIAkKrvbLIXJAoq2R3weqBivumvMldhsfkQ4dUv0s/G4wT4KpZYt4mJhRbyjrcLKC8KjUZCtWmVjZJHGLndszBq6ZSK26RMJE0wR98=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA9CBF5D54EAB489CB3135840E1CA80@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a00e34-a5e1-4e38-4bc3-08d636bc343a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2018 18:45:27.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE4LTEwLTIwIGF0IDE5OjI4ICswMTAwLCBBbGFuIENveCB3cm90ZToNCj4gPiAr
dG8gdGhlIGNpcmN1bXN0YW5jZXMuIFRoZSBDb2RlIG9mIENvbmR1Y3QgQ29tbWl0dGVlIGlzIG9i
bGlnYXRlZA0KPiA+IHRvDQo+ID4gK21haW50YWluIGNvbmZpZGVudGlhbGl0eSB3aXRoIHJlZ2Fy
ZCB0byB0aGUgcmVwb3J0ZXIgb2YgYW4NCj4gPiBpbmNpZGVudC4NCj4gPiArRnVydGhlciBkZXRh
aWxzIG9mIHNwZWNpZmljIGVuZm9yY2VtZW50IHBvbGljaWVzIG1heSBiZSBwb3N0ZWQNCj4gPiAr
c2VwYXJhdGVseS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgYnkgaWdub3JpbmcgdGhlIG90aGVyIHN1
Z2dlc3Rpb25zIG9uIHRoaXMgeW91J3ZlIGxlZnQNCj4gdGhpcw0KPiBiaXQgYnJva2VuLg0KPiAN
Cj4gVGhlIGNvbW1pdHRlZSBjYW4ndCBrZWVwIG1vc3Qgc3R1ZmYgY29uZmlkZW50aWFsIHNvIGl0
J3MgbWlzbGVhZGluZw0KPiBhbmQNCj4gd3JvbmcgdG8gaW1wbHkgdGhleSBjYW4uIERhdGEgcHJv
dGVjdGlvbiBsYXcsIHJlcG9ydGluZyBsYXdzIGluIHNvbWUNCj4gY291bnRyaWVzIGFuZCB0aGUg
bGlrZSBtZWFuIHRoYXQgYW55b25lIGV4cGVjdGluZyBhbiBpbmNpZGVudCB0bw0KPiByZW1haW4N
Cj4gY29uZmlkZW50aWFsIGZyb20gdGhlIHBlcnNvbiBpdCB3YXMgcmVwb3J0ZWQgYWdhaW5zdCBp
cyBsaXZpbmcgaW4NCj4gZHJlYW1sYW5kIGFuZCBhcmUgZ29pbmcgdG8gZ2V0IGEgbmFzdHkgc2hv
Y2suDQo+IA0KPiBBdCB0aGUgdmVyeSBsZWFzdCBpdCBzaG91bGQgc2F5ICcoZXhjZXB0IHdoZXJl
IHJlcXVpcmVkIGJ5IGxhdyknLg0KPiANCj4gVGhlcmUgaXMgYSBzZXBhcmF0ZSBpc3N1ZSB0aGF0
IHNlcmlvdXMgdGhpbmdzIHNob3VsZCBhbHdheXMgZ28gdG8gbGF3DQo+IGVuZm9yY2VtZW50IC0g
eW91IGFyZSBzZXR0aW5nIHVwIGEgcG9saWN5IGFraW4gdG8gdGhlIG9uZSB0aGF0IGdvdA0KPiB0
aGUNCj4gY2F0aG9saWMgY2h1cmNoIGFuZCBtYW55IG90aGVycyBpbiB0cm91YmxlLg0KPiANCj4g
WW91IHNob3VsZCBhbHNvIHJlc2VydmluZyB0aGUgcmlnaHQgdG8gcmVwb3J0IHNlcmlvdXMgaW5j
aWRlbnRzDQo+IGRpcmVjdGx5DQo+IHRvIGxhdyBlbmZvcmNlbWVudC4gVW5sZXNzIG9mIGNvdXJz
ZSB5b3Ugd2FudCB0byBiZSBmb3JjZWQgdG8gc2l0IG9uDQo+IG11bHRpcGxlIHJlcG9ydHMgb2Yg
cGh5c2ljYWwgYWJ1c2UgZnJvbSBkaWZmZXJlbnQgcGVvcGxlIGFib3V0DQo+IHNvbWVvbmUgLSB1
bmFibGUgdG8gdGVsbCB0aGVtIGFib3V0IGVhY2ggb3RoZXJzIHJlcG9ydCwgdW5hYmxlIHRvDQo+
IHByb3ZlDQo+IGFueXRoaW5nLCBhbmQgaW4gdHdlbnR5IHllYXJzIHRpbWUgaGF2aW5nIHRvIGV4
cGxhaW4gdG8gdGhlIG1lZGlhIHdoeQ0KPiBub3RoaW5nIHdhcyBkb25lLg0KPiANCg0KLi4uYW5k
IHRoZW4geW91IGdldCBpbnRvIHF1ZXN0aW9ucyBhYm91dCBob3cgdGhpcyBjb21taXR0ZWUgd2ls
bA0KcmVzcG9uZCB0byBxdWVyaWVzIGZyb20gc2FpZCBsYXcgZW5mb3JjZW1lbnQsIGFuZCBpbmRl
ZWQgdG8gd2hpY2ggbGVnYWwNCnN5c3RlbXMgdGhlIGNvbW1pdHRlZSB3aWxsIG9yIHdpbGwgbm90
IHJlcG9ydCBpbmNpZGVudHMuDQoNCldoeSB3b3VsZCB3ZSB3YW50IHRvIGJlIGdvaW5nIGRvd24g
dGhlIHBhdGggb2YgdHJ5aW5nIHRvIGhhbmRsZSByZXBvcnRzDQphYm91dCAic2VyaW91cyBpbmNp
ZGVudHMiIGluIHRoZSBmaXJzdCBwbGFjZT8gVGhhdCBzZWVtcyB3YXkgb3V0IG9mDQpzY29wZSBm
b3IgYSBjb2RlIG9mIGNvbmR1Y3QgYXJiaXRyYXRpb24gc2NoZW1lLiBFdmVuIGF0dGVtcHRpbmcg
dG8NCmNvdW5zZWwgcGVvcGxlIGFzIHRvIHdoZXRoZXIgb3Igbm90IHRoZXkgc2hvdWxkIHJlcG9y
dCBpbmNpZGVudHMgY2FuDQpnZXQgeW91IGluIHRyb3VibGUgaW4gbWFueSBwYXJ0cyBvZiB0aGUg
d29ybGQuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
