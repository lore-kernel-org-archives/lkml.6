Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEVQoa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:44:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeEVQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:44:26 -0400
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: fix spelling mistake: "Platfoem" -> "Platform"
Date: Tue, 22 May 2018 17:44:24 +0100
Message-Id: <20180522164424.8971-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in ODM_RT_TRACE message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtlwifi/phydm/phydm_rainfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
index a89bc59cf63b..b46791a727c7 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
+++ b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
@@ -711,7 +711,7 @@ void phydm_update_hal_ra_mask(void *dm_void, u32 wireless_mode, u8 rf_type,
 	phydm_BW = phydm_trans_platform_bw(dm, BW);
 
 	ODM_RT_TRACE(dm, ODM_COMP_RA_MASK,
-		     "Platfoem original RA Mask = (( 0x %x | %x ))\n",
+		     "Platform original RA Mask = (( 0x %x | %x ))\n",
 		     ratr_bitmap_msb, ratr_bitmap);
 
 	switch (wireless_mode) {
-- 
2.17.0
