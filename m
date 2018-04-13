Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeDMRnU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:43:20 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:42113 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbeDMRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:43:15 -0400
X-Google-Smtp-Source: AIpwx4+j20zA1e0rTjp/y3MenFoLGODhXVhc1YW0omiJU9mUnWkfMgZ0JIohx6dq7+wl5LmxFal9uBuRM+PB
MIME-Version: 1.0
Date: Fri, 13 Apr 2018 10:42:57 -0700
In-Reply-To: <20180413174257.139182-1-hansens@google.com>
Message-Id: <20180413174257.139182-3-hansens@google.com>
References: <20180413174257.139182-1-hansens@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH v3 3/3] Documentation/i2c: adopt kernel commenting style in examples
From: Sam Hansen <hansens@google.com>
To: linux-i2c@vger.kernel.org, hansens@google.com, wsa@the-dreams.de,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sam Hansen <hansens@google.com>, wsa@the-dreams.de, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example I2C code is rewritten to adopt the preferred kernel block
commenting style.

Signed-off-by: Sam Hansen <hansens@google.com>
---
Changes from v2:
  1. only the block comment is updated.
  2. one-line comments are reverted to prior form.

 Documentation/i2c/dev-interface | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
index f92ee1f59914..fbed645ccd75 100644
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -67,8 +67,10 @@ the device supports them. Both are illustrated below.
     /* res contains the read word */
   }
 
-  /* Using I2C Write, equivalent of
-     i2c_smbus_write_word_data(file, reg, 0x6543) */
+  /*
+   * Using I2C Write, equivalent of
+   * i2c_smbus_write_word_data(file, reg, 0x6543)
+   */
   buf[0] = reg;
   buf[1] = 0x43;
   buf[2] = 0x65;
-- 
2.17.0.484.g0c8726318c-goog
