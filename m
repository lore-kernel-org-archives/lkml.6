Return-Path: <leo.wen@rock-chips.com>
X-Google-Smtp-Source: AG47ELvMTuqj1b9ED8dyfg+Z4RJ4ao50qOWSUGlFJmMA7ZNWcHzmgD2Dw1fMWixsQAenkbAPt1mo
ARC-Seal: i=1; a=rsa-sha256; t=1520491129; cv=none;
        d=google.com; s=arc-20160816;
        b=Seo8oW2Wf7LtTTraNFwQhyFLdhKj5fCV4HTPq+NMky9IQfQRCg2yLno6b04qe+UuOh
         slBCFO8JDNDgcR5TIBCHDlOIynqlEOjnDXCKQa6VkUsCOyucn9cFQ04FtpeQMEjBE+tJ
         YJNyP+xf2GHa2BZpeSup0M0b2piKG2jeOgPKRU5b1th8Qn2LgaJUwq064JPnNItvQ0ea
         PotOyu00Dzug0nTdOjy49/WfOzaLWOloCueDk68a4w9PHQ0lwqOyQ2f6hSTtZ/jT2Xwa
         E+7AyHCT5eeCS3OWr9x9rP++4eBk89Y9p9IRLJ2N8r65BSKMMSNQ++ByhfcCWh5kMtsx
         8xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=IDDhFXhQOgcFNfYZYGDyOt7juXMEpzASU35Fs4Yr5RU=;
        b=Vx9O21qu1DdXyXQuMxEO8hXv21C9KSo/7ol9wOjLvDA982JWeXJkE1sLQ4mDKQg5Bh
         rhKJZFukwxsZKkWllEqoWaPgczw4JNIypYzBXtQTQaKP2qSuAZA0Yka1d8bneiqRJHxM
         wEAT8xsP8nbkCv3wjdV18cXT0DRB3KtdmPVNZzAeW29smwwqsaMq0bpTDhQ2kgK23TR2
         NXI9V5rWhLr/eT2zqnZfjCge3R50AW4ARgC6V3Gp2kOUmgnhizFEx7064TZaMFFyghRp
         t/xQ4uB2TzFxK0YHyV91T08cW7WLYlX3aDrI+iPhTI14t2r5fvzK6BIbGKxxBSu7yko8
         U8Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.137 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.137 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: leo.wen@rock-chips.com
X-FST-TO: mchehab@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: leo.wen@rock-chips.com
X-UNIQUE-TAG: <4eab319a7f6aff98e138ed0bc8efb6de>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Wen Nuan <leo.wen@rock-chips.com>
To: mchehab@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org,
	jacob2.chen@rock-chips.com
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	eddie.cai@rock-chips.com,
	Leo Wen <leo.wen@rock-chips.com>
Subject: [PATCH v4 0/2] Rockchip: Add RK1608 driver and DT-bindings
Date: Thu,  8 Mar 2018 14:38:40 +0800
Message-Id: <1520491122-5629-1-git-send-email-leo.wen@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594350506148264803?=
X-GMAIL-MSGID: =?utf-8?q?1594350506148264803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leo Wen <leo.wen@rock-chips.com>

You can use the v4l2-ctl command to capture frames for RK1608.
Add DT-bindings documentation for Rockchip RK1608.
Add the information of the MAINTAINERS.

Leo Wen (2):
  [media] Add Rockchip RK1608 driver
  dt-bindings: Document the Rockchip RK1608 bindings

 Documentation/devicetree/bindings/media/rk1608.txt |   95 ++
 MAINTAINERS                                        |    7 +
 drivers/media/spi/Makefile                         |    1 +
 drivers/media/spi/rk1608.c                         | 1374 ++++++++++++++++++++
 drivers/media/spi/rk1608.h                         |  442 +++++++
 5 files changed, 1919 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rk1608.txt
 create mode 100644 drivers/media/spi/rk1608.c
 create mode 100644 drivers/media/spi/rk1608.h

-- 
2.7.4
