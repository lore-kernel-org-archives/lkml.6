Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELuNhexYZqOs+AWoz7wNWz3LZMMTWG+rJVnUNPZ5rwApKu3WJKTY1zenHo5Hw6RtZbNdGk2/
ARC-Seal: i=1; a=rsa-sha256; t=1519660212; cv=none;
        d=google.com; s=arc-20160816;
        b=lzWnb8/ExErJR1DuBZq9jjBUK30G6OHc16OozkqzOU4gA1TKe6LC4XB7mLkpIjU/7j
         9Z6MqWUmmQZrQCIZh61V7706/IPtg10fdgWmc/dab4KIkAeM2DnegmUBEqK+rohL2X3f
         oLPa+NXahgJF+jeYZTUM5hWuBzxJn/cxvqDkoC0dzWBYM1QwfOuZ8jV+sG3P+coNvs8p
         1t6jPy8y5Nfwy7iV2QvGaHCnP1IcRxS/FyACbUQNS+h7jbdBKa2vNg6TuonF5qpXSfyK
         zyD08A9OOh3OymwHGeO+miUKjf3iGcugcHDoMtpmrFdIiB8w/dw2OeEf4A+g2SbhQxIZ
         JR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=OTaflZQNMEB83Y6Im9snTTksf5D6VrzR1XUB8u6bfE8=;
        b=gBmYtsNmI3de8eFNTbhbQZ9cg5miGFO1F3n9rrBBHZ+dfnBNeWfYvPBD1krJkC3pyO
         MsA6Ylaif6L4ap8mMnkXnhqOwuZNqkmRORUWfyNHGtP93L2ksWp8aATtJvLC5fXXdpq3
         YnMVTDGqUOhvDhINRxv/GDVvPzvg+j9Jl9awrNElI/yQxx+GlLAenjCHq40CSGGxceoX
         4Z+UKuYegOyTUguntZ08iPqL6HPYvW/c9eykqgXz4o6bJy70h3ML2YvJkd2ywc7ehEhV
         txPwkSTrwdg63IzRXebcYJYybCL8HcKVBsfH+IrduNU2vcgqlUMWaGg8vs0MjMfvA6Mc
         Kang==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=john.garry@huawei.com
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>,
	<andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <minyard@acm.org>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v15 9/9] MAINTAINERS: Add maintainer for HiSilicon LPC driver
Date: Tue, 27 Feb 2018 00:40:49 +0800
Message-ID: <1519663249-9850-10-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479227174836977?=
X-GMAIL-MSGID: =?utf-8?q?1593479227174836977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c2320e1..ef5c38a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6401,6 +6401,13 @@ W:	http://www.hisilicon.com
 S:	Maintained
 F:	drivers/net/ethernet/hisilicon/hns3/
 
+HISILICON LPC BUS DRIVER
+M:	john.garry@huawei.com
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
1.9.1
