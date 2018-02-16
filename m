Return-Path: <daniel.baluta@nxp.com>
X-Google-Smtp-Source: AH8x227Ko55ESNp3BdD9plaK/0CL5rjqSLNaox8AzPMArPC89A5M7zSGmczHql2qOntnv+lZ+Eoe
ARC-Seal: i=1; a=rsa-sha256; t=1518785800; cv=none;
        d=google.com; s=arc-20160816;
        b=H+NZQFQhXtziep+nk5z/UToQtQShrxIaes7OUwIx2OrOgkdxcz/6Y82u1iAuJ5lbE+
         s844YrQj3Z0T5SarFldOPs68L8enMrwx3gq3iJevh2/XDumPp20S16iDyRqgZmJX+rVO
         G3jxaxsKjCHwWgd16lYsO2FwGKuhI7biu9qXjtbGaHKBal8TJ+4E5ODfucqbbZJd5G5q
         U7JwIZvZv+FwIcCBKhylOr4MmOLPp7vuUMdFXPBgdWVMkLzejSubcqg0JxQYN2lzOd75
         po9DmEMsHfBOMuU1KWFjhFhE6u2r0vTMlL8Q79SJQP+ymiKDhAFl7Lv5+PRZD+y7xKo9
         k4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hakBwQwHyMwi5jWeqDwKi6cHI5s7sjoOrvPyTEFimCU=;
        b=NTbP/sNwJwqHhxykuwecEk0Lb6JwnAjVF5Jibq/f2gSdI2BW4sK5fXJLxseXIkptlb
         mSiHVnS44piVNslEB4NN7/wGnlVvmOTSoPFUI6jC2Ur8FQWATRDnMHhInueJRYGdK/on
         Z3WRu/DFccA+VaqP7S+JvyQ8+TmMWIXrMurwqg5mLZe7mVs4X9Hx7kuEgJoYDNAi7akb
         Sn5PwqUZUC04YooGwbyyC32XzNDOYmlqmL3T9Pt66o1wsyDZ9QsOaULBBUK/pADB7uXk
         h3RMF9Gc1Q9wJuPHGtRHr5MzHEFVMeUeMZM7mgUjgZQR04rGmTbL1y+oLYs4y4Hx31pV
         HMmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=xdd8Iy2c;
       spf=pass (google.com: domain of daniel.baluta@nxp.com designates 40.107.1.54 as permitted sender) smtp.mailfrom=daniel.baluta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=xdd8Iy2c;
       spf=pass (google.com: domain of daniel.baluta@nxp.com designates 40.107.1.54 as permitted sender) smtp.mailfrom=daniel.baluta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "lars@metafoo.de" <lars@metafoo.de>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
	"Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: iio/meter: add name to function definition
 arguments
Thread-Topic: [PATCH] staging: iio/meter: add name to function definition
 arguments
Thread-Index: AQHTpyTGyovvP9Yy90KZZENbdwstWqOm/N4A
Date: Fri, 16 Feb 2018 12:56:36 +0000
Message-ID: <1518785796.9517.25.camel@nxp.com>
References: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
In-Reply-To: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB370;7:KxYRt856ZkY/6v90HOLFRQkLFeQq/8j8vSGpTdu8I/9s3Sjb3ZBbHBZ4Hvo4VdXtchBS7qYtrZJVVTp1tUe/6m1wa/OyaVBuFCfmM8AgJg1515bq635OhM2QrN8vp/eHHZnVtMPmTXigtyulJB9PXHmaZk9IV6EC4KmQNzMM/+XLzOQS9/4/bvt0Emk5ES0JOUmbMOqnWsCx1mr2VI6PAQPI3vXUoiVo9pebUpnNsqGR8PT6+nZGqPMm7VqgzLpc
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65929372-d16b-4d0c-aa55-08d5753cb6f4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB370;
x-ms-traffictypediagnostic: AM3PR04MB370:
x-microsoft-antispam-prvs: <AM3PR04MB370DCC74797517D8ECB01EFF9CB0@AM3PR04MB370.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB370;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB370;
x-forefront-prvs: 0585417D7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(377424004)(199004)(189003)(8936002)(66066001)(2900100001)(68736007)(2950100002)(229853002)(81156014)(2201001)(81166006)(105586002)(86362001)(3846002)(186003)(8676002)(26005)(36756003)(106356001)(478600001)(5250100002)(110136005)(3660700001)(103116003)(76176011)(3280700002)(316002)(39060400002)(59450400001)(6486002)(6506007)(99286004)(6436002)(8666007)(2906002)(6512007)(102836004)(54906003)(305945005)(97736004)(6116002)(5660300001)(14454004)(2501003)(25786009)(6246003)(53936002)(4326008)(7416002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB370;H:AM3PR04MB500.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8/C2pXwiTElyqi+kvusTDOO1nVQ0Oh9OHuK5FYFMWUqjJRl9RnnyJedR/uQSip+1G3TKICTUNyshnKAq15ybFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C31BB7A8FEB0649A312FDDE24411729@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65929372-d16b-4d0c-aa55-08d5753cb6f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2018 12:56:36.9362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB370
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592561969326261427?=
X-GMAIL-MSGID: =?utf-8?q?1592562339559298759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgUm9kcmlnbywNCg0KSSB0aGluayB0aGlzIGlzIGEgbmljZSBmaW5kaW5nLiBPbmUgY29tbWVu
dCBpbmxpbmU6DQoNCk9uIFZpLCAyMDE4LTAyLTE2IGF0IDEwOjUwIC0wMjAwLCByb2RyaWdvc2lx
dWVpcmEgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGNoZWNrcGF0Y2gucGwgd2Fybmlu
ZzoNCj4gDQo+IGRyaXZlcnMvc3RhZ2luZy9paW8vbWV0ZXIvYWRlNzg1NC5oOjE1NzogV0FSTklO
RzogZnVuY3Rpb24gZGVmaW5pdGlvbg0KPiBhcmd1bWVudCAnc3RydWN0IGRldmljZSAqJyBzaG91
bGQgYWxzbyBoYXZlIGFuIGlkZW50aWZpZXIgbmFtZS4uLg0KPsKgDQo+ICsJaW50ICgqcmVhZF9y
ZWdfMzIpKHN0cnVjdCBkZXZpY2UgKmRldiwgdTE2IHJlZ19hZGRyZXNzLCB1MzIgKnZhbCk7DQo+
ICsJaW50ICgqd3JpdGVfcmVnXzgpKHN0cnVjdCBkZXZpY2UgKmRldiwgdTE2IHJlZ19hZGRyZXNz
LCB1OCB2YWx1ZSk7DQoNCg0KQW55IHBhcnRpY3VsYXIgcmVhc29uIGZvciB1c2luZyB2YWwgdnMg
dmFsdWU/IEkgZ2V0IHRoYXQgb25lIGlzIGEgcG9pbnRlcg0KYW5kIGFub3RoZXIgYSBwbGFpbiB0
eXBlLCBidXQgSSB0aGluayB0aGUgbmFtZSBzaG91bGQgYmUgdGhlIHNhbWUuDQoNCnRoYW5rcywN
CkRhbmllbC4NCg0K
