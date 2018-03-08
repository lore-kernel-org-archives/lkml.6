Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtKg8cb5SzSmR8OmJFyof5OwkALVL8RlDRABjKVWn7YsaXIx5BGHgc6Yk7wgKJMVlMVHnZm
ARC-Seal: i=1; a=rsa-sha256; t=1520485577; cv=none;
        d=google.com; s=arc-20160816;
        b=rhOKeWOxKgwrLcb4/jfp6Pr0BqOi8tEifYaW5P10vAr/ZbMTcknXxJ5kPvc1bc3qQo
         nWrRRsdOtgJVTlMUCoS1b3epzT1mqOTWHgN9wEDyIPSZkWzbrhjvP91jPM0RxMFTCAVt
         /nsR6m9C3gU/3t8ZwXxyRR1rLBOPgAROOzetLRJNzz1aDVBmHdwgyduRJuuVC2zt1lGx
         /Nr5uScoKam2FQlzSi3Vm1uoWWs3/nfgn/yor0X/tzhsPbI0BLTfWJ/R3Gz8DXuO8rSv
         srdoeBb5d8wOqL6muAJ8Y2uRgbfUzuGwYLKM5hCfHN6o2u7FgAH+H/irV8Xzo7vAy6pv
         d97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=Ut4Xq4PL+kiSZYl2EcYcf3goS03n+hHyUM9AiAuCobQ=;
        b=CdvVSShgq8DJwd471t8I6gJCOgQU1xBZ6phryR0Wwxgrpl/lUeIVobWb8raGTz8cFr
         tmijstG4ENCgxb1gMdctZ8C8yscN3sMfysbZdRREQ1oAlKDL/T+bVLa38DMgFQ25JHbb
         v2Ql4XgjKRbK5HOAEjXOOg/cUnKCbSj0eiHqWw9A/JU8ssLc8fXGfUtL4rlN3jzRHQP5
         5EzFO+0USkkIllF65uBVsP6qhJw/GlKyf7zshVTmR5ln+FYCvQAuciAOvFefyjiz+Mp5
         NPlroXhFPhMq8OpAs+TlKLcOqfGEATsrHn4hULKrMUX0FXpYoj6NEPAK206IYORyV4f6
         ihZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=cfxD9Bde;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.111 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=cfxD9Bde;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.111 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 059/101] staging: wilc1000: fix unchecked
 return value
Thread-Topic: [PATCH AUTOSEL for 4.4 059/101] staging: wilc1000: fix unchecked
 return value
Thread-Index: AQHTtpqUOp7Jmssx4k6C2bCgWnqyFw==
Date: Thu, 8 Mar 2018 05:01:56 +0000
Message-ID: <20180308050023.8548-59-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:/gippby5Hx9msnaCCyi7xnZcYeZjDloIv5RjQy4v9xn+pDt5no04UOXQU3HSSEtELEkO6vkPkVrU4ZRZMS+B4AfzazpdBCoViEv6f9888hySjTNOU89N2f6yoEXJjHwPe9IFvdY++0FR1nolwy3pjXeUgiLj92tn9YwJjio0zW9n85Z7YMHH7omVIQTdz+JZgRUEMIUWwy4F5pAo/HMQ/kDDQ8d/OqZByoy1GEHvEjBbs4ge15DyUX2UiphREnPf;20:uTt6hyrw7IECPbpLnLkucF7hxbatZQsFQ37fzNVC3KUzuE9E59VXSsBsNQwmJT6zsZtKXH2vgDpKmoPOKxmO/w52OlihDBMWuud79VVHD6EcLjxkIls75lZMVgxJ1kIjDiOOv+ISL8US219T3xs36L6XDptyWlUmgVTKyaenVX8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9302353-f5af-4c36-4115-08d584b2522a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917F852DCAD289F2EE02F9FFBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 5Y27c09oLLuYIiMXhvx5a6ahv8sWd/fcj13YVObH1ppTQ8L3KE/WXJJ4fEBEgtrIvw8Kqd6H+uxb7RfKLvhiUjroDpgfIGOwbR+xTmWXtuMt/AfAs7UY+4zeK9DSbZPyYf6K5JUOqqwamAHNx0bFzlRGVTex9NuJ4qWa7Dp91iMui39ruVQyWZaniQsBrjENPbshqJgkAQLST1b6X0qA/TIZdGPTGLti2S7FOgQ1sXKscY9JKtTzk9JaOwi/SLGvGGXE6rwMf50DPsgw/EhGEl8YWCX+ic8xJfxNLzyr9DSXttUs2jCNnqHhhMvdBd/+2YkQNIR0ZUUFl/++JPrmwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9302353-f5af-4c36-4115-08d584b2522a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:56.3857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344431308014013?=
X-GMAIL-MSGID: =?utf-8?q?1594344684830734759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 9e96652756ad647b7bcc03cb99ffc9756d7b5f93 ]

Function dev_alloc_skb() will return a NULL pointer if there is no
enough memory. However, in function WILC_WFI_mon_xmit(), its return
value is used without validation. This may result in a bad memory access
bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/wilc1000/linux_mon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/wilc1000/linux_mon.c b/drivers/staging/wilc100=
0/linux_mon.c
index 450af1b77f99..b2092c5ec7f3 100644
--- a/drivers/staging/wilc1000/linux_mon.c
+++ b/drivers/staging/wilc1000/linux_mon.c
@@ -251,6 +251,8 @@ static netdev_tx_t WILC_WFI_mon_xmit(struct sk_buff *sk=
b,
=20
 	if (skb->data[0] =3D=3D 0xc0 && (!(memcmp(broadcast, &skb->data[4], 6))))=
 {
 		skb2 =3D dev_alloc_skb(skb->len + sizeof(struct wilc_wfi_radiotap_cb_hdr=
));
+		if (!skb2)
+			return -ENOMEM;
=20
 		memcpy(skb_put(skb2, skb->len), skb->data, skb->len);
=20
--=20
2.14.1
