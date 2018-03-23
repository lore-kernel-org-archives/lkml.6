Return-Path: <Adam.Thomson.Opensource@diasemi.com>
X-Google-Smtp-Source: AG47ELsfZXH7RxtiZzw0Lo2GzZ+lQQjUw0oOojRrRqXjVZcBBFDdAB8KLBQc0vQ4WADA3Tas44sb
ARC-Seal: i=1; a=rsa-sha256; t=1521799944; cv=none;
        d=google.com; s=arc-20160816;
        b=IZlVXFH3XjvbDs4c+LWcx3jgjdk/2EUpslEl+k2siYckJ4GJVVu2NWBrzL3E0q5FyQ
         rrG+D23AzpsdDncfWQ3NsRwOdVu/aJ5cEs63WUa8Qj6Y2fjO/9X8RYu9B21TqEKnFPAI
         a0LiR2EVL2awxU5aVlHqbXtiRx2Eiy7xZFSnFxk02VZrZTS19ERtpL5nUwl96ThWb10B
         DNwhk+huPaEq46tYP1WuneKRjZW5XkpEdMAwBZC883Xf3sT372j2hwWrCAyGxzSVswpE
         JCjz7oStkFaOIXvfzqwXnlVdl1MAQ1jyHvrfFYfVIQLO9KHliP0Wij0sIxpEkUQGlEi3
         O1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:cc:to:subject:date:from:references:in-reply-to
         :message-id:arc-authentication-results;
        bh=HgJ9OvH1IuBrxHV65xo3NbyMAn0ZWpTKVD/L4ZhqYHM=;
        b=y/TT8mepWprbi+xiN6Db+77yyl1hit+/1SUdIyvRJK57drEJ7DLgaPFT5usUAEGGxX
         Ag0nAXplBI6uEf0FBcUWFiS3Cq75b2uOJxHbJb4f5VWb/Pn/1sVnzGxXLHkBbB2xpjN0
         Zvbg7yDL4ZAQvgYPSMmW7jGKgzQEfQV8XEkPMAVzkHyxco7J2f4I/2Z0xczxMDYWN2vy
         YY4ra62B6a2M3aVJxf6Ruvn/6vzlOgZ+PKlu/szxWxqfY1FxlTKSqFU2eVk3JpwNQWP4
         JQMIQwoDWPT35IkalZY3yZTQX7Wwxr3UHG8cvz/OzGSgchYOFXr8HjopsGKzRdXCgI4U
         PmBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.112 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of adam.thomson.opensource@diasemi.com designates 85.158.142.112 as permitted sender) smtp.mailfrom=Adam.Thomson.Opensource@diasemi.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=diasemi.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRWlGSWpSXmKPExsUSt3OpsS7H5S1
  RBlM6RCyaF69ns3hzfDqTRdfqnSwW1471Mllc3jWHzeJz7xFGi0XLWpktniw8w2RxeneJA6fH
  plWdbB7zTgZ67J+7ht1j47sdTB7v911l89j5vYHd4/MmuQD2KNbMvKT8igTWjM4N0QV/OSpan
  yxmamB8yN7FyMUhJLCeUeL9zzlsXYycQE6FxKOb7awgNq9ApsT6gy/B4pwC7hL3XnYydTFyAN
  W4Sez5xAwSZhOwkJh84gFYCYuAqkTvpA9MILawQJTE8Qt3wOaLCLxnlPj0+AMLSIJZoE6i9/d
  bFoj5ghInZz6BiktIHHzxghniBgOJ0wsaweISAvYS099fZQbZKyGgL9F4LBYibCjxfdY3qBJz
  iVlnd7BNYBSchWTqLCRTFzAyrWK0TCrKTM8oyU3MzNE1NDDQNTQ01jXXNTKy0Eus0k3SSy3VT
  U7NKylKBMrqJZYX6xVX5ibnpOjlpZZsYgTGEAMQ7GB8fCz5EKMkB5OSKG/m8S1RQnxJ+SmVGY
  nFGfFFpTmpxYcYZTg4lCR4r10EygkWpaanVqRl5gCjGSYtwcGjJML7HiTNW1yQmFucmQ6ROsV
  ozPFs74M2Zo4bL163MQux5OXnpUqJ864AKRUAKc0ozYMbBEsylxhlpYR5GYFOE+IpSC3KzSxB
  lX/FKM7BqCTM+w1kCk9mXgncvldApzABneIzBeyUkkSElFQDo5TK0gffJ4dtNtt1Ko3RP1qZu
  33eDa/eJyoRu1s4nPNOzz7Tt0TxuHmBipPe0Y72++Y73fkv77Cyv7iYKej1rwsqWfZ6ykpRnN
  der2qwFLb1Tf7z76lN0g71lWFxHOkpCb/Ln6f4b9cyYd50c8Y9gQnhD+6VGiwTOtbTuHCuxQ2
  N5ZbXKzM/K7EUZyQaajEXFScCAG5ZfqQtAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-11.tower-239.messagelabs.com!1521799943!579713!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <84159a4df772e123d850561eff38ece7577e816f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 23 Mar 2018 10:12:23 +0000
Subject: [PATCH v7 3/6] power: supply: Add error checking of psy desc during
 registration
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun
 Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 23/03/2018 08:40:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722898876671522?=
X-GMAIL-MSGID: =?utf-8?q?1595722898876671522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently there's no error checking of this parameter in the
registration function and it's blindly added to psy class and
subsequently used as is. For example if this is NULL the call
to psy_register_thermal() will try to dereference the pointer
thus causing a kernel dump.

This commit updates the registration code to add some basic
checks on the desc pointer validity, name, and presence of
properties.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/power/supply/power_supply_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 82f998a..64f6449 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -849,6 +849,9 @@ static void psy_unregister_cooler(struct power_supply *psy)
 		pr_warn("%s: Expected proper parent device for '%s'\n",
 			__func__, desc->name);
 
+	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
+		return ERR_PTR(-EINVAL);
+
 	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
 	if (!psy)
 		return ERR_PTR(-ENOMEM);
-- 
1.9.1
