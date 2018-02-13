Return-Path: <gaku.inami.xh@renesas.com>
X-Google-Smtp-Source: AH8x226+pw5zO+RmSWvTkRASnIN+C6L0y2WdVGuSnNLhSwWPS5h/GBGdRb7+5EXniU/BoI/G+ni3
ARC-Seal: i=1; a=rsa-sha256; t=1518484876; cv=none;
        d=google.com; s=arc-20160816;
        b=aOLmlZFacIc5/m+dRPjd6FKaHQQcznymy0XKWm4w8gx1oJfW07PKuzHSiNnBTyJnDY
         ahyoNjygFEkuoENr0aYLV0uDeDtFTRhXNFd0/3TLtAt4/W25s3vTr89dOQFdFr5/5oRM
         Gv+bavfIedYVYLtFjx3JCogz8C4lIQS7K1kwjjmCOTTeBwWcAaW3VHfGr6XOV1IFi+Z+
         giIq05pBhfw/ph1W05y2NOvoHmKc25p3n2Od8TInTBakqLkMkMgp4wgBptss3lLv/JjV
         5CS6e7LMWk8ec46f24m9Yw+ojb/p/61vlLiPUVZn+0BEKP01bTb0Ljj15bUq6P2p0/aa
         G9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Rpuz9mbGLYZlHXC+/aUCC3JVvwQQamhoXrUn+MWJZKg=;
        b=d2uGHRqsz+caNk/rgvLkYfnxRG5lMj5qaOOFLby6Sq1kkro56mw/gZCtpGhVo7a1fl
         xWaOYhW71aEXCuftozWfm9vPCo7JfxbJSqLDkY2SoS7Kfgg0KF/oZw1PrbvOKbc06EmQ
         8Sw+RlQUXuWV3XgaSaCPGUpumYosuIYHkggGHOdjHGAJi/OPBuJRKdx7ACLDiJ+3smrV
         BdisTPJxfa2JPSTTrE0mCMwztkG7IpBezfjnA9Tt+I/rpl3vggr/JZgzH0bBvBlnSQ1E
         zIniY59s5LpjUus/81Xz492Wmh/01riz6uHvsVP89qMyTRYlvmMAnpn/CDDT2p5pvXLJ
         jZNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=Plz704vj;
       spf=pass (google.com: domain of gaku.inami.xh@renesas.com designates 210.160.252.174 as permitted sender) smtp.mailfrom=gaku.inami.xh@renesas.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@renesasgroup.onmicrosoft.com header.s=selector1-renesas-com header.b=Plz704vj;
       spf=pass (google.com: domain of gaku.inami.xh@renesas.com designates 210.160.252.174 as permitted sender) smtp.mailfrom=gaku.inami.xh@renesas.com
X-IronPort-AV: E=Sophos;i="5.46,504,1511794800";
   d="scan'208";a="270987530"
From: Gaku Inami <gaku.inami.xh@renesas.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "psodagud@codeaurora.org"
	<psodagud@codeaurora.org>
Subject: RE: [PATCH] Revert "base: arch_topology: fix section mismatch build
 warnings"
Thread-Topic: [PATCH] Revert "base: arch_topology: fix section mismatch build
 warnings"
Thread-Index: AQHTn+3tbNQXQbihz0K1Q0Oi80MtLqOguiuAgADW6oA=
Date: Tue, 13 Feb 2018 01:21:07 +0000
Message-ID: <HK2PR06MB1748717407BF7D42EDC173FEA2F60@HK2PR06MB1748.apcprd06.prod.outlook.com>
References: <1517992328-3559-1-git-send-email-gaku.inami.xh@renesas.com>
 <cd046554-4155-6ed9-8378-fb9ef9e6f9d2@arm.com>
In-Reply-To: <cd046554-4155-6ed9-8378-fb9ef9e6f9d2@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gaku.inami.xh@renesas.com;
x-originating-ip: [211.11.155.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR06MB1666;20:4XMx0a8m8mIHUrqJPiO6Vu1OPn+LowUbmAJh2yvxZVUH1b/57OHz0x7naCMMCYQ7WP21y376rLiVN+X9AfHItp98SoNlDgjugCYYVp1uo8vBGObOqArRwl9A+JYi1tVi8MNtgtG49bXJl3EAY/mjiSrVw8vqspJwnoViznLVTw8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a99cfc94-b217-4548-6625-08d572800f08
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HK2PR06MB1666;
x-ms-traffictypediagnostic: HK2PR06MB1666:
x-microsoft-antispam-prvs: <HK2PR06MB166675E9EC72897EC0B19112A2F60@HK2PR06MB1666.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR06MB1666;BCL:0;PCL:0;RULEID:;SRVR:HK2PR06MB1666;
x-forefront-prvs: 0582641F53
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(13464003)(53936002)(2950100002)(305945005)(7736002)(55016002)(9686003)(53546011)(6506007)(6246003)(316002)(6436002)(66066001)(2906002)(86362001)(2201001)(59450400001)(3846002)(25786009)(68736007)(4326008)(106356001)(74316002)(229853002)(6116002)(81156014)(8676002)(81166006)(54906003)(3660700001)(97736004)(7696005)(3280700002)(5660300001)(8936002)(33656002)(105586002)(99286004)(110136005)(2900100001)(478600001)(76176011)(102836004)(5250100002)(26005)(186003)(14454004)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR06MB1666;H:HK2PR06MB1748.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: iNF+UJX24hqWJysWhok4WqSUuIFxsfW4xwBEGcpbqK3ZGzlO3lVIg8dPLh6Smop6y0BscmnB3R9UXcRQp1nVdA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99cfc94-b217-4548-6625-08d572800f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2018 01:21:07.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB1666
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591730231008876964?=
X-GMAIL-MSGID: =?utf-8?q?1592246797162972607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdWRlZXAgSG9sbGEgW21haWx0
bzpzdWRlZXAuaG9sbGFAYXJtLmNvbV0NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMiwgMjAx
OCA5OjI5IFBNDQo+IFRvOiBHYWt1IEluYW1pIDxnYWt1LmluYW1pLnhoQHJlbmVzYXMuY29tPjsg
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+OyBkaWV0bWFyLmVnZ2Vt
YW5uQGFybS5jb207IGp1cmkubGVsbGlAcmVkaGF0LmNvbTsNCj4gcHNvZGFndWRAY29kZWF1cm9y
YS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gUmV2ZXJ0ICJiYXNlOiBhcmNoX3RvcG9sb2d5
OiBmaXggc2VjdGlvbiBtaXNtYXRjaCBidWlsZCB3YXJuaW5ncyINCg0KPHNuaXA+DQo+IA0KPiBB
aCBJIHNlZSBjb21taXQgODJkOGJhNzE3Y2NiIG1hZGUgdGhlIGNvbW1pdCA0NTI1NjJhYmI1Yjcg
cmVkdW5kYW50DQo+IGJ5IHJlbW92aW5nIHRoZSBfX2luaXQuIEJvdGggYXR0ZW1wdCB0byBzb2x2
ZSB0aGUgc2FtZSBwcm9ibGVtIGluDQo+IGRpZmZlcmVudCB3YXlzIDopDQo+IA0KPiBDYW4geW91
IHBsZWFzZSBhZGQgdGhlIHRoZSB0YWcsIHNvIHRoYXQgaXQgZ2V0cyBwaWNrZWQgdXAgYWNjb3Jk
aW5nbHkgPw0KPiANCj4gRml4ZXM6IDgyZDhiYTcxN2NjYiAoImFyY2hfdG9wb2xvZ3k6IEZpeCBz
ZWN0aW9uIG1pc3MgbWF0Y2ggd2FybmluZyBkdWUNCj4gdG8gZnJlZV9yYXdfY2FwYWNpdHkoKSIp
DQo+IA0KPiANCj4gRldJVywNCj4gDQo+IEFja2VkLWJ5OiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5o
b2xsYUBhcm0uY29tPg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBhY2suIEkgd2lsbCBz
ZW5kIHYyIHBhdGNoIHNvb24uDQoNClJlZ2FyZHMsDQpJbmFtaQ0K
