Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeEVIdt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:33:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58648 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEVIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:33:48 -0400
From: Colin King <colin.king@canonical.com>
To: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: fix spelling mistake: "Inavlid" -> "Invalid"
Date: Tue, 22 May 2018 09:33:42 +0100
Message-Id: <20180522083342.5722-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/greybus/audio_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index de4b1b2b12f3..15e57f701630 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -996,7 +996,7 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 
 	ret = gbaudio_validate_kcontrol_count(w);
 	if (ret) {
-		dev_err(module->dev, "Inavlid kcontrol count=%d for %s\n",
+		dev_err(module->dev, "Invalid kcontrol count=%d for %s\n",
 			w->ncontrols, w->name);
 		return ret;
 	}
-- 
2.17.0
