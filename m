Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeFBJEg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:04:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52534 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFBJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:04:33 -0400
X-Google-Smtp-Source: ADUXVKKCsREMChUcPAII61sC2H8SfmDpfNU1Eulyb7jTSq6g+IN1x8696Dju1icJOGVvw4G4INWtqA==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH v2 1/3] staging: rtlwifi: Fix "Trafic"->"Traffic"
Date: Sat,  2 Jun 2018 11:04:12 +0200
Message-Id: <20180602090414.5208-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601060740.GA25648@kroah.com>
References: <20180601060740.GA25648@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in comment text.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
Changes in v2:
 - Added proper to and cc fields to the patch series.

 drivers/staging/rtlwifi/phydm/phydm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm.c b/drivers/staging/rtlwifi/phydm/phydm.c
index 985978d3decc..27635feedba2 100644
--- a/drivers/staging/rtlwifi/phydm/phydm.c
+++ b/drivers/staging/rtlwifi/phydm/phydm.c
@@ -149,7 +149,7 @@ static void phydm_traffic_load_decision(void *dm_void)
 {
 	struct phy_dm_struct *dm = (struct phy_dm_struct *)dm_void;
 
-	/*---TP & Trafic-load calculation---*/
+	/*---TP & Traffic-load calculation---*/
 
 	if (dm->last_tx_ok_cnt > *dm->num_tx_bytes_unicast)
 		dm->last_tx_ok_cnt = *dm->num_tx_bytes_unicast;
-- 
2.17.0
