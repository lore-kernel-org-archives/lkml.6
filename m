Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELv2U12+fclJ3obfGtGlQU1ANhsv3N1twF1TkB+HjbJpYYRcthXmuGE0vHcBdjzGJobiaDce
ARC-Seal: i=1; a=rsa-sha256; t=1520262044; cv=none;
        d=google.com; s=arc-20160816;
        b=f9NaiepcaV5GX4TGoR2EPyCfxaDwVMsMRKDhHrYofK5A8S+rKhv2A1F1ljflP5OD/H
         PV/qYkIxa8CBrqgYOKdEjOGwAMkwXMmnfaXi4P0sTlGB5MXmg7MnNN2k2BO3wJeZuzMz
         XUNXkAVxsYTo3106AtHz4oomipOuyG++Cq0CyCmRzFFBLl39fCdyFbAucNLXMeB4uSGQ
         mcRQ/iqirVqScazprW0JgL0Fge7sN3m27PhsDqCLFwkgejbLWdzChiIvtMJIBySzOU6C
         yf0o5Te/EqG2csaUB0dkN6smIGpoRu8uBWEUSLnQcF2LX7eVw7TkG7B9sIvotpYtXv7X
         lgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=hkDKGzrLjg0DQvpegOk8aDKDTDmwdB1RmHgcMCkPFd8=;
        b=x5l0r3H11b3C6+M3m3n9oiWM9isCkA2CdFRJ0uZ/Lg7VUw7UoFN/86dCO+c9qyDfAM
         VsGgnwz9ZrdN9hQWpdwg/X9mh5tMMrkc+DSbzya6xteIqd5dvTwL43d5UVSkhanlACnZ
         mMznrsgz43Koy/8r/taBRQbEJ2wktF6I6j8eoXOVnIDc0MsRBUtfIDg8epkRNWzxMIiv
         bV+dyyL9LmeFug/5w/p83bVRPjEhxf+gYXJqxhMZEVUhI6jQMd0/Ykf2sLKj8nCZTHyS
         LF6q/WzRvCgkMOPBf1o0uXR8VBgKlIEilDfOcIKTkfdsJu3ZN7A7qZCT8FsXDjE1RfI0
         XErg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=IekY8mj4;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.49 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=IekY8mj4;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.49 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "will.deacon@arm.com"
	<will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "joro@8bytes.org"
	<joro@8bytes.org>, Leo Li <leoyang.li@nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
	"stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
Thread-Topic: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree
 binding
Thread-Index: AQHTtI51S/QE8Lhu2k6Y+QLep+bwVKPBukuAgAAAUkA=
Date: Mon, 5 Mar 2018 15:00:37 +0000
Message-ID: <HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
 <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
In-Reply-To: <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1820;6:PZR9W4mZA/K4NmnpJvjHvkPFjUsMSFTrJPyAwf4eYJF3fnBKNDcZFWvKa49K63loBTQhqDh9kiTGY/6sbD9y3ot53IKsMJGpYpEy5FM2U7ZcL13lupIKMGuBKsaHHAuaCoPYju+SdSitG7aBPZcOihcT+KB6pa/IvRktRvOIzUy4vizfsudHQY7pad3BrFalNRFdT+lISPZewfc7vZo96BnlulRWuT3udaHUHJgluoNmy1F8AJuY4BBvgQmSWhqK488whG8dAyD63cZ3nxEtqsBKH52SF72S/X1ZJUsjUzOI0Q7P39nIEbIsoT+ccXI3DpE38poO+Sb82RjzdaA6r6IvVORhbZkdCfgbIJaLqmIt0ojMWTk15kni9fBKouNb;5:oUKwIwf9K4nZfvSYVjRr2vYmXBjeGQ027ZgmMZowvbMW7HzWDP+Cvlz67VWjDUkEulmhhj9F8OaNFBJVPIdzME5iuQeFSM2qKMpfSBaPT4+MT88DlRz3AXIrMwACZg31MFNX0NgFj/YPEcJ6yO3RCdIR6BzcRFHMWcl2GWqNhrM=;24:cktKFC3ReNDR6sGQShTHnB7PiiBb7Y9baqFfde6zZY/8VOafa73KltlQiE2zNIgaMfE+c6Dta8twnJpBk/cF5O1GfEYIaHLrqBi7qjAUj7g=;7:znJRIxbU4qovaS6o9cbBrsduLkgl69kZF8vY4AMP3ncMdgzLAjLXlnRwhfJhBIbrQVcxcF/wy05Y4PBiOm+muvr3UzY2/6pzxKvHBTbdNtcSRnrfnra+j+eyfsaK/4KVoo/e00ha18JqMn/kIoBqq90bysSCpzDtVbaIPQOAB8XS/5cnnUTS00Z3RKXGiYMaxCG6nMTiWbU1W2WD8KItdxuidhZga2YMjXZlLXV38XL4/1kjLMc88ouFHzMYz+1/
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(366004)(346002)(13464003)(189003)(199004)(26005)(6436002)(6506007)(7416002)(316002)(53546011)(66066001)(74316002)(55236004)(6116002)(2201001)(5660300001)(3846002)(39060400002)(575784001)(86362001)(99286004)(110136005)(54906003)(4326008)(97736004)(25786009)(102836004)(9686003)(186003)(53936002)(55016002)(76176011)(33656002)(7696005)(6246003)(8676002)(3280700002)(81166006)(14454004)(81156014)(2900100001)(2950100002)(478600001)(7736002)(5250100002)(8936002)(2501003)(305945005)(229853002)(106356001)(105586002)(2906002)(3660700001)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1820;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3110e1ec-5851-4962-0ba0-08d582a9daa2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB1820;
x-ms-traffictypediagnostic: HE1PR0401MB1820:
x-microsoft-antispam-prvs: <HE1PR0401MB182094D33762F94D4CF5EBB9E6DA0@HE1PR0401MB1820.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(275809806118684)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0401MB1820;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1820;
x-forefront-prvs: 06022AA85F
x-microsoft-antispam-message-info: BjelPvGlzX2rcg2Bjw5poFFlm+aJRo8DsD3dn45zUf2IrvpKA3iryDHCYckbKt7J8pYgC5DZLwl/KZJeh15gWRKVUTpXpglMKp3rwTDk6CIAWVLdIXlaZXGOur1MRa97CDbyM5zcptesLB6BRrbwNzHIAIXx2rcNM4OSYmqYJuBu8ZSd1IGqAHSQ+SJ6OYf/l8cnA+3AyG+2UlTcMQaeEtOFBrBh9looi3gSuiEIQWUtrS1NJq2nk17Xkggh4pRyh8KwHvk9mys76AYTZMhGT9aLnfYGXW2jFpPCyTwBBKG/5OrUNviWq2kEpOlw7Eo7pIO9BOUNY66bBeDCrzzIsA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3110e1ec-5851-4962-0ba0-08d582a9daa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 15:00:37.0680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1820
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108370915742934?=
X-GMAIL-MSGID: =?utf-8?q?1594110293712251056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMDUsIDIw
MTggMjA6MjMNCj4gVG86IE5pcHVuIEd1cHRhIDxuaXB1bi5ndXB0YUBueHAuY29tPjsgd2lsbC5k
ZWFjb25AYXJtLmNvbTsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tDQo+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgcm9iaCtkdEBr
ZXJuZWwub3JnOyBoY2hAbHN0LmRlOw0KPiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnOyBqb3JvQDhieXRlcy5vcmc7DQo+IExlbyBMaSA8bGVveWFu
Zy5saUBueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsg
QmhhcmF0IEJodXNoYW4NCj4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+OyBzdHV5b2RlckBnbWFp
bC5jb207IExhdXJlbnRpdSBUdWRvcg0KPiA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS82XSBEb2NzOiBkdDogYWRkIGZzbC1tYyBpb21tdS1wYXJlbnQg
ZGV2aWNlLXRyZWUgYmluZGluZw0KPiANCj4gT24gMDUvMDMvMTggMTQ6MjksIE5pcHVuIEd1cHRh
IHdyb3RlOg0KPiA+IFRoZSBleGlzdGluZyBJT01NVSBiaW5kaW5ncyBjYW5ub3QgYmUgdXNlZCB0
byBzcGVjaWZ5IHRoZSByZWxhdGlvbnNoaXANCj4gPiBiZXR3ZWVuIGZzbC1tYyBkZXZpY2VzIGFu
ZCBJT01NVXMuIFRoaXMgcGF0Y2ggYWRkcyBhIGJpbmRpbmcgZm9yDQo+ID4gbWFwcGluZyBmc2wt
bWMgZGV2aWNlcyB0byBJT01NVXMsIHVzaW5nIGEgbmV3IGlvbW11LXBhcmVudCBwcm9wZXJ0eS4N
Cj4gDQo+IEdpdmVuIHRoYXQgYWxsb3dpbmcgIm1zaS1wYXJlbnQiIGZvciAjbXNpLWNlbGxzID4g
MSBpcyBtZXJlbHkgYQ0KPiBiYWNrd2FyZC1jb21wYXRpYmlsaXR5IGJvZGdlIGZ1bGwgb2YgaGFy
ZC1jb2RlZCBhc3N1bXB0aW9ucywgd2h5IHdvdWxkDQo+IHdlIHdhbnQgdG8ga25vd2luZ2x5IGlu
dHJvZHVjZSBhIHNpbWlsYXJseSB1bnBsZWFzYW50IGVxdWl2YWxlbnQgZm9yDQo+IElPTU1Vcz8g
V2hhdCdzIHdyb25nIHdpdGggImlvbW11LW1hcCI/DQoNCkhpIFJvYmluLA0KDQpXaXRoICdtc2kt
cGFyZW50JyB0aGUgcHJvcGVydHkgaXMgZml4ZWQgdXAgdG8gaGF2ZSBtc2ktbWFwLiBJbiB0aGlz
IGNhc2UgdGhlcmUgaXMNCm5vIGZpeHVwIHJlcXVpcmVkIGFuZCBzaW1wbGUgJ2lvbW11LXBhcmVu
dCcgcHJvcGVydHkgY2FuIGJlIHVzZWQsIHdpdGggTUMgYnVzDQppdHNlbGYgcHJvdmlkaW5nIHRo
ZSBzdHJlYW0taWQncyAoaW4gdGhlIGNvZGUgZXhlY3V0aW9uIHZpYSBGVykuDQoNCldlIGNhbiBh
bHNvIHVzZSB0aGUgaW9tbXUtbWFwIHByb3BlcnR5IHNpbWlsYXIgdG8gUENJLCB3aGljaCB3aWxs
IHJlcXVpcmUgdS1ib290DQpmaXh1cC4gQnV0IHRoZW4gaXQgbGVhZHMgdG8gbGl0dGxlIGJpdCBj
b21wbGljYXRpb25zIG9mIHUtYm9vdCAtIGtlcm5lbCBjb21wYXRpYmlsaXR5Lg0KDQpJZiB5b3Ug
c3VnZ2VzdCB3ZSBjYW4gcmUtdXNlIHRoZSBpb21tdS1tYXAgcHJvcGVydHkuIFdoYXQgaXMgeW91
ciBvcGluaW9uPw0KDQpUaGFua3MsDQpOaXB1bg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5p
cHVuIEd1cHRhIDxuaXB1bi5ndXB0YUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWlzYy9mc2wscW9yaXEtbWMudHh0ICAgICAgfCAzMQ0KPiArKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
aXNjL2ZzbCxxb3JpcS1tYy50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWlzYy9mc2wscW9yaXEtbWMudHh0DQo+ID4gaW5kZXggNjYxMWE3Yy4uMDExYzdkNiAxMDA2
NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9mc2ws
cW9yaXEtbWMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21pc2MvZnNsLHFvcmlxLW1jLnR4dA0KPiA+IEBAIC05LDYgKzksMjQgQEAgYmxvY2tzIHRoYXQg
Y2FuIGJlIHVzZWQgdG8gY3JlYXRlIGZ1bmN0aW9uYWwgaGFyZHdhcmUNCj4gb2JqZWN0cy9kZXZp
Y2VzDQo+ID4gICBzdWNoIGFzIG5ldHdvcmsgaW50ZXJmYWNlcywgY3J5cHRvIGFjY2VsZXJhdG9y
IGluc3RhbmNlcywgTDIgc3dpdGNoZXMsDQo+ID4gICBldGMuDQo+ID4NCj4gPiArRm9yIGFuIG92
ZXJ2aWV3IG9mIHRoZSBEUEFBMiBhcmNoaXRlY3R1cmUgYW5kIGZzbC1tYyBidXMgc2VlOg0KPiA+
ICtkcml2ZXJzL3N0YWdpbmcvZnNsLW1jL1JFQURNRS50eHQNCj4gPiArDQo+ID4gK0FzIGRlc2Ny
aWJlZCBpbiB0aGUgYWJvdmUgb3ZlcnZpZXcsIGFsbCBEUEFBMiBvYmplY3RzIGluIGEgRFBSQyBz
aGFyZSB0aGUNCj4gPiArc2FtZSBoYXJkd2FyZSAiaXNvbGF0aW9uIGNvbnRleHQiIGFuZCBhIDEw
LWJpdCB2YWx1ZSBjYWxsZWQgYW4gSUNJRA0KPiA+ICsoaXNvbGF0aW9uIGNvbnRleHQgaWQpIGlz
IGV4cHJlc3NlZCBieSB0aGUgaGFyZHdhcmUgdG8gaWRlbnRpZnkNCj4gPiArdGhlIHJlcXVlc3Rl
ci4NCj4gDQo+IElPVywgcHJlY2lzZWx5IHRoZSBjYXNlIGZvciB3aGljaCAie21zaSxpb21tdX0t
bWFwIiBleGlzdC4gWWVzLCBJIGtub3cNCj4gdGhleSdyZSBjdXJyZW50bHkgZG9jdW1lbnRlZCB1
bmRlciBiaW5kaW5ncy9wY2ksIGJ1dCB0aGV5J3JlIG5vdCByZWFsbHkNCj4gaW50ZW5kZWQgdG8g
YmUgYWJzb2x1dGVseSBQQ0ktc3BlY2lmaWMuDQo+IA0KPiBSb2Jpbi4NCj4gDQo+ID4gK1RoZSBn
ZW5lcmljICdpb21tdXMnIHByb3BlcnR5IGlzIGNhbm5vdCBiZSB1c2VkIHRvIGRlc2NyaWJlIHRo
ZSByZWxhdGlvbnNoaXANCj4gPiArYmV0d2VlbiBmc2wtbWMgYW5kIElPTU1Vcywgc28gYW4gaW9t
bXUtcGFyZW50IHByb3BlcnR5IGlzIHVzZWQgdG8gZGVmaW5lDQo+ID4gK3RoZSBzYW1lLg0KPiA+
ICsNCj4gPiArRm9yIGdlbmVyaWMgSU9NTVUgYmluZGluZ3MsIHNlZQ0KPiA+ICtEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvaW9tbXUudHh0Lg0KPiA+ICsNCj4gPiArRm9y
IGFybS1zbW11IGJpbmRpbmcsIHNlZToNCj4gPiArRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lvbW11L2FybSxzbW11LnR4dC4NCj4gPiArDQo+ID4gICBSZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPiA+DQo+ID4gICAgICAgLSBjb21wYXRpYmxlDQo+ID4gQEAgLTg4LDE0ICsxMDYsMjcg
QEAgU3ViLW5vZGVzOg0KPiA+ICAgICAgICAgICAgICAgICBWYWx1ZSB0eXBlOiA8cGhhbmRsZT4N
Cj4gPiAgICAgICAgICAgICAgICAgRGVmaW5pdGlvbjogU3BlY2lmaWVzIHRoZSBwaGFuZGxlIHRv
IHRoZSBQSFkgZGV2aWNlIG5vZGUgYXNzb2NpYXRlZA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB3aXRoIHRoZSB0aGlzIGRwbWFjLg0KPiA+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
PiA+ICsNCj4gPiArLSBpb21tdS1wYXJlbnQ6IE1hcHMgdGhlIGRldmljZXMgb24gZnNsLW1jIGJ1
cyB0byBhbiBJT01NVS4NCj4gPiArICBUaGUgcHJvcGVydHkgc3BlY2lmaWVzIHRoZSBJT01NVSBi
ZWhpbmQgd2hpY2ggdGhlIGRldmljZXMgb24NCj4gPiArICBmc2wtbWMgYnVzIGFyZSByZXNpZGlu
Zy4NCj4gPg0KPiA+ICAgRXhhbXBsZToNCj4gPg0KPiA+ICsgICAgICAgIHNtbXU6IGlvbW11QDUw
MDAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxtbXUtNTAwIjsN
Cj4gPiArICAgICAgICAgICAgICAgI2lvbW11LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAg
ICAgICBzdHJlYW0tbWF0Y2gtbWFzayA9IDwweDdDMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAu
Li4NCj4gPiArICAgICAgICB9Ow0KPiA+ICsNCj4gPiAgICAgICAgICAgZnNsX21jOiBmc2wtbWNA
ODBjMDAwMDAwIHsNCj4gPiAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxxb3Jp
cS1tYyI7DQo+ID4gICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MDAwMDAwMDggMHgwYzAwMDAw
MCAwIDB4NDA+LCAgICAvKiBNQyBwb3J0YWwgYmFzZSAqLw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIDwweDAwMDAwMDAwIDB4MDgzNDAwMDAgMCAweDQwMDAwPjsgLyogTUMgY29udHJvbCBy
ZWcgKi8NCj4gPiAgICAgICAgICAgICAgICAgICBtc2ktcGFyZW50ID0gPCZpdHM+Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgaW9tbXUtcGFyZW50ID0gPCZzbW11PjsNCj4gPiAgICAgICAgICAgICAg
ICAgICAjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiAgICAgICAgICAgICAgICAgICAjc2l6ZS1j
ZWxscyA9IDwxPjsNCj4gPg0KPiA+DQo=
