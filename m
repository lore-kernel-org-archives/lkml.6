Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/n42XxQm2GC4RQo7IteKFVZcGenTUODzuPpqfxdaE4fDcS1/rmBSv56ECxBioaz9b+89vJ
ARC-Seal: i=1; a=rsa-sha256; t=1524135754; cv=none;
        d=google.com; s=arc-20160816;
        b=r/1TU/JEiU7BUvr5LHSHeakvS56FPNI4T3RdyaSOy2ZCn63DddJAhJi175J80+6F+N
         ElzWHo7XbzxsqjuyK43XIIhSuBXudpOsRoM4XLcYqx3alkZ7bXW7aK5XNKW7G5X4DnDc
         YnTXeWQ+s8F0eLopdhnfWYE/f5G5zT7hcsqgYVCIjlltYWjx5FEHSI2qSEAT7P/QrNo+
         5d3I3dc5JweiToAAEXqNW6wSnbN6SwLjG0nkZlxcPeyL7mLZ2UPJ2bCKVFJlWUjDvmjk
         SLKAFJQ2LmhnVfOjPep691fSWP03srEVlhKxEWcN7p0oAu4fO5LlgknDrHOVzOOKaJGo
         2JAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sPawRBlY62/00oX5U3ne+7CRK8NMNOnR0fxLkPeEur0=;
        b=dZJkGtW0jvz9a3FyK6EMeIxTcKoyXb2Jh1m1KTAtNXN1YAx6Qyzl+QDibEuf4o19+F
         o8uC8bkaNs/9pb/NZ1kssAUwXutav/XIhJrmkcgddWYlwPsX3RrzHoMDpUJPVLMt/wGm
         7nAL+iMH9fTCPhNcuxSSqLonz2F7gFf9bZc6eZk2fEMOs4JtmACFv0F+o7iLnWhoAV6w
         E8iAQly/m9KxjMtFpiCnFZgAhl1z7cTrgy80R4aIzNIEk1qLE+Lc/WhoCwOGnv5MMDls
         n3yZLNZFIWT4KFGr5LSC9qisQxhyeviDITXfr+ZDmNJ4VPxU5NjW3gQoli5hKGD+69xz
         lh7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="49129445"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: update my email address
Date: Thu, 19 Apr 2018 14:02:30 +0300
Message-Id: <20180419110230.80987-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419110230.80987-1-mika.westerberg@linux.intel.com>
References: <20180419110230.80987-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598172173004222943?=
X-GMAIL-MSGID: =?utf-8?q?1598172173004222943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Bernat, Yehezkel" <yehezkel.bernat@intel.com>

Soon I'll not be available by my Intel email address, so switching to my
personal email address instead.

Signed-off-by: Yehezkel Bernat <yehezkel.bernat@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..56cd1eb943ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13936,7 +13936,7 @@ THUNDERBOLT DRIVER
 M:	Andreas Noever <andreas.noever@gmail.com>
 M:	Michael Jamet <michael.jamet@intel.com>
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
-M:	Yehezkel Bernat <yehezkel.bernat@intel.com>
+M:	Yehezkel Bernat <YehezkelShB@gmail.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
 S:	Maintained
 F:	Documentation/admin-guide/thunderbolt.rst
@@ -13946,7 +13946,7 @@ F:	include/linux/thunderbolt.h
 THUNDERBOLT NETWORK DRIVER
 M:	Michael Jamet <michael.jamet@intel.com>
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
-M:	Yehezkel Bernat <yehezkel.bernat@intel.com>
+M:	Yehezkel Bernat <YehezkelShB@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/thunderbolt.c
-- 
2.17.0
