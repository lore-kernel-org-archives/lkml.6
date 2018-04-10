Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48WAoQ5tvTBui+qU1RSo3EB2iFSItmKG7JLzLRmH9u3TduiVPJD8mn7RgiaUaaKWoOOfEYf
ARC-Seal: i=1; a=rsa-sha256; t=1523363957; cv=none;
        d=google.com; s=arc-20160816;
        b=nAavaCWGezBxurhEnt/pDqU/y+VU+VmJdU4IxIWN3A5jWpINQxqwvFKsKrkNj4xz5f
         a9LmCQArLC0LJEy3vClHzb2Cb5mIBIa8tngdENnO+B/LLP/dITeOWTuxW31gtU5vE+jc
         G02KQRVHjoJOKncEvQAs73z0VliOXDlgslc6/RMFz2XQyF5Jw5IGlYiuOxMnwWhFItvt
         M3ClRYdIQTIbpyYz8W8fxswLh2BJPDxmRu3Tf3OHc0L6eLGFJCiJs6GxIGKYZIoxZG38
         aFmeqcl4TfB37qKJzTQgZK4BZxsdaBbT9r5KlNNZMEzDszcZ/mC+uvJEeWxcajtaXXs+
         obBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=fmBoFewTGRjRnM2adjr37suYC2o6RS+BngJTjoAvjsY=;
        b=vD6B/5D3unNYaKGkcULiArMWcVMOPH+CWN1iCflXZ5XLwmmwVX5tootP340iPVZtaT
         2xDwSjuLKLkBkt5YRJVpL40mCszpMiV1RL3AG6vheRmLGFVMzRYi16TNXZ6fBMHsLrRc
         9V2WMuF1nWLSVXpdrjrjHoGBsuV4V3irHWInCdZB3ZGKp67awbYRbaUj/largRNUxegf
         Lz+HlRdup83hpLgye9InJNOSKbdNmf5gE6hq1xta7r8S5P40t05MjC0Jsf1h3huqEP9l
         bdld/PALUN+sC1jrS7Z1mHha55E072uduj9xCIo904KooBDMiSTCuhKlobJRTbjhMAas
         Wovw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeDJMjC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 08:39:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49343 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeDJMjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 08:39:01 -0400
From: Colin King <colin.king@canonical.com>
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Ken Hofsass <hofsass@google.com>,
        linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kvm: selftests: fix spelling mistake: "divisable" and "divisible"
Date: Tue, 10 Apr 2018 13:38:56 +0100
Message-Id: <20180410123856.24869-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597362884933828919?=
X-GMAIL-MSGID: =?utf-8?q?1597362884933828919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in comment and message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c  | 2 +-
 tools/testing/selftests/kvm/lib/sparsebit.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7ca1bb40c498..e213d513dc61 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1435,7 +1435,7 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm,
 	sparsebit_idx_t pg;
 
 	TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
-		"not divisable by page size.\n"
+		"not divisible by page size.\n"
 		"  paddr_min: 0x%lx page_size: 0x%x",
 		paddr_min, vm->page_size);
 
diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index 0c5cf3e0cb6f..b132bc95d183 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -121,7 +121,7 @@
  *     avoided by moving the setting of the nodes mask bits into
  *     the previous nodes num_after setting.
  *
- *   + Node starting index is evenly divisable by the number of bits
+ *   + Node starting index is evenly divisible by the number of bits
  *     within a nodes mask member.
  *
  *   + Nodes never represent a range of bits that wrap around the
@@ -1741,7 +1741,7 @@ void sparsebit_validate_internal(struct sparsebit *s)
 
 		/* Validate node index is divisible by the mask size */
 		if (nodep->idx % MASK_BITS) {
-			fprintf(stderr, "Node index not divisable by "
+			fprintf(stderr, "Node index not divisible by "
 				"mask size,\n"
 				"  nodep: %p nodep->idx: 0x%lx "
 				"MASK_BITS: %lu\n",
-- 
2.15.1

