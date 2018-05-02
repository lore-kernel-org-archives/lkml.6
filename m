Return-Path: <kernel-hardening-return-13177-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrhkLh0FFbHTpIBEyK34Cl463dhMELXrQFG8e3T+1aUmhCM0IfGBDRbLdgwUNfFkrZ+ki6Y
ARC-Seal: i=1; a=rsa-sha256; t=1525223190; cv=none;
        d=google.com; s=arc-20160816;
        b=btNclpAPpG2IV7/QtVmtxoNXQCMk40D/0Q7dnb6zIlMqKYW6WigpVO/oNFODO61lAX
         gSOKIHlYs0fm6mnDBN3jIneEP0NyMPb6EHyVA+BORVyFCzwhFnH1SACB351+JGO8LOHt
         qwQI00E5ibbQQbrcC2WeWfGrioUXcJaGZ5eIQ3Qu2elTAbTNSe4oKE+HEiCujxsLpQ0F
         tbeGA1N5S/OCZNLahhq7+4mCJq+9JLKbEVYIaFSeAChk4DoAy23sxBbr8DzlkoChrgTW
         77fB0JD/gzlhVTJKKfqz+kkEgALE82qpS09jLgsYdljTru5FIkfuRkjaNoMafcU2xGN6
         69Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LgHueGsbNfB6XIjd7SXXhyKi9rsWMZceKqKGuRkq1Kw=;
        b=WCwC+Xf+Bd0774fDm5cCL/8b7oipk2gy52oGPHftrOPBH4dsJIEpO5xRPw32vP1k1G
         ZyKpYZYF7z+xeTZXNle3Ye8Gn38tyoCvV+RZ/7oMvL/FnZz5jlrS2xZu7akr2GBQ4WU0
         tkREK0seJ32b2sQ67PcftFpAB5/4sFVHl8122NXPcSQBeXgSCZ6l6fDloCsRq5yQagLH
         0AzCjGKZI6ZP8HEKjIcoBftaPO2TKIqYbeGSYjwKbD1hp/XQoc96flX1ORFNRxALw7PF
         0Ku6GWXJ0/WjevdzLvMpm/HblBPaowkP6pi8EdsMbc5SyFg5AdhyUYV1wF8QDLQ5+shm
         TA9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vdcLe1sC;
       spf=pass (google.com: domain of kernel-hardening-return-13177-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13177-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vdcLe1sC;
       spf=pass (google.com: domain of kernel-hardening-return-13177-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13177-gregkh=linuxfoundation.org@lists.openwall.com;
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
Date: Wed,  2 May 2018 05:05:21 +0400
Message-Id: <20180502010522.28767-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180502010522.28767-1-igor.stoppa@huawei.com>
References: <20180502010522.28767-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599312431929831820?=
X-GMAIL-MSGID: =?utf-8?q?1599312431929831820?=
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
