Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELtNAKbI0kfqxY/To/IVHLDtK0X6YytSLW5ZA8qh8273L3xSpCn+ue/ZGuKuGtvcRQR9GBcv
ARC-Seal: i=1; a=rsa-sha256; t=1520333307; cv=none;
        d=google.com; s=arc-20160816;
        b=dmffvVXWB020e5cBkqFwd59ABnCT8c2sH2Z4KCXp9tKSo+f6lfxUuksyZwE4fiX11J
         48ilRWIOcPgu4STSHzNVYwyLLW6KUNY5tdhu98Wr+zA9y70XceT+NwJ+Hwj+MhBQ3x6N
         FqmBHURBYvziiPcwZH4yyFIBPr996RDQcZPxXX7d8tMbLgfLC7EaGSd3jeXxmb5nif3K
         eTW9W/6ga8i49LWm4UjLK1g86KY0u1vrUmityVHh2AAIOYw/sf69OYv/ouoiU7Gjhmob
         J2YEgqToasn5LTYm36l+0TEi3kxygPu+pkFMm0NfhUCUoHNph+vX9UND5mGjcWl2UZHo
         UY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=I1Ny4etVpnhj4w4E0Liop+7XjFBzJdOKJp6JVI/JQQs=;
        b=ZK5NousBWyyFFinLFT6HWe+3vXTHAelN1npRbt0dQTLhLzvmUPhRrJvGCNY0QrDF+r
         /6GdR0C/FvbuopPW2GWSPwNZToe8rq6zA8DCQ54bYCx3VJsRJK2NIEeQMVeheWRiREp2
         qFJfl/+P/nRMbAGsQArhkYOthDJ914PS+i87aIiIGquy6/RPYjRjpyUpYjiOSQE5ZYWi
         K+HqcZX0ldIP96z0rJI2WY+skNyB3TNakvXicMD6pqNg1GZeGopJmAxOCOFvWXa0y7jV
         r+63oXR/uG7MKKUOsqFppfP938AOPeoaNgOtMi7SSsnAMLpKO232FqisaUAVGzb78zVn
         eqVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
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
Subject: [PATCH v16 9/9] MAINTAINERS: Add maintainer for HiSilicon LPC driver
Date: Tue, 6 Mar 2018 18:47:48 +0800
Message-ID: <1520333268-82754-10-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594185018373770883?=
X-GMAIL-MSGID: =?utf-8?q?1594185018373770883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c187bc8..cd4f9dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6403,6 +6403,13 @@ W:	http://www.hisilicon.com
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
