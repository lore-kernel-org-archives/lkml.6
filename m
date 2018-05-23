Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527104071-2-15081050180320011342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527104071; b=E/eZGyBMVCxYnKk+W04ApmvTZov0apZZRS14HeqiEKIGe2KE+N
    FXT6/6CF5ayqoBv+6cIl1DHkVbopx8QYRfsViD4HX5Rur0iXNLtW4Y/DKlOhTe+h
    x8aOjmvvf33uqqyz/ulWDdiy+QYXMmUqOd3nBihttocL3Ww7IHqsdFK2uxWtCpji
    wn2T8K4NZUbLX0o9hioZak1/REZC3R2ewS9ZJh8VjJiLeAR3J1HmfPyO47DbCHq3
    7Ahh0XFw6sYn1sIyPXzMy4FP4wLIsuJG9GpeqqRLGxVdao1XuAe9lmH9YgNBkEVN
    bNecoabdubqFKZOa9VVLlxOiUvI6OOhkZXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527104071; bh=
    vjTfOMnLCKr4ZfnFxQEt2DRnrp6tLE811oOP20OqJ50=; b=LsG7jj8TaK+g7H9P
    7HyIZEPHPFSWddceNJyYnvmsXWXhIBSjZ5jBPnPPKIMK5rp+YtHLDkcizO2yqGpu
    jRIdUw4hDOdNlTstUEj/9jhwva8eP6cVUulXsknPTM5Il3xWJrs6JmXWNtXPJaZF
    nxUgbAZxFLgejzJ196/TKU5wnlV/VqEkMDTwxm3qcaROvkQfjQu6NmvZDpYS+Xfk
    svTV9CMWfGLmZzjhyU73ijl6RQL0aFZNylahPcmsKLBMQ04O4RPM/SgoeBurVduz
    77AQ4BNI7MzfYzmfFNRNAEjxPpWyfCe1ux2vuBgdE9cLqjAV1+80Qg4GFwQciS4H
    MZUsAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Zn9MVMZ3
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Zn9MVMZ3
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEZQ+365jt5lD8QtE0bPkkZnoX6SdSXeAPd0HJ9W6EUOtDw+47Hy/ajRztNWI83b5kZq6fsf3N9PJ0barEuLP0NKKkuBd8WHXbOBmsE9Mn8h3wA1szDb
    bsfAG42a4nI7Zk5sVYuEOtVmCWA3AQF/RK8geaIRK36BgNWV+0T0sp5mer5d1sAbMLe3OYrY3ZiLRkI2MCZiZf2BPICtsvuK1OTX1iCRHU+ekmv/K6Yj8ulW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=SpbB-_G9PZjyH-7U9rAA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934318AbeEWTUh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:20:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934090AbeEWTUc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:32 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/33] uapi: turn __poll_t sparse checkin on by default
Date: Wed, 23 May 2018 21:19:51 +0200
Message-Id: <20180523192022.1703-3-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/linux/types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index cd4f0b897a48..2fce8b6876e9 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -49,11 +49,7 @@ typedef __u32 __bitwise __wsum;
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 
-#ifdef __CHECK_POLL
 typedef unsigned __bitwise __poll_t;
-#else
-typedef unsigned __poll_t;
-#endif
 
 #endif /*  __ASSEMBLY__ */
 #endif /* _UAPI_LINUX_TYPES_H */
-- 
2.17.0

