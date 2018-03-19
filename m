Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELv6inFu1uGUKWntpCFLWlOPXx33iIQDJr0RitwhDQ76w5Z/GFnrw2qWSi9B6ryrGwNOBjyB
ARC-Seal: i=1; a=rsa-sha256; t=1521476830; cv=none;
        d=google.com; s=arc-20160816;
        b=rTUI0aGT+rMqH3h2ebGd1ivykXpL3cnB8dA12XOE58DzJVahvWToWcteCH3LdD6XrS
         H5ZB+wMpwwkEggPNXEBUUDbbixvaEVYDQa8l65po8R/j8soV7aMgAlmn0dftPIjP1ScT
         5dD2He0Y6QCjfHwSzeTArO+B+YlB2+1mq4gZ61zhk1JFMx0txRGfFPedDMtWyZnOZa+c
         OwUiua/BQtswnrSmPQceF1/oJwpc/trLcffiOwLtfXWAESW0yYD6R5U48Zr/wzaKCK3M
         5MXE+Ka/XzGB4Ho4g6+0/IPP53fWbEKJRFz7UaDo7Id9zTIDAlkO73J3DP0jiwxi8f9r
         JDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=9ZUTuIWXEJz/5o2Zh1ciZLW7dM/MptNoMznRr/LvTE4=;
        b=rlb0DiLynFA0X19Kad3AdN952G3+BiZJPtE23rBe021hz4wOTM53e/0KwCdmPzahNt
         6GbuOUqBtJn/CDzJpHBSiOfI/4uMhs4qDq9XWm4D1tCgnVcgOZHbLzoogJ1ZgtqVXnoh
         /iVnkcCFP9awI+4qK1Y8KLAsPuvlJn2POfSPCLs+NgWLLHI879Pe5qtmDJ4LyQtwdEdg
         SqXU3zuBhPL5HVT64VOxoRSA+IU7dfX32iW6cssHe7MnN1A3kX4XvR/3isnHQ+3V95PX
         0+pXTNvqmbyaVFf8taX1wir6QD3O4XS7v7uVzcVDy5mXv/ufEMGNkFEHFc5Vez/Am5+M
         gwQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="25258476"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: [PATCH 09/19] thunderbolt: Correct function name in kernel-doc comment
Date: Mon, 19 Mar 2018 19:26:53 +0300
Message-Id: <20180319162703.5331-10-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384089234656138?=
X-GMAIL-MSGID: =?utf-8?q?1595384089234656138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Radion Mirchevsky <radion.mirchevsky@intel.com>

Use correct name in kernel-doc of tb_switch_find_by_uuid().

Signed-off-by: Radion Mirchevsky <radion.mirchevsky@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 1cc79785ce42..2a0bded44922 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1528,7 +1528,7 @@ struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link, u8 depth)
 }
 
 /**
- * tb_switch_find_by_link_depth() - Find switch by UUID
+ * tb_switch_find_by_uuid() - Find switch by UUID
  * @tb: Domain the switch belongs
  * @uuid: UUID to look for
  *
-- 
2.16.2
