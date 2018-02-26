Return-Path: <leo.wen@rock-chips.com>
X-Google-Smtp-Source: AH8x225Vhw6aqehhUwsXGeBUk7lMw0z+Ku9WTumSIwE85yZ6Vy/9ArJJJahZmCs6gBxoO/XFQJkX
ARC-Seal: i=1; a=rsa-sha256; t=1519633104; cv=none;
        d=google.com; s=arc-20160816;
        b=k1VEXe6D2YbN//X2fqVDZHV6dRgnqWLSRGT1cMs2qmQ6Fgme5KiWd6o2pRZqj63EqJ
         RzK5fSMqCfEP26CuSfgoLTD3PI9H3DJbp+NNE1amnw8dQX+DrNy7nMe+t5HQyRXLsmRL
         JjbjI9gvmGfrEPQjSVZK2eydSFTy2BTNpm7LVGPC0AJAGN2sVIu39tXJBBJO/PrdR29L
         vCc49xyc1ic/QISLir93/L7X+fcMT767WcONdXeNQlnesQ/6mfqqKT1MpjVFX6GEUACf
         OINaxnze6frGy8Jp/tGNYR5++F0zaYQSw4km4jSDtOITE4tr0avJXc4CvU2qPrOL06q/
         Infw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=OddffCTLskGTYgsJe40Q256VvS3+htPRCht55FtI/hA=;
        b=eNsRB6W590+oFFD1Srso4yEUs51xMAKESnWKDldNc1qgfSIhJNKVZXe3rOpGXdQMTQ
         Dtw7xKB4KBupQKrTiprQJ21RCbTo2Uefhmh+phcWvR6EdewS7qabf6ssSGXBZtIvNdd/
         YlUiA085h4wjY25lS7mwz91UG1eY7kCFS+qlh6mKjedtQbfKBy/UOKpkTF6a4HnqwsZV
         s4ZwfuNVOrHgGbgl/UdNFlynwjrkr9IChcffOYePZF9P9568Q518xP4nuBhiYdqNFb4V
         mL5RZofTJA5Pnciv/S6nx6/xGzJjPUg2pMj8wUv6Xl57wXWXYyQEX+/Cw4cNSjOUfwtR
         wKzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.141 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of leo.wen@rock-chips.com designates 211.150.99.141 as permitted sender) smtp.mailfrom=leo.wen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: leo.wen@rock-chips.com
X-FST-TO: mchehab@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: leo.wen@rock-chips.com
X-UNIQUE-TAG: <5a900378c90756decf3a4e066cab576e>
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
Subject: [PATCH V2 0/2] Rockchip: Add RK1608 driver and DT-bindings
Date: Mon, 26 Feb 2018 16:16:02 +0800
Message-Id: <1519632964-64257-1-git-send-email-leo.wen@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593450801845132785?=
X-GMAIL-MSGID: =?utf-8?q?1593450801845132785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leo Wen <leo.wen@rock-chips.com>

You can use the v4l2-ctl command to capture frames for RK1608.
Add DT-bindings documentation for Rockchip RK1608.
Add the information of the MAINTAINERS.

Leo Wen (2):
  [media] Add Rockchip RK1608 driver
  dt-bindings: Document the Rockchip RK1608 bindings

 Documentation/devicetree/bindings/media/rk1608.txt |   97 ++
 MAINTAINERS                                        |    7 +
 drivers/media/spi/Makefile                         |    1 +
 drivers/media/spi/rk1608.c                         | 1664 ++++++++++++++++++++
 drivers/media/spi/rk1608.h                         |  471 ++++++
 5 files changed, 2240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rk1608.txt
 create mode 100644 drivers/media/spi/rk1608.c
 create mode 100644 drivers/media/spi/rk1608.h

-- 
2.7.4
