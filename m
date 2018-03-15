Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AG47ELuG5Uw6uST3OA686HHTNUXnp7aqP02llyyQhFpC9nX/v3Tlky1AYwbtPzK0RjxDJYmQUHrM
ARC-Seal: i=1; a=rsa-sha256; t=1521136395; cv=none;
        d=google.com; s=arc-20160816;
        b=RxqtU4gsUkQ2f3rlz8Mw9Aut7E4nlHZxOVpe9aRWpQEwR0HiBhOpFDW2zkGPyf4gMO
         edmK6+4uy0qNP6g42I9Rjme5rUjLAZd+j+f4Ix2tQgjWQhfCBhdCcZWl936yUCh3lAX1
         Nemma4ak+0LfooLwNsxmhqfRlz/S6G/ZUhMh+aeunh6lyiR/U3IqrLykcsMW5nt7LBbc
         MSFiKe2VgLenGMfsE1bn9KHeG7wXivtUbU5xbhGVdVyv9aanFXJiDwdJAQEOcooQyXk5
         bdk9ka3UZLO1cGE5mV1AGpFjMY+/Hm16GuesQ23bNGkvgS2AKg/dcBg9Odf3G6C7knEo
         Ciag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Aj2IXZ1QbdHmnsH04TiFLu9ykZyPg27070vqXG1xlgY=;
        b=JIa76o/rIx/mUQwcQN7bm4dqpnqZXOgghL3O7Ln5Ak6bA84HWE0G1VNVR9W1/7BUJn
         yxJ3n8xCiFguSOp6vbiA+4ytayDNxxFs2GwMUJAkbEyNWPC/H5/mD7mi//JINLe9qatW
         Xj8j/54hhHWY9IuoECfsyaZxTdR8zfX4h0f5dig8OYnWa+12qleTXlEuV+NLkKk7r8Ik
         WSGj31XnqbQekGHR9t8JOFZsN4Lslfs4q41JxBcRz/5mXhCKxPe7cEVHcLk88CRM1KYJ
         93A3R1iIdomyir5cbLCFJ9HJrJlsN5KY1FCd7lVy7DH0yF3nlG5biElcu6Uuupfr1zvt
         R88g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=0kmr4Ob5;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.41.50 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=0kmr4Ob5;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.41.50 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "matt@codeblueprint.co.uk"
	<matt@codeblueprint.co.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, Rajan Vaja
	<RAJANV@xilinx.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>
Subject: RE: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Thread-Topic: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Thread-Index: AQHTqoAjZ4bTH6GbAkK1c5K+qT+P8aO7feAAgAiFjiCAAlbPAIAG+bfggADB5wCAA6GwUA==
Date: Thu, 15 Mar 2018 17:53:10 +0000
Message-ID: <DM2PR0201MB0767229750776EF2AF8455F3B8D00@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-3-git-send-email-jollys@xilinx.com>
 <dab419e8-3afe-5bfe-240e-e9ee4f2300f2@arm.com>
 <DM2PR0201MB076735E33069DC6F0C84EFDCB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <2fb8ee8c-35ac-b7e6-e691-84464b0c8745@arm.com>
 <DM2PR0201MB07673298E409D07F0F748316B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <4cff1193-5345-0531-d81e-0dd6e0633b19@arm.com>
In-Reply-To: <4cff1193-5345-0531-d81e-0dd6e0633b19@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [73.162.184.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0688;7:Q30Wa3F48l9V+FCTK+dgM6T6AyuYXYH2Bofcix/MoDJq/D8ed4F2zXZIwUKAD+YPbSbTKm1QkWNlzQaFALjyPe11VcLOLc2gn6h/s+rv6pTHEtviBhgKi2eNbMvdCHRTQRwbPnlg8uVqd2LUu/NaRZtQ19LjKzdR97SClGiBrMu4/xID3Dojx4xtOwjkH0oTOxJ1H0+vohikKB+1xsMyquyjc4HhnDzbzLmV1mpNTdTOnXxTCtiuFVYc7rUicPqD
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(13464003)(6436002)(8936002)(5250100002)(7736002)(229853002)(107886003)(102836004)(81156014)(106356001)(9686003)(81166006)(33656002)(74316002)(3846002)(316002)(54906003)(2900100001)(7416002)(76176011)(99286004)(7696005)(59450400001)(105586002)(305945005)(6246003)(3280700002)(53936002)(6506007)(39060400002)(97736004)(72206003)(478600001)(86362001)(93886005)(6116002)(3660700001)(55016002)(53546011)(14454004)(25786009)(4326008)(68736007)(8676002)(66066001)(26005)(2950100002)(5660300001)(186003)(2906002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0688;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ef6ecca-4860-4b41-ea79-08d58a9d9dbb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0688;
x-ms-traffictypediagnostic: DM2PR0201MB0688:
x-microsoft-antispam-prvs: <DM2PR0201MB068848A9ED3B58CE14C56296B8D00@DM2PR0201MB0688.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR0201MB0688;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0688;
x-forefront-prvs: 0612E553B4
x-microsoft-antispam-message-info: xHVcls0tLG/aGjlRZ+m9fporbDFV+OLQB90vj7ohy8tfoN35NrCFPy5ai4ojzRSz+r46yshd/GJfMPLjHcwT40AWfTQWLOetytpxsRnjKj4fO+SONH4kO4Cmc1Cx0VY3CWiVPW6rDLHBKjREMHR/kQIYVl1MHKpj1WwV1vdCJgAIrtSrp6oXTIEagZsf7fDwwrwDANfGdww0y1bhqTHjgB6JkMkKqq5rRRLyeuPhal4GqlFHul1OdokqhIvRsPwvJUWyJN0NcrXFNFbmedVj54B21MLJoKABaG3iYmdzu1YSvnz2JRQ7PJReNl4OjlvJSaGOXOqHbbqYiaIJMp2i5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef6ecca-4860-4b41-ea79-08d58a9d9dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 17:53:10.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0688
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948934312896009?=
X-GMAIL-MSGID: =?utf-8?q?1595027116544999779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSBbbWFpbHRvOnN1ZGVlcC5ob2xsYUBhcm0uY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBN
YXJjaCAxMywgMjAxOCAzOjI0IEFNDQo+IFRvOiBKb2xseSBTaGFoIDxKT0xMWVNAeGlsaW54LmNv
bT4NCj4gQ2M6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+OyBhcmQuYmllc2hl
dXZlbEBsaW5hcm8ub3JnOw0KPiBtaW5nb0BrZXJuZWwub3JnOyBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsgbWF0dEBjb2RlYmx1ZXByaW50LmNvLnVrOw0KPiBoa2FsbHdlaXQxQGdtYWlsLmNv
bTsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOw0KPiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tOyBy
b2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBSYWphbiBWYWphIDxS
QUpBTlZAeGlsaW54LmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIv
NF0gZHJpdmVyczogZmlybXdhcmU6IHhpbGlueDogQWRkIFp5bnFNUCBmaXJtd2FyZQ0KPiBkcml2
ZXINCj4gDQo+IA0KPiANCj4gT24gMTIvMDMvMTggMjM6MDUsIEpvbGx5IFNoYWggd3JvdGU6DQo+
ID4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+Pg0KPiA+PiBPSywgd2hhdCBhcmUgdGhlIHR5cGVzIHlv
dSBhcmUgcmVmZXJyaW5nIGhlcmUgPyBvciB3aHkgUFNDSSBpcyBub3Qgc3VmZmljaWVudCA/DQo+
ID4+IEhvdyBkbyB5b3UgcGxhbiB0byB1c2UgdGhlc2UgQVBJcyBpbiBMaW51eCA/DQo+ID4NCj4g
PiBJdCBzdXBwb3J0cyBzeXN0ZW0vc3Vic3lzdGVtIHJlc3RhcnQgYXMgdHlwZXMuIEZvciBleGFt
cGxlLCBvbmx5IEFQVQ0KPiA+IHJlc3RhcnQsIHN5c3RlbSByZXN0YXJ0LCBQUyByZXN0YXJ0IGZv
ciBaeW5xTVAgUFNDSSBkb2VzbuKAmXQgc3VwcG9ydA0KPiA+IGFueSBhcmd1bWVudCB0byBpZGVu
dGlmeSB0aGVzZSB0eXBlcy4gTGludXgsIG9uZSBjYW4gc2V0IHRoZSByZXNldA0KPiA+IHNjb3Bl
IHRocm91Z2ggZGVidWcgaW50ZXJmYWNlIGFuZCBleGVjdXRlICJyZWJvb3QiIHRoZW4uIEluc2lk
ZSBBVEYsDQo+ID4gUFNDSV9TWVNURU1fUkVTRVQgbWFwcGVkIGZ1bmN0aW9uIHdpbGwgY2FsbCBF
RU1JIEFQSSB3aXRoIHRoYXQgc2NvcGUuDQo+IA0KPiBPSywgSSBhbSBub3Qgc3VyZSBob3cgeW91
IHVzZSB0aGVtIGluIExpbnV4LiBQbGVhc2UgYWRkIGRyaXZlcnMgdXNpbmcgdGhlbSBvcg0KPiBq
dXN0IGRyb3AgdGhlbSBmb3Igbm93IGFuZCBhZGQgd2hlbiB5b3UgYWRkIHRoZSB1c2VycyBvZiB0
aGVzZSBmdW5jdGlvbnMuDQo+IA0KPiA+Pg0KPiA+Pj4+DQo+ID4+Pj4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHp5bnFtcF9lZW1pX29wcyBlZW1pX29wcyA9IHsNCj4gPj4+Pj4gKwkuZ2V0X2FwaV92
ZXJzaW9uID0genlucW1wX3BtX2dldF9hcGlfdmVyc2lvbiwNCj4gPj4+Pj4gKwkuZ2V0X2NoaXBp
ZCA9IHp5bnFtcF9wbV9nZXRfY2hpcGlkLA0KPiA+Pj4+PiArCS5yZXNldF9hc3NlcnQgPSB6eW5x
bXBfcG1fcmVzZXRfYXNzZXJ0LA0KPiA+Pj4+PiArCS5yZXNldF9nZXRfc3RhdHVzID0genlucW1w
X3BtX3Jlc2V0X2dldF9zdGF0dXMsDQo+ID4+Pj4+ICsJLmZwZ2FfbG9hZCA9IHp5bnFtcF9wbV9m
cGdhX2xvYWQsDQo+ID4+Pj4+ICsJLmZwZ2FfZ2V0X3N0YXR1cyA9IHp5bnFtcF9wbV9mcGdhX2dl
dF9zdGF0dXMsDQo+ID4+Pj4+ICsJLnNoYV9oYXNoID0genlucW1wX3BtX3NoYV9oYXNoLA0KPiA+
Pj4+PiArCS5yc2EgPSB6eW5xbXBfcG1fcnNhLA0KPiA+Pj4+PiArCS5yZXF1ZXN0X3N1c3BlbmQg
PSB6eW5xbXBfcG1fcmVxdWVzdF9zdXNwZW5kLA0KPiA+Pj4+PiArCS5mb3JjZV9wb3dlcmRvd24g
PSB6eW5xbXBfcG1fZm9yY2VfcG93ZXJkb3duLA0KPiA+Pj4+PiArCS5yZXF1ZXN0X3dha2V1cCA9
IHp5bnFtcF9wbV9yZXF1ZXN0X3dha2V1cCwNCj4gPj4+Pj4gKwkuc2V0X3dha2V1cF9zb3VyY2Ug
PSB6eW5xbXBfcG1fc2V0X3dha2V1cF9zb3VyY2UsDQo+ID4+Pj4+ICsJLnN5c3RlbV9zaHV0ZG93
biA9IHp5bnFtcF9wbV9zeXN0ZW1fc2h1dGRvd24sDQo+ID4+Pj4+ICsJLnJlcXVlc3Rfbm9kZSA9
IHp5bnFtcF9wbV9yZXF1ZXN0X25vZGUsDQo+ID4+Pj4+ICsJLnJlbGVhc2Vfbm9kZSA9IHp5bnFt
cF9wbV9yZWxlYXNlX25vZGUsDQo+ID4+Pj4+ICsJLnNldF9yZXF1aXJlbWVudCA9IHp5bnFtcF9w
bV9zZXRfcmVxdWlyZW1lbnQsDQo+ID4+Pj4+ICsJLnNldF9tYXhfbGF0ZW5jeSA9IHp5bnFtcF9w
bV9zZXRfbWF4X2xhdGVuY3ksDQo+ID4+Pj4+ICsJLnNldF9jb25maWd1cmF0aW9uID0genlucW1w
X3BtX3NldF9jb25maWd1cmF0aW9uLA0KPiA+Pj4+PiArCS5nZXRfbm9kZV9zdGF0dXMgPSB6eW5x
bXBfcG1fZ2V0X25vZGVfc3RhdHVzLA0KPiA+Pj4+PiArCS5nZXRfb3BlcmF0aW5nX2NoYXJhY3Rl
cmlzdGljID0NCj4gPj4+PiB6eW5xbXBfcG1fZ2V0X29wZXJhdGluZ19jaGFyYWN0ZXJpc3RpYywN
Cj4gPj4+Pj4gKwkuaW5pdF9maW5hbGl6ZSA9IHp5bnFtcF9wbV9pbml0X2ZpbmFsaXplLA0KPiA+
Pj4+PiArCS5zZXRfc3VzcGVuZF9tb2RlID0genlucW1wX3BtX3NldF9zdXNwZW5kX21vZGUsDQo+
ID4+Pj4+ICsJLmlvY3RsID0genlucW1wX3BtX2lvY3RsLA0KPiA+Pj4+PiArCS5xdWVyeV9kYXRh
ID0genlucW1wX3BtX3F1ZXJ5X2RhdGEsDQo+ID4+Pj4+ICsJLnBpbmN0cmxfcmVxdWVzdCA9IHp5
bnFtcF9wbV9waW5jdHJsX3JlcXVlc3QsDQo+ID4+Pj4+ICsJLnBpbmN0cmxfcmVsZWFzZSA9IHp5
bnFtcF9wbV9waW5jdHJsX3JlbGVhc2UsDQo+ID4+Pj4+ICsJLnBpbmN0cmxfZ2V0X2Z1bmN0aW9u
ID0genlucW1wX3BtX3BpbmN0cmxfZ2V0X2Z1bmN0aW9uLA0KPiA+Pj4+PiArCS5waW5jdHJsX3Nl
dF9mdW5jdGlvbiA9IHp5bnFtcF9wbV9waW5jdHJsX3NldF9mdW5jdGlvbiwNCj4gPj4+Pj4gKwku
cGluY3RybF9nZXRfY29uZmlnID0genlucW1wX3BtX3BpbmN0cmxfZ2V0X2NvbmZpZywNCj4gPj4+
Pj4gKwkucGluY3RybF9zZXRfY29uZmlnID0genlucW1wX3BtX3BpbmN0cmxfc2V0X2NvbmZpZywN
Cj4gPj4+Pj4gKwkuY2xvY2tfZW5hYmxlID0genlucW1wX3BtX2Nsb2NrX2VuYWJsZSwNCj4gPj4+
Pj4gKwkuY2xvY2tfZGlzYWJsZSA9IHp5bnFtcF9wbV9jbG9ja19kaXNhYmxlLA0KPiA+Pj4+PiAr
CS5jbG9ja19nZXRzdGF0ZSA9IHp5bnFtcF9wbV9jbG9ja19nZXRzdGF0ZSwNCj4gPj4+Pj4gKwku
Y2xvY2tfc2V0ZGl2aWRlciA9IHp5bnFtcF9wbV9jbG9ja19zZXRkaXZpZGVyLA0KPiA+Pj4+PiAr
CS5jbG9ja19nZXRkaXZpZGVyID0genlucW1wX3BtX2Nsb2NrX2dldGRpdmlkZXIsDQo+ID4+Pj4+
ICsJLmNsb2NrX3NldHJhdGUgPSB6eW5xbXBfcG1fY2xvY2tfc2V0cmF0ZSwNCj4gPj4+Pj4gKwku
Y2xvY2tfZ2V0cmF0ZSA9IHp5bnFtcF9wbV9jbG9ja19nZXRyYXRlLA0KPiA+Pj4+PiArCS5jbG9j
a19zZXRwYXJlbnQgPSB6eW5xbXBfcG1fY2xvY2tfc2V0cGFyZW50LA0KPiA+Pj4+PiArCS5jbG9j
a19nZXRwYXJlbnQgPSB6eW5xbXBfcG1fY2xvY2tfZ2V0cGFyZW50LCB9Ow0KPiA+Pj4+PiArDQo+
ID4+Pj4gSW5zdGVhZCBvZiBpbnRyb2R1Y2luZyBhbGwgdGhlc2UgaW4gb25lc2hvdCwgYWRkIHRo
ZW0gYXMgeW91IGhhdmUgdXNlcnMgb2YNCj4gaXQuDQo+ID4+Pj4gSU9XLCBzaG93IHRoZSB1c2Vy
cyBvZiB0aGVzZSBmdW5jdGlvbnMgaW4gdGhlIHNlcmllcy4gQWxzbyBJIGFza2VkDQo+ID4+Pj4g
dG8gc3BsaXQgdGhpcyBpbnRvIGZ1bmN0aW9uYWwgY2hhbmdlcyBsaWtlIGNsb2NrLCBwaW5jdHJs
LCBwb3dlciwgZXRjLg0KPiA+Pj4NCj4gPj4+IEl0IGNhbiBiZSBzcGxpdCBpbnRvIGZ1bmN0aW9u
YWwgY2hhbmdlcyBpbiBzYW1lIHNlcmllcyBidXQgaXQgd2lsbA0KPiA+Pj4gYmUgZGlmZmljdWx0
IHRvIHNwbGl0IGJldHdlZW4gdXNlcnMgYXMgdGhlcmUgYXJlIG1vcmUgdGhhbiAxMCBkcml2ZXIN
Cj4gPj4+IHVzZXJzIGZvciBkaWZmZXJlbnQgRUVNSSBBUElzIGFuZCBhbHNvIG11bHRpcGxlIGRy
aXZlciB1c2VycyB1c2luZw0KPiA+Pj4gc3BlY2lmYyBFRU1JIEFQSXMuIFRoZXkgYWxsIGNhbid0
IGJlIHN1Ym1pdHRlZCBhcyBzaW5nbGUgc2VyaWVzLg0KPiA+Pj4NCj4gPj4NCj4gPj4gV2h5ID8g
U3RhcnQgd2l0aCBiYXNpYyBFRU1JIGFuZCBvbmUgZnVuY3Rpb25hbGl0eSB3aXRoIGl0J3MNCj4g
Pj4gdXNlci9jbGllbnQgZHJpdmVyIGluIG9uZSBzZXJpZXMuIFRoZW4geW91IGNhbiB0b3AgdXAg
d2l0aCBFRU1JDQo+ID4+IGNoYW5nZXMgZm9yIG90aGVyIGZ1bmN0aW9uYWxpdHkgd2l0aCBpdCdz
IHVzZXIuIElmIHlvdSBpbnRyb2R1Y2UNCj4gPj4gQVBJJ3Mgd2l0aG91dCB0aGUgdXNlcnMgaW4g
YSBzZXJpZXMgaXQncyBoYXJkIHRvIHJldmlldyBhbmQgaWYgdGhlcmUgYXJlIG1vcmUNCj4gc3Vj
aCB1bnVzZWQgQVBJcyBJIHdpbGwgb2JqZWN0IGl0IGluIGZ1dHVyZSB2ZXJzaW9ucy4NCj4gPj4N
Cj4gPj4gVG8gc3RhcnQgd2l0aCBhZGQgb25seSBjbG9jayBvciBwb3dlciBBUElzIGFuZCBmdW5j
dGlvbmFsaXR5IGluIHRoaXMNCj4gPj4gc2VyaWVzLCBhZGQgZHJpdmVycyB1c2luZyB0aGVuLiBE
cm9wIG90aGVyIGZ1bmN0aW9uYWxpdGllcyBsaWtlDQo+ID4+IHBpbmN0cmwsIGZwZ2EgY29udHJv
bCBhbmQgb3RoZXIgZnVuY3Rpb25hbGl0aWVzLiBJT1cgc3RhcnQgc29tZXRoaW5nIGJhc2ljIGFu
ZA0KPiBzaW1wbGUuDQo+ID4+DQo+IA0KPiA+DQo+ID4gSSBhbSBvayB0byBicmVhayBpdCBmb3Ig
Y2xvY2svcGluY3RybCB3aXRoIHVzZXJzIGJ1dCB0aGVyZSBhcmUNCj4gPiBtdWx0aXBsZSB1c2Vy
cyBmb3Igc29tZSBBUElzLiBJbiB0aGF0IGNhc2UsIGl0IHdpbGwgY3JlYXRlIGRlcGVuZGVuY3kN
Cj4gPiBpc3N1ZXMgd2hlbiBkaWZmZXJlbnQgb3duZXJzIGFyZSBpbnZvbHZlZC4NCj4gPiBBbHNv
LCBpdCB3aWxsIGhhcmQgdG8gdmlzdWFsaXplIGEgd2hvbGUgRUVNSSBpbnRlcmZhY2UgaWYgaXRz
IGJyb2tlbg0KPiA+IGludG8gc3VjaCBwaWVjZXMuDQo+ID4NCj4gDQo+IEl0J3Mgb3Bwb3NpdGUs
IHlvdSBhcmUganVzdCBhZGRpbmcgd2hvbGUgbG90IG9mIGZ1bmN0aW9ucy9BUElzIGhlcmUgd2l0
aCBvdXQgdGhlDQo+IHVzZXJzIG9mIHRob3NlIEFQSXMuIEkgYW0gdW5hYmxlIHRvIHZpc3VhbGlz
ZSBob3cgdGhleSBhcmUgZ2V0dGluZyB1c2VkLiBTbyBmb3INCj4gbWUgZXZlbiBpZiB5b3UganVz
dCBhZGQgaGFuZGZ1bCBvZiBhYm92ZSBBUElzIHdpdGggZHJpdmVycyBtYWtpbmcgY2FsbCB0byBl
YWNoDQo+IG9uZSBvZiB0aGVtIGFsb25nIHdpdGggaXQsIEkgY2FuIGJldHRlciB1bmRlcnN0YW5k
IGl0LiBXaXRob3V0IGFueSB1c2FnZSBvZiB0aGVzZQ0KPiBBUElzIGluIHRoaXMgc2VyaWVzLCBJ
IGZhaWwgdG8gdW5kZXJzdGFuZCB0aGUgbmVlZCBvZiBpdC4NCj4gU28gTkFDSyB0byB0aGlzIHBh
dGNoIHdpdGhvdXQgdGhlIHVzZXJzIG9mIHRoZSBBUElzIGludHJvZHVjZWQgaGVyZS4NCj4gDQoN
Ck9rLiBJIHdpbGwgYnJlYWsgc2VyaWVzIHdpdGggdXNlcnMgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+
IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0K
