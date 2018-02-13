Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x22789eJttOg1vBKiNwrER6IpFuB53lGLl0PxVh9LahxCuYDmZc2jeIYwbn5B8cWoWe1qoNtg
ARC-Seal: i=1; a=rsa-sha256; t=1518558302; cv=none;
        d=google.com; s=arc-20160816;
        b=HsZfH6sUVNe3M064RHdJGGYJ8jrcwv7NPaYwKvvv66SxnWIayXRs7//vObG8JHz9dx
         aNsYs26/JGEL2bHfgkZZfI+wc6LlEEFs34dX8XwiD/DOl5U78Xy+qeIsNmqPFOC60d6H
         B6I9VTbZr+plwYvHAb00k1e50MUb9zgafylHwpiP/fpR1bBIc8YUcOmjx/ZGgFiHwvrr
         JV75HlXcUoz3fT7MQ04l5Zu27RmEKzoJKsdAFyb2EGB4G9JUcCrP2NhpaarUbGJbExdf
         J+4TDXUa4RsTpYq9JdnqNo73FWmCyJuTzJOJuf3WYg9pec8dVumQZQ/sAibgSL0ZaD3L
         j+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=M8MRbYAbL99RHHEhvpHKHAZmz9CkCt1bSt9xwkdA8bw=;
        b=Ns9Zlo3CRQ4dhsXyEZKp46oG7fOJXT1QDXeC9wT83iMcbmjKA/HM1rL91Tf+XMXnUi
         cWxiLeZ9Q35r6SSnUDDBjxMTH31ilNuLnKiVQGFuZqC+MMrER0ZFWKCNMYHI92WfL0sT
         L/ozojN+4Z1Zl1iSUbILEyJseGS5zVQ9GUd90MlUNPFry/+qlwpcGb/u/dpR4YAhD5dP
         hAqljI3h0XA11dZilYP2AriUHE3mjkc08HD8I32glVhmw/pqpde8VPv/OgxizoE/YLI6
         b1Au4CNsgbjErZlvcMrj0LqaOEy+gFAdBZv8KMPiCUjBjO86iXhadHNWempXdbYsipQP
         n8ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965934AbeBMVpB (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 13 Feb 2018 16:45:01 -0500
Received: from osg.samsung.com ([64.30.133.232]:64207 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965843AbeBMVpB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Feb 2018 16:45:01 -0500
From: Shuah Khan <shuahkh@osg.samsung.com>
To: shuah@kernel.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: vm: update .gitignore with new test
Date: Tue, 13 Feb 2018 14:44:38 -0700
Message-Id: <20180213214438.21771-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592323790501707679?=
X-GMAIL-MSGID: =?utf-8?q?1592323790501707679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Update .gitignore with new test.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 tools/testing/selftests/vm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 63c94d776e89..342c7bc9dc8c 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -11,3 +11,4 @@ mlock-intersect-test
 mlock-random-test
 virtual_address_range
 gup_benchmark
+va_128TBswitch
-- 
2.14.1

