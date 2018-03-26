Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeCZRDo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:03:44 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:57120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeCZRDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 2/8] drm/arm/malidp: Modified the prototype of malidp_se_irq_fini
Date: Mon, 26 Mar 2018 18:03:14 +0100
Message-Id: <1522083800-30100-3-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
References: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AM6PR08MB3032.eurprd08.prod.outlook.com
 (2603:10a6:209:45::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6d9c0d9-d864-45a6-5d62-08d5933b855d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:+UXzGxo5m5HJxg0h1NyW0lk84n70gPbBHLkBjKrg2voHa6F44GymXYp7jhxhmufUrRwGngNA2cuqon3r4tB83Rbp6Itp1IGjlv9387Mfy9P0rV5acOoK8nRfeJKx2wUHAzK/qFxxSoB22t3cRzWJRqjAzfUbqvQRIS7joEurYjRoAHugIhoSw0QHQ0VmYqq3DgUYzsLOp3LRT6T/fKMBtSciEQes2Oes1G+ueVexvbKQWvY+iomGiDXwrv/2Xx6v;25:MZPCbmE1mPhzRrZaMxNd5bGBBfeZ3mu/dPdpm7t6j94AlMGuSy7fFA6c0FbQmLjZ+zhY8YsDKjJNdMz/KLeqFXbo1rZcdrC/uchv1rLM2RMLxJIH4ToN29GFmRge1IL5MOOVHIcCBpYmGlycPuxExjjzZGCtzzN/xIc/Wi77NrClyxMImGmQy9FdKbQIik3tbM0xbRTc0HCguhWID8Kr1hnW4ljEgtFj6EfbPr/cT7JhJjqXJvuamMxWXZnShabK3V1CS8EyWdlTs0DWyMDh/yZxxMKEmCcteyKjp70IiCL5eJtHjLyqNsqqUo0ZIKfOW4kyvk2O1RcgMFEJGPqMAw==;31:i+WHPEYy+bUsRahuk9gGGSAyfUBysqSkAjtWG+oE/buEsXyIaViCMuELKf6Vu1/fGZM5qrjepXdELJfToPlC+i/xxnbkBef8BdcSKfKCKcOHn0sfzwwPNRY2sf5s6iui0MvjY5i525FiMxi00y6if+HzngTohNNaS03UUM6CHMBURSIV3n7uoY/ldH5LotUu/+IFvCe76B2Ruy1puYhJKjbwh5vIESFR7I6H0sbjkkY=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:a2j5Td9JtGsnhz7SGwc6qiEWdYnXHjdN4sER5JLqTckCdqU2tHW5373Aqx7NRRx+DT5+VmJ6bGMKD49xy66mfveq7549ChdN72wdD4i9Tr3N2soEe2fS5Uej5fTM7ReM4CKIZ6UReHTFncYKQWKrKYZcUDnZ2FBxMlZlaPA4O10=;4:/kR3bsL1HTQ0eLDO/Ht1+DnV1qYXMoqbiqQLbUDAseKflYZ/caVfmJIKXFw70u8dtFQKoTDvyG4U/KehLkOEPBXizIL+0AGt8NfOeQogd3cV7gjgudMidi95g0uX6e2aMUjyHo3f2WuPTusJmLSg6oMnH8AvbV90dvQUeAqQ88R9C8qjtQcGCyxg7BwQgtES5+2pCxWEUC8BcseSEKRZXuifjhf1nXX9Os3bUGer4V/v9IVDf94FA+QdtCjSUis992Gjc/4VbZJlozFth4+oMjB/1rX6k4TDty/Gocodgd/QSU4X3t7JrqQxfmjAKmFd
X-Microsoft-Antispam-PRVS: <AM6PR08MB30329475CE05912685DB7E01E4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(76176011)(305945005)(26005)(8936002)(446003)(86362001)(575784001)(478600001)(11346002)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:I1Jt/w5iil00vcgHbNGUgb+5cyAi6yZ9n1HxmOmJn?=
 =?us-ascii?Q?+wWUvz9hkxfeHzYckAvM2lyAQEP+q5sDt36NJGts3+pFcsMuUGaZjrsTyoyB?=
 =?us-ascii?Q?gQc2fTOIxOm1cp/lVfHXKm1iTDMGIQ/1h3T8q2eJ3iQ5uCpPMaQaFrDcBfWp?=
 =?us-ascii?Q?8jpiI2xaHPylkUKEBGtksWBVbl903sWmyJ8LqT9l8fAFrEEuj37Xy2oqN5bI?=
 =?us-ascii?Q?lhdJS7qFCmPtBuV60s+KMAPRuhdCLhBJyDE08cMB1GSuUoqJgYlIHCllmVVr?=
 =?us-ascii?Q?Sx5J0+GlMNRyMFinaaUfockVuQxW5Od9nV32jQKdPo93xBFFoxV/mwqKZjXk?=
 =?us-ascii?Q?XZqcG4bpu/cHoKD+tXOpkB5egYEwvAl9MtV2u00dkH2xyLyY6VGAhgB42wxz?=
 =?us-ascii?Q?YZNrBRsFbT7byoFtE8X1NDngXv9/Ouz5Kve3TUbZ+HAbP0dDdgRlGqAS2Prb?=
 =?us-ascii?Q?0lVE60+8RYWSDJC1igjKyZlIq1EPQx3uw7gsG+wCcVdnZztDUGGm+onS3JcY?=
 =?us-ascii?Q?2tdlPCswdXOL0rlkh7szi2MJjolnL4hpROFd0HbycbYczOJ27IkYhrVjlyaA?=
 =?us-ascii?Q?4XEmSV3mzgF9hhMKYOoov23fiPqjzZYTKygjrnrFO6IqRIxy6SFRtQWeD9l5?=
 =?us-ascii?Q?FdGDKoXzSL071fMkJqXoUqeNPtTYHqErnTsCPuk2ofuUuOiskKydpHCE4I/k?=
 =?us-ascii?Q?2pe5yDNe9BVSPrXoxGZ0AXf5LyMD4HPreCzsMukG74LqBWteuoMWksROU+hw?=
 =?us-ascii?Q?sqjLklG0EIomeGhmvf1uo006XFVVQznRJ9bFTHGAw5E2N8gvgbNe3Uex76SO?=
 =?us-ascii?Q?BECUzFeOcdHBNBudKIto8b+yyzjxjuhHgKsSae14zGuiIlbMSz+psAbkZtQL?=
 =?us-ascii?Q?N75NqF0Bb/ZI9EYsLMkn7pk+v0+MSoZQi/XFypfx0dtsZ5o+3I2I03CiyvWh?=
 =?us-ascii?Q?UJhgAnwnAdXteEzY4UG4V6kbmbjJgdtzS1yxI5A8rHru4YFVEbIslK3OKSm6?=
 =?us-ascii?Q?0gNAWbD7cNsRMbgs7sZLfpjOAxRz7/5K1Br73A2yot6hzLhAqy0NWmSrqsJp?=
 =?us-ascii?Q?zW7d7xRwYGLvt8CRydT8Yf4ef1x3I77RiUAqz+NqGvHwqioPq3r7zV86qVWV?=
 =?us-ascii?Q?8UqHzh3Xe2Hruv4xf6P/NHxpkxTImUpyYbBTEDSIy7TY66N2Vflqh8rs1oXh?=
 =?us-ascii?Q?aTJ6xW0Uz0L91Q=3D?=
X-Microsoft-Antispam-Message-Info: oWP9AgWcY93N/hz9SqzTGrdu/1cvhmRtRgvVsOimW/S2nnlxjx7GHS+ThCJJHQkGUF/NUS0oq61/zVw9SR9xJmb1qKfKKtGHmHpNeFP6zdATXJQVq2yDdHBikHfq3AurDDL2lPt9tePw0Thgmkst8EpiayWKIv9bV+4CME4P1/M1LZMW1N0yZqpUjrOuYbVj
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:K7zyoGTxAtpwe+CeqURAG/rxAYr/NJvtnruNJ2Qo9vi4jDdaSDvRuRNpGX9kGhFo1L/psXa01bPrhGplltAJqF/A+ktSjv5sllKx8wMY8apPvi23J+0SxjJw0BNtmRnfaSXRoJtqqz3Vj8oDZzrmAU0SPQoEB6lbdlDz1/Iwiiur5QE0mqEfyn1mWJfX+VQmMATNTDPsx3cBxQUUwWDMJ0dL+bH3jW0qDjf1BIi70lA33fekAoy2wrO86k6trrxPo5JAmRZhweatx4fuuj4RnzeNqpbNsO0dWJzc/+NwgMxWa8dkaXup+v8stiJXO++7IchupVnefmlfZXEFLadHHmutNCED3eU4MxFJyZVTapkOIvA9nJpnRYFtlIqmC4L2rUgd6KKQlINrLoW1sOU1r8qLgsnRhU6HrtGR/z8BN0cS1HFl4Vp0Kl6W8evNqmCzDg2esyTie7VyoohkjRXmgA==;5:bHjAN7xWHkcu5siL6aL2INtgYCf9o9dQGW49SJ7Mtxw2hKv/Sby8j/RYaEB7bCWQ+05Nge7iQpMHaVIUOhPo97nUNTQUlTp6VutVDR6t4CFIPS4ws9LVLFAoF49zKZycLSPgWpHz6rCnlKLoFwBTXNO9vOiAFot1criqHJuvtHE=;24:qYZ5Jo059BKrrvH3+bi/RcZz2G6tNbtkgtTtX5A8E9k0mOSo79zchU0FHqjfifzIF0NfdOMhLtdJiQ6LKmc5b3bek1v062LKnrWYnSWmoMo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:9ZjteaAd5r6s7BV0gUZXDlM4X2TEmMJAA6jjcJVMukNEuaVMWP0lcMFseKM7QzdDWrDzhgJaEfEn/Rxb//LZXl6cUYCbpSt13Jm1aG6X6XNhwrLYf2K4x6VgC/9yc3b5Ri9M+HcMnrMKeOOVRdzNRRw0n0O7PZK5nOozXJSwN10dlgGw5uwTOq8Jor9ymhnYrn6eSWPbojMO80jTuGw4CLJ8+EqcgajZuLeRemzORSlUSEYH50E9motFrwoKOdst
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:38.6072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d9c0d9-d864-45a6-5d62-08d5933b855d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct drm_device' is being replaced with 'struct malidp_hw_device'
as the function argument.The reason being the dependency of
malidp_se_irq_fini on 'struct drm_device' needs to be removed so as to
enable it to call from functions which receives 'struct malidp_hw_device'
as argument. Furthermore, there is no way to retrieve 'struct drm_device'
from 'struct malidp_hw_device'

Change-Id: Iab7ac99917f0faf739aee97b00e1758ad1ae787b
Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 4 ++--
 drivers/gpu/drm/arm/malidp_hw.c  | 5 +----
 drivers/gpu/drm/arm/malidp_hw.h  | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index ed38ba9..f7a8beb 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -653,7 +653,7 @@ static int malidp_bind(struct device *dev)
 fbdev_fail:
 	pm_runtime_get_sync(dev);
 vblank_fail:
-	malidp_se_irq_fini(drm);
+	malidp_se_irq_fini(hwdev);
 	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 irq_init_fail:
@@ -690,7 +690,7 @@ static void malidp_unbind(struct device *dev)
 	drm_kms_helper_poll_fini(drm);
 	pm_runtime_get_sync(dev);
 	drm_crtc_vblank_off(&malidp->crtc);
-	malidp_se_irq_fini(drm);
+	malidp_se_irq_fini(hwdev);
 	malidp_de_irq_fini(hwdev);
 	drm->irq_enabled = false;
 	component_unbind_all(dev, drm);
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index b13dfac..8fb02f3 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -970,11 +970,8 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)
 	return 0;
 }
 
-void malidp_se_irq_fini(struct drm_device *drm)
+void malidp_se_irq_fini(struct malidp_hw_device *hwdev)
 {
-	struct malidp_drm *malidp = drm->dev_private;
-	struct malidp_hw_device *hwdev = malidp->dev;
-
 	malidp_hw_disable_irq(hwdev, MALIDP_SE_BLOCK,
 			      hwdev->hw->map.se_irq_map.irq_mask);
 }
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index 6e2a2f6..6607aba 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -299,7 +299,7 @@ static inline void malidp_hw_enable_irq(struct malidp_hw_device *hwdev,
 int malidp_de_irq_init(struct drm_device *drm, int irq);
 void malidp_de_irq_fini(struct malidp_hw_device *hwdev);
 int malidp_se_irq_init(struct drm_device *drm, int irq);
-void malidp_se_irq_fini(struct drm_device *drm);
+void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
 
 u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
 			   u8 layer_id, u32 format);
-- 
2.7.4
