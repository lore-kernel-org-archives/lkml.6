Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96FCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64134214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DooJlTAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64134214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeHVJUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:20:55 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:42788 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbeHVJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:20:54 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 22 Aug 2018 14:57:31 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 8603668901;
        Wed, 22 Aug 2018 14:57:31 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,272,1531753200"; 
   d="scan'208";a="288727056"
Received: from mail-ty1jpn01lp0183.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.183])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2018 14:57:31 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uye6Ixz2IeAVaY/iFlWEL48gC96UiirBA3rYPq5x5kA=;
 b=DooJlTAE2rlSfYDl4+fgmBpjmAN3Rg4Myb/4CkyF5PyfpkdmxVeY0+Mf4yjgiY9um2tyJNWIZpwinsNkh+iCe7YXXMqkPuG36WUZcNcc7bv2WEHmFcXUuUTv8OkRr8EWEH9Fu4xEZdNnOO9HI1saNuHZL+HC/6Su1T2KCUwdwAY=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB1637.jpnprd01.prod.outlook.com (52.134.226.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Wed, 22 Aug 2018 05:57:29 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723%2]) with mapi id 15.20.1059.023; Wed, 22 Aug 2018
 05:57:29 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/11] phy: renesas: use SPDX identifier for Renesas
 drivers
Thread-Topic: [PATCH 07/11] phy: renesas: use SPDX identifier for Renesas
 drivers
Thread-Index: AQHUOZq3kUkNRFeWK0qp3d7XY0f2xaTLRlqw
Date:   Wed, 22 Aug 2018 05:57:29 +0000
Message-ID: <OSBPR01MB22937B2576B9712C0721DD0FD8300@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-8-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180821220233.9202-8-wsa+renesas@sang-engineering.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1637;20:mDN7xFGMofDtHKSUGjr8L2DVBwZZv1b1czeWZpuhR9GEwo8A06m7gWJPTQycJ5haQ0cnY9HBg0DjgCDmDg4PeOKTnkxJ/is/SiAyVnMbC22UGejD8SqgIc/wzlllnr7bwgynIopVjeDLL9X95XU4ihSyU2hkCZfGaQADOxFWqmI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 91db3000-0bf0-46cc-3a39-08d607f4252e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1637;
x-ms-traffictypediagnostic: OSBPR01MB1637:
x-microsoft-antispam-prvs: <OSBPR01MB1637D0A3241E8333468DF45BD8300@OSBPR01MB1637.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:OSBPR01MB1637;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1637;
x-forefront-prvs: 0772E5DAD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(396003)(366004)(346002)(199004)(189003)(99286004)(39060400002)(2906002)(8676002)(446003)(11346002)(14454004)(478600001)(74316002)(76176011)(25786009)(110136005)(345774005)(54906003)(55016002)(2900100001)(105586002)(33656002)(66066001)(5660300001)(6246003)(7696005)(6436002)(9686003)(316002)(4326008)(2501003)(97736004)(106356001)(6116002)(229853002)(486006)(476003)(102836004)(256004)(558084003)(305945005)(3846002)(86362001)(6506007)(81166006)(81156014)(8936002)(7736002)(26005)(68736007)(186003)(5250100002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1637;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2KL71HySYJFkFy8RKMvWnZfmA89H0GPh8o8jQQDwdfQJ0XT0EH6+CLDYu0xnrS9SOMw+HSOxp9j6tjsaLau3RGZFzzXXNaP/YnI+2ntNDySDT7S41rSZ69unxSqqG8042K6CMmIxriJ4r4rCloPxsnV9JvpesHRlfsUWOYOy3S/U8gKoDhhdhr3QBSh3g6q+kBZJnhZmzrr4Lb+yHpwPq9UoQ9W+cbEePJbtVzjEeUCj0tWE+vlZ4ws/VVwdP2qNlEcr0DnUpUjQkWlpRhshkvktMuIugPLW7TFT17OSwDP3dZPchk26ltrrsxlQwasn7kjoXJxrqvlx3OOjmCE/8fIVWubbtxZtq5yZ1ey3xPs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91db3000-0bf0-46cc-3a39-08d607f4252e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2018 05:57:29.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram-san,

> From: Wolfram Sang, Sent: Wednesday, August 22, 2018 7:02 AM
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Thank you for the patch!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

