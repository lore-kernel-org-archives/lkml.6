Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A213ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C73F2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="49uS5HTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C73F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbeKADtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:49:19 -0400
Received: from mail-eopbgr740054.outbound.protection.outlook.com ([40.107.74.54]:37600
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730097AbeKADtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuJfdisEo5v/irCEtXxIQawsVqKM9utloGfyzB8Mvxo=;
 b=49uS5HTW6g1GEP8Rw1vZeyJakpbROwvuxkspRvbLgRH/lk9xXt2VbdI+TYL3ry7/1QrldyNwqMUHyQHnQoe3e+zifbRDQDuJAWqCgWnp0FR6yg+J7YPUePcgYUb4UrDWafT7GfX1rwffXIwvaNn3MwiVLM1XY8rSABhw6HknR2g=
Received: from BY2PR12MB0178.namprd12.prod.outlook.com (10.162.82.27) by
 BY2PR12MB0037.namprd12.prod.outlook.com (10.160.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Wed, 31 Oct 2018 18:49:53 +0000
Received: from BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::1c95:ee1d:3995:439e]) by BY2PR12MB0178.namprd12.prod.outlook.com
 ([fe80::1c95:ee1d:3995:439e%10]) with mapi id 15.20.1273.028; Wed, 31 Oct
 2018 18:49:53 +0000
From:   "Wentland, Harry" <Harry.Wentland@amd.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH V2] MAINTAINERS: Add entry for VKMS
Thread-Topic: [PATCH V2] MAINTAINERS: Add entry for VKMS
Thread-Index: AQHUaaZcZvYYiIbASk6vMZR/M9Fz6qU5wbQA
Date:   Wed, 31 Oct 2018 18:49:53 +0000
Message-ID: <004d6761-b7a3-b7c6-2657-9fd6170412b8@amd.com>
References: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
In-Reply-To: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.250]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0037;20:Ia5kzZ7BtDwOjmDXI5luhkp9iVAPfrwTcZwvX522hWjWwmlas32S2vNg3j/vwevbjrULPN3ekhlR7t+HxJqFbGHC+HBrdRc8vI0/sj+Ru3aoTB/fPCUFlDS6UASfGKngptDH4VNfERQ9X0zZw+b8pRcuw110tf2ahGr3ObaxRuY6aMPJOQJS5UTGG/aukKutlhjbI5ds6J0usqhttyrL81D81LIrt5nDqoCnlcvZ32/nE+9a7/bHg/u+jfsyI4o6
x-ms-office365-filtering-correlation-id: ddbfc03c-1ce3-4344-25a5-08d63f61a4cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0037;
x-ms-traffictypediagnostic: BY2PR12MB0037:
x-microsoft-antispam-prvs: <BY2PR12MB0037A1ADAAFB4665AA4587E18CCD0@BY2PR12MB0037.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(85827821059158)(767451399110)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0037;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0037;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(52116002)(6116002)(2900100001)(3846002)(76176011)(106356001)(6246003)(68736007)(256004)(14444005)(97736004)(110136005)(58126008)(54906003)(186003)(4001150100001)(5250100002)(102836004)(71200400001)(6512007)(53936002)(6506007)(53546011)(386003)(26005)(6486002)(316002)(305945005)(6436002)(7736002)(71190400001)(478600001)(99286004)(81166006)(65826007)(39060400002)(8676002)(72206003)(81156014)(31686004)(64126003)(2906002)(4326008)(229853002)(65806001)(65956001)(66066001)(36756003)(25786009)(8936002)(14454004)(476003)(86362001)(11346002)(486006)(31696002)(446003)(2616005)(105586002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0037;H:BY2PR12MB0178.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9dAcAkOS+7Y8mLdVrTOryv//g2WJQV0w/434Tm46v3v8KeMBVIt+ytwKfUl6YO2VW9yeS3J0FS7Z0IYyIvs4y7iOlOut0ijX+nHWxLLqVpAut7jzsbMxboIcw+CVlV/vS8J+2QRROcdGdQaypYYueSXRNbo/LvD69UWGudoi2jIfD+4qux2dFF2Fhvp78SvaNzNJx9WECBOvT1YUVNCztWxN9vP3C7MorE/aiVTOHOOsu5GOYpKJp3R1quJ+eIvw7z1yIxzaJBl2GKhi57CwMvsN7TPPVaGckLXsVL/m8oJeELtsdefs4CMSjllh/zTp0B7dhq8XWiuGyqQShM07SOv/rl+LZ+TLEwo7zcbW3ps=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE16E0F2BECB4244BB0012ED28873FCF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbfc03c-1ce3-4344-25a5-08d63f61a4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 18:49:53.5343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMC0yMSA5OjI3IHAubS4sIFJvZHJpZ28gU2lxdWVpcmEgd3JvdGU6DQo+IEFkZCBt
YWludGFpbmVycyBhbmQgcmV2aWV3ZXJzIGZvciBWS01TIGRyaXZlcg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8cm9kcmlnb3NpcXVlaXJhbWVsb0BnbWFpbC5jb20+DQoN
CkFja2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFy
cnkNCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gICAtIEluc2VydCB0aGUgc2VjdGlvbiBp
biBhbHBoYWJldGljYWwgb3JkZXINCj4gDQo+ICBNQUlOVEFJTkVSUyB8IDEwICsrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
TUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCAzOWMzZjY2ODJhY2UuLjU2NTcyZjA5
NjhjZSAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4g
QEAgLTQ3MzMsNiArNDczMywxNiBAQCBTOglPZGQgRml4ZXMNCj4gIEY6CWRyaXZlcnMvZ3B1L2Ry
bS91ZGwvDQo+ICBUOglnaXQgZ2l0Oi8vYW5vbmdpdC5mcmVlZGVza3RvcC5vcmcvZHJtL2RybS1t
aXNjDQo+ICANCj4gK0RSTSBEUklWRVIgRk9SIFZJUlRVQUwgS0VSTkVMIE1PREVTRVRUSU5HIChW
S01TKQ0KPiArTToJUm9kcmlnbyBTaXF1ZWlyYSA8cm9kcmlnb3NpcXVlaXJhbWVsb0BnbWFpbC5j
b20+DQo+ICtSOglIYW5lZW4gTW9oYW1tZWQgPGhhbW9oYW1tZWQuc2FAZ21haWwuY29tPg0KPiAr
UjoJRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KPiArVDoJZ2l0IGdpdDovL2Fub25n
aXQuZnJlZWRlc2t0b3Aub3JnL2RybS9kcm0tbWlzYw0KPiArUzoJTWFpbnRhaW5lZA0KPiArTDoJ
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiArRjoJZHJpdmVycy9ncHUvZHJtL3Zr
bXMvDQo+ICtGOglEb2N1bWVudGF0aW9uL2dwdS92a21zLnJzdA0KPiArDQo+ICBEUk0gRFJJVkVS
IEZPUiBWTVdBUkUgVklSVFVBTCBHUFUNCj4gIE06CSJWTXdhcmUgR3JhcGhpY3MiIDxsaW51eC1n
cmFwaGljcy1tYWludGFpbmVyQHZtd2FyZS5jb20+DQo+ICBNOglTaW5jbGFpciBZZWggPHN5ZWhA
dm13YXJlLmNvbT4NCj4gDQo=
