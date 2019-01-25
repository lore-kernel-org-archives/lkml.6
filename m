Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC6C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5105C218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VjZj+YO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfAYJQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:16:34 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12443 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfAYJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:16:33 -0500
X-IronPort-AV: E=Sophos;i="5.56,520,1539673200"; 
   d="scan'208";a="26870514"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Jan 2019 02:16:32 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 25 Jan 2019 02:16:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WZUCY6Di03hKUMa4tqTUJNblkWiVMkuXsp5A2JfJ1I=;
 b=VjZj+YO5EqFQRYghVfN6IiLLIJjDVqn2A2HrXyc1ycPwRl0nzVUYdxlWhAwTv8qqk0ZRMb2jFKvFfR/2v3YZS3EMXohUD5KDTiZNiCyOm9xZJN0NbHLrM7ywg41VmtRsBXvZflkS6Z901jFEUZnV6fcs25wCRa0plSbR3BJqoUU=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1791.namprd11.prod.outlook.com (10.175.53.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 09:16:30 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 09:16:30 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 8/8] net: macb: add sam9x60-macb compatibility string
Thread-Topic: [PATCH 8/8] net: macb: add sam9x60-macb compatibility string
Thread-Index: AQHUtI6ooIMeCW+w8ka7mi+cbTeyLA==
Date:   Fri, 25 Jan 2019 09:16:30 +0000
Message-ID: <2f8d3a0b-fa06-2157-db4b-fc0d6e8d9016@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <dfc7db7606e0898fbedc1f45ed9637379595f9cb.1547629763.git.nicolas.ferre@microchip.com>
In-Reply-To: <dfc7db7606e0898fbedc1f45ed9637379595f9cb.1547629763.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1791;6:neDNziDTvCPXDCDXehdeL0pA7zFyS6SBmxCSL6Oi6v1k/pftUDHCOiZVRz/L3KESTNdIViPU8Mk9Gc06pXq+62f8icluiW2xibmy++aS/1GTS6gCxtcMCkncH8SdynFwBAgjSngXEN12+bH/dLGuoJoG/KhIYxnsozvOcoWJIBjEH/X/buysZDhZEcqUPxPwnDc2lrljV9jY9R0FTaJ+B7s0q1QCR13VTFVDkrd56fP04FPobxp6g20w48LfgsqW5n+YdZSYtQJgwuiLYR/C+LWQWzcJhCZl6nO2P+h/fUIQThcXSnn3orMKLBXLF9J0UySRf+JrE03/++fHtE3ahk6y7DqBfMEkwZfx6L2qLczR7s1BHVz2NfgWbQ4QlZ9Mhkihph0uoy6nKF/hdH3ilwptlPWUZlHTUY7vSlFS8my/pr23KnjF6PoJvrXpu3zfXL6rnRhUQnZp7yEqdW70MQ==;5:rpN70vRuxX+L63oQSFemCRbbPjC/0KLCmRGN7ShdZH1bxfcL7/ocXQOIhMleIIU6w3NWmNMLvRIZaRHxcShKzpHcMtUMkYCFT2m5/GOBw4QxKFM8gYYV/u58eJeHcfiVcrDQvCszOKuikbSTZWxzhkpuelbBgNGgJDvQxzI9mKDAqdOeqkFciekUIOsTqISTfQlzvpwfywe9cf1JB5o4iQ==;7:TOh+CD1lh25u8BJY66/RslCnpeuZLjIkLzoykv6hpKCo+FIC8H4a7+AIwxPYJ5u/RCuDgLecgT75x9uOR7ezq5/63gPPQJCGJL7oMJ+DH0+I2D22vFjMhbxkSnTw2XBwcN+CrrYvcastCrozbhIRbQ==
x-ms-office365-filtering-correlation-id: 0e8005fe-23ab-4233-359f-08d682a5cac8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1791;
x-ms-traffictypediagnostic: MWHPR11MB1791:
x-microsoft-antispam-prvs: <MWHPR11MB17914F8A82C3F18E037C4DEEE09B0@MWHPR11MB1791.namprd11.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(376002)(39860400002)(199004)(189003)(7416002)(186003)(2906002)(52116002)(31696002)(105586002)(106356001)(25786009)(486006)(76176011)(11346002)(446003)(97736004)(2616005)(476003)(2501003)(256004)(478600001)(6506007)(53546011)(6512007)(7736002)(6116002)(3846002)(102836004)(305945005)(386003)(8676002)(8936002)(6436002)(72206003)(26005)(6486002)(229853002)(6246003)(66066001)(71190400001)(71200400001)(81166006)(81156014)(53936002)(14454004)(316002)(110136005)(86362001)(54906003)(99286004)(31686004)(68736007)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1791;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B96gw18J/wncDGPKVpK3DK3p1yoikqaS8WqbUGqNwxAG84ywyuQzMiTQS+cwAQc8NXEIGTBygyvOwyV3CMQltmE5SLsX9Utwu4+D5H+KDBhfBGZpaDdsvtPTZpFD0abVNbKZ0J8j7VN3mUlJtmkXHezQ22JT7vqObbsjODy1CQ2C0BTNp8t+09W7U4GxNNFpLqVhbwGePzxLkjJ5LSjREML8T+WQ1pcM6pEb3xdEoPXfhU+06u0tERjtwK68egVhgs/wImmmRmbRECTze1Zlfs2idelFsXb3nRPZsgU2QFzZNhW3gMvPWmutNc/uuNK9qGNdWscCKv9MQvvWHq28pTZiWT65vzRvDebwZhNlPjskp/Bv7eOHy+BYFec0tYfU/I9lb2Q8EJTcXZ/YfD3dVawYdVYBkzM81RAUjMnTMHk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4A375AA93587C48B64E20C9290C4942@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8005fe-23ab-4233-359f-08d682a5cac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 09:16:27.6118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1791
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCk9uIDE2LzAxLzIwMTkgYXQgMTA6NTcsIE5pY29sYXMgRmVycmUgd3JvdGU6
DQo+IEFkZCBhIG5ldyBjb21wYXRpYmlsaXR5IHN0cmluZyBmb3IgdGhpcyBwcm9kdWN0LiBJdCdz
IHVzaW5nDQo+IGF0OTFzYW05MjYwLW1hY2IgbGF5b3V0IGJ1dCBoYXMgYSBuZXdlciBoYXJkd2Fy
ZSByZXZpc2lvbjogaXQncyBzYWZlcg0KPiB0byB1c2UgaXRzIG93biBzdHJpbmcuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+
DQoNCkknbSB0aGlua2luZyBvZiBwdXNoaW5nIHRoaXMgcGF0Y2ggd2l0aCB0aGUgb3RoZXJzIG9m
IHRoZSBzZXJpZXMgdGhyb3VnaCANCmFybS1zb2MgdHJlZS4gQ2FuIEkgaGF2ZSB5b3VyICJBY2tl
ZC1ieSIgdGFnIHRoZW4/DQoNCkJlc3QgcmVnYXJkcywNCiAgIE5pY29sYXMNCg0KDQo+IC0tLQ0K
PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMgfCAxICsNCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
Y2FkZW5jZS9tYWNiX21haW4uYw0KPiBpbmRleCA2NmNjNzkyNzA2MWEuLmEwODg5ZWYxMDdhMSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0K
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IEBAIC0z
OTQxLDYgKzM5NDEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtYWNiX2R0
X2lkc1tdID0gew0KPiAgIAl7IC5jb21wYXRpYmxlID0gImNkbnMsbnA0LW1hY2IiLCAuZGF0YSA9
ICZucDRfY29uZmlnIH0sDQo+ICAgCXsgLmNvbXBhdGlibGUgPSAiY2RucyxwYzMwMi1nZW0iLCAu
ZGF0YSA9ICZwYzMwMmdlbV9jb25maWcgfSwNCj4gICAJeyAuY29tcGF0aWJsZSA9ICJjZG5zLGdl
bSIsIC5kYXRhID0gJnBjMzAyZ2VtX2NvbmZpZyB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiY2Ru
cyxzYW05eDYwLW1hY2IiLCAuZGF0YSA9ICZhdDkxc2FtOTI2MF9jb25maWcgfSwNCj4gICAJeyAu
Y29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWdlbSIsIC5kYXRhID0gJnNhbWE1ZDJfY29uZmln
IH0sDQo+ICAgCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMy1nZW0iLCAuZGF0YSA9ICZz
YW1hNWQzX2NvbmZpZyB9LA0KPiAgIAl7IC5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDMtbWFj
YiIsIC5kYXRhID0gJnNhbWE1ZDNtYWNiX2NvbmZpZyB9LA0KPiANCg0KDQotLSANCk5pY29sYXMg
RmVycmUNCg==
