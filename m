Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246380-2-13659264582355796866
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
    1523246379; b=MX0fjhArJ95A6hBt9KQxe/KV6lDrumX8PW6soupgjeSc7MpCKb
    rUOEY/6uJMB7jkKXkBlodBSemgHu8NR0IQ3gRJu/1jBPuds9XC5BV0Um3zB2GIvm
    Gfih3HufNLU7MeI9qj6m8CKDGH5gpPofxEMnerH6to9y9lLIPLNy/Kf7aQjyWCR3
    UQ7ZC8r6dsozIR5bx2rHl27F7XgKqHrYnD8DjexvCe/CZ2gJI8ltgWfAoxA+TS62
    wqLYx2h1wPKdfvyysIOzvSGFrF7A6tvCwUqP+Zr95hFbwkomnQEOfdH7pNNus6A3
    nAjdneB99TOTNe5EWxryNcsyNJHfz42uwEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246379; bh=UsGar6ggRL
    ZuBaiFto+bDBQ9gwJRGx7wY1pvF3IPzf8=; b=uJAIHpZbgEq7cxnlKHp7KZCHhw
    gEO1PAJMW6Ws085zsCUqR67lpvuXJUsQdQgqskrujwgh6CpR0AmNfUM11LnvufVk
    UT/G6F4etnnFtozPBhodpEjx0/CdSO/t80jrGgRyk01CSHHwjsCR2PBJhODanw3S
    TR3y/x0oERVTzP4786Np/23+DcAAWUp57QqStZbKfY8uBaBCHy0CC3JLR18o6PsM
    nJRDBDepmEM+NsV52iwsBYzslx00YGyQBka+hqqKlz4CgQnwMVEM8kgM5ksQKyPe
    GbT1TQQNeU5ETToK0h2mmyvoqw9yqDnZD92wUtfS6uFILyN4hsKzZ1AdMquQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hmq1dj0F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Hmq1dj0F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHOkjS1hs9O8Za0phXTYwNR+vKRvAZGa9//qUyewo6e5Db7zcAOQIaRIPyoXVWL+R3ag0rUEws2TBkIdEElhD33UIaNOKj1h3TG+9IvatgIs3A5Q1bYT
    98DxDuSd0IzoF53UNrN4QadG7hGhtSiXeAmvawhkMGD8ntumuhq3bNbgMH9ti4TGCzsFb08ZoltUhGOLOgfhudGprUmJ4Fqi+i+k37UdIs1nE3R02WS/pJrj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=k0PnuNMsIyS_oRYzJ3sA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeDID7K (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:59:10 -0400
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:30557
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753645AbeDIASg (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 069/189] f2fs: fix to update last_disk_size
 correctly
Thread-Topic: [PATCH AUTOSEL for 4.15 069/189] f2fs: fix to update
 last_disk_size correctly
Thread-Index: AQHTz5grNxn16xWUIkCJh9BYzrhgdQ==
Date: Mon, 9 Apr 2018 00:17:39 +0000
Message-ID: <20180409001637.162453-69-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:I1SkAK8T9qYOQz0T0V8JL5jegJub3rUVee4v6dCUdtPt2kip1Hz+ZmduJ5RS6XntWxJywq5sygL1dXGuuE+mDhzAnYdaUmotkQg8m42V1Sg/WXF8/gM0yVThudtPSlG106/+/k4zG+N0ORd16rm0FUFMfp4BIqdzbdB9HmFg4CaxAgXJms5Yd37SP6SYj/v2olgcsLS0BIkXD3g2fFtevrf9YQLxBI21mXxrFs2PSx+4Xc0B57btSHI60SPdj5uB;20:BxP1ur1D3XsgSMJ5USEjX1jA2JXNWDvQ5+7kp12AUlwfRP0tp7sGG5QZxtnf6d5YWc63MS8WRUI4zfWUtejopxRiaR7vZRisBjWPg+k3t976Pml+n/Wf0GwW2xgwM40T6kPgADjg7qJh5czSTArmUQ949NJ0yczsFiLJet2i3Qc=
X-MS-Office365-Filtering-Correlation-Id: 33f41473-c1be-4d6c-b05c-08d59daf6d59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046A6B6F9CB872403EE94BCFBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(575784001)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(15650500001)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8G8dTSBU/65rwiIOY8aBBl9fkIbLhF8nw91iXp4cCsg7oLnA/k/9HATO4xZtinBmAjSC238BKi6e0WzapL5XCOpE97R4S/kcNFVKGngVVcVUv0hk9vDbwthPUQ2nN+PIJjW70IL7FrNiAN54p6An984/FYNcpDKLpiIxcVdVan2Jr/aZKnTarp+XdwwowLn/I1dd8TTJWibhMQfpCAC9eNbvd5RpTKRYh05yhAH4308Q2nO+iR/vPZnJtEDN9F+hypOTp4wfR/+yoG28W1CPA6zsM7JPS4KxxB1ojaa9wOsojN6byO9ZO5WDaSlsU7DFPoObharBMz7RqvGTBtMRCD5E/SbIN3Zddj0rymMnZUJZssfPeJdLCsCMSHc3psbF3KAI9lcMF+BUgg5oO9wCj6nRiAuBBpvwVwEjCwoCQpg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f41473-c1be-4d6c-b05c-08d59daf6d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:39.4305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit eb4497975e82448746bb7de3d13b743b7145aed7 ]

This patch fixes to update last_disk_size only when writing out page
successfully.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/data.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 516fa0d3ff9c..3399ddb723dd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1571,10 +1571,14 @@ write:
 		}
 	}
=20
-	down_write(&F2FS_I(inode)->i_sem);
-	if (F2FS_I(inode)->last_disk_size < psize)
-		F2FS_I(inode)->last_disk_size =3D psize;
-	up_write(&F2FS_I(inode)->i_sem);
+	if (err) {
+		file_set_keep_isize(inode);
+	} else {
+		down_write(&F2FS_I(inode)->i_sem);
+		if (F2FS_I(inode)->last_disk_size < psize)
+			F2FS_I(inode)->last_disk_size =3D psize;
+		up_write(&F2FS_I(inode)->i_sem);
+	}
=20
 done:
 	if (err && err !=3D -ENOENT)
--=20
2.15.1
