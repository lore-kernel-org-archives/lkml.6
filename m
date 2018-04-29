Return-Path: <kernel-hardening-return-13154-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrXbaUeQh/9W07rBRqjvTg4jxETk8lpKZE/KhI7zizxanj4If7m91leHYBfbulp0HqhPJ45
ARC-Seal: i=1; a=rsa-sha256; t=1524970005; cv=none;
        d=google.com; s=arc-20160816;
        b=Apn3DRF8nkmpuKV4vfjLN64AbmlMtM+BxtJhYMOWrtdntt6wRBXOkQWNPmuOz7I2qg
         N5E94Muk5NfQS2cv+5MI9Ly/WG8V/tUr4Axirml7Az0pNXyGC8e+gPRgpmkeC8PjHE4Q
         dLcmjHQvzo4/qtduT/gk1uxUDURhdoD+Zu6UoQZD619qOj2igM35jJn0euIpuaiAOjgg
         PvaYLpIhoEQ25P66bO90S1QtTF6PKyIZgqaNToL0bDkYUXz4QGBpVLOCD38mLRJFBOLw
         8fha7fQJLFWIc1aYpuGVKdapLQpc/8XnAzVRRUV0dJkC7vzaAEAjS1p9ZDK5BpQZjRjs
         a0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LgHueGsbNfB6XIjd7SXXhyKi9rsWMZceKqKGuRkq1Kw=;
        b=hSRaZ9CgduP/TjmbHbGXqPlgizwtrVo2FRuVGTLGb0mvzAc6AHMfKlHcCQSqBdwgDJ
         23S5Z+EuIwFHqAbuFgXtTQ0wbZyjg5WdZ7fU9b/8nCzdji4KAjCyDAx9r1VE7kERB/VO
         IfVbFZNd6u6RsZ1tHa+YgyqK9+EaB/lvTLjf1PhDWES/aoEsyStFpbxCjeon/ytro20+
         RX0khs/LhboAmQN6pybsmIVcvVlFPeNrpa9QDBtfhFV/rr1XnVJUsiYY3prRgif3dyds
         WA3FiFzCVowdRvvePcd7Dyb4HmGMNhBF4RVSfi38b1fNY4ON1L/P/KzNIU8UGMgtg62e
         VGWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=stdFSP0s;
       spf=pass (google.com: domain of kernel-hardening-return-13154-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13154-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=stdFSP0s;
       spf=pass (google.com: domain of kernel-hardening-return-13154-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13154-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: mhocko@kernel.org,
	akpm@linux-foundation.org,
	keescook@chromium.org,
	linux-mm@kvack.org,
	kernel-hardening@lists.openwall.com,
	linux-security-module@vger.kernel.org
Cc: willy@infradead.org,
	labbott@redhat.com,
	linux-kernel@vger.kernel.org,
	igor.stoppa@huawei.com
Subject: [PATCH 2/3] Add label and license to genalloc.rst
Date: Sun, 29 Apr 2018 06:45:41 +0400
Message-Id: <20180429024542.19475-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180429024542.19475-1-igor.stoppa@huawei.com>
References: <20180429024542.19475-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599046948353861383?=
X-GMAIL-MSGID: =?utf-8?q?1599046948353861383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add SPDX license to genalloc.rst, then a label, to allow cross-referencing.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/genalloc.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/genalloc.rst b/Documentation/core-api/genalloc.rst
index 6b38a39fab24..0b5ade832ee8 100644
--- a/Documentation/core-api/genalloc.rst
+++ b/Documentation/core-api/genalloc.rst
@@ -1,3 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _genalloc:
+
 The genalloc/genpool subsystem
 ==============================
 
-- 
2.14.1
