Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeDSWYP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:24:15 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:41248 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeDSWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:24:11 -0400
X-Google-Smtp-Source: AIpwx48ivyS6m9U1K1dqSCr4G1bosaOHMfLh0H7LHthsL9T92/uLkzL1nK64O3YdrhQOgS4tZ6MhGrqnDKNL
MIME-Version: 1.0
Date: Thu, 19 Apr 2018 15:23:56 -0700
Message-Id: <20180419222356.242535-1-hansens@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH] Documentation/i2c: direct users to i2c-tools regarding i2c/smbus.h
From: Sam Hansen <hansens@google.com>
To: linux-i2c@vger.kernel.org, jdelvare@suse.de, hansens@google.com,
        wsa@the-dreams.de, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: jdelvare@suse.de, Sam Hansen <hansens@google.com>, wsa@the-dreams.de,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current examples reference i2c/smbus.h, which is the first reference
in Documentation/i2c/dev-interface to anything related to the i2c-tools
project.  This moves the existing reference to i2c-tools up into the
C-example, directing the user to the project's git repository.

Signed-off-by: Sam Hansen <hansens@google.com>
---
 Documentation/i2c/dev-interface | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index fbed645ccd75..ed20f7b7851a 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -23,6 +23,10 @@ First, you need to include these two headers:
   #include <linux/i2c-dev.h>
   #include <i2c/smbus.h>
 
+The i2c/smbus header file is provided by the i2c-tools project.  For more info
+about i2c-tools, see:
+https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/
+
 Now, you have to decide which adapter you want to access. You should
 inspect /sys/class/i2c-dev/ or run "i2cdetect -l" to decide this.
 Adapter numbers are assigned somewhat dynamically, so you can not
@@ -163,10 +167,6 @@ what happened. The 'write' transactions return 0 on success; the
 returns the number of values read. The block buffers need not be longer
 than 32 bytes.
 
-The above functions are made available by linking against the libi2c library,
-which is provided by the i2c-tools project.  See:
-https://git.kernel.org/pub/scm/utils/i2c-tools/i2c-tools.git/.
-
 
 Implementation details
 ======================
-- 
2.17.0.484.g0c8726318c-goog
