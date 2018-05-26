Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031924AbeEZPLL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 11:11:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56731 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031848AbeEZPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 11:11:09 -0400
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: seq: fix spelling mistake "Unamed" -> "Unnamed"
Date: Sat, 26 May 2018 16:11:00 +0100
Message-Id: <20180526151100.10774-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/seq/seq_ports.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index d21ece9f8d73..24d90abfc64d 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -669,7 +669,7 @@ int snd_seq_event_port_attach(int client,
 	/* Set up the port */
 	memset(&portinfo, 0, sizeof(portinfo));
 	portinfo.addr.client = client;
-	strlcpy(portinfo.name, portname ? portname : "Unamed port",
+	strlcpy(portinfo.name, portname ? portname : "Unnamed port",
 		sizeof(portinfo.name));
 
 	portinfo.capability = cap;
-- 
2.17.0
