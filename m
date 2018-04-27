Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZpC2ZAQ3w9IPf1nxR95Qdb1Mhdz+UsyTKxW7/74NYXq0V351/wnSxW1rWykQhhQs4TT9u5i
ARC-Seal: i=1; a=rsa-sha256; t=1524792590; cv=none;
        d=google.com; s=arc-20160816;
        b=gfpacxWQMZ8Y0aeSN+TcX1S8+81zy0hB05qGKGZvniyTVR4wf9fsuDckpA+IxK57Ej
         flTuPzWREkKKnHdBMMN7Y61RFVmLm2QMGZ5B8+ok+nQMXV5d9D7aElVUQzIASEFaYTi8
         LLSHiVXav3Q8VBB0W7t70ivOV09my82hK+6VguwDgVFxsS1q7kJc85a7l85KhUpChMXP
         qu/nEu1yzn9kgDNzJpjeE91JjVoMXGJPnTYH+i+CkJ39uYLtpeU32ui9cUiq3b6KynBX
         vyteSKjZcv2LHeI/+3YQ+xAN9jgiXiEb3OdyhEpooseu7m8Ofx/sZzieWAddbgKrtptm
         eCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:dkim-signature
         :arc-authentication-results;
        bh=XoFVXFuYs2HKyCyykPTPxYg9I1ujdzoDqUeD85gWxIk=;
        b=TWWH29DRgPE1GUV7xKyrtYxZP8nHzRzo14INn1tIhOfjXourFU+xFuni2IpsaVDIwe
         SMb+RoFpAJ1uS5LE8SZHvXVLucyj9io/k1USGrE26X9rvW1H1Hxe7NoX8+Mynnp+Z7fG
         nDDLoX0xaDQF3t22lLuSPlmDhZUater+48BirAc9U3SPlO/rg8bLUn5Krw2BWXwMgilp
         O8ouEMJAv+KSqo56WCr63ExxmjErqTQTUhdnrzi4wLawWOFAOUHwCQHgCKAuEd0mvqLT
         DNp5UeCac58HpyzcT/PmpiLGOmpQAvVDECyLEbF3ps3s5L4L5/5fJrdd8n7Sfw0rYSRj
         aIPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=CUzArWpR;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=CUzArWpR;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: driver-api: fix device_connection.rst
 kernel-doc error
Message-ID: <4dcdb5c8-1365-9a0a-81be-893b0d1ea731@infradead.org>
Date: Thu, 26 Apr 2018 18:29:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598860916051196881?=
X-GMAIL-MSGID: =?utf-8?q?1598860916051196881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Using incorrect :functions: syntax (extra space) causes an odd kernel-doc
warning, so fix that.

Documentation/driver-api/device_connection.rst:42: ERROR: Error in "kernel-doc" directive:

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/driver-api/device_connection.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180426.orig/Documentation/driver-api/device_connection.rst
+++ linux-next-20180426/Documentation/driver-api/device_connection.rst
@@ -40,4 +40,4 @@ API
 ---
 
 .. kernel-doc:: drivers/base/devcon.c
-   : functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
+   :functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
