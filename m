Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeDJNsk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:48:40 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42305 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeDJNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:48:38 -0400
X-Google-Smtp-Source: AIpwx492rA8Xah8xwKsHdM3uCk8SFgWhZEG91t+4QCiCsc71MgaxdMli1laW9COkPeW7wXKCjYFFhA==
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: kvm: add .gitignore for generated files
Date: Tue, 10 Apr 2018 15:48:22 +0200
Message-Id: <20180410134822.23990-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/kvm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/.gitignore

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
new file mode 100644
index 000000000000..a546e052d19a
--- /dev/null
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -0,0 +1,2 @@
+set_sregs_test
+sync_regs_test
-- 
2.16.3
