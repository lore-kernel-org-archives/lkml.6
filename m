Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D258C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0184204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Rrze+AWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0184204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbeIXVOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:14:20 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730352AbeIXUup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUgMz6ETxtO21F2mkoUee/ZfbNM8tnO6x3iFYc2R0ZE=;
 b=Rrze+AWejavvtsu5qcMGdT6Nc/W0JYQZLup4Fxj/C+R1zTvDXwTJCWTMWYv8rwVciqY7qHSCMKcijEhsLvgr2BtU4w0rzW/BCg+C4PwwTR9zzxtKf2R5yHULWYTtCxvl3hV4gGtMuT/+ne0+RSNss6zutlLt8zRX1imOqz4mEPw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:06 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:06 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 09/76] scsi: libata: Add missing newline at end
 of file
Thread-Topic: [PATCH AUTOSEL 4.18 09/76] scsi: libata: Add missing newline at
 end of file
Thread-Index: AQHUVBWZNGdi1pjkLEmwmv4eWraOhg==
Date:   Mon, 24 Sep 2018 14:48:05 +0000
Message-ID: <20180924144751.164410-9-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:6bXQjyTxCSAVjwgPie7PQ82d2Lo3zE1hqn/lbd5KCOLEKLq3KRGcs0H3qOu2XFAz0LcvXk7qXL/6GrpMLbeJ/2ry+8iG5v62XkrGmE40KMJFx2U7IPLhbP0InAzt3w8Py1DFf6oVuLg7AUyho7z4ZkvZFBR+6hmONgOOBxrDCxCWfwashgXM/dhoQqhooFIlel+qHbcLw5G+fNpOfRreFoASvJg4TZytzkMolWcGb+NVPWQrsJYeO3NDTLX6YRkZTQFVBFShp9KFf1/AcGxYqvOKi4cCedrG7H+KWMAu4BDuqz+a4M0HSgAF/7JQDiMf7LsmAvd1fuQxdLTNNXmEE36O2uJH0N0AJ2id4YaofSl94DczDnGqSve2Gj3LbZC7blJX4MrhTiTEfUYbEuSPBZe0LcBbNUmRJ7+d0bs0C+AhE7mfEyakkzYLTG9OyVECuWgIEwgUsmrmYF47zjFSTQ==;5:Du5ACe3rhGkGDUX7DQmE6PzEAa6lQDXkmBSEu1rDLSc8HYU/ekT/dBqg0afl5saSLKnqhSPh9/5cdjywvkA5QjHKTnWYz7+pQImz0X1tZg374EMY99G1SN4g3Tj+VUQXaoTP/5bsVRKowVMwlQHV/IS527cqK674pQjoW4nHhL0=;7:uk5TvT8E1AYt7B0CPa1ysqRZBe6CYHqcQwxMV09E1R0S8eMBD8Y+On8heQN4XNMJTM+4KmDiF0JwZ4vUHsuAjn72k+7VOIItj+OvYu2viQfVNZOwlevHTGGtkNON8PrAJICPocyHXmn0qAWnKqCihMV6ikDceGda7uVr6dKw6b+OMSxF1RuqibxI0aGcLWXX5RCuQU408yIJiTHruEBIijiQxmaFPpX1pKK1gzAO/gAe9naV1gKsVqlj1L2yW5i9
x-ms-office365-filtering-correlation-id: 2dd5572d-6984-486d-1c3a-08d6222cbd15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB013498BD93C70129CBC72B29FB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(575784001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: GlOsYqp6r5tRuUDzYaKVxN/c/uaXPMfNINB3VRWTMDWF86fWmmIHA9zzCwFySWaKjy9jY7tKilJlExp3ETx0fO9kBvDFzhrQQ4VTi4mjcH0EOTP2IBhhjS7NTMew4dQJdiJi+jF9nR5orS28uQBn23Kq/Vmj3toA02hhj2Gh2mrEbLuJIbi8Vn2hK/zLtM5eYy0NzK0NbVQmQQDnnSaetP6YOf5SAAFx5ZkoEEYPxanRcEBkM1qhcSJ8X1Gyuy3Kh2i6TeiGa+6rGwu2q8AAjUsZu6CGOl+wuZZoRC9/NvOA4SP92po9VUxyQyzM/9+JEHcba35oYof/i1pMVaZVR+nqrbIxVqQeSy2KualD8XQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd5572d-6984-486d-1c3a-08d6222cbd15
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:05.4327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 4e8065aa6c6f50765290be27ab8a64a4e44cb009 ]

With gcc 4.1.2:

    drivers/ata/libata-core.c:7396:33: warning: no newline at end of file

Fixes: 2fa4a32613c9182b ("scsi: libsas: dynamically allocate and free ata h=
ost")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 984b37647b2f..c26dba0ee3ce 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7393,4 +7393,4 @@ EXPORT_SYMBOL_GPL(ata_cable_unknown);
 EXPORT_SYMBOL_GPL(ata_cable_ignore);
 EXPORT_SYMBOL_GPL(ata_cable_sata);
 EXPORT_SYMBOL_GPL(ata_host_get);
-EXPORT_SYMBOL_GPL(ata_host_put);
\ No newline at end of file
+EXPORT_SYMBOL_GPL(ata_host_put);
--=20
2.17.1
