Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fVLnaJz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C21B060555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeFFKYH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:24:07 -0400
Received: from mail-ve1eur01on0056.outbound.protection.outlook.com ([104.47.1.56]:2465
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932332AbeFFKYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:24:05 -0400
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] ASoC: ak5558: make two structures static
Thread-Topic: [PATCH] ASoC: ak5558: make two structures static
Thread-Index: AQHT/XzJF4V4HKcWuEKxXAQrYhmqEaRTBf4A
Date: Wed, 6 Jun 2018 10:24:01 +0000
Message-ID: <1528280640.1938.22.camel@nxp.com>
References: <20180606095719.30831-1-colin.king@canonical.com>
In-Reply-To: <20180606095719.30831-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2861;7:1sG/mYI6xlS0FIS1AH+fzNSOhcryOXRsk6Es5CSpYUVJk/m2fvYAw++uFNTR8H6eKuhwJ5ABCjtOwFjOFvbMq6rR0UeEzyPJlUm7HeT0eo1dfglVFLBSkt6Fo4vIYy1W2QCKhKr6d3IlEIcN5Vna8FvMlfJHd3ePM8GT2sZTPfpZX8/+wFgIFq+CfXqlGs0Chc5TyPdUrsKoVDTCUSsmJoAvbRZq1pjC1sjjecnH5xZgvDgzNqzMG8vgTyNIH7y6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2861;
x-ms-traffictypediagnostic: VI1PR0402MB2861:
x-microsoft-antispam-prvs: <VI1PR0402MB286103500BF1FDD75D093F11F9650@VI1PR0402MB2861.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0402MB2861;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2861;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(396003)(39860400002)(39380400002)(346002)(189003)(199004)(6246003)(39060400002)(7736002)(6116002)(97736004)(3660700001)(3846002)(53936002)(6512007)(3280700002)(106356001)(478600001)(76176011)(2201001)(25786009)(14454004)(4326008)(8676002)(11346002)(305945005)(66066001)(105586002)(36756003)(86362001)(44832011)(6436002)(68736007)(102836004)(486006)(59450400001)(5660300001)(99286004)(2900100001)(2501003)(6486002)(476003)(81156014)(81166006)(2906002)(229853002)(446003)(8936002)(54906003)(26005)(6506007)(186003)(316002)(103116003)(110136005)(2616005)(5250100002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2861;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9IoyWBKn/+fKbfaVkN0/9MhwezeanB/4jV1AYHb33XVrXjpheApYlyTO/LAAhUa3GuqA0Dd6G1/aRuLtUzcl2t7YuPjiKNhp7MWUYuyPEmTsTiedag1gmZZ2OUBXTCJqT6QJzAsG1F+5Z+o5OrBDtaOmWgl5HPNWBsfZQhXUCRN1ue6jHxiPuz2Lwz8O8hzA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A7C52DFD8EFA94C9DB4D69558B9353A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9f243b6f-02a8-4a88-c82d-08d5cb979f39
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f243b6f-02a8-4a88-c82d-08d5cb979f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 10:24:01.3095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2861
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWksIDIwMTgtMDYtMDYgYXQgMTA6NTcgKzAxMDAsIENvbGluIEtpbmcgd3JvdGU6DQo+IEZy
b206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGUg
c3RydWN0dXJlIGFrNTU1OF9wbSBhbmQgc29jX2NvZGVjX2Rldl9hazU1NTggYXJlIGxvY2FsIHRv
IHRoZQ0KPiBzb3VyY2UgYW5kIGRvIG5vdCBuZWVkIHRvIGJlIGluIGdsb2JhbCBzY29wZSwgc28g
bWFrZSB0aGVtIHN0YXRpYy4NCj4gQWxzbyBtYWtlIHNvY19jb2RlY19kZXZfYWs1NTU4IHN0YXRp
Yy4NCj4gDQo+IENsZWFucyB1cCBzcGFyc2Ugd2FybmluZ3M6DQo+IHdhcm5pbmc6IHN5bWJvbCAn
YWs1NTU4X3BtJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiB3YXJu
aW5nOiBzeW1ib2wgJ3NvY19jb2RlY19kZXZfYWs1NTU4JyB3YXMgbm90IGRlY2xhcmVkLiBTaG91
bGQgaXQgYmUNCj4gc3RhdGljPw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcg
PGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERhbmllbCBCYWx1dGEg
PGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCg==
