Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2279207-1517450637-2-5337943513239872969
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517450637; b=wECc4sp9lB0m8L0Qg6RPwpYJkOMnQB6qhBIJD/MmICs5bMI
    cSdgxPJ5fq0g7mWUwGkcuRRh0+yG9LmiXdhgRWdwcUtyiaI0T9Vsm8UD+fIja4ko
    Qhd2MFWXQnrajX0gFoF18PjNt8i4qd69QX/X8yat/UDlsP2fBUPTqersyHJALZW7
    /+tol2YbxbN+Q86vHuR2TJuADgBoC30oF1khIfxXLVTEmIGYo4zbkBOMPlJIDxlI
    /h4TecCJLHTxhjDM3pGCyDKvezVEzad4g9O8g662eXiJXBkHLIHpyTUC4D8IBBUP
    AHlh9L78oMoC6qpprLgjQj3js8BMoXqBedG4wSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517450637; bh=f
    4o+e83st7O6dd6bYku3i9qOAnyXAPeOemPNbTkXSEI=; b=MMz3IQOd676IUmajH
    nydvUCynci1uxzMC2ClNvdkX/1wCJ/XYokKsYuUS1tfoUxr1p4M3lRiNtBjyNLhm
    570lYAYMCndH2Fp/oa5qqT2ZV3e43M41ZD5W0yXm8C8xBBuOVrdMpOlb4gXb2C4O
    6CebkzitTE2tixhjBPziU+pjzXfgc5VO/j1jfQ8HIIfdIA7+8Niy8rMfo1/9J3IQ
    tvnwPYDSPYbNakLSP43ggOGcl2MHJ8pgpyQwXe0qaQhBKPhOVX6577OuCa1eKGaN
    vkt2xBrPNn53JSS794TpHaS4h62yIuPg2QTWm2uF4mx2d9Eu0CO9ZNrfImvHkoB7
    vk+Vg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <gregkh@linuxfoundation.org>
Subject: [PATCH resend 2/3] staging: android: ion: Remove unused include files
 for ion_page_pool.c
Date: Thu, 1 Feb 2018 09:54:21 +0800
Message-ID: <1517450062-16123-2-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1517450062-16123-1-git-send-email-xieyisheng1@huawei.com>
References: <1517450062-16123-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, xieyisheng1@huawei.com, sumit.semwal@linaro.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After rewrite of ion_page_pool, some of its include file is no need
anymore, just remove it.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/android/ion/ion_page_pool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 817849d..f2318c9 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -14,10 +14,6 @@
  *
  */
 
-#include <linux/debugfs.h>
-#include <linux/dma-mapping.h>
-#include <linux/err.h>
-#include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-- 
1.7.12.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
