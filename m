Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeEaLFA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:05:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53753 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754611AbeEaLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:04:55 -0400
X-Google-Smtp-Source: ADUXVKJ7LjKhRvs3Hgh2CiM5KintwOyjo1eTcuabppybkjpsi7NMVobDWf6Mw0CVNmsf6Wf0DBQbJg==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 1/3] staging: rtlwifi: Fix "Trafic"->"Traffic"
Date: Thu, 31 May 2018 13:03:12 +0200
Message-Id: <20180531110314.3760-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in comment text.

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 drivers/staging/rtlwifi/phydm/phydm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm.c b/drivers/staging/rtlwifi/phydm/phydm.c
index 8b2a180cc13c..2b61b12e6b21 100644
--- a/drivers/staging/rtlwifi/phydm/phydm.c
+++ b/drivers/staging/rtlwifi/phydm/phydm.c
@@ -160,7 +160,7 @@ static void phydm_traffic_load_decision(void *dm_void)
 {
 	struct phy_dm_struct *dm = (struct phy_dm_struct *)dm_void;
 
-	/*---TP & Trafic-load calculation---*/
+	/*---TP & Traffic-load calculation---*/
 
 	if (dm->last_tx_ok_cnt > *dm->num_tx_bytes_unicast)
 		dm->last_tx_ok_cnt = *dm->num_tx_bytes_unicast;
-- 
2.17.0
