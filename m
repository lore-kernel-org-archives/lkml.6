Return-Path: <outreachy-kernel+bncBCAMTT4T6ABRBRF25LKAKGQE756VZKA@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520082244; cv=pass;
        d=google.com; s=arc-20160816;
        b=ldc5lVJ11l3Q2zHdfjMc0zncqLsjpEZkVyNggO5lNX+kpiuJJvz+7r8cClarlzJsMz
         yixVS056yJMXWmwCDWTHOSJ7fMjAlhy7txZQ24MSudEHnqZ3Jwg7IRXmGo7idEdQrEqS
         j8f1SSRl1nq/xXTWU5XxEaNNzeI5rFoXKB9LooT0kO3hmLOKXtIpjfDvLZzdS5iGp8cM
         phEA6oB5ZXx0glF5efmeKUtaKpzknrL70/+r6kWc0vSHMxqvdmqDR19S5ubQl8jHmzJO
         oT3ao2VxIWXNRRl1ZY44q3sdBkFd7Qu9Xi2fgdKoTUjnJdgLLztDBsmV+UeL0rmuf3FV
         MhYw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=ZflDCOYrngER0v67rNtZlT9g68rPlwkKQtDnTZZm8K0=;
        b=TN05K3bhFQvNkjgTNqWKQ1YNiPv8LZS6Bbb5MZbNptE+ObX+kAGXdZJttHDjOR2jzO
         AY/fDD4Zj9kRRXj2vLjQ0gcV1rDgNac67czHFv9PRHQ8TdKBE5QduTfKRPA9GXe7CyN1
         S3rt9bQ2vkeemqzqLSkcvCaQNUB5VA3DGcKCkI18KrT9XwoyL2AKOtShbzvqvjkwmET4
         NMxTeKKpDXx2+dN6GeX3tfB2v3d5IaKgfesPDJx87kyRH0MFhU4gorjjenZ2uzEqUybh
         WkSqOCAvZ4gM6yjjUZuxpYdYrqV8ekdQ734X/hsrTrfu3YvpFnjToVQQpAwUl6LMsV3y
         ShKA==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=awX+Brn4;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KHOO2YAn;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbrf25lkakgqe756vzka@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBRF25LKAKGQE756VZKA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=awX+Brn4;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KHOO2YAn;
       arc=pass (i=2 spf=pass spfdomain=gmail.com dkim=pass dkdomain=gmail.com dmarc=pass fromdomain=gmail.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcamtt4t6abrbrf25lkakgqe756vzka@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCAMTT4T6ABRBRF25LKAKGQE756VZKA@googlegroups.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
ARC-Seal: i=2; a=rsa-sha256; t=1520082244; cv=pass;
        d=google.com; s=arc-20160816;
        b=wimFp0rOIqVEYevcFb93r7yYJvC2bxRLQ6j8GU2YrEwfbGMSVbrFLkwDYmBMQWN6/v
         DcmzptYIozEmi98tMcukFrj/FG1c0BpaCyhkEaHNH0WSajRPoKbVK2Pv05hlarNwnojh
         F3MykZxqCOGQx6KEOsg2HsDuaTMGeN9BfGltTbmO7ZEpcQGn0lh6+mokXd37wViYnW4U
         rsdwRTcfCW1Pa4FZqZf5HgkE540H7WjuMDTNQKqDnSAAWk++jVbz5s3+SERY+WrExLoy
         QAtotzYprDcpXlJAcbHAg0qX279oa6lHkibwIMQjsGMoVcM+Eu6S3rEN4m6MZPe5qF8O
         SKMg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:user-agent:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:arc-authentication-results
         :arc-message-signature:sender:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ZflDCOYrngER0v67rNtZlT9g68rPlwkKQtDnTZZm8K0=;
        b=V3fASJRq3pJ7ZLZIrE+sSxcTDZhY2kc/aigvHAXsNU3VOx+2UjVkAeLWdUNpUX0vNm
         lCQ9rP80U3iEBuXNePAJbfH+N9dZsRzWkw4qL3MGpLuIRLISgRz2BOY8DfMfHIFYoX1n
         pMYfXfIqxuGHwI/YyHk2UYUSMNyJi1fXdd5unup41O3YVENBPecRVCv2hLayJ233y542
         pXiSFFcPKod/OCqFxkPbIjkLUAjY62180yz430UQuoVJExGbulPbFB0snS6JXAw8Z+Sj
         Cy/1E5LalTRviRAbDheQz0n7E0mrWEDxii4GfcnOme7hR4mhksnVbFjcEtxsYxYHd8vX
         Byxg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PgBPDVAw;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::241 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtjtiIg0mmpeu4L4WnUjRWyC0O9YL8scO3Y1fpX5X5idr08o+5Di4M/NbiTQpExOb7Z0cCQyg==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520082244; cv=none;
        d=google.com; s=arc-20160816;
        b=wPG1h3v0AsMNvGlaGEHRu6NgQctYK//pCFq6giBuyqIIgO2ZlTsTv36p4YGyPPnC5D
         T0UHvdRRooSzCzsoaT1BOwpRB4Fx5g5CB6rnpjaqU0+fx726pS1HY0THBlMHs4DhmDG2
         ur+sND0YDpVwy5+I/FWiZhLpO5oYlEQXSKi/ffgTNYu7LYQSDYA8a5NTi5ruuobPFaaK
         5491MmQDyRrVKVoEDbT/G/PWoqY/VdmV//7rckdZlSZ2TFp/jyvnH6JBbZJBfJKjj/uF
         LNR5LwrGG1KKtkFbT44WggFQxBUSih2oYz+9SACQALkLz1W/QRdcAoRIwKJTZQ+Mf5Do
         F/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=6Kc3nu+Og7Ox1yaDfazBbKTM7lbK18QGdkuY70ZKhk8=;
        b=eAKNmI4jJRiAPu2S3hkh8V186xHeiNGf0R6PBr9OKbrik156iy4tkT1Skau2ER34G+
         90CnSvo2Mo5tx93/tIrrAu7oPXXeay5gXWauvUWzHBc/sUbDXaWeR+5IwfyFrU1wSKXS
         4c0KQ1u10oj62E0suODZyk4yJr3+Ro7Ayrp3GlHszhhCerAQQekQYYqxLhdTBU/5R3NP
         EoHwhuMWDp3K+KbKaR+OvloteJYe85EDVAaMZZtITwGWJlZ8o3bswULE5xoiHewtAmj/
         Gj9vtMx97HOizro8PeYgF1IqWyoM4yhGeLF+4OxXPoySXnr8D1GyVg29c/R5md1wrLwy
         DT0A==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PgBPDVAw;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 2607:f8b0:400e:c05::241 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Date: Sat, 3 Mar 2018 18:33:36 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dennis.dalessandro@intel.com
Cc: mike.marciniszyn@intel.com, Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] [PATCH] infiniband: hw: Drop unnecessary continue
Message-ID: <20180303130336.GA8210@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Original-Sender: arushisinghal19971997@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=PgBPDVAw;       spf=pass
 (google.com: domain of arushisinghal19971997@gmail.com designates
 2607:f8b0:400e:c05::241 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593921759797565624?=
X-GMAIL-MSGID: =?utf-8?q?1593921759797565624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Continue at the bottom of a loop are removed.
Issue found using drop_continue.cocci Coccinelle script.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/infiniband/hw/qib/qib_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 3990f38..1bd3b32 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -681,7 +681,6 @@ int qib_init(struct qib_devdata *dd, int reinit)
 		if (lastfail) {
 			qib_dev_err(dd,
 				"failed to allocate kernel ctxt's rcvhdrq and/or egr bufs\n");
-			continue;
 		}
 	}
 
-- 
2.7.4

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303130336.GA8210%40seema-Inspiron-15-3567.
For more options, visit https://groups.google.com/d/optout.
