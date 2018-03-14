Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELuqRMoNXuDVLxkh3SkwLPoYo4S+WPR2pQr/LeeIe+6SGI8u06dDMId3royPt//G3QcMBMh/
ARC-Seal: i=1; a=rsa-sha256; t=1521051428; cv=none;
        d=google.com; s=arc-20160816;
        b=UvRiYfVXjxxVmTY1ys9i672bxRzWNu/T5rZU9/GE5fjD6PRbHfTzJXyb1eQZqJY1sv
         DjyT9YwtML2rFO/hrTRIa+OsTALUVAz6oyOV+WcPct/c+FGncKWp5J8kRYRDIhnhij1V
         C0wrGYHBv5FWdte1PhE6sqzsNxz7stl/pLLQVu8didlDR8C6+zinG6SAIIpW9AO3qAfc
         eSLH6MnTRGxyF3Sz53oX7rW0Bm1g/9pTx1OyFeGwzyLyqY/9Agg/eZDChmS5xoPJ36zs
         xozZlHGbpFZrcFJQVfU6i5IzAPrQXQrO2ql9ES2RehGh1g+w2lceu1cBPT7UzC5AhYFD
         ZfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=I1Ny4etVpnhj4w4E0Liop+7XjFBzJdOKJp6JVI/JQQs=;
        b=iNoFH54PjoAdxofcRmQMadA/DGHCfrX9Qc08XeZSamNgoa6I+KG1T2wBPcZ/GCcosN
         E6hECKDKN3FV4V50+YZ6shFwfpFVeyKGfAe1sMiEGCUEw9id7NL62YtPuWsDl26iGGMx
         OylSAMWyyINJ9wNV+UX/kCj9xv8PsH1JThUnAWo54PqRFP0juJllgZmpoZu6hPypce6R
         9gsH9JWHOsxLwZ/CjsPBmlCscTsdlWtUZdWY83P+r7yT18SdJeAaSpLFhr7de4Zet7+r
         RAiwB9PXWZL4X3fRUZ03eVVO78Ygj17l+prQbR/Ka4sdW1FNu90BLiifY9snELjEonZR
         onPQ==
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
Subject: [PATCH v17 10/10] MAINTAINERS: Add maintainer for HiSilicon LPC driver
Date: Thu, 15 Mar 2018 02:15:59 +0800
Message-ID: <1521051359-34473-11-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938023103562004?=
X-GMAIL-MSGID: =?utf-8?q?1594938023103562004?=
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
