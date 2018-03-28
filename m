Return-Path: <doshir@vmware.com>
X-Google-Smtp-Source: AIpwx48146AJ9q1Sdx/SLPd8i8JP96BOAIShIPGv0vhvrjkhhm3YgUhtzZ0u0FWVOOa7EiSJRgJd
ARC-Seal: i=1; a=rsa-sha256; t=1522276735; cv=none;
        d=google.com; s=arc-20160816;
        b=sEVIPL8iVXpxvGiAL6m5i6rbtSS63kMUif6bVktJvrXnt06UK2g74SOYt4v8k2Wc74
         xUXg+eC8u8QsL5XmnX6oXeCeRB4jxRTGgiUddYorDq5PqPgj3uyq1RJO3mpyv2XzGp1R
         8GrhZ9WmvI1q5eTSSpMamJ4tGl6/Sc8bUjWAIi25MP6CP8+wYO2tXXTzqi7CstlLesur
         oZezMi6Ag1YGTRm6HU8KDndhjUSsinT+a6+fseVUas+MziNgink6g2gR7CJOGPVbDOEQ
         ZR4H9cPjA7NvyASH0N2vTWwwdei1t7BqjsdjcAI0XxWGEaWs9yWUmZWqmA4uIJrQD89c
         fwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GPITKE1Ftc8uK8WoguQtNGu+IaRLc0f/HVV2NtxGK9k=;
        b=A8uvo+QdfOC/jdIep5i8E5rYS9xN1pOFdcZPeDEMq6ifQ9rQpQge8qnM6NxaMDJUpb
         /ls6jtT+UKGEgwldonGztViPWqcBTocwpIBz2QIovUBcJUdvM6m+SDZdedvi2VWBMgUv
         at8o+Mr+OaQXE4DytuplGrzayw6VPIKMNrGsl5NOOt5uVI/yqhRK/JNa2xAEUSvBfE9w
         5ptwe9aomDOPe9mUMxmnjwA1x0APW/bgW8VuZlneAfZ+LomjcbhDGmhXoYD9KA1pxZZO
         z9a5ZQRdcbdql41YuDhXERnsLFByQcug46P8rZ4U0iQLF1DbHskG0xjfCwXp2NlL/AUF
         bKOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of doshir@vmware.com designates 208.91.0.189 as permitted sender) smtp.mailfrom=doshir@vmware.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of doshir@vmware.com designates 208.91.0.189 as permitted sender) smtp.mailfrom=doshir@vmware.com
From: Ronak Doshi <doshir@vmware.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <doshir@vmware.com>, Shrikrishna Khare <skhare@vmware.com>,
	"David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus
 Walleij <linus.walleij@linaro.org>, Andrew Morton
	<akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] MAINTAINERS: update vmxnet3 driver maintainer
Date: Wed, 28 Mar 2018 15:38:19 -0700
Message-ID: <20180328223834.5452-1-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596222849906671702?=
X-GMAIL-MSGID: =?utf-8?q?1596222849906671702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Shrikrishna Khare would no longer maintain the vmxnet3 driver. Taking
over the role of vmxnet3 maintainer.

Signed-off-by: Ronak Doshi <doshir@vmware.com>
Signed-off-by: Shrikrishna Khare <skhare@vmware.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9107d9241564..aace4ae4ad30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14940,7 +14940,7 @@ F:	drivers/input/mouse/vmmouse.c
 F:	drivers/input/mouse/vmmouse.h
 
 VMWARE VMXNET3 ETHERNET DRIVER
-M:	Shrikrishna Khare <skhare@vmware.com>
+M:	Ronak Doshi <doshir@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.11.0
