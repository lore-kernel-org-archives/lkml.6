Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx486xHhtA2P5M4NYXwgxxj2eZXylvdIwKqKUKJspb15Pr1+6Js5/EeTlJeAvYY6ONRpfe2Se
ARC-Seal: i=1; a=rsa-sha256; t=1524491470; cv=none;
        d=google.com; s=arc-20160816;
        b=ebedrmWQR0qmQhADT8wJ8T3THFniPCQDHj9RWP/x4yYJUOQmyVG0D5i2Dih2C7ErRe
         X8dJrsYjNmXUtBOcaB51MKNA3Xiq34lGDvub15ZCLiQcdM7iadTsZrrfUIkGGicDH/Bl
         i+jw7D6SUqgZkxSq4lSfJujC16yktEZGHfzvy76W6kGIPYTtWvJ0sVbcKDi4SWD+kzp3
         j/I+9nBf7doMN4EmQIVkKRXJR4N06rXtsTnB2pizWOVu7D88PmD4u8zYwDr7pohzRM2i
         ItbqML4hUH996Ato68uBtjAoJSib9Zz5MOrseKuDKkHzYXqDf0ZWpiDykpSY3OmBGkxb
         u0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HlVsSwz3N6+UtrV1+7rElhj211UhQUCMfHLyZcYN0kc=;
        b=bOPtS8k7cuEXyD8vqwprEwzERWS8240g0K0j0o7OhGDUVxqxLLPgG8JUGeqLunveR+
         A6JFPKDtMUgXV2fjKV5QIxm89TXMs38eAyqLM9CXD8arkDfs9QqkoSOtdh4ICkQmfGce
         3TIQlL2lr/RjJlk33XEksonl7Kr0dz+CQyqx1UVYogpnJnq5YfnnQsszdUPA4YJEbNC/
         qz7Y886dTCEJWkYSn/w4rwC0LVwEqhXoYm6vG9ND08Ps5xAoOBBYHExAmHtElNpkE+92
         Wr/XW5mc7i6v9S+m6kp1/5STxXx7K7Yx+4vCRATgofUCUdBekPU40BDrc1tTkYXjgvCS
         Uwhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=FZ6LKWFK;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=FZ6LKWFK;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755307AbeDWNvJ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 09:51:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40299 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755126AbeDWNvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 09:51:08 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: update .gitignore with missing file
Date: Mon, 23 Apr 2018 15:50:57 +0200
Message-Id: <20180423135057.951-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545167658218974?=
X-GMAIL-MSGID: =?utf-8?q?1598545167658218974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes: c0fa1b6c3efc ("bpf: btf: Add BTF tests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 5e1ab2f0eb79..3e3b3ced3f7c 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -15,3 +15,4 @@ test_libbpf_open
 test_sock
 test_sock_addr
 urandom_read
+test_btf
-- 
2.17.0

