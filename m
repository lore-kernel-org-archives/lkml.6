Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+JKiq76qndrLC/1wUFBRPWxkinQm6DUFVUeYQ3wYeyx/bL6Ri1MoIIKa93SMLavIUcCCWo
ARC-Seal: i=1; a=rsa-sha256; t=1523363087; cv=none;
        d=google.com; s=arc-20160816;
        b=03xWyQc1jRWe8eidNCU6OA3kUifVtmzcX0uqrlxJFOrqHUoHgjc/0Rcbv7oOnMb29e
         /7Ge4CECIWK8JI/bFXjrRmvAh0ATfj7wsVKPxfH3WjGnuwR9Y08VomYvdw0ubxnQSPTs
         1AKOKoQGsOxq0j/S/ltJRZpU+pb0kc7uDnmhtSrxk6/KqDtHwDoKXv5CCg4vceMSxskw
         X+eFewj5xn6KU4wRbI1V4SgBJrcOLHp7cQtTDf2unPVInXRarPFOENU/xsScO44yXcWE
         uusXGI28kwdzWoTVu4lbtsnDwr4jfRUc8ewn1m+PrxMk1ZLxed8afoTZZuFDk35XLYtq
         gJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=oRwbkJHI7cDIjtpaEV46uqXJpwIxgAGYs/YhJqOtpnU=;
        b=lcOrFk/kdBbNCJMl4yq6Qj2BeM+09XHxCaPimB1Hz0aHl4NtlYYLnkH22FtkMFLy3J
         xmftnhu1eWuqJj9dp7xGwGwwAENXjGSroQ2bFnAObNLIi52pUSLnetnwru4K+cTYuanF
         Z/8IXNWmAJCaLQ8mZHQPyQF2rdaXrbzW8aKxFL64BRafM2bo0UqifjBW+QL3PxHpCdGs
         25rorvq9zuL6LgpWkHwSXNrVEVF4IcWPU7Z4tLRVrNehTAK+IR9cL1yVPKxnddLIwMdx
         b34DHl+ELqfVNspoSXXISrXqWPpOegvjyXsKx+S3eugvPwvJfysvYjjsVNZO94nkcPn/
         JSYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=JxEp/mZG;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=JxEp/mZG;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeDJMYq (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 10 Apr 2018 08:24:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33989 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752921AbeDJMYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Apr 2018 08:24:45 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: daniel@iogearbox.net, ast@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: update .gitignore with missing generated files
Date: Tue, 10 Apr 2018 14:24:21 +0200
Message-Id: <20180410122421.25393-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597361972964244768?=
X-GMAIL-MSGID: =?utf-8?q?1597361972964244768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 9cf83f895d98..5e1ab2f0eb79 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -12,3 +12,6 @@ test_tcpbpf_user
 test_verifier_log
 feature
 test_libbpf_open
+test_sock
+test_sock_addr
+urandom_read
-- 
2.16.3

