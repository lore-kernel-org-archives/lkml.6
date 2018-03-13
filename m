Return-Path: <kernel-hardening-return-12554-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvmpDn7weJFTZgjf8q3nldGaJlHQE+4YxyBYIW+H/J+GGrmfqNhdO+WXpu7hFPHE9DerOEk
ARC-Seal: i=1; a=rsa-sha256; t=1520977830; cv=none;
        d=google.com; s=arc-20160816;
        b=qOvCmFB0rSKrhmLwbwxUrPg54vjowiebHtl9KxYgt9RcpFvZENS/0AKIhSiHMn77qV
         B0+zKF1Vkbn+GkhW11VveAWVQ0ZdQamAysLUB4Svr9DpcAY6a2jjjj9roZXx7zFuhhE6
         co4Vh1l8wR5FfPCILgtViVWXR52k/IjsELOTSwlqJ7SO0OinjTvyvNxKyPjAq5UxkAS+
         YFyxaOnP6B6bvuyDTEOrHT6A3wimbnfA+3gVGyXh0FQ8jSWDnX4H1NpGYX4kwfBN23yk
         EIemf3FdUpp6QKdGCMjefVCUUvbAg+2en586BeNJ9w5R52y2dtH+oaxsSR9y+iOHKls+
         j61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=/4oYHF00dZ26Oy2h7eyPD4Yjrsr+OayI+12SLHl8bQM=;
        b=jMJclFmII2h1mKTbmGinb7dWFZcHMOI8Wa1ChZaGizlF5S7ZrZVU7550KiNORvVWMO
         sxDIRshPc1FM4dG62AyFupuo6JFXEqb4Gyjnydb+z0NoYQ6Zskj1VNWxQ1ISjIERI2JI
         dKjHDgXVSB251yxwyAJ0LjzLCbYx+QP3Nc/czUJ09MftbtM4GWKEWdrAnFqBU0rBypYq
         qQTyLCmmfdDEb8z0S6lj9JsX5JekFyMjtpLBZXjk8FfajhtS+rS4YqUKnf5PPhX9MBDg
         XwD6EuEWtKNY9YWNeEzCh0mwPR/bEn7wy5fxAbow0rXuKEd7c12NdWB+Uhr+DDk2E8nJ
         qVTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12554-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12554-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12554-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12554-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <rppt@linux.vnet.ibm.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 2/8] Add label to genalloc.rst for cross reference
Date: Tue, 13 Mar 2018 23:45:48 +0200
Message-ID: <20180313214554.28521-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180313214554.28521-1-igor.stoppa@huawei.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860849603891116?=
X-GMAIL-MSGID: =?utf-8?q?1594860849603891116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Put a label at the beginning of the genalloc.rst, to allow other
documents to cross-reference it.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 Documentation/core-api/genalloc.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/core-api/genalloc.rst b/Documentation/core-api/genalloc.rst
index 6b38a39fab24..39dba5bb7b05 100644
--- a/Documentation/core-api/genalloc.rst
+++ b/Documentation/core-api/genalloc.rst
@@ -1,3 +1,5 @@
+.. _genalloc:
+
 The genalloc/genpool subsystem
 ==============================
 
-- 
2.14.1
