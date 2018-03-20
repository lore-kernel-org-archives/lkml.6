Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeCTFLn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 01:11:43 -0400
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:46261
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751022AbeCTFLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 01:11:40 -0400
From: "Kalluru, Sudarsana" <Sudarsana.Kalluru@cavium.com>
To: Colin King <colin.king@canonical.com>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bnx2x: fix spelling mistake: "registeration" ->
 "registration"
Thread-Topic: [PATCH] bnx2x: fix spelling mistake: "registeration" ->
 "registration"
Thread-Index: AQHTv48xVZ0bv/YVTEe3mvPPZzPQOqPYlAPQ
Date: Tue, 20 Mar 2018 05:11:37 +0000
Message-ID: <MW2PR07MB41394233EBB630C3EADB36C58AAB0@MW2PR07MB4139.namprd07.prod.outlook.com>
References: <20180319143259.5796-1-colin.king@canonical.com>
In-Reply-To: <20180319143259.5796-1-colin.king@canonical.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2402:3a80:516:735:6902:1e7b:f65c:36ab]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB4060;7:+FfRTZquwiEWQy+r/skEiXWvxd1/vHqi8+/3nPxTCvPHwe0eXphQQWcDUXD2cFLvd/ctpg2jJwomQcf9d85zvWa8IZ7JhyST2vj9ZcFICJKjCcnOJBMRlKtNn3ZZ8444C5yulZTekEmETZc3LhiWRnGkpaYeJXm5Pu6bFyqK/PPl6LTAVYblCtEcvNUgwgb3H6pUE+ekyxmVmkRgV3hpa1vPUTFIGEebnwDKq44nRiyLDT/2RrwdbukbkG136sYv
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 381bba93-a948-43e6-1f88-08d58e210ec2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB4060;
x-ms-traffictypediagnostic: MW2PR07MB4060:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sudarsana.Kalluru@cavium.com;
x-microsoft-antispam-prvs: <MW2PR07MB4060D1AFFA75F9562906751E8AAB0@MW2PR07MB4060.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501307)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR07MB4060;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB4060;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(39380400002)(13464003)(189003)(199004)(3280700002)(2950100002)(6116002)(97736004)(2906002)(106356001)(5250100002)(2501003)(59450400001)(6506007)(186003)(110136005)(54906003)(53546011)(46003)(86362001)(102836004)(76176011)(99286004)(229853002)(316002)(7696005)(25786009)(33656002)(305945005)(478600001)(7736002)(3660700001)(68736007)(72206003)(14454004)(4326008)(53936002)(9686003)(2900100001)(81156014)(8676002)(81166006)(8936002)(6436002)(6246003)(5660300001)(105586002)(55016002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4060;H:MW2PR07MB4139.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BBHAHHwvfa6jQ4rNz1gieh+KEwZMqNfjupkOEiyOmqCoHdIJT44WOOb/r8A3nnZPYQk1wTob2dLyc/dSr0CbJJArDrmMmknTEp1uclqyHPaI2r/+5WALEvMgo0koJuzD4ajBFEda9LXoaOkIgNGCENz7FkUjCOp/TSGBy0vr/npElRGJwqqINtxGUn7wmd5lKp60DAhiZzNUiCY7mSQt0MnlIYBw//J5YIv37xAj8wU8tg32BcDgUHieqvhH0s3jZb3GXGW9brIBM6m486qIC4cYmPuYq2uGTDgcqdE1JShJkhkDXc7blbLUz5dS5WJwdw4GAhQ7okO9x+hTa+36yg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381bba93-a948-43e6-1f88-08d58e210ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 05:11:37.4367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4060
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2K5Br6l015354

-----Original Message-----
From: Colin King [mailto:colin.king@canonical.com] 
Sent: 19 March 2018 20:03
To: Elior, Ariel <Ariel.Elior@cavium.com>; Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>; netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [PATCH] bnx2x: fix spelling mistake: "registeration" -> "registration"

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in BNX2X_ERR error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 74fc9af4aadb..b8388e93520a 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13913,7 +13913,7 @@ static void bnx2x_register_phc(struct bnx2x *bp)
 	bp->ptp_clock = ptp_clock_register(&bp->ptp_clock_info, &bp->pdev->dev);
 	if (IS_ERR(bp->ptp_clock)) {
 		bp->ptp_clock = NULL;
-		BNX2X_ERR("PTP clock registeration failed\n");
+		BNX2X_ERR("PTP clock registration failed\n");
 	}
 }
 
-- 
2.15.1

Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
