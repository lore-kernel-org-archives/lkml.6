Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212FCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C619421019
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="YFl7Ukp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfAHQJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:09:34 -0500
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:5190
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728211AbfAHQJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9rKfJzSGIWZuOUdYaFPk+4OMTbAtsDwaA2pIDGvY+4=;
 b=YFl7Ukp7ySQTB5U6oRF1jBvO/U6buaQsf2bk9MY5zhjigQoUfjDRba1Kf7vsWf+w19eLa2dvyu6a2FmJTHp3q4pXw+0OH31v8lNPFpxAVS50OYYUgEoVHNfaLR1z9wWjRmxUsUYlIrCfbebPpmF3Sg6t32r5JyDKOTTh35yDQXo=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3361.eurprd04.prod.outlook.com (52.133.44.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 8 Jan 2019 16:09:30 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 16:09:30 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Topic: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Index: AQHUlt/bwU7HN6OdJEGSFUlfmMcu7qWU250AgBCFWYCAADYNgIAAAQgAgAATRQA=
Date:   Tue, 8 Jan 2019 16:09:30 +0000
Message-ID: <f96952b2-7b19-5397-00a1-0fe9b5800dab@ysoft.com>
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
 <20181228232556.GA14277@bogus>
 <49371bd4-6ab9-31c3-dd48-800becac17e3@ysoft.com>
 <CAL_JsqJyZt=VCv2bX1YYFQt91BcFqDWfeAqkJVcF7eFD0_JM1g@mail.gmail.com>
 <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com>
In-Reply-To: <6fd5ac6a-edb5-a600-3c10-b46a1c1d9906@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0042.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::19) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3361;6:zjgXLtf9tVqHjuIVNlGWx4AJKpZzshF55ZOY822yy+e/7zqU/PWMKuM/YHgLIXOYNjw85csxFxt/17wKxQ5TVTRcTvisovVXv216Mj+EI+JJFzZMsewuyTXTaU5E37r8Bug2JSk6FLxrjKnQlhu637vqOZV9AskY+mJk2EDtOnZ0UVB97gjDFNGY5FRb0GDOJhcZJvTPTwTL3LX+kLSkF7bsrc2c86QXFjSXgbmZAAZhQZuFkuOmGAJC+ObcB5U6UO5rSaj1tm5LCMXNDL+nPpVlRfSl1sHeAI7InGuyW43/hn0NkNk8ib1abqtzi75rX1fDWHdH66WDRFgH+pSF840qsOFAnkCPCng8rtrkYwj4vAbuFa5Sg21BgEt7SFm+7hBOz97AhjR7iiml6UHSOcuBF31D1Jyc4ZRxmT6Y/fpl87iK0SvGGVQzHxwed0G0sbaF4MALTbPPORPlVljHrg==;5:YAwPnri4h19rbJ4VPUqXLx6XGuzGsD9fGuX8i+9nPp7HOJOjR5/itHxY6jrRJu4CN0i50QCz5k/tWyl8GTRVSxi2L32maCAN894JDofkBpDoNDdKW2mgF3kw2gcWWdPkrJ3t7bsFYMhxKiQTgIXBz94YGIrB/1lkW+7N8du5VFVoYZtylNQiNTeUZwSTZi0wWmDf/Bj3Y+/jwiuL5DYQow==;7:qxBmQxMPpFEoeCwIsPnKe/2OlT6Sf9UrU+nLdOV4JCwTv6h1y4xkp/7e+ZFsy0O4ZTGOn/GS7fe8ZBWaWduKVmYWRS78vPrARlmll2+RKEp7k46fT4zsgd9XdxM6paxxcXPmfbJV8AUFIUV4TrW3zg==
x-ms-office365-filtering-correlation-id: e9650519-2aec-423f-ecc0-08d67583ab85
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3361;
x-ms-traffictypediagnostic: AM0PR0402MB3361:
x-microsoft-antispam-prvs: <AM0PR0402MB3361AFE4172584963CE8DD129E8A0@AM0PR0402MB3361.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3361;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3361;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39850400004)(189003)(199004)(2616005)(99286004)(85182001)(6916009)(476003)(93886005)(3846002)(11346002)(229853002)(6116002)(305945005)(81156014)(81166006)(7736002)(8936002)(8676002)(6486002)(6436002)(66066001)(446003)(6506007)(386003)(53546011)(68736007)(102836004)(2906002)(14454004)(25786009)(36756003)(478600001)(316002)(486006)(26005)(256004)(5660300001)(97736004)(186003)(72206003)(31696002)(86362001)(106356001)(105586002)(6512007)(76176011)(52116002)(71190400001)(71200400001)(53936002)(31686004)(6246003)(54906003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3361;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QOfSCdwqeQ0Gc3DehHASMrmrwn2/hLNoUuudMcJOmirkzkZvHytVsfWoGncRxJ2PvS3+J79xRU/RmGSPjiazuEXgSuGhtSPRNzfmliNG5h1DTQrT78LuuZ9UQoXx9zq24JFhWz+ah7czuZIlm101DXmV3xYUxUjPaoHXlPHPSfoCCT1Wrs/DP6NMfCM5ndVsWuVT4ms3Ipnnfx4z+bw0RkyLDPMbk6bAmtNUdedSXiHpWBlkYqrMg+L27iZyJ2HkiQXqenLFLSMfP6tOTnI/c2yRb+kl//ABgtb3npRaF2mcOIF5HmBlL2CjJdmEtnwV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3AEFEAD395B954291955C5469C50AE0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9650519-2aec-423f-ecc0-08d67583ab85
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 16:09:29.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC4xLjIwMTkgMTY6MDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0KPiBPbiA4LjEuMjAxOSAx
NTo1NiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+PiBPbiBUdWUsIEphbiA4LCAyMDE5IGF0IDU6NDMg
QU0gVm9rw6HEjSBNaWNoYWwgPE1pY2hhbC5Wb2thY0B5c29mdC5jb20+IHdyb3RlOg0KPj4+DQo+
Pj4gT24gMjkuMTIuMjAxOCAwMDoyNSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4+IE9uIFR1ZSwg
RGVjIDE4LCAyMDE4IGF0IDAyOjQyOjExUE0gKzAwMDAsIFZva8OhxI0gTWljaGFsIHdyb3RlOg0K
Pj4+Pj4gVGhlc2UgYXJlIGkuTVg2Uy9ETCBiYXNlZCBTQkNzIGVtYmVkZGVkIGluIHZhcmlvdXMg
WSBTb2Z0IHByb2R1Y3RzLg0KPj4+Pj4gQWxsIHNoYXJlIHRoZSBzYW1lIGJvYXJkIGRlc2lnbiBi
dXQgaGF2ZSBzbGlnaHRseSBkaWZmZXJlbnQgSFcNCj4+Pj4+IGNvbmZpZ3VyYXRpb24uDQo+Pg0K
Pj4gWy4uLl0NCj4+DQo+Pj4+PiArLyB7DQo+Pj4+PiArICAgIG1vZGVsID0gIlkgU29mdCBJT1RB
IERyYWNvIGkuTVg2U29sbyBib2FyZCI7DQo+Pj4+PiArICAgIGNvbXBhdGlibGUgPSAieXNvZnQs
aW14NmRsLXlhcHA0LWRyYWNvIiwgImZzbCxpbXg2ZGwiOw0KPj4+Pg0KPj4+PiBBbGwgY29tcGF0
aWJsZSBzdHJpbmdzIHNob3VsZCBiZSBkb2N1bWVudGVkLCBub3QganVzdCBTb0MgdmVuZG9yIGJv
YXJkcy4NCj4+Pg0KPj4+IE9LLCBJIHdpbGwgYWRkIGEgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS95c29mdC55YW1sIGZpbGUgZm9yIHRoYXQuDQo+Pg0KPj4gQWN0dWFsbHks
IGl0IHNob3VsZCBnbyBpbiBmc2wueWFtbC4gVGhlIGZpbGUgZm9yIGV2ZXJ5IGJvYXJkIHZlbmRv
ciBpcw0KPj4gZ29uZS4gaS5NWCB3YXMgcHJldHR5IG11Y2ggdGhlIG9ubHkgcGxhdGZvcm0gZG9p
bmcgdGhhdC4NCj4gDQo+IE9LLCBJIHdpbGwgZG8gc28uIFRoYW5rIHlvdS4NCg0KSSBhbSBzb3Jy
eSBmb3IgdGhlIG5vaXNlIFJvYiwgYnV0IHlvdXIgImR0LWJpbmRpbmdzOiBhcm06IENvbnZlcnQg
RlNMDQpib2FyZC9zb2MgYmluZGluZ3MgdG8ganNvbi1zY2hlbWEiIHBhdGNoIGlzIG5vdCBpbiBt
YWlubGluZSB5ZXQuIFNvDQp0aGVyZSBpcyBubyBhcm0vZnNsLnlhbWwgZmlsZSB0byBhZGQgbXkg
Y29tcGF0aWJsZSBzdHJpbmdzIGludG8uDQoNCk5vdyBJIGRvIG5vdCBrbm93IGhvdyB0byByZXNw
aW4uIFNob3VsZCBJIHNlbmQgdGhpcyB1cGRhdGVkIGR0cy9kdHNpDQpwYXRjaCBhcyB1c3VhbCBh
bmQgY3JlYXRlIGFub3RoZXIgcGF0Y2ggd2l0aCB0aGUgeXNvZnQgY29tcGF0aWJsZQ0Kc3RyaW5n
cyBhZ2FpbnN0IHlvdXIgeWFtbC1iaW5kaW5ncy12MiBicmFuY2gsIHdoZXJlIHRoZSBmc2wueWFt
bCBmaWxlDQpleGlzdD8gT3Igc29tZXRoaW5nIGVsc2U/DQoNClRoYW5rIHlvdSwNCk1pY2hhbA0K
