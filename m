Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755502AbeDWN5l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:57:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34073 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755482AbeDWN5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:57:32 -0400
X-Google-Smtp-Source: AIpwx4/pzQgC+PxxYuEl1j8WUWEjP/0CetU6y9NusDFUv53Z7H5ElSeVXRTUeVX1v/larfBilbt7FA==
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: kvm: update .gitignore with missing file
Date: Mon, 23 Apr 2018 15:57:25 +0200
Message-Id: <20180423135725.3753-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: d5edb7f8e7ab ("kvm: selftests: add vmx_tsc_adjust_test")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/kvm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index a546e052d19a..63fc1ab9248f 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,2 +1,3 @@
 set_sregs_test
 sync_regs_test
+vmx_tsc_adjust_test
-- 
2.17.0
