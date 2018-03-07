Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AG47ELsmaYVldrqk/eK3QbaVE7DpZ4ZvnnETvW0/mdmqmc+5ZG1B5MVJz6nRIxeGmtDfj7rl71Fx
ARC-Seal: i=1; a=rsa-sha256; t=1520461506; cv=none;
        d=google.com; s=arc-20160816;
        b=JdwLRvSSnnX2mRMQQp06EgEwPg9lNiOjGi3p4M/CgqwlhORU0R6hFy7f2V8MzwEQEn
         k7BUsbsFli0Hb4EzASpZFqvr5OVSt987MUhkEybXrJT4V1aXGCx36y7QWYm900rb6nXD
         Ty8SCN6B0bc25JyhnsX0p0BBuFCcNSBliswMg5Bmv6O3Os0occgk7srb9BWMVYteX0X2
         UmkAcVGM0eT8C3KwKQ4kDaKBAj3boqG7Tqmc5CDb8xhleZKcYShskUO4uZZ6Stuf3ctc
         0FuF/hpJ9LOQQi/zwaOmcHw2hc+MHsvUIbkeewyT1npsHJPhdY5VXzMf+f03OSW2UGev
         pRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=OoSJmyR5dtE9hxAiWv/NtoplhrBIBbO9djn3abEijcM=;
        b=ermLcsVsOSGz3zVJSlvTrvFwetG4yPL0WeuDdkAJmsx8jbDqjLV75CuLaXr02gAORc
         XWkgD2BPSURnPKRI9pPS2XBXWnNiuuFF7ZqJkB5y1ufS1U7+yCSyp+PkVYgU3yBqltyL
         cmmf4pr9h5ySEmphjVr4rgnLbUld7Rl9S1Op0mB+2IpRP2/srUieagQ+p7b/NIF+TpQo
         z1vP/R7rHnlfiz9OJOYTfHN44pwm0sJNMJuscd2P1Hy3DbDlpWMk3dIKYFzLnABQ9nbU
         OqFnOxiL2g7oZMp3ql6jHrzqhMCbJK2Bz+btEyjuwOfXmt9CIfv1KwpTmC3EAMQU55ZL
         ZilA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=SIrLoRXx;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.76 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=SIrLoRXx;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.76 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "matt@codeblueprint.co.uk"
	<matt@codeblueprint.co.uk>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, Rajan Vaja <RAJANV@xilinx.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Thread-Topic: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
Thread-Index: AQHTqoAmKKGb/CVRXk2mfd+L4ykECqO7enoAgAnz4+A=
Date: Wed, 7 Mar 2018 22:25:03 +0000
Message-ID: <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
 <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
In-Reply-To: <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0201MB1899;6:04OC8V8Fg8Zo3eXncDSNI6t7sCk7AoUpH4HokassdW9eiqxryPZNu0zo5zjQx8Gwnf24x9SugexqPnJ7kSzV+NY4ShU0SVf6ddiIjxOZCWNPBh80m+uFR9zxtpL2E3tgYycoSwLkhxR/EEaaSBKsDqmD4zO2lJgzwwuZTCzcl3a+khNtf/ACgiY4L7NM/G2NPyKpQpA5YfgjW9DZSoFgEe+4QUaan/hrAEZW/cu9BDLlwYVFguEEoOOMj3jf5UsWVDhfy38bP7kgfMcFhMZdts5jgISIcBWLbDMKBhsLek91Rs40eqjyEy/lmm+GKJvukjsTkDm1yyS9hcRSHZZ6ul4HKNh/WBS+TbLUI0flzZLMNy65nqpfsPpRKCvObcJQ;5:d4/8khAE0sMdatp60zOvjHcJiOixrig6u6OEvXS+5bm1hSiF/vhQ6cOXWb+5gSNz8sGf5g1ESQJfF1/80sOQ6BSivrMs9+MTtSSu9vPS62dDNxfGM1IR199/fZF7mD1IWtJ72uauJO7coiFATrORweTLmX/49GNMcxsOnSbU9DI=;24:zyHvKwHLeS3IaOy3yMIIoBcsOr7yZ5GeFgc+2VzMnlB0Y0lQmvufWNMp9I2g7Jb7V3wBqGBsfoxDlJiJidbvu7DlC6Kqjt06o9N8zSALjy4=;7:y7xbAiv0mjbIzogPdnp8Bwiw9DBfOr7/XQLnwbqhQrvyY3FbGtehKYZKj/PrRBZxyyFQ1PplVuq13LBCha7kt1gl5tlARD60rNx3ImFJRvxeR0DdPsqe0dg89GOjN7MQshPJVYgY7UTJkPUYGfzwfG+We6f+o5xesFMEsI6o3+twnX5jbdMaHX5UE+SWTdCK2TiTPUmRuzF/4oCyOmoAi/BRs1TsvyCU9kpFjVt2AZVE/pN3rDIcGceX+yHNmcle
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(366004)(39380400002)(199004)(189003)(13464003)(105586002)(3660700001)(186003)(54906003)(229853002)(110136005)(106356001)(53936002)(77096007)(316002)(26005)(9686003)(5660300001)(55016002)(4326008)(2501003)(97736004)(33656002)(8936002)(68736007)(2900100001)(3280700002)(39060400002)(6116002)(8676002)(81156014)(81166006)(6436002)(72206003)(74316002)(86362001)(66066001)(3846002)(99286004)(478600001)(76176011)(25786009)(2950100002)(6506007)(7736002)(6246003)(7416002)(2201001)(7696005)(2906002)(14454004)(102836004)(305945005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1899;H:CY1PR0201MB0764.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca406c09-7ef4-4693-66ff-08d5847a45ce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0201MB1899;
x-ms-traffictypediagnostic: CY1PR0201MB1899:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-microsoft-antispam-prvs: <CY1PR0201MB189911DD46D40C3313FD409CB8D80@CY1PR0201MB1899.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0201MB1899;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1899;
x-forefront-prvs: 0604AFA86B
x-microsoft-antispam-message-info: lHgiILRnxcHdTr5rCUmToGmG+QNABmkK9DlIh7cec2hil6lMfAz9KozYeNkh5by4jG+wZkpQEa4VqGp2KrUTW5oH+moM5tAEuYUx+RHBw4pGuXR7apATp+9NLXBfGfHazuM8vaH7KFpDPw5sdFJ8RwWj0AruuaKF/mSHI01wB/t749UKNGCVu3X2VTcRilPprYo5dIm6ITp2QMfubt5L2rvf16UgM+Y772CR4P+BIg8dO+eKIRZrIltib09t1ZPQ8GIwja/9I3/VhYIzO2tOPC/NeNpvNFajhJXg6NF07OVGZ7FszTh3LFdh5DFS5Lbbrdlnx2qQWNyK3Q9GHof+xA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca406c09-7ef4-4693-66ff-08d5847a45ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 22:25:03.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1899
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1594319444873935330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgU3VkZWVwLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVl
cCBIb2xsYSBbbWFpbHRvOnN1ZGVlcC5ob2xsYUBhcm0uY29tXQ0KPiBTZW50OiBUaHVyc2RheSwg
TWFyY2ggMDEsIDIwMTggNjoxNSBBTQ0KPiBUbzogSm9sbHkgU2hhaCA8Sk9MTFlTQHhpbGlueC5j
b20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gbWF0dEBjb2RlYmx1ZXByaW50LmNv
LnVrOyBoa2FsbHdlaXQxQGdtYWlsLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+IHJv
YmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb20NCj4gQ2M6IGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc7IG1pbmdvQGtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsN
Cj4gZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbTsgU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFA
YXJtLmNvbT47IFJhamFuDQo+IFZhamEgPFJBSkFOVkB4aWxpbnguY29tPjsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEpvbGx5IFNoYWgNCj4gPEpPTExZU0B4aWxp
bnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvNF0gZHQtYmluZGluZ3M6IGZpcm13
YXJlOiBBZGQgYmluZGluZ3MgZm9yIFp5bnFNUA0KPiBmaXJtd2FyZQ0KPiANCj4gDQo+IA0KPiBP
biAyMC8wMi8xOCAxOToyMSwgSm9sbHkgU2hhaCB3cm90ZToNCj4gPiBBZGQgZG9jdW1lbnRhdGlv
biB0byBkZXNjcmliZSBYaWxpbnggWnlucU1QIGZpcm13YXJlIGRyaXZlciBiaW5kaW5ncy4NCj4g
PiBGaXJtd2FyZSBkcml2ZXIgcHJvdmlkZXMgYW4gaW50ZXJmYWNlIHRvIGZpcm13YXJlIEFQSXMu
IEludGVyZmFjZSBBUElzDQo+ID4gY2FuIGJlIHVzZWQgYnkgYW55IGRyaXZlciB0byBjb21tdW5p
Y2F0ZSB0byBQTVVGVyAoUGxhdGZvcm0gTWFuYWdlbWVudA0KPiA+IFVuaXQpLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSm9sbHkgU2hhaCA8am9sbHlzQHhpbGlueC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUmFqYW4gVmFqYSA8cmFqYW52QHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9maXJtd2FyZS94aWxpbngveGxueCx6eW5xbXAtZmlybXdhcmUudHh0ICAgICAgIHwgMjQNCj4g
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9u
cygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZmlybXdhcmUveGlsaW54L3hsbngsenlucW1wLWZpcm13YXJlDQo+ID4gLnR4
dA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Zpcm13YXJlL3hpbGlueC94bG54LHp5bnFtcC1maXJtd2ENCj4gPiByZS50eHQNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS94aWxpbngveGxu
eCx6eW5xbXAtZmlybXdhDQo+ID4gcmUudHh0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwLi45OTQzNGJhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9maXJtd2FyZS94aWxpbngveGxueCx6eW5x
bXAtZmkNCj4gPiArKysgcm13YXJlLnR4dA0KPiA+IEBAIC0wLDAgKzEsMjQgQEANCj4gPiArWGls
aW54IFp5bnEgTVBTb0MgRmlybXdhcmUgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4gPiArDQo+ID4g
K1RoZSB6eW5xbXAtZmlybXdhcmUgbm9kZSBkZXNjcmliZXMgdGhlIGludGVyZmFjZSB0byBwbGF0
Zm9ybSBmaXJtd2FyZS4NCj4gPiArWnlucU1QIGhhcyBhbiBpbnRlcmZhY2UgdG8gY29tbXVuaWNh
dGUgd2l0aCBzZWN1cmUgZmlybXdhcmUuIEZpcm13YXJlDQo+ID4gK2RyaXZlciBwcm92aWRlcyBh
biBpbnRlcmZhY2UgdG8gZmlybXdhcmUgQVBJcy4gSW50ZXJmYWNlIEFQSXMgY2FuIGJlDQo+ID4g
K3VzZWQgYnkgYW55IGRyaXZlciB0byBjb21tdW5pY2F0ZSB0byBQTVVGVyhQbGF0Zm9ybSBNYW5h
Z2VtZW50IFVuaXQpLg0KPiA+ICtUaGVzZSByZXF1ZXN0cyBpbmNsdWRlIGNsb2NrIG1hbmFnZW1l
bnQsIHBpbiBjb250cm9sLCBkZXZpY2UgY29udHJvbCwNCj4gPiArcG93ZXIgbWFuYWdlbWVudCBz
ZXJ2aWNlLCBGUEdBIHNlcnZpY2UgYW5kIG90aGVyIHBsYXRmb3JtIG1hbmFnZW1lbnQNCj4gPiAr
c2VydmljZXMuDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICsgLSBjb21w
YXRpYmxlOglNdXN0IGNvbnRhaW46ICAieGxueCx6eW5xbXAtZmlybXdhcmUiDQo+ID4gKyAtIG1l
dGhvZDoJVGhlIG1ldGhvZCBvZiBjYWxsaW5nIHRoZSBQTS1BUEkgZmlybXdhcmUgbGF5ZXIuDQo+
ID4gKwkJUGVybWl0dGVkIHZhbHVlcyBhcmU6DQo+ID4gKwkJICAtICJzbWMiIDogU01DICMwLCBm
b2xsb3dpbmcgdGhlIFNNQ0NDDQo+ID4gKwkJICAtICJodmMiIDogSFZDICMwLCBmb2xsb3dpbmcg
dGhlIFNNQ0NDDQo+ID4gKw0KPiA+ICtFeGFtcGxlczoNCj4gPiArCWZpcm13YXJlIHsNCj4gPiAr
CQl6eW5xbXBfZmlybXdhcmU6IHp5bnFtcC1maXJtd2FyZSB7DQo+ID4gKwkJCWNvbXBhdGlibGUg
PSAieGxueCx6eW5xbXAtZmlybXdhcmUiOw0KPiA+ICsJCQltZXRob2QgPSAic21jIjsNCj4gPiAr
CQl9Ow0KPiA+ICsJfTsNCj4gPg0KPiANCj4gRG8geW91IGZvcmVzZWUgdXNpbmcgU01DL0hWQyBm
b3IgdGhpcyBmaXJtd2FyZSBldmVuIG9uIGZ1dHVyZSBwbGF0Zm9ybXM/DQo+IElmIG5vdCwgSSBz
dWdnZXN0IHRvIGtlZXAgdGhlIHByb3RvY29sIHBhcnQgc2VwYXJhdGUgZnJvbSB0aGUgdHJhbnNw
b3J0IGkuZS4NCj4gc21jL2h2YyB2aWEgQVRGLiBJdCBjb3VsZCBiZSByZXBsYWNlZCB3aXRoIG1h
aWxib3ggb3Igc29tZSBoL3cgbWVjaGFuaXNtIGluDQo+IGZ1dHVyZSA/DQo+IA0KDQpXZSBoYXZl
IFBTQ0kgYW5kIEVFTUkgaW50ZXJmYWNlcyBleHBvc2VkIHRvIGxpbnV4IGZyb20gQVRGLiAgUFND
SSBpcyBhbiBFRU1JIGNsaWVudC4gV2UgZG8gbm90IGhhdmUgY3VycmVudCBwbGFucyB0byBzd2l0
Y2ggdG8gbWFpbGJveCBhcyBpdCB3aWxsIHJlcXVpcmUgMiBjb21tdW5pY2F0aW9uIGNoYW5uZWxz
IHRvIFBNVSBhcyBQU0NJIGlzIHRocm91Z2ggQVRGLiANCg0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBT
dWRlZXANCg==
