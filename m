Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49cq54WIrtUsV8fhso6iNbK/DKEdloPxSq+RVXR3OXv++My3+OVLCKcz28qW3m3cdkhsKxJ
ARC-Seal: i=1; a=rsa-sha256; t=1522344277; cv=none;
        d=google.com; s=arc-20160816;
        b=bZvrlfrOhaYBRgyoHmziM4+fDkVeSHulbxLLhR4eeeOLV+AMTj6+xuMvvluONNZTZX
         2kvn49ysV+Yd0auLQkJ9+HFACgKoabjTHaEHzgOrG2kU/HZ+rZVMkb8c9sWWhwel93mX
         eYuQTlKzoUKi0ln4HFeO+w8kYcQbGV/isyzXZKSrYJ4m1XAk2M6DTxx3OLGGP75XrUyP
         yyCLoHqJuAOzEBn8GPBJTgFKSRNwZGARuxF1WI+BMn9gS/S3NbGUFf24ygQ268aIJPqg
         oLbwMtAfJsSXwBEqeDVCkYgIADV1JjRhKedIF+2zsKfvHBmiPBFB7XGEVC/kujyBT2zo
         I+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=WTQLItB76ZiPg4D/QIGqzPkhWgRFs2O37VdI12/Wbt8=;
        b=vXApU9aA1OW+hL05JBLcJTN70q4qefUkYbMU8z1q7LOXsxO/YpPmvpM6B38nLd4la6
         5v58Og6P51zGjRGE/lhh3UdJFgi2a6EW0q1d1OvmNjqmeskRB/QfSn8IE4AnaPou77r4
         fAV07qxBN8Jvx4KX8E2iAprLJf1BV5Gr6dvwVicbYKEP759MY4BHfipzXKHYC/WSXt3Z
         SAd9nI7n0IRPyyvEJzDek42GN3Esw4BWEdFtMRXDvh6iTJNsFYpJH+wiUKcSy1NLYdEb
         6QTS/PO0OolF58vkemwboE3xO/C4DScvwT6eohuJ8WsrEz6pWu0AvnHVpxlr2Iog9G5+
         1iiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeC2RYg (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 29 Mar 2018 13:24:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46759 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC2RYg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Mar 2018 13:24:36 -0400
From: Colin King <colin.king@canonical.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" -> "triggers"
Date: Thu, 29 Mar 2018 18:24:31 +0100
Message-Id: <20180329172431.8171-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596293672950856020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
index c5ef8b9d02b3..1b8faf4c318c 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
@@ -35,7 +35,7 @@ do_reset
 
 reset_trigger
 
-echo "Test histogram multiple tiggers"
+echo "Test histogram multiple triggers"
 
 echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
 echo 'hist:keys=parent_comm:vals=child_pid' >> events/sched/sched_process_fork/trigger
-- 
2.15.1

