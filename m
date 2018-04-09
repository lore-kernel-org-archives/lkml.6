Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246232-2-5785181092250863252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246231; b=qEJ1rDXth77+wBrX/UumHPZw1wgKyBbwJw9UtoWX5dAhC8coGT
    O+Bc6NYAtq3RfuRcjZjN/4zi4JnWU9GLwgTqLQmvHTOAML/Bielj+A4do9cyhhHy
    HGlh4loUSlQajxAAVBDj51xceAaEaOd5nk5hFFIlKNURTGSMQZJeAipa9iAFKliD
    QGXM8docvf/mPMkvh1TcQO686mFXuesvtyJc87cyWbLgt+9KUPsF0vwL6HwVWPsu
    h987xbmZb8sLBtFucbM81aTVPJBhJbgvP/uXaspyLR0lHcDRtA0cyCi2i9vg2r1U
    n7dlLbQP6Mnzn4to1TEyp08D88vckZFgSW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246231; bh=l7QLeaZOp2
    MGIRf37C/5jbE6fbuU79IIZD7eQShu9rU=; b=TuQdpNigVxgvBmAVEZkk2hFB2P
    yN8uIjZZHauI05GWXuHysur6X+XittEWTH35lcB9nkfh2ulmfcyO9bye+u5POHGU
    2PP+jC+qwbe9e1BdzFFJfkAV3cz8kRYnaAnin/valFMijRMUwSXryWoCEZ4puqdR
    hwKIhTwKcH+JZMdurpWKytEr2KDrp3/BUnPhf7kn5h+FTi+cl0OiZHYyUF1KoU2U
    WxX6QnUT563jP4fu/fff7CS3tsajaMNC3qQj7tXuX064mr+LYCJ9G+IgBRHW5ltl
    dTQN3q1mcW+mb0muVMp3feXANf46tNqlzqDrcORqiNYbxmAUI+12i3qkC91A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=erz3rLZw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=erz3rLZw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE0WQO2jeQHrL58Q+C2gl+IEYnXe2Fift/SnQ6agdIXapFq6OFY/qlLM4oMNZiCjsTdLP92+k0yTsPcGB2vOnl8uiiplFDejxdD2cQtu0iMT6Z/2FrCR
    o/FQt6txVdJ3qXiRRsl1nuYXIUZCzssWpJmB+34LGc+b7CUkQfHvBS1qi3Rqjmf8W56eXNBGtz7ziJhUCCVMtEot+qQIVMiGWOfiOO2gEiehPwf4/jichhLi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8 a=N8YU52xSM6bygaFl0ccA:9
    a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeDID5I (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:57:08 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:59343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753734AbeDIASn (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 077/189] bpf: test_maps: cleanup sockmaps
 when test ends
Thread-Topic: [PATCH AUTOSEL for 4.15 077/189] bpf: test_maps: cleanup
 sockmaps when test ends
Thread-Index: AQHTz5gvY6+/mPJBP0SkasRQdlmrPQ==
Date: Mon, 9 Apr 2018 00:17:45 +0000
Message-ID: <20180409001637.162453-77-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:lmQESi4yIS0q3H9KDpdBZrtMWTtdoRPdvVBJlqqpz8oKz0qPMuzoN8PiwOwNurimBL1pNToBQ7SZdd54gri/bbDeKVyOyWpZwcEd2bfJUpAtRQK6Cr27c4NmMY9AJcNJbDcf/FEGwptP+FDzumerwKy/7VUcpiZx2oH+nPMQ4ptuStJNXTuxdNB+beRhQ8nKjeGityOMUG3C5BUK3ZJ/8od/kSQBX1/dlaiOqXGHQN1b65dA5K18YjG2sjLyyv76;20:9Wv3iQ1ZHwGCcLeGewyRHgWUimkVcURSdRIasuWWBnSEdsfX44cTS2QJDFORoDzNopArk8CLmw51gfflUDnEHp9k5GSudfp3d/IgeJg0Pt65NXcYS1MJjOl5cTVxftfhcd5bMm71Aopd7NpsgL8ehuxi3dFRZ/cdSKjkSba5+ko=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0553a64-07e5-49f5-d53f-08d59daf7011
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112846032D3523B50ED97F1AFBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 1dInFrmFqx3WPmuCid8kOJCGoPwtpdbCyx6x5whSrCwZjvsrwwEGsJAG4nfZnRKxdu1Oys3uqqUk93rmjiAFvyl8/cELsUqb8jKGJfOYyvA+Dbtom59Zm7B4vXmczSeW1rt3h8ZVjI/pNKCM53OmXDsQg8XP7M3Zomj2SObRjvZDDf13FsJk/RpOzwYpy7bK3L21tRLMZXy7hkpIrm51o2QY/pQlSElc0Qk4ZfTn7y9oWvNKpGAqNGJLBXw//CM4IjP9BCpY117bk6uEvB7NKZ9Q8BaR6MYoiQBFcSw3ZQlEjEYZlTKHJVxos5AAoaaFtRCJ6ou9Ou7eXsSrsjSTgzSXIV/uXGUTG/a1vnREJA3S8306HG4fN/WTIvGTr740aHEA19FT6tx1bnCmNUE/6O8PEj7JAAZ9hCKObLqWwzk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0553a64-07e5-49f5-d53f-08d59daf7011
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:45.7268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>

[ Upstream commit 783687810e986a15ffbf86c516a1a48ff37f38f7 ]

Bug: BPF programs and maps related to sockmaps test exist
in memory even after test_maps ends.

This patch fixes it as a short term workaround (sockmap
kernel side needs real fixing) by empyting sockmaps when
test ends.

Fixes: 6f6d33f3b3d0f ("bpf: selftests add sockmap tests")
Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
[ daniel: Note on workaround. ]
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/bpf/test_maps.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selfte=
sts/bpf/test_maps.c
index 040356ecc862..5fb1355f80fc 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -463,7 +463,7 @@ static void test_devmap(int task, void *data)
 #define SOCKMAP_VERDICT_PROG "./sockmap_verdict_prog.o"
 static void test_sockmap(int tasks, void *data)
 {
-	int one =3D 1, map_fd_rx, map_fd_tx, map_fd_break, s, sc, rc;
+	int one =3D 1, map_fd_rx =3D 0, map_fd_tx =3D 0, map_fd_break, s, sc, rc;
 	struct bpf_map *bpf_map_rx, *bpf_map_tx, *bpf_map_break;
 	int ports[] =3D {50200, 50201, 50202, 50204};
 	int err, i, fd, udp, sfd[6] =3D {0xdeadbeef};
@@ -868,9 +868,12 @@ static void test_sockmap(int tasks, void *data)
 		goto out_sockmap;
 	}
=20
-	/* Test map close sockets */
-	for (i =3D 0; i < 6; i++)
+	/* Test map close sockets and empty maps */
+	for (i =3D 0; i < 6; i++) {
+		bpf_map_delete_elem(map_fd_tx, &i);
+		bpf_map_delete_elem(map_fd_rx, &i);
 		close(sfd[i]);
+	}
 	close(fd);
 	close(map_fd_rx);
 	bpf_object__close(obj);
@@ -881,8 +884,13 @@ out:
 	printf("Failed to create sockmap '%i:%s'!\n", i, strerror(errno));
 	exit(1);
 out_sockmap:
-	for (i =3D 0; i < 6; i++)
+	for (i =3D 0; i < 6; i++) {
+		if (map_fd_tx)
+			bpf_map_delete_elem(map_fd_tx, &i);
+		if (map_fd_rx)
+			bpf_map_delete_elem(map_fd_rx, &i);
 		close(sfd[i]);
+	}
 	close(fd);
 	exit(1);
 }
--=20
2.15.1
