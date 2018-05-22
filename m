Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeEVQtN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:49:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40826 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeEVQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:49:08 -0400
From: Colin King <colin.king@canonical.com>
To: Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: fix spelling mistake: "Preamle" -> "Preamble"
Date: Tue, 22 May 2018 17:49:05 +0100
Message-Id: <20180522164905.10874-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in netdev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/wilc1000/host_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index a2f82c885d63..7b613cd72d22 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -577,7 +577,7 @@ static void handle_cfg_param(struct wilc_vif *vif, struct cfg_param_attr *param)
 			wid_list[i].size = sizeof(char);
 			hif_drv->cfg_values.preamble_type = preamble_type;
 		} else {
-			netdev_err(vif->ndev, "Preamle Range(0~2) over\n");
+			netdev_err(vif->ndev, "Preamble Range(0~2) over\n");
 			goto unlock;
 		}
 		i++;
-- 
2.17.0
