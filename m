Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AIpwx48y0/lrOu20MyDSqJ+HBikN7oFHRtLe7ORoNFM+L6WwHFbmi6/BVas/sh2df5bMf1TGQkAH
ARC-Seal: i=1; a=rsa-sha256; t=1524135754; cv=none;
        d=google.com; s=arc-20160816;
        b=Eh+DslbQj2mdilNYEQSG1+zhS40SH7X87ni7lcssjOIS11u0XxV9Gcs2y20YRYESdJ
         Ih+naTAFTAsrxTEvWSqB7Em1xDnAU8YiX+qwaIrfcw+DI4AHEyOyEFh/HToEHN4KxC52
         iHBW7Sk8D4XY2m08XdYzArJMAuR7LfPd43HKjBME7zQju77RK2cScEzOh6H4Y7Rw3Iq6
         dd465DEAAXk9H6W6gq6/i4GjsRvtPlQdthA6EQ/Fb7iJXj8snG/Lv2Ze4erexJaYkEb/
         R9ctLkSHF5wzeB9zZb2p+deVhDskqAA/9811OO6IRpKp4LMv0wRZIiFHnhBM+1UOt6h6
         k+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=mWVQB1Msm3QDRfcBUrWYlU6T362bn6sbHSldXEfEneE=;
        b=eqt9BuSzhF015x3QekNA5Y0PWnVikeE+hxnDTSE4EYwacU0XWo8xHYpD2qpX7yyqFG
         RfSOP4tVzDAR+3Z+clsmDaJYdXyK8qBZhbL+I/zERglr6OCcJL/5xF8AZgV0iyBz0VXi
         WgE67JOnBsDJOGzxXqqCmShT75l+EerdjYDYrnxBULmQU/wsHbPOMnI3GAChIpljhx7Z
         +L7QK6brTDBhWofTlC6DZiFyFpBU+mUd/0qdg4LmKeu2nXfFRPD4IDzDBqpvb7bDVwDS
         JqqlHxZVqr5GOso7siXWs2uFt5MGFvVmkDI4Oyly1eNNKi1J25lPQJfIobfY4k8cR4JP
         eyAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="44485773"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] thunderbolt: Fixes for v4.17-rc2
Date: Thu, 19 Apr 2018 14:02:29 +0300
Message-Id: <20180419110230.80987-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598172172456996966?=
X-GMAIL-MSGID: =?utf-8?q?1598172172456996966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Here is one Thunderbolt MAINTAINERS update for v4.17-rc2. There is also a
signed tag if you want to pull the change directly.

Thanks!

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v4.17-rc2

for you to fetch changes up to 17cc33d4a95720ae2e20ed359966a9c16a4c0ecd:

  MAINTAINERS: update my email address (2018-04-16 13:16:39 +0300)

Bernat, Yehezkel (1):
  MAINTAINERS: update my email address

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.0
