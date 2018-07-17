Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4BE20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FVzJNf4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4BE20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeGQIgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:36:04 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:51760
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbeGQIgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tcpq45HJQwDk16yqzjdO7wl+Byri4r+ikCxsBGqVBaI=;
 b=FVzJNf4eyHh16EKzFqWtdKz4rc6x9+HIvZ6i2izSh0TgTnhfV0QJH5iev+xdjJUleqytl6OaZCLCDcDla4PcPakVUxw/d07vGIG/e3WTUVXmFMOWhAOAWOc8jeHK6K5wz+eFNZ81muRKe6Ubf6EX+9lqf2/XKP9y3MWtemc/+JU=
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com (52.133.39.11) by
 AM0PR0402MB3940.eurprd04.prod.outlook.com (52.133.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 17 Jul 2018 08:04:38 +0000
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13]) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13%4]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 08:04:38 +0000
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH] usb: phy: fix phy-fsl-usb.c's copyright issue
Thread-Topic: [PATCH] usb: phy: fix phy-fsl-usb.c's copyright issue
Thread-Index: AQHUHZkVNVDoGufEXEuHwGEaFVR2YaSS/4hAgAAIh4CAAALGIA==
Date:   Tue, 17 Jul 2018 08:04:38 +0000
Message-ID: <AM0PR0402MB374793A9EB0D1062242FCC00F45C0@AM0PR0402MB3747.eurprd04.prod.outlook.com>
References: <1531808756-989-1-git-send-email-pengbo.mu@nxp.com>
 <20180717064043.GB1789@kroah.com>
 <AM0PR0402MB3747D31A9362E2DDDDA93030F45C0@AM0PR0402MB3747.eurprd04.prod.outlook.com>
 <20180717074153.GA14274@kroah.com>
In-Reply-To: <20180717074153.GA14274@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pengbo.mu@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3940;6:Sq3RTr4nUPdZw1CB6QytM8+qf6s20ZKN/J+a4yvGVFWg6yW9Hus0Ko+RJSYjaYm0OfFnm4sU9PR9BC3i5JFs+CdYvVYqbLtlBSQ6d276unR4ElkSqrz/hDyeeMjwFUpzSlkK4pa2eEjs1gE+bWeS1YpGJdnzzjBXX+ILIc7BNkEn3xnAEWeP3HTke/PJnZjy03XkyUDOljK2RE/f8Pm9ro8Qjqn7eR7fYvVxCsuDEDf5xIcg4xFLTmJDJKqRhfMFf+s3adj7cjNofvMiAVfz2/u65/zQGsEaj6rusP7WIaCPEyX+/17RV3dWETJ83Gi1fU5H0NX/j3WMl4xr3/OcoRJWpKTMSFJMZVAOHhJAs4d0SUZAKGZGc8p7JOggcF1CYKsbyS/C4YHtd0AyoDHJ1F9MZdbJ9vT3RlGIny7PU+U7Rlh9gnqZW3SCWEq1CGsR7LQEucNUpc5VS7KieLwI3A==;5:x4XJBlcMKMGqZi+PD0IYy6OnET+lSmfd3PZrRdZHG6VSnVriUTQyw/fmS66lvEo1reHugz+HxmpbP6ko5Qc9d01ncd5aQ2UOj+1AlsBP8pH8eUhONF94XtbKI5zWH0+63ebUeBIwmUtb5jtCeRVzARRIXtk0Ia5srMUGAGfKC+I=;7:vsi0Hjywh6pFNMoi7GLaStnH21/KyMfd9Ev4/jutKGyObmkV7tN9AReSnyKO+E4+/5ta5Orqi0COhI2ImWKH5Rh7xP1XqpI5jjFHmJGemjc6xQjFrwUWuk50vzadB5j8mlIMeZeOI7OxO/N+NAeR6LYgRXL85RyXVwYZrxFEBF9YRxAP+BeaworEQcoAdFQvzyi42TmMO4SHCwnE5ITMDV+YpLfIcwnlJfwiGU1I2L8po4jTPFdNCX335ktA4P/d
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bd6c9856-44ae-4d22-c586-08d5ebbbf177
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3940;
x-ms-traffictypediagnostic: AM0PR0402MB3940:
x-microsoft-antispam-prvs: <AM0PR0402MB3940BE9E1BB00CC201CB00F3F45C0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3940;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3940;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(13464003)(54534003)(189003)(199004)(53936002)(6506007)(53546011)(6246003)(66066001)(2900100001)(6436002)(44832011)(76176011)(8676002)(9686003)(55016002)(7696005)(256004)(305945005)(229853002)(102836004)(6116002)(74316002)(26005)(68736007)(14444005)(4326008)(14454004)(86362001)(8936002)(316002)(446003)(25786009)(93886005)(110136005)(54906003)(486006)(81156014)(2906002)(476003)(186003)(7736002)(81166006)(106356001)(11346002)(105586002)(3846002)(5660300001)(99286004)(478600001)(33656002)(5250100002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3940;H:AM0PR0402MB3747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VMZvNK+zE0l5ToaNDkwHa9AP3fEhIUnEm2RhwOzahI15uLDX/7sKazrDragNO/2vqtEMI3gmXYJREdCiGnxdXZxt31eZsIfXyeVjtW0vz2bp7nyFTtn8qaqX5BiEPAFmtlR6QJ2CDYJso5SpyjKaTurfRmqVtRlApYHRDDkmdIBVx8O2VmmLq5jPFD6kFYdJMQpjIS6Gqyr/EvBEmnKpJIP464kTKZvCFx9DxBDKxN2icC5LNODpnt2zDrwmyGQBQcaa3YKhpNC4TIbi5D8QtNK32XWqvRsN6DL+RcMRmPFUR+1BdZXxikQvua5l4kc5QwhZzJrwUtr8gucvBgCCODBzRp8CLwDlv5JlYhgYavY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6c9856-44ae-4d22-c586-08d5ebbbf177
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 08:04:38.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3940
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXBlICwgR3JlZywNCg0KQWZ0ZXIgb3VyIGRpc2N1c3Npb24gLCB0aGlzIHBhdGNoIHdv
dWxkIG5vdCBiZWVuIHNlbnQgdGVtcG9yYXJpbHkgLg0KSSdsbCBwYXkgbW9yZSBhdHRlbnRpb24g
dG8gbGVhcm4gdGhlIHVwc3RlYW0uDQpUaGFua3MgRmVsaXBlICwgR3JlZyAuDQoNClJlZ2FyZHMs
DQpQZW5nYm8gTXUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEdyZWcgS3Jv
YWgtSGFydG1hbiBbbWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXSANClNlbnQ6IDIw
MTjlubQ35pyIMTfml6UgMTU6NDINClRvOiBQZW5nYm8gTXUgPHBlbmdiby5tdUBueHAuY29tPg0K
Q2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IHVzYjogcGh5OiBmaXggcGh5LWZzbC11c2IuYydzIGNvcHlyaWdodCBpc3N1ZQ0KDQpPbiBUdWUs
IEp1bCAxNywgMjAxOCBhdCAwNzoxNjo0MEFNICswMDAwLCBQZW5nYm8gTXUgd3JvdGU6DQo+IEhp
IEdyZWfvvIwNCj4gDQo+IFNvcnJ5IGZvciBtaXNzaW5nIHRoZSBjaGFuZ2Vsb2cgdGV4dCAmIHNp
Z24gLg0KPiBCVFcgLCBpdCdzIG15IGZpcnN0IHNlbmQgZW1haWwgdG8gdXBzdHJlYW0uIA0KDQpE
byBub3QgbWFrZSB5b3VyIGZpcnN0IHBhdGNoIHRvIGEgZHJpdmVyIGJlIGEgbGVnYWwgb25lLCB1
bmxlc3MgeW91IGhhdmUgYSB2ZXJ5IHN0cm9uZyBsZWdhbCBiYWNrZ3JvdW5kIGFuZCBjYW4gcHJv
cGVybHkgYW5zd2VyIHRoZSBxdWVzdGlvbnMgYXNrZWQgb2Ygc3VjaCBhIGNoYW5nZS4gIFRyeSBk
b2luZyByZWFsIGJ1ZyBmaXhlcyBpbnN0ZWFkLg0KDQp0aGFua3MsDQoNCmdyZWcgay1oDQo=
