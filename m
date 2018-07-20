Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C361120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="plUn0S1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C361120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeGTJL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:11:29 -0400
Received: from mail-eopbgr40099.outbound.protection.outlook.com ([40.107.4.99]:59590
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbeGTJL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN8E1pMRANnqTzNAgBbl01wsf6GN4VDHaPhrPnz7ph0=;
 b=plUn0S1/LsjVHq16fZbo9SVh5vSKakVGQGx0ANALZxrj+K/utahcI5cT6oAbT19LmxywXSZn8Ls5kRYs26LSZ6MJIQNbAAoJ1KQnI000ecOX50pqexuSPZYJa/Ll8RP0J0RKRe6p/iCoug1NlN9dlO8rh1z1q+1xbDeWLU20ULk=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB3599.eurprd05.prod.outlook.com (10.166.198.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Fri, 20 Jul 2018 08:24:16 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Fri, 20 Jul 2018
 08:24:16 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Subject: Re: [PATCH] pinctrl: tegra: fix spelling in devicetree binding
 document
Thread-Topic: [PATCH] pinctrl: tegra: fix spelling in devicetree binding
 document
Thread-Index: AQHUH/6sNpzxW4p130yKTA8RpQxVPaSXwswAgAADTAA=
Date:   Fri, 20 Jul 2018 08:24:16 +0000
Message-ID: <1532075054.19673.5.camel@toradex.com>
References: <20180720075235.18617-1-marcel@ziswiler.com>
         <5e51036b-a0b0-9cb4-4698-cf830309ef8a@nvidia.com>
In-Reply-To: <5e51036b-a0b0-9cb4-4698-cf830309ef8a@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB3599;6:vKfnUHo15bA1nRrBKrWcU13NNqaFI0ZyuFO4QuLcwcfQZ2u0RxE1ryfGtRKMM3/5YaLWGdTiktJgbTzhD7ySXinW8FMtqyzffDgl5I/m+2l0h6aUuLm4UtRzZmW55PcsWoEI6gfEbMS+ACYFxARiG8MJmbAHhxUZVZaw1ybO9EM668Au3HfSkDmJv5UG0LPt7NZTMfirahMPKtb0cPj55h8MyPmjGS6RiB1Nr+QxjDpU4iqlmjyYvWVktiEZPIVe7zyLLflAUrhn/MBjOqw6QfVY1/uaBNtciwLO+Cz7Ujjg+oWTGgtuUwkpsLEa3eiFmeMDNMSFcQ9Gvd58WerqneXA0LGoO8OWbxaiDuVSvJBLA0LiVjLJ+RzRFe7clDyd0iQx0ZTir0ejO184Hg2EmbqskTHUImaR/BYi8wXEwq5Q7ZDlBNtnhRefoU4P9kYIV/kFFSvhm0F7AdB5BmAlWQ==;5:QPb+JdyRAo6m0tWskKvQ7t+8CfHm8CUarFS46BhgXEeuUdIUnHmRZnCxhEOLzrjP7NGTy6Vng7Per1uBNnSopexYboCNTIIKDjTGmsxm+ZR1hQoMuzT7CwFkE4CPS1JrWr3Cni6NrvMqe8uTwLi5PMJp+DEwji5c8WbzIH/vRlM=;7:Usnh8UtRMMHQ0/TtL0tEI+Ji/TMrUqeN2d4IpsYb/7meCLXmkE+znY1+WIUWOSe82ZUhBoH0I/AAZ9teyHno98tHS5IDI5wfiS2wzTb4W6olKIJhb0h4LYBVxRcfo2AilgVRuBMF1wm6BhRdXRG1o/dopvwSQRpS9gy5E+Eu0ZuCjL+Sgpf2x4dNswvsN11yrVZPnafDPqp91hur1xJUndpWBtzckpQqrAs5h6dPbxQQr8231fS1NPfwBr7dkvxz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 97dfd6d5-2be9-4686-6d0e-08d5ee1a2ee4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB3599;
x-ms-traffictypediagnostic: VI1PR0501MB3599:
x-microsoft-antispam-prvs: <VI1PR0501MB3599FFBEA48583DE1F38E983FB510@VI1PR0501MB3599.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB3599;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB3599;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39840400004)(136003)(189003)(199004)(186003)(305945005)(54906003)(110136005)(6486002)(25786009)(26005)(102836004)(316002)(36756003)(105586002)(8936002)(97736004)(106356001)(14454004)(229853002)(53546011)(6506007)(14444005)(256004)(2906002)(76176011)(575784001)(446003)(103116003)(68736007)(99286004)(86362001)(5660300001)(478600001)(6512007)(3846002)(6436002)(11346002)(486006)(44832011)(476003)(6116002)(6246003)(5250100002)(53936002)(4326008)(2616005)(66066001)(2900100001)(8676002)(7736002)(2201001)(2501003)(39060400002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB3599;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Z7MDsPiAwdTSU+b7P71i8k8UElX8rJMmtOQ8zok8WUg/I0N1fIP504ojygvdtP5/UmIYqciW/GHi3YqbnEbnVHsT+XgE0VWE0c4R0wSMWs6nDIIaZl0PvNZupyRYjaRNUfBmle4lHpTPOcD4bd3oQbkFGS3srx2UgqoWPv/OHbUh5fAXDSJqzW8slOJBDBRYujqXBcVOrWwqH6XPE+1jvj1I8uRorcY+NvYJYcyBwApAu6J3lvg2OSNzOLbgGHGmDF15y0pXkdMYVVXEDFU5byt8Kn0Yh61u4uddI4g5+9RRuCVWTEgGMvscnqktJgbYfsK7y2CGcLaZnytCO2Qw/D66DOffLmtbgtlKjY9XD9Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C97AEDD578193941A5A43705314AE296@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dfd6d5-2be9-4686-6d0e-08d5ee1a2ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 08:24:16.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB3599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTIwIGF0IDA5OjEyICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBP
biAyMC8wNy8xOCAwODo1MiwgTWFyY2VsIFppc3dpbGVyIHdyb3RlOg0KPiA+IEZyb206IE1hcmNl
bCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IFRoaXMg
Zml4ZXMgYSBzcGVsbGluZyBtaXN0YWtlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNl
bCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IC0tLQ0K
PiA+IA0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9udmlk
aWEsdGVncmExMjQtDQo+ID4gcGlubXV4LnR4dCB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbnZpZGlhLHRlZ3Jh
MTI0LQ0KPiA+IHBpbm11eC50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9waW5jdHJsL252aWRpYSx0ZWdyYTEyNC0NCj4gPiBwaW5tdXgudHh0DQo+ID4gaW5kZXgg
ZWNiNWMwZDI1MjE4Li5mNGQwNmJiMGI1NWEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbnZpZGlhLHRlZ3JhMTI0LQ0KPiA+IHBpbm11
eC50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3Ry
bC9udmlkaWEsdGVncmExMjQtDQo+ID4gcGlubXV4LnR4dA0KPiA+IEBAIC0xNyw3ICsxNyw3IEBA
IFRlZ3JhMTI0IGFkZHMgdGhlIGZvbGxvd2luZyBvcHRpb25hbCBwcm9wZXJ0aWVzDQo+ID4gZm9y
IHBpbiBjb25maWd1cmF0aW9uIHN1Ym5vZGVzLg0KPiA+ICBUaGUgbWFjcm9zIGZvciBvcHRpb25z
IGFyZSBkZWZpbmVkIGluIHRoZQ0KPiA+ICAJaW5jbHVkZS9kdC1iaW5kaW5nL3BpbmN0cmwvcGlu
Y3RybC10ZWdyYS5oLg0KPiA+ICAtIG52aWRpYSxlbmFibGUtaW5wdXQ6IEludGVnZXIuIEVuYWJs
ZSB0aGUgcGluJ3MgaW5wdXQgcGF0aC4NCj4gPiAtCQllbmFibGUgOlRFR1JBX1BJTl9FTkFCTEUw
IGFuZA0KPiA+ICsJCWVuYWJsZSA6VEVHUkFfUElOX0VOQUJMRSBhbmQNCj4gPiAgCQlkaXNhYmxl
IG9yIG91dHB1dCBvbmx5OiBURUdSQV9QSU5fRElTQUJMRS4NCj4gPiAgLSBudmlkaWEsb3Blbi1k
cmFpbjogSW50ZWdlci4NCj4gPiAgCQllbmFibGU6IFRFR1JBX1BJTl9FTkFCTEUuDQo+IA0KPiBU
aGFua3MgZm9yIGZpeGluZyEgQ2FuIHlvdSBhbHNvIGZpeCB1cCB0aGUgb25lIGluIG52aWRpYSx0
ZWdyYTIxMC0NCj4gcGlubXV4LnR4dCBhcyB3ZWxsPw0KDQpTdXJlLCB0aGF0IHJlbWluZHMgbWUg
dG8gYWx3YXlzIGdyZXAgdGhyb3VnaCB0aGUgd2hvbGUgdHJlZSBmb3Igc3VjaA0KY3VyaW9zaXRp
ZXMgKDstcCkuDQoNCkkganVzdCBzZW50IG91dCBhIHYyLg0KDQo+IENoZWVycyENCj4gSm9u
