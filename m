Return-Path: <hariprasath.elango@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521023044; cv=none;
        d=google.com; s=arc-20160816;
        b=v83DG+kavGmp8/CviwQYLEPvF2om3gaBS9LbEcZ/shF0KB8920p6Re7u9MlTMvXHvb
         49YVzUXSvElV1UMlywOaGWs2fcXtU1RyGe9UTv5zpD+6Qi0Id6yJ8bZYAUHukTbGYbqr
         tEwxHatAvIuIK9LDkHTXEW/Jlz5cUjYcAZY2KzLGkLfLVy87s4qTq8G1NaG4o4xCioYN
         xqlIGGGcE9RQ4g6QG2TAusodBvmLknOrYS6UiCr00IaXfknD0yVL7OPpboNZfwfA78gg
         s9bFa8ZsQhg499b7bi7AmKAw80jfH00Wzb/PlGbpeAn0ESW9Y0IFByfr/xahnln2e+a8
         v1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=3f1DubGsmL+9Td1G2PJydN5vyAoNChL1lmAwmM/TbQk=;
        b=Q6GscuGsbrKcWuB/40kZVtg1+CTviZlz3XfHirfHI1kXAw+utqMGCF9+fmqN59S3mT
         cUaBRbSFKVbHACVPp+k6cIIEkaKtLqaysfbDgHhwjhSigT5Wp2Eobr0N7pUg51drSZMj
         /5TMPxpWwx7JfaovOZJhGzxrMIN1KNlKu1l8AfetI/B+64pNapGVAGo+YaYJqZlBb+oY
         +pTEMPAHYEXgAAM495kdx100K9yNLMWxahP1aSm5BZkKL0v/m/o/82w6Pr60wZZ0mWkn
         f910+VosEIceVU5JqamcDk3fD2keym/0HFvt/+3AExeOqJJHDT5r5m1HX9XNcbK63tZZ
         326Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p5jgH8Mn;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p5jgH8Mn;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuyZnlv/QxjFHTTQs08YQCriPt5fybhtVn1kh7KDHXd1jV8uis7avc6q3nZ/1FSjy/cXChGUg==
From: hariprasath.elango@gmail.com
To: linux@wolf-entwicklungen.de,
	gregkh@linuxfoundation.org
Cc: hariprasath.elango@gmail.com,
	Valentin Vidic <Valentin.Vidic@CARNet.hr>,
	=?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>,
	Nguyen Phan Quang Minh <minhnpq16@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Srishti Sharma <srishtishar@gmail.com>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: Remove comments inside code
Date: Wed, 14 Mar 2018 15:53:31 +0530
Message-Id: <20180314102336.8594-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594908260538557704?=
X-GMAIL-MSGID: =?utf-8?q?1594908260538557704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Remove comments inbetween code as in this case.

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 88da91d..5c6a722 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1331,7 +1331,7 @@ static int __init pi433_init(void)
 	 * that will key udev/mdev to add/remove /dev nodes.  Last, register
 	 * Last, register the driver which manages those device numbers.
 	 */
-	status = alloc_chrdev_region(&pi433_dev, 0 /*firstminor*/, N_PI433_MINORS /*count*/, "pi433" /*name*/);
+	status = alloc_chrdev_region(&pi433_dev, 0, N_PI433_MINORS, "pi433");
 	if (status < 0)
 		return status;
 
-- 
2.10.0.GIT
