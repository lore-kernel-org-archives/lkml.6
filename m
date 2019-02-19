Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6901C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B0A2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BVOauf29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfBSUZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:25:59 -0500
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:27328
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbfBSUZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIe5txGKhhsculu8kBeYs5dWurpDsu7mSdOKTeGK4sk=;
 b=BVOauf29PhWk/34Pbh4WVjMjySR5VU3AmYeQSAvtXKikBpd3TV+Xv1viBzp8gWLnUDeUzAxuVo/gUyeyqK6lSJRVoieW+ixoY1Y3RDXki6cxAFP/hU++dBdGP2rhpi1wunQC7FbgR0TkLUPZo4fcMKHRxse6HumQVTDOhPU1icM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2829.namprd12.prod.outlook.com (20.177.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 20:25:52 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe%2]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:25:52 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 1/5] EDAC/amd64: Add Fam17hMod30h PCI IDs
Thread-Topic: [PATCH 1/5] EDAC/amd64: Add Fam17hMod30h PCI IDs
Thread-Index: AQHUyJFO2kTGZslcCUS37hwB/bq0XQ==
Date:   Tue, 19 Feb 2019 20:25:51 +0000
Message-ID: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0031.prod.exchangelabs.com (2603:10b6:804:2::41)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65777d7b-2344-4398-96ac-08d696a8712c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2829;
x-ms-traffictypediagnostic: SN6PR12MB2829:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2829;20:DDNFsrba3prPNsOUlP4ZrbZrnxTuRyXq3ZT+f+CFg8iwVMKJ+cnRYZM40uGKYcN3yPj31zqmU9AsmT12aRSR9auKnF96AcLk24o2z9ReOw/RjjJEFIUAs3sVEF+RKqWHbpH7lOdVDDI7Cjf57upwZpysnqQiJLTgdJuKXE6Ib9ZxsAFRFECi2zVh4sK1lDs0VpA5zNnx06+VJbz//tB9FP6SiGOpMhgwhewKDyqUdVExoHFGArZx3bIdQLaZUmXE
x-microsoft-antispam-prvs: <SN6PR12MB28294A1D7F549268EA23A647F87C0@SN6PR12MB2829.namprd12.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(189003)(199004)(36756003)(476003)(68736007)(86362001)(486006)(6486002)(26005)(14454004)(72206003)(478600001)(3846002)(6116002)(6512007)(6346003)(6506007)(102836004)(316002)(2616005)(25786009)(6436002)(6916009)(54906003)(4326008)(186003)(2906002)(5640700003)(5660300002)(386003)(53936002)(2501003)(99286004)(97736004)(305945005)(105586002)(52116002)(1076003)(50226002)(71190400001)(66066001)(8936002)(106356001)(2351001)(81166006)(71200400001)(81156014)(14444005)(8676002)(256004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2829;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r+N31OtVaxmVZd9FecFxd48XklsV7sApzeaF9Sl+oWW644pEOgAz4kpGyJjvGu5vdjHzKZn2DDI7q/nPs+cJoP0j0WFxP+2Ngwrp1b5myzkPPkAc1Fw7cnEHNbioI8JcVTydOcxNs/UcnC0N/le/BBskaPprnU+JJFHkWONeGKqSsvDK0yzNZoBSjHSfSmxk6FGH5DFLZVMPMryW81XdihKehlqV9ba6EStQFS1kk8cWJW15tmfEpC3Kh3flXlE+V3+NMZZc51X1wbsRm+w+VX9qDXOlqk66730N5n9uCr0nSDc95H/iLGMUpiIeWjVY44sg1ozrHM+HQx4Y8ofyhxQvOCl74B7uBVyVm2SvRysfEzALSKnnW3pttNQaC3ojlsEKAhlpcWO4hYjmFq37xdBvBHbZS2prk1fIiI/xCe0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65777d7b-2344-4398-96ac-08d696a8712c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:25:50.0561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Add the new Family 17h Model 30h PCI IDs to the AMD64 EDAC module.

This also fixes a probe failure that appeared when some other PCI IDs
for Fam17hMod30h were added to the AMD NB code.

Fixes: be3518a16ef2 (x86/amd_nb: Add PCI device IDs for family 17h, model 3=
0h)
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 15 ++++++++++++++-
 drivers/edac/amd64_edac.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6ea98575a402..9947437d9574 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2211,6 +2211,15 @@ static struct amd64_family_type family_types[] =3D {
 			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
 		}
 	},
+	[F17_M30H_CPUS] =3D {
+		.ctl_name =3D "F17h_M30h",
+		.f0_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
+		.f6_id =3D PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
+		.ops =3D {
+			.early_channel_count	=3D f17_early_channel_count,
+			.dbam_to_cs		=3D f17_base_addr_to_cs_size,
+		}
+	},
 };
=20
 /*
@@ -3199,7 +3208,11 @@ static struct amd64_family_type *per_family_init(str=
uct amd64_pvt *pvt)
 		break;
=20
 	case 0x17:
-		if (pvt->model >=3D 0x10 && pvt->model <=3D 0x2f) {
+		if (pvt->model >=3D 0x30 && pvt->model <=3D 0x3f) {
+			fam_type =3D &family_types[F17_M30H_CPUS];
+			pvt->ops =3D &family_types[F17_M30H_CPUS].ops;
+			break;
+		} else if (pvt->model >=3D 0x10 && pvt->model <=3D 0x2f) {
 			fam_type =3D &family_types[F17_M10H_CPUS];
 			pvt->ops =3D &family_types[F17_M10H_CPUS].ops;
 			break;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4242f8e39c18..de8dbb0b42b5 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -117,6 +117,8 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F6	0x1466
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F0 0x15e8
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
=20
 /*
  * Function 1 - Address Map
@@ -284,6 +286,7 @@ enum amd_families {
 	F16_M30H_CPUS,
 	F17_CPUS,
 	F17_M10H_CPUS,
+	F17_M30H_CPUS,
 	NUM_FAMILIES,
 };
=20
--=20
2.17.1

