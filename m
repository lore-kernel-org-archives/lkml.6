Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE55C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B995F2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r5XnPzZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B995F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbeKQADM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:03:12 -0500
Received: from mail-eopbgr680050.outbound.protection.outlook.com ([40.107.68.50]:28957
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727727AbeKQADM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow5dx7P9twSAKuuMJ1k78SUzALMRl9HejuINmPf5MME=;
 b=r5XnPzZD6ct0w2MTw/A3IDiVY8eDO1iV4wg9jg5TeddSGhraCIOQNC+ULf3EqODvlvuIQXlFLWjcLcyeOD0lF+rIbkY0MMruGQJcAf95rDoMHIWfTtSm0HygBSkf3fZiUbFoyIyt8UW8fwfzhiIUASqZydGSRu1zR0/1Q/kcqeU=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2431.namprd02.prod.outlook.com (10.168.204.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Fri, 16 Nov 2018 13:50:37 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c%6]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 13:50:35 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Michal Simek <michals@xilinx.com>,
        Martin Lund <martin.lund@keep-it-simple.com>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?utf-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        naga sureshkumar <nagasuresh12@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Topic: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Index: AQHUd+lLNqh5tQSG70at2ta/kVZ5BaVSVToAgAAMPQCAABM+oA==
Date:   Fri, 16 Nov 2018 13:50:35 +0000
Message-ID: <MWHPR02MB26231009A82C0372F62B5292AFDD0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CAB7pii3kx75ajF=8TsU7mWrmrzoHLiy7uAb+PirGw04BH65bZg@mail.gmail.com>
 <6ce1726a-f24d-17b8-d839-0a51c424a850@xilinx.com>
In-Reply-To: <6ce1726a-f24d-17b8-d839-0a51c424a850@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2431;6:h2A0Tbg9AWPK57dzQRx+WPHxtgsGOEOIAU730C2Po6vzJUcjjb2SCQOxsLkR3O5zf03Tj6NDurHlUpDkt5azknaDF+J6It3WN2FaCCTdTHfkKX8+Por3R0glXSl8YZn8kQ0pyE/kP6YFeCkQ58Lf9a/iT9k5kHymE45kk+3ZoCEFKtBGiDdf/2Pn+4c3VGaWeXQQZgbYs/qyNs4PUu3+6fMh4Zn1wT5wjxDp7MCpoYVfaPFe/Z/8QizmZ0pRSevZw2juw5kJsJ32B4W2pRCyTz9ZkQBG+sTsxff+5YNLgMLMQqOlo7MIZvsnxH/K9p9awo6rVhXN7GPr7KWHcVXY1IA3wQ3IHxnXh09aFkMDceWT0sUDWCWN+xxHcHIxInhTOIxTi15tLcbi/jZjfLEZm1XZele+Z0RplGuvEiKyOYcZ0eDt/4xyPVQkRhM5yL6ptjvQ9lypgATEDY4i1LjqCQ==;5:R1nlngWrUVLDsbka3WPpJzx2H0tCvc/1nthFQkVazig5weR8K73geyLe7MHmtF/uob20vBlzXOBTqjg9BQ4VmJe0+XWLkw4VlrA31a7HkzCtLF5FOptizowDT8JkjI/CkgGVgiGbUrjcUMjOaebGpA93eNnShHZu/dseYNNtz3w=;7:EjoyYSfp/Tm1VaAGS/orT4RDoV3CugSmmBiwu6h/1SZAs+n5BEUsjawUaD/8KHMFPC6SkR1Ty9snrFlGC/+VeVTUv6p3ZXTwFfly+Ab92ETx0cnYs9RGm4si18JGvxQ2wU3Gm1rnKF2ZuXizjNkHkw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(13464003)(2906002)(5660300001)(68736007)(26005)(102836004)(256004)(76176011)(33656002)(6506007)(53546011)(14444005)(66574009)(6246003)(14454004)(71190400001)(53936002)(7696005)(2900100001)(99286004)(105586002)(81166006)(106356001)(8676002)(7736002)(74316002)(6436002)(39060400002)(476003)(8936002)(93886005)(9686003)(4326008)(81156014)(7416002)(316002)(229853002)(217873002)(25786009)(305945005)(110136005)(97736004)(478600001)(446003)(66066001)(54906003)(11346002)(86362001)(71200400001)(186003)(486006)(3846002)(6116002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2431;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1e7e5d12-efd6-4385-0239-08d64bca7c3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2431;
x-ms-traffictypediagnostic: MWHPR02MB2431:
x-microsoft-antispam-prvs: <MWHPR02MB2431358F6060DE86F27F110EAFDD0@MWHPR02MB2431.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(258649278758335)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2431;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2431;
x-forefront-prvs: 0858FF8026
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IgmMpwv6dYmbaqPuh5hwcHJfnzyLg10WfKIspuTaHNOIayELlVT58BWo3ukYdJc0YTMRUQ39PfoRejmBiJm+a/6sRxtmniOHsiyDwQ8QYx1ANYZ2LxO0McX80FRzccCPJrW4+O15MY3S0s6dBlx+26lJhcruM07oFXqHeWMCRWXEMLguATs3n/e+621PQiIrEVc50QP9iYBeIVs+jxSjvSTHsT+oGFD54xxDirShRUV4tmBRuXT9V0dDM+FMKeqs2sTE9TntXgqTH11+BqYUyXtrOjepooodrx7zCT8P10nxC49tMxU+iBVwRxI4thZALXS0d3+PT5uD23gi2fIfu0mEuxVBgZTfnUDkqHH8StU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7e5d12-efd6-4385-0239-08d64bca7c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 13:50:35.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVr
IFttYWlsdG86bWljaGFsLnNpbWVrQHhpbGlueC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1i
ZXIgMTYsIDIwMTggNjowNCBQTQ0KPiBUbzogTWFydGluIEx1bmQgPG1hcnRpbi5sdW5kQGtlZXAt
aXQtc2ltcGxlLmNvbT47IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkNCj4gPG5hZ2FzdXJlQHhpbGlu
eC5jb20+DQo+IENjOiBib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb207IG1pcXVlbC5yYXluYWxA
Ym9vdGxpbi5jb207IHJpY2hhcmRAbm9kLmF0OyBEYXZpZA0KPiBXb29kaG91c2UgPGR3bXcyQGlu
ZnJhZGVhZC5vcmc+OyBCcmlhbiBOb3JyaXMgPGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbT47
IE1hcmVrDQo+IFZhxaF1dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPjsgbmFnYSBzdXJlc2hrdW1h
ciA8bmFnYXN1cmVzaDEyQGdtYWlsLmNvbT47IGxpbnV4LQ0KPiBtdGRAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbTElOVVggUEFUQ0ggdjEyIDEvM10gZHQtYmluZGluZ3M6IG10ZDogYXJhc2Fu
OiBBZGQgZGV2aWNlIHRyZWUgYmluZGluZw0KPiBkb2N1bWVudGF0aW9uDQo+IA0KPiBPbiAxNi4g
MTEuIDE4IDEyOjUwLCBNYXJ0aW4gTHVuZCB3cm90ZToNCj4gPiBIaSBOYWdhLA0KPiA+DQo+ID4g
SSd2ZSBiZWVuIHdvcmtpbmcgb24gcnVubmluZyB1cCB0aGUgbGF0ZXN0IGtlcm5lbCAodjQuMjAt
cmMyKSBvbiBvdXINCj4gPiBjdXN0b20gWGlsaW54IGh3IGJvYXJkIHNvIHRoYXQgSSBjYW4gdGVz
dCB0aGUgdjEyIHZlcnNpb24gb2YgeW91cg0KPiA+IEFyYXNhbiBuYW5kIGRyaXZlci4NCj4gPg0K
PiA+IEkndmUgbWFuYWdlZCB0byBnZXQgdGhlIGRyaXZlciBzdWNjZXNzZnVsbHkgdXAgYW5kIHJ1
bm5pbmcgYW5kIHJlYWR5DQo+ID4gZm9yIHRlc3Rpbmcgd2l0aCBhIE1pY3JvbiBNVDI5RjY0RzA4
QUZBQUFXUCBkZXZpY2UuIEhvd2V2ZXIsIHNldHRpbmcNCj4gPiBpdCB1cCBJJ3ZlIGZvdW5kIGEg
ZmV3IGluYWNjdXJhY2llcyBpbiB0aGUgZG9jdW1lbnRhdGlvbiBvZiB0aGUgZGV2aWNlDQo+ID4g
dHJlZSBiaW5kaW5ncy4NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIGRldmljZSBjb25maWd1cmF0aW9u
IHRoYXQgZW5kZWQgdXAgd29ya2luZyBmb3IgbWUgd2l0aA0KPiA+IGxpbnV4IHY0LjIwLXJjMjoN
Cj4gPg0KPiA+ICAgICAgICBuZmM6IG5hbmRAZmYxMDAwMDAgew0KPiA+ICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAieGxueCx6eW5xbXAtbmFuZCIsICJhcmFzYW4sbmZjLXYzcDEwIjsNCj4gPiAg
ICAgICAgICAgICByZWcgPSA8MHgwIDB4ZmYxMDAwMDAgMHgwIDB4MTAwMD47DQo+ID4gICAgICAg
ICAgICAgY2xvY2stbmFtZXMgPSAiY2xrX3N5cyIsICJjbGtfZmxhc2giOw0KPiA+ICAgICAgICAg
ICAgIGNsb2NrcyA9IDwmY2xrMjAwPiwgPCZjbGsxMDA+Ow0KPiA+ICAgICAgICAgICAgIGludGVy
cnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ID4gICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwwIDE0
IDQ+Ow0KPiA+ICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAgICAgICAg
ICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+DQo+ID4gICAgICAgICAgICAgbmFuZEAwIHsNCj4g
PiAgICAgICAgICAgICAgICAgcmVnID0gPDA+Ow0KPiA+ICAgICAgICAgICAgICAgICBuYW5kLWVj
Yy1tb2RlID0gImh3IjsNCj4gPiAgICAgICAgICAgICB9Ow0KPiA+ICAgICAgICAgfTsNCj4gPg0K
PiA+IENvbXBhcmVkIHdpdGggdGhlIGV4YW1wbGUgeW91IHdpbGwgbm90aWNlIHRoYXQgImNsb2Nr
LW5hbWUiIHNob3VsZCBiZQ0KPiA+ICJjbG9jay1uYW1lcyIuIHJlZyB3YXMgbWlzc2luZyBhICIw
eDAiLg0KPiANCj4gY2xvY2stbmFtZXMgYW5kIGV2ZW4gdGhhdCBuYW1lcyAtIHlvdSBhcmUgcmln
aHQgaXQgaXMgbm90IGNvcnJlY3QgYW5kIHNob3VsZCBiZSBmaXhlZC4NCkNsb2NrLW5hbWVzIEkg
d2lsbCBjaGFuZ2UgZnJvbSAiY2xvY2stbmFtZSIgdG8gImNsb2NrLW5hbWVzIi4NCkJ1dCBJIGdv
dCBzb21lIHJldmlldyBjb21tZW50cyBwcmV2aW91c2x5LCB0byB1c2UgInN5cyIgaW5zdGVhZCBv
ZiAgImNsa19zeXMiIGFuZCAiZmxhc2giIGluc3RlYWQgb2YgImNsa19mbGFzaCIuDQpBbmQgSSBo
YXZlIHRvIGNoYW5nZSB0aGlzIGluIGRyaXZlci4NCkkgd2lsbCB1cGRhdGUgdGhhdC4NCg0KVGhh
bmtzLA0KTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KDQo+IA0KPiBNaXNzaW5nIDB4MCBpbiByZWcg
ZG9lc24ndCBtYXR0ZXIgYmVjYXVzZSBpdCBkZXBlbmRzIG9uIGFkZHJlc3Mvc2l6ZSBjZWxscy4N
Cj4gDQo+ID4gSSB0aGluayBpdCBpcyBoZWxwZnVsIHRvIHByb3ZpZGUgYSByZWFsLXdvcmxkIHdv
cmtpbmcgZXhhbXBsZSwgc28geW91DQo+ID4gbWlnaHQgYWxzbyBjb25zaWRlciBjaGFuZ2luZyB0
aGUgZXhhbXBsZSAiY2xvY2tzIiBjb25maWd1cmF0aW9uIHRvDQo+ID4gY2xrMjAwL2NsazEwMCBz
aW5jZSB0aGVyZSBpcyBubyBjbGtfbWlzYyBhbW9uZyB0aGUgY2xvY2sgc291cmNlcyBvZg0KPiA+
IGFueSBvZiB0aGUgeGlsaW54IHp5bnFtcCBib2FyZCBkZXZpY2UgdHJlZSBjb25maWd1cmF0aW9u
cy4NCj4gDQo+IFJlYWwgZXhhbXBsZSBpcyB0aGUgYmVzdCBub3JtYWxseSBqdXN0IGMmcCBmcm9t
IGV4aXN0aW5nIGR0cyBpcyB0aGUgd2F5IHRvIGdvLg0KPiBCdXQgaW4gY29ubmVjdGlvbiB0byBj
bG9ja3MgaXQgZG9lc24ndCBtYXR0ZXIgd2hhdCBleGFjdGx5IHNob3VsZCBiZSB0aGVyZSBhbmQg
SSBkb24ndCB0aGluaw0KPiB0aGVyZSBpcyBhbnkgY29uc2lzdGVuY3kgaW4gdGhhdC4gSG9wZWZ1
bGx5IHRoaXMgd2lsbCBiZSByZW1vdmVkIGJ5IHlhbWwgY29udmVyc2lvbi4NCj4gDQo+IFRoYW5r
cywNCj4gTWljaGFsDQoNCg==
