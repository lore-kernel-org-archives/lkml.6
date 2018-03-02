Return-Path: <richard.gong@linux.intel.com>
X-Google-Smtp-Source: AG47ELuqfNF9YzEkZDUb9rGFjfbOhUR9oG+qKkcO133xfAt5pIQ5KEkn7ivwKAdlrK1WBjxmPLzZ
ARC-Seal: i=1; a=rsa-sha256; t=1519950210; cv=none;
        d=google.com; s=arc-20160816;
        b=qaJDC31LDFx4MgcdyNsTaffziY2YvvN/u/2/B7m0zZAbTM7QRGP2B4ng/YF8Yc2+gd
         c4B3HECGGMVy7rzC9wujLR0GYcJ5a89ZfDIBEWvti2orc3eXv4ZXMKyCB3TrDQD7cQ4K
         qAsvFqKMBSYC7mrZgtPHeQ2alFgd/tRGNvXUUWt3QzJA6nISE9mSWWni8InGYfJxyd/u
         AxCdQiPtzmvF2+LyTI7GxcHu9uNrN35oo62tjO13lwYY4Qa7GiwK1SWkbe/5ryoPvz3Q
         FH/4QHoKi/6/V80gx4x4xiZ56IyfyiRNJYK9EZ/oQ07TWNcVYV/On8Z4L98tM7lajM0n
         FdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=lh6uEeT3anAL5xSfATZHxxSWayz/qdaSvsmB5Fg3LN4=;
        b=jRY93tBReCbWRi3bOTYO+0GdHn2ZcToa7a6LDdTQFEy47qJyI3LJXkrwVDajnFCyTY
         Bi47LLaN5u4Hii0RO74DbQceomlaJcpZFKnb6mmuKoXCbtrG7be6OcfNqxV5D7LP3Smy
         6L9uwThoHEFtblAMEUuTrLGh2cbpbtsftSXuqLsPhduqNjz5amy/zyDzQgJUxESJR3JH
         sdhA7XxbZApiVduaVe3TX/V/luPj1Pi14vqFlE3k7WLD+rvkHXSGpXeuui4rk00ccxaO
         TSXRgxTYjGFE/ZN8o4R8P5TiDmBGStKGziPoc/huenArwQ88jCEBYFdP7W3UWXAe7N2S
         Th7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of richard.gong@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=richard.gong@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="35279654"
From: richard.gong@linux.intel.com
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	dinguyen@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	atull@kernel.org,
	mdf@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	yves.vandervennet@linux.intel.com,
	richard.gong@linux.intel.com
Subject: [PATCHv2 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
Date: Thu,  1 Mar 2018 18:19:32 -0600
Message-Id: <1519949975-13548-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593783311696826067?=
X-GMAIL-MSGID: =?utf-8?q?1593783311696826067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Tull <atull@kernel.org>

Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.

Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
---
 .../devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt  | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
new file mode 100644
index 0000000..78de689
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
@@ -0,0 +1,10 @@
+Intel Stratix10 SoC FPGA Manager
+
+Required properties:
+- compatible : should contain "intel,stratix10-soc-fpga-mgr"
+
+Example:
+
+	fpga_mgr: fpga-mgr@0 {
+		compatible = "intel,stratix10-soc-fpga-mgr";
+	};
-- 
2.7.4
