Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELsxDB+vy+sMiLTgoit7eqWp/g0udvfiZ76MXxElpkq29JwH/NM/7KF7RwChlDLJySR2myoP
ARC-Seal: i=1; a=rsa-sha256; t=1520265280; cv=none;
        d=google.com; s=arc-20160816;
        b=q0jD/PjvT9gs4plCztPSLlIq56mdSrOGmkpaXV9WPBe+CYYJJ8DecPvZ31KFuFLE6R
         20eTpxVl6w8nRbDE99S2dZN0Sv//HG88q8Vvnq+zhl8TF8w9aqlTGd/0e6JW/XTQYrwT
         tBXdIahnfi5Cee7BPYym58lpilgcz2lGnBdCyp2AwW06Ae3ZjIeKBdGs85cqc8pN+xPo
         db97wKKq+yRHAO6j6BkLiDyNq1qb+PLP31JEsVNE7U2CjzK0cTIPqO3fjVCISPJVz7Qi
         4pLGUkVgrz3IZaG8nU5wabY7JPMEwTGJrdH5KJgPUXR2yjbJmtnMdu4rXWXwVeV4O7Qk
         eWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=B+HPo4mI/HYXF8YfStYUrJLgly8/W50WdfgrLeg2Ga0=;
        b=MRb6kp4Z14vIBqzkg3pbMSY3hpE8qjoPMniYMi0073Z8LFd2fa52GN9BXU8ZNqMWnj
         XXkVb8EneghQSF50zxaGVDahrZ6wTwVbO1fgZtHzH4eqObiudeYm6OPootGrUp1f5o44
         uECMTHVonPXnI86/knUQ5OTek9khZQNF5ETRtcoXwvhpsp5jihRQ/H/A+UNTpgbDUZEA
         wI2sCHZbzculAOyafYC9Od5sgopS6HwBSMjhyPO3TBkVI+uKTvt84EqWZ7XYMOOELE/6
         fy0BkVX32G4upfQ859Hr2Z4T4jQzNwuQnybNZ49JfaVxdabrKU2cmHhIQUV9MMIUyITS
         oZkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=YsDgP7SR;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.82 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=YsDgP7SR;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.1.82 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
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
Thread-Index: AQHTtI51S/QE8Lhu2k6Y+QLep+bwVKPBukuAgAAAUkCAAAwDgIAAA6yQ
Date: Mon, 5 Mar 2018 15:54:34 +0000
Message-ID: <HE1PR0401MB2425F261CA777DAA1D41A477E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
 <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
 <HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <f382e92a-8ab5-7c93-1f39-fe6797e5c876@arm.com>
In-Reply-To: <f382e92a-8ab5-7c93-1f39-fe6797e5c876@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1724;7:kkJC7bRkXL5wh98A76L29T5gvJynNSgjFJIQ37xUMF6EmEQ+05UxB6RWytA6kch2Yg0SddA8gUP/VXZIKc26yLZGC7zNvRLCY2Vc/rTXMMnDiPpSldUFZuobRAow1sDsKwfGjpC5ld1q6Grt14Z/OviT+RkuHXAD05nWQxFVz0uYppM0useGGK55w2h8C4+ofIABLDt4AmYF2he6vjOpwhJG76hLUN1plwTUNp1eVOxv9vCsfPhJiWBO3GzGUpww
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(396003)(366004)(199004)(189003)(13464003)(7416002)(26005)(305945005)(5250100002)(2501003)(99286004)(2906002)(55016002)(8936002)(9686003)(3846002)(6116002)(6246003)(53936002)(6346003)(2201001)(68736007)(7696005)(186003)(86362001)(76176011)(97736004)(105586002)(2950100002)(7736002)(74316002)(5660300001)(229853002)(54906003)(110136005)(478600001)(316002)(53546011)(14454004)(33656002)(102836004)(55236004)(39060400002)(81166006)(81156014)(3660700001)(25786009)(6436002)(8676002)(66066001)(106356001)(93886005)(2900100001)(4326008)(3280700002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1724;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f2f2240-66a3-45bc-6a59-08d582b1644c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB1724;
x-ms-traffictypediagnostic: HE1PR0401MB1724:
x-microsoft-antispam-prvs: <HE1PR0401MB172460178260221A128F7B33E6DA0@HE1PR0401MB1724.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0401MB1724;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1724;
x-forefront-prvs: 06022AA85F
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-microsoft-antispam-message-info: rKOws9qGNA7jU5q2e92ImieHG2fvHnFM9CB/JSjwcjzlhXxNTuL2d6NS6tOtMS0KW00kwVNwQ70ie6DL2bknxvWSUd+GrvS5rA2VmC0CWzCnlQ5vfcVRS3bZTf1r2cfb/JJDwiGcOuC3IKN3TjddMWVQhicoItoO+1eEYowdbgH5DGkeDdfnP9QceEy7OR3O78zt5xsP46ETBhTbETRvhoRhix0HasQD6UB/PKthwSSesCUsWLLIiGhhRRidmWs6zLFH4jbedoqQsJv3MbDjNSm9QyWEr9cDL+iM0/DxeCTfRoFGG873+tKoOTbvvoYTsP5qbY2NrLV+t6dk0rqbGg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2f2240-66a3-45bc-6a59-08d582b1644c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 15:54:34.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1724
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108370915742934?=
X-GMAIL-MSGID: =?utf-8?q?1594113686275757419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMDUsIDIw
MTggMjE6MDcNCj4gVG86IE5pcHVuIEd1cHRhIDxuaXB1bi5ndXB0YUBueHAuY29tPjsgd2lsbC5k
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
ZGV2aWNlLXRyZWUgYmluZGluZw0KPiANCj4gT24gMDUvMDMvMTggMTU6MDAsIE5pcHVuIEd1cHRh
IHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4g
RnJvbTogUm9iaW4gTXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+ID4+IFNl
bnQ6IE1vbmRheSwgTWFyY2ggMDUsIDIwMTggMjA6MjMNCj4gPj4gVG86IE5pcHVuIEd1cHRhIDxu
aXB1bi5ndXB0YUBueHAuY29tPjsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gPj4gbWFyay5ydXRs
YW5kQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tDQo+ID4+IENjOiBpb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBoY2hAbHN0LmRlOw0K
PiA+PiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
Ow0KPiBqb3JvQDhieXRlcy5vcmc7DQo+ID4+IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsg
c2hhd25ndW9Aa2VybmVsLm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+ID4+IGtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgQmhhcmF0IEJo
dXNoYW4NCj4gPj4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+OyBzdHV5b2RlckBnbWFpbC5jb207
IExhdXJlbnRpdSBUdWRvcg0KPiA+PiA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+ID4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS82XSBEb2NzOiBkdDogYWRkIGZzbC1tYyBpb21tdS1wYXJlbnQg
ZGV2aWNlLXRyZWUNCj4gYmluZGluZw0KPiA+Pg0KPiA+PiBPbiAwNS8wMy8xOCAxNDoyOSwgTmlw
dW4gR3VwdGEgd3JvdGU6DQo+ID4+PiBUaGUgZXhpc3RpbmcgSU9NTVUgYmluZGluZ3MgY2Fubm90
IGJlIHVzZWQgdG8gc3BlY2lmeSB0aGUgcmVsYXRpb25zaGlwDQo+ID4+PiBiZXR3ZWVuIGZzbC1t
YyBkZXZpY2VzIGFuZCBJT01NVXMuIFRoaXMgcGF0Y2ggYWRkcyBhIGJpbmRpbmcgZm9yDQo+ID4+
PiBtYXBwaW5nIGZzbC1tYyBkZXZpY2VzIHRvIElPTU1VcywgdXNpbmcgYSBuZXcgaW9tbXUtcGFy
ZW50IHByb3BlcnR5Lg0KPiA+Pg0KPiA+PiBHaXZlbiB0aGF0IGFsbG93aW5nICJtc2ktcGFyZW50
IiBmb3IgI21zaS1jZWxscyA+IDEgaXMgbWVyZWx5IGENCj4gPj4gYmFja3dhcmQtY29tcGF0aWJp
bGl0eSBib2RnZSBmdWxsIG9mIGhhcmQtY29kZWQgYXNzdW1wdGlvbnMsIHdoeSB3b3VsZA0KPiA+
PiB3ZSB3YW50IHRvIGtub3dpbmdseSBpbnRyb2R1Y2UgYSBzaW1pbGFybHkgdW5wbGVhc2FudCBl
cXVpdmFsZW50IGZvcg0KPiA+PiBJT01NVXM/IFdoYXQncyB3cm9uZyB3aXRoICJpb21tdS1tYXAi
Pw0KPiA+DQo+ID4gSGkgUm9iaW4sDQo+ID4NCj4gPiBXaXRoICdtc2ktcGFyZW50JyB0aGUgcHJv
cGVydHkgaXMgZml4ZWQgdXAgdG8gaGF2ZSBtc2ktbWFwLiBJbiB0aGlzIGNhc2UgdGhlcmUgaXMN
Cj4gPiBubyBmaXh1cCByZXF1aXJlZCBhbmQgc2ltcGxlICdpb21tdS1wYXJlbnQnIHByb3BlcnR5
IGNhbiBiZSB1c2VkLCB3aXRoIE1DDQo+IGJ1cw0KPiA+IGl0c2VsZiBwcm92aWRpbmcgdGhlIHN0
cmVhbS1pZCdzIChpbiB0aGUgY29kZSBleGVjdXRpb24gdmlhIEZXKS4NCj4gPg0KPiA+IFdlIGNh
biBhbHNvIHVzZSB0aGUgaW9tbXUtbWFwIHByb3BlcnR5IHNpbWlsYXIgdG8gUENJLCB3aGljaCB3
aWxsIHJlcXVpcmUgdS0NCj4gYm9vdA0KPiA+IGZpeHVwLiBCdXQgdGhlbiBpdCBsZWFkcyB0byBs
aXR0bGUgYml0IGNvbXBsaWNhdGlvbnMgb2YgdS1ib290IC0ga2VybmVsDQo+IGNvbXBhdGliaWxp
dHkuDQo+IA0KPiBXaGF0IG5lZWRzIGZpeGluZyB1cD8gV2l0aCBhIHN0cmVhbS1tYXAtbWFzayBp
biBwbGFjZSB0byBpZ25vcmUgdGhlDQo+IHVwcGVyIFN0cmVhbSBJRCBiaXRzLCB5b3UganVzdCBu
ZWVkOg0KPiANCj4gCWlvbW11LW1hcCA9IDwwICZzbW11IDAgMHg4MD47DQo+IA0KPiB0byBzYXkg
dGhhdCB0aGUgbG93ZXIgYml0cyBvZiB0aGUgSUNJRCB2YWx1ZSBtYXAgZGlyZWN0bHkgdG8gdGhl
IGxvd2VyDQo+IGJpdHMgb2YgdGhlIFN0cmVhbSBJRCB2YWx1ZSAtIHRoYXQncyB0aGUgc2FtZSBm
aXhlZCBwcm9wZXJ0eSBvZiB0aGUNCj4gaGFyZHdhcmUgdGhhdCB5b3UncmUgd2FudGluZyB0byBh
c3N1bWUgaW4gaW9tbXUtcGFyZW50Lg0KDQpNYWtlcyBzZW5zZS4gSSB3YXMgZ29pbmcgaW4gYSBs
aXR0bGUgYml0IHdyb25nIGRpcmVjdGlvbi4gVGhhbmtzIGZvciBjb3JyZWN0aW5nLg0KSSB3aWxs
IHNlbmQgdjIgcGF0Y2hzZXQgd2l0aCBpb21tdS1tYXAgcHJvcGVydHkuDQoNClJlZ2FyZHMsDQpO
aXB1bg0KDQo+IA0KPiA+IElmIHlvdSBzdWdnZXN0IHdlIGNhbiByZS11c2UgdGhlIGlvbW11LW1h
cCBwcm9wZXJ0eS4gV2hhdCBpcyB5b3VyIG9waW5pb24/DQo+IA0KPiBJIHRoaW5rIGl0IG1ha2Vz
IGEgbG90IG1vcmUgc2Vuc2UgdG8gZGlyZWN0bHkgdXNlIHRoZSBwcm9wZXJ0eSB3aGljaA0KPiBh
bHJlYWR5IGV4aXN0cywgdGhhbiB0byBpbnRyb2R1Y2UgYSBuZXcgb25lIHRvIG1lcmVseSBhc3N1
bWUgb25lDQo+IGhhcmQtY29kZWQgdmFsdWUgb2YgdGhlIGV4aXN0aW5nIG9uZS4gRXh0ZW5kaW5n
IG1zaS1wYXJlbnQgdG8gbXNpLW1hcA0KPiB3YXMgYSBjYXNlIG9mICJvb3BzLCBpdCB0dXJucyBv
dXQgd2UgbmVlZCBtb3JlIGZsZXhpYmlsaXR5IGhlcmUiOyBmb3INCj4gdGhlIGNhc2Ugb2YgaW9t
bXUtbWFwIEkgY2FuJ3QgaW1hZ2luZSBhbnkganVzdGlmaWNhdGlvbiBmb3Igc2F5aW5nDQo+ICJv
b3BzLCB3ZSBuZWVkIGxlc3MgZmxleGliaWxpdHkgaGVyZSIgKHNhdmluZyA5IHdob2xlIGJ5dGVz
IGluIHRoZSBEVA0KPiByZWFsbHkgaXMgaXJyZWxldmFudCkuDQo+IA0KPiBSb2Jpbi4NCg==
