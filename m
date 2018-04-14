Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+COiT7gQ+hx6BBv/ibE8OILHyPHV9CvCEfoKR55AhLGaTTFtAV6yp/nILWMsQQY5HF5wf5
ARC-Seal: i=1; a=rsa-sha256; t=1523703111; cv=none;
        d=google.com; s=arc-20160816;
        b=TGcZv4Iczv0nC4NRi7DpAIH7hJX8xB49TKHJCu0qdAecoMXa4qHrXHwreMe7ssPhbh
         T/02ARD43fdfeS7raf5F0l0kPMceZjflPT3962lS5FUsXAInS8lW7Bv0zgZTQJIpTlCU
         I8398dBS6h4YXgQh4RmtQ0KNtUJQWozU8KizPplD1QvgFXY7JvnTz98P4ZH/RYQriRHF
         MIogoeZFLamJ33CNSUO2ZnZ+A/uAGk5yQlT9/Ebx61pht0YJIUjtk2w1wI2UkUWIUOWR
         uRqV00b2xWO14j3BW1N/vJ5Wmke72MiWP/WZ9Fpxps4oF82vVo5c/KT30E1381t8rALO
         LCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Ej3Z98ldvKQiQreoMyOQRsZI2j1KxM0ZSiR57fQ3+uM=;
        b=TbSE0gppkaqX2aa2SuMPAKPP/te1PJPuaCF15jF9p9J7OlMmSJlhvnoZaLecquf80a
         iwjro1+yxi7inzpTkjDWEeVHur9+x+qLHMs610+8GCs3cOLcdwHVtL8LaOIW6yTyLlNp
         Q31A+nrJOzfjDqltSYAoDQKtbUN3Dt2RkFbS2MO2nrOP1NBkXoPdHo4hopsnQMDMbOiN
         4+HK2ZlXZ6WZNmJU0Td2+B75eQqf5zPKxsJqmGU1F0kjWhc3G0nY4lm+wYAQy09UBsuy
         6/2l/vIfHPfDEZEJA2r1Y/HjZAjY0+iW/PPJkomE0OhAU+wglCPgDw1ejX++wTe7sM0e
         WAGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750965AbeDNKvv convert rfc822-to-8bit (ORCPT
        <rfc822;gregkh@linuxfoundation.org>); Sat, 14 Apr 2018 06:51:51 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:43558 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750939AbeDNKvu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Apr 2018 06:51:50 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
To: shuah@kernel.org, aarcange@redhat.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] selftests:vm: add include file
Date: Sun, 15 Apr 2018 03:08:56 +0800
Message-Id: <1523732936-42546-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-04-14 18:51:53,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-04-14 18:51:23
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn w3EApggD082811
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597718514051062643?=
X-GMAIL-MSGID: =?utf-8?q?1597718514051062643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

userfaultfd.c: In function ‘hugetlb_release_pages’:
userfaultfd.c:145:25: error: ‘FALLOC_FL_PUNCH_HOLE’ undeclared 
(first use in this function)

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 tools/testing/selftests/vm/userfaultfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index de2f9ec..d8fe447 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -68,6 +68,7 @@
 #include <linux/userfaultfd.h>
 #include <setjmp.h>
 #include <stdbool.h>
+#include <linux/falloc.h>
 
 #ifdef __NR_userfaultfd
 
-- 
1.8.3.1

