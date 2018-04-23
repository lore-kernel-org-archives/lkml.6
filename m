Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+/xAS7QuvGKp56cuTptH4tEc0JPuACeFOc8h6p5fjhI4RsRYLgOSEO0S8jKqfA+d2mjXcg
ARC-Seal: i=1; a=rsa-sha256; t=1524492069; cv=none;
        d=google.com; s=arc-20160816;
        b=CBBixlK2SzrBH/QlSr+nwzxj+T4WJPkXcWR9ykZaGA5+/Yw0Ntz/F7cQD0x5Ycd9so
         pGxAPzewJ9mGKvvb/zDJMw7eDstsJMkpNhAh74idNQCHDWDev0SNsjelhyzrxG0fseEI
         Q4hC+UkgwoDolKjEh0LdkLYrbKj4F2+VJ96bwesZu/yHp8kGAi7TvStTF307pGkV/g3k
         4KQ4NEX3chG9WKPAegZ0uAVuQ5+nLzpCuuJArlY6Wmxs1eHZsWhHe6WjoPsiXURpamHa
         8pYfvj6pycJK8pHAc5nhEsL1OII6+gtx28K39iWtveOIVn0QVkx8rHoAIMUhaG5X9BfB
         YTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gjRyfB7YQYOBpaf6YpPSpjKLq0fnuX+J5LUhBZavyNQ=;
        b=fj4E3Gchuifb7VD8ov/UOgjFWQvDHJL+ESQh0E/tVX+xDbXAVJnNDGn/i60H6VIPol
         jaDytvDxgr/DJgvIKppwlqIcnhC48JRKDyPhyFu+Cp3Cy0jOChjwZiFWONMm7yOZZSqC
         1hFtW79x0PeXb1w5FXNQNE9wpzoTf/uwwj7evmV9zE8m8JBBVVJWA9KocP8UoFJjLe2I
         Rxs8VU1Gr+NBNshMSrnBgp7YuidpOa0Ow6eA+Nfbsy76Z3G+l6044ARZPmrQfm2VFGUK
         RjWVSFdVYPBGa2vIOVVIRSA0+yUBAlcg6SvL1tTJoYhFGVXRqvLJzuqv17w7YBdf2Lzv
         attA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=V9nG2qUX;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=V9nG2qUX;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbeDWOBI (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 10:01:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37412 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755386AbeDWOBF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 10:01:05 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: update .gitignore with missing test
Date: Mon, 23 Apr 2018 16:00:50 +0200
Message-Id: <20180423140050.4508-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598545796050250563?=
X-GMAIL-MSGID: =?utf-8?q?1598545796050250563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes: 192dc405f308 ("selftests: net: add tcp_mmap program")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index c612d6e38c62..5559f6add046 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -7,3 +7,4 @@ reuseport_bpf_cpu
 reuseport_bpf_numa
 reuseport_dualstack
 reuseaddr_conflict
+tcp_mmap
-- 
2.17.0

