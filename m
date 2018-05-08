Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755948AbeEHWBz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:01:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43155 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755745AbeEHWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:01:53 -0400
From: Colin King <colin.king@canonical.com>
To: Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ATM] firestream: fix spelling mistake: "reseverd" -> "reserved"
Date: Tue,  8 May 2018 23:01:51 +0100
Message-Id: <20180508220151.20725-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in res_strings string array

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/atm/firestream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index d97c05690faa..4e46dc9e41ad 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -191,7 +191,7 @@ static char *res_strings[] = {
 	"reserved 37",
 	"reserved 38",
 	"reserved 39",
-	"reseverd 40",
+	"reserved 40",
 	"reserved 41", 
 	"reserved 42", 
 	"reserved 43", 
-- 
2.17.0
