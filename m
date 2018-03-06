Return-Path: <leo.wen@rock-chips.com>
X-Google-Smtp-Source: AG47ELs9JYipRBkYBXYUgU2OWgpGXjrHRPqYIZ23MhcyNm5vuXB1kHIY3ih7rIAEPgQGhaTWzGyp
ARC-Seal: i=1; a=rsa-sha256; t=1520301576; cv=none;
        d=google.com; s=arc-20160816;
        b=Z83zb+ODSEzvK81w7jQAoZ8oCccGUeoH3M7nd65hv/+9cgMoDs6gZLX8V5yjj2MWQc
         sgqJgNqkS9DFFp2kTx7f8RwAhYTRz5OxzNmKCM8nI8pTu7aHUZIlU4l1YcO8eb9hYOT2
         6m9kleZTldb2AdIZyVnsuPgTAT3BWKxy1Hx7xmZsihqJQkvGWj1MX+ojQPKJiEDootHS
         5LvIQJ5Hi3ecEnuFYSdVD5SDaKxPAvLtvG+klKDxkgJ84jIJV1go9J3d0C7yefiGD9MB
         7mzbNs2tsJ0h5D/WKjRiFACT/8Zv+35DsyUY7eWerw4wb1d/CmkX0UIxhr2ZzYu9hlWt
         BMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=j9xuZWrOLgjKs9yngaadKt+Zc8WxUcS0QswfblFy7qY=;
        b=po+YcVMiTtegr131fsRRBit81E/tk5M2bOMCtd1F3/rec7FRPKaEZKL8Qa2bqSQvOH
         mv0KU7B3Y93DMM88DDQba5u4ELfb1F0nvjmg1FaJ9Q8rN7ohzl/Pzn0RprKUQurNvIjL
         5TM9217fZ/Qeq8yCCHcP4nBkmVqkkRz1gWnvAn2SwTuP87iiPPdZ6bmFnL+u4o/IJ7Ww
         HTbC5d7iXQE/x/5FR/tRtFeL2mV3C96vVEhUMzb9082QUvjkAYQy3LE9vg0gFW7MbvGQ
         FA0wHFtCa/DiyFyx6H1ujTT7u5hi567NDRwdKgIvX3DeLKItYiGE8qggWNQCIxaU7TG+
         MiIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.133 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.133 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: leo.wen@rock-chips.com
X-FST-TO: mchehab@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: leo.wen@rock-chips.com
X-UNIQUE-TAG: <78a5abbf51312c27fd4966e9da00ea47>
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
Subject: [PATCH V3 0/2] Rockchip: Add RK1608 driver and DT-bindings
Date: Tue,  6 Mar 2018 09:59:18 +0800
Message-Id: <1520301560-114573-1-git-send-email-leo.wen@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151745570396225?=
X-GMAIL-MSGID: =?utf-8?q?1594151745570396225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leo Wen <leo.wen@rock-chips.com>

You can use the v4l2-ctl command to capture frames for RK1608.
Add DT-bindings documentation for Rockchip RK1608.
Add the information of the MAINTAINERS.

Leo Wen (2):
  [media] Add Rockchip RK1608 driver
  dt-bindings: Document the Rockchip RK1608 bindings

 Documentation/devicetree/bindings/media/rk1608.txt |   87 ++
 MAINTAINERS                                        |    7 +
 drivers/media/spi/Makefile                         |    1 +
 drivers/media/spi/rk1608.c                         | 1409 ++++++++++++++++++++
 drivers/media/spi/rk1608.h                         |  442 ++++++
 5 files changed, 1946 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rk1608.txt
 create mode 100644 drivers/media/spi/rk1608.c
 create mode 100644 drivers/media/spi/rk1608.h

-- 
2.7.4
