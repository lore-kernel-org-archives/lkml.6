Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeB1FEN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:04:13 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38192 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeB1FEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:04:12 -0500
X-Google-Smtp-Source: AG47ELv/4ySyQ+XStbAl7Pm4/CR6ZsHAsSv0Otl53NRwxXa6s4z5rxQYYuG/krU0Y3zCmaQRaB1ZDw==
From: Leo Yan <leo.yan@linaro.org>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND] checkpatch: Make '$min_conf_desc_length' default value to 1
Date: Wed, 28 Feb 2018 13:03:59 +0800
Message-Id: <1519794239-21530-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make '$min_conf_desc_length' default value from 4 to 1; so can give more
relax check for Kconfig description has at least one line rather than
four lines.

User can still pass parameter "--min-conf-desc-length=X" to set more
strict check.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5cbc887..83d8663 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -51,7 +51,7 @@ my $configuration_file = ".checkpatch.conf";
 my $max_line_length = 80;
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
-my $min_conf_desc_length = 4;
+my $min_conf_desc_length = 1;
 my $spelling_file = "$D/spelling.txt";
 my $codespell = 0;
 my $codespellfile = "/usr/share/codespell/dictionary.txt";
-- 
1.9.1
