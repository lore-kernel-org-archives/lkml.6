Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E33C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1118D2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I1YS+rmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfBDKhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:37:06 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38752 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbfBDKhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:37:06 -0500
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="23388022"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 04 Feb 2019 03:37:05 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:37:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDkG6Rt+GD+8ix9bcua2DGLJn7+6rqYT5zZzu2ys9Fs=;
 b=I1YS+rmgnFeJqFAU8AMB42cC4sXDnmBEUXVlAm1ORPBSevu4NC+Pe0UHOMGycUbDcDvjtt8hV0ff5nmXHGdrXno2Qu35QwyUNpYmNGK0H+GA6anHRSTTM+D8kt9YwK/VBMQ96T2ZMeHjpxJDX6ZTT40Phdf/YaczPlpPpYrHtP4=
Received: from BL0PR11MB2897.namprd11.prod.outlook.com (20.177.146.210) by
 BL0PR11MB3442.namprd11.prod.outlook.com (10.167.240.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:37:03 +0000
Received: from BL0PR11MB2897.namprd11.prod.outlook.com
 ([fe80::143:81d6:8bef:ce45]) by BL0PR11MB2897.namprd11.prod.outlook.com
 ([fe80::143:81d6:8bef:ce45%2]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:37:03 +0000
From:   <Mahesh.Rajashekhara@microchip.com>
To:     <aacraid@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: aacraid: clean up some indentation and formatting
 issues
Thread-Topic: [PATCH] scsi: aacraid: clean up some indentation and formatting
 issues
Thread-Index: AQHUuuPQcjCaM1z5Qkm7uOUQc/NbPaXNTMxkgADeQxCAAUksMA==
Date:   Mon, 4 Feb 2019 10:37:02 +0000
Message-ID: <BL0PR11MB289749AD4D35250355C72423FE6D0@BL0PR11MB2897.namprd11.prod.outlook.com>
References: <20190202104052.16552-1-colin.king@canonical.com>
 <7293537e-5619-4e08-846d-d5016001d891@email.android.com>
 <BYAPR11MB322448EB89EA76E8727A92B3E26C0@BYAPR11MB3224.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB322448EB89EA76E8727A92B3E26C0@BYAPR11MB3224.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mahesh.Rajashekhara@microchip.com; 
x-originating-ip: [111.93.137.110]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR11MB3442;6:fLRkdwUhFA1NxD3ZhdLZdVB5DXTrW5D36gClAmpKkcVHnfrBdXY7f5C0hW6zNocXsJvkryVxgueg/aiEgTCVUUpROE7XBEJ3N7db7d8OJ58OCrpeZ/3Cy1z2Hv3cIokNcL3yezGm0TZfNcVRR8DQxHTRSbOlAYde0iH3LRcX40rx4ZCzkq71tfQ79DocOFSNhndIApoxqVB3NNYo2FZfChDxfyKToTMQz0zQ5EDe+E0bKnVLnFxybUQD3KaVslKmeDiGIRg+lP4H6gidVftICvLsUUlrTCjjGhJ0pk+uFsubUnex7UdnDGxl8t9AsdeauoN7tKTmiqcMIxafStj0CzO1z446H7oDyzHbEGTkk73QmZLqQbJ/zbyvL6fspjCraIQG0F7o8MjtZ/+zjH9/mWzDdu/oqwYHSz0xX7SFDMaYq4ciOpZkNEjAnu/MZvNVVhauPPWYTwoZXLdLr7KLFw==;5:4668yjxaMTikNIwK1+wfrqX+32dlgOwA3mGbrFY4v0fINx9xmTxcn71RwHEA5MUhegeFPbtGpiTQdLa6dNlRBaaVS3EAKu7LZMQNvtA/MADvcusWTS+LdHJlY+umINDJz636Rs9qgn9PjlYZlt3NP0iUiIJM69QzZA3vAEhwSO5OcNo2B3OnGFax9n/TeaKkkhf232cokM6HqVmYI3TMtg==;7:TsOhVX2VsBytGvQszONz7ZiokH3uxNLqZ4TPAV8QRJASH4Jsn/702uI/+hCfcV//e4Fs259TI3WKUUIlSsX3cdJtl4TEBX3bWqwCqFn7AgJ46xXM5sw4KCTv1S10j5cgSjdLPBgOpLGUVqJL1wS5rA==
x-ms-office365-filtering-correlation-id: 146d02c9-1d7b-4241-5cd4-08d68a8cb387
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BL0PR11MB3442;
x-ms-traffictypediagnostic: BL0PR11MB3442:
x-microsoft-antispam-prvs: <BL0PR11MB34427D927BE438440BA16BFCFE6D0@BL0PR11MB3442.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(22974007)(189003)(199004)(6116002)(3846002)(105586002)(81156014)(6436002)(74316002)(81166006)(8676002)(7696005)(186003)(256004)(8936002)(106356001)(2501003)(99286004)(316002)(110136005)(4326008)(86362001)(53546011)(229853002)(14454004)(25786009)(2201001)(7736002)(72206003)(6246003)(478600001)(305945005)(54906003)(55016002)(9686003)(53936002)(71190400001)(486006)(33656002)(71200400001)(6506007)(102836004)(476003)(68736007)(11346002)(97736004)(2906002)(446003)(26005)(76176011)(78486014)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3442;H:BL0PR11MB2897.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KEjnhRRy3/GZrTE5ngy2SQru4BPiwgYIQByfhYYktr1Ke5IyUtTMK6K9okO/7mIot66S6KVGSLbUCL8Fw9jPeTNeik2Lz5V/UWlJFU9MtKZXnIAUOKDv3YkO4gbKUjnFKPExFvFqca8Mrkaeugxy+k3cff3aC8cJ7O4luNer2C4i2MCvgPi3o37kcsNlyN2L+KozpGDg4E6V3rjAju8+oaCotWd78og7UMTJNu+9AUrB5CMK3wCA+57KeH6NVnuRb/3akGFBey05UvbIXkIJAYk/DjOeKkHS07jJV1cA7/d0S2ojbxIXrj0nYZ9FQE2eNa4qkhpJWr+4AxptYq8TSP3sEP5AieyFbCozIc/IBhBQ0G4dNJBKRETDyAQ3AVVbq8uHqf1jIT0XNsYwAOKkdWMo/3PNpb0+QASESmQL+jM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 146d02c9-1d7b-4241-5cd4-08d68a8cb387
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:37:03.0040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3442
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>

---------- Forwarded message ----------
From: Colin King <mailto:colin.king@canonical.com>
Date: Feb 2, 2019 2:41 AM
Subject: [PATCH] scsi: aacraid: clean up some indentation and formatting is=
sues
To: Adaptec OEM Raid Solutions <mailto:aacraid@microsemi.com>,"James E . J =
. Bottomley" <mailto:jejb@linux.ibm.com>,"Martin K . Petersen" <mailto:mart=
in.petersen@oracle.com>,linux-scsi@vger.kernel.org
Cc: mailto:kernel-janitors@vger.kernel.org,linux-kernel@vger.kernel.org
EXTERNAL EMAIL


From: Colin Ian King <mailto:colin.king@canonical.com>

There are several issues with badly indented statements. Fix these
and clean up the formatting.

Signed-off-by: Colin Ian King <mailto:colin.king@canonical.com>
---
=A0drivers/scsi/aacraid/commsup.c | 25 +++++++++++++------------
=A0drivers/scsi/aacraid/linit.c=A0=A0 |=A0 3 +--
=A0drivers/scsi/aacraid/src.c=A0=A0=A0=A0 |=A0 2 +-
=A03 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.=
c
index d5a6aa9676c8..0bdc6b0f725f 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1376,18 +1376,19 @@ static void aac_handle_aif(struct aac_dev * dev, st=
ruct fib * fibptr)

=A0=A0=A0=A0=A0=A0=A0 container =3D 0;
=A0retry_next:
-=A0=A0=A0=A0=A0=A0 if (device_config_needed =3D=3D NOTHING)
-=A0=A0=A0=A0=A0=A0 for (; container < dev->maximum_num_containers; ++conta=
iner) {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((dev->fsa_dev[container].co=
nfig_waiting_on =3D=3D 0) &&
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (dev->f=
sa_dev[container].config_needed !=3D NOTHING) &&
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 time_be=
fore(jiffies, dev->fsa_dev[container].config_waiting_stamp + AIF_SNIFF_TIME=
OUT)) {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_=
config_needed =3D
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 dev->fsa_dev[container].config_needed;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->fs=
a_dev[container].config_needed =3D NOTHING;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 channel=
 =3D CONTAINER_TO_CHANNEL(container);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 id =3D =
CONTAINER_TO_ID(container);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lun =3D=
 CONTAINER_TO_LUN(container);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
+=A0=A0=A0=A0=A0=A0 if (device_config_needed =3D=3D NOTHING) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (; container < dev->maximum=
_num_containers; ++container) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((de=
v->fsa_dev[container].config_waiting_on =3D=3D 0) &&
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 (dev->fsa_dev[container].config_needed !=3D NOTHING) &&
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 time_before(jiffies, dev->fsa_dev[container].config_waiting_stamp + =
AIF_SNIFF_TIMEOUT)) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 device_config_needed =3D
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->fsa_dev[container].config_n=
eeded;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 dev->fsa_dev[container].config_needed =3D NOTHING;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 channel =3D CONTAINER_TO_CHANNEL(container);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 id =3D CONTAINER_TO_ID(container);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 lun =3D CONTAINER_TO_LUN(container);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 break;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 if (device_config_needed =3D=3D NOTHING)
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 7e56a11836c1..e977b459f823 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -852,8 +852,7 @@ static u8 aac_eh_tmf_hard_reset_fib(struct aac_hba_map_=
info *info,

=A0=A0=A0=A0=A0=A0=A0 address =3D (u64)fib->hw_error_pa;
=A0=A0=A0=A0=A0=A0=A0 rst->error_ptr_hi =3D cpu_to_le32((u32)(address >> 32=
));
-=A0=A0=A0=A0=A0=A0 rst->error_ptr_lo =3D cpu_to_le32
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ((u32)(address & 0xffffffff));
+=A0=A0=A0=A0=A0=A0 rst->error_ptr_lo =3D cpu_to_le32((u32)(address & 0xfff=
fffff));
=A0=A0=A0=A0=A0=A0=A0 rst->error_length =3D cpu_to_le32(FW_ERROR_BUFFER_SIZ=
E);
=A0=A0=A0=A0=A0=A0=A0 fib->hbacmd_size =3D sizeof(*rst);

diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 8377aec0649d..97bb9e9d201c 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -1157,7 +1157,7 @@ static int aac_src_soft_reset(struct aac_dev *dev)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&dev->pdev->dev, "%s:=
 %s status =3D %d", __func__,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state=
_str[state], rc);

-return rc;
+=A0=A0=A0=A0=A0=A0 return rc;
=A0}
=A0/**
=A0 *=A0 aac_srcv_init=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0 initialize an SRC=
v card
--
2.20.1
