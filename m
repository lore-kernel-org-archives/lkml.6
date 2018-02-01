Return-Path: <clabbe@baylibre.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517517567; cv=none;
        d=google.com; s=arc-20160816;
        b=QNulGbgBx+PKNzWvwowlK00iN97KgyD63awLsMCYyT+H6UuuyJARSIbENJCV7D0g/e
         VMxmh0ZYoCUwnFUfQmRPkDhHxo5/TjKfwMQVZis40bwok3RIa0jnji2kNS5XRv9lUjbv
         PSxTlZodubYaKEes2nZwemZuW7HngK3ofcY4riaTOdqFMkcWFoQYlM8uPUGq89GBradO
         BUiFNQ0yWZF5oYcN6CnuGE33sLqax1KPBUuvVniCPWUgVwGqCL1/sq2Rg6jCW6jlg/ti
         jyiVf0YLJ/YSabCDwx6cDHYgNN1aBwKYaut2CpVhxSaeQOpNZJGJzNRYtqzEorDVSpS3
         yYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=O89Fa49JVhAIYcF63/J4UcwU60cP/S821KUDoDs1Dc4=;
        b=sx7RSxK0SNylt1HU00W56O6BnL9v+z6NIgtJ+oeteFNIjs/EVE0LQj7l3xlK+0hZW6
         4dKw+2U9iey7Kv7UNdprBUgy6fh4bpi6GCM47uYNeJogyepOFECfROHoN5Hqu4R9YuCj
         I5njKTpGgULRNyTEY3kanzSjkJDva6O8z8YbzmeylwoE02GCrb+fb6grBppnagO2VR+/
         KGZ3ZYA2AqKd2hp/c1Jhhv594fJNhIr+tfx3sakku4J+Z7zv5Duur8YEvo0pdByx5EZG
         6zg6NPNguH9FrayozPRCfxgP/92kQxovtOmxuH/oGZhvNNl5pvvBV8RUMlSEDSo2or+g
         XIsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=1I/GO6Ol;
       spf=softfail (google.com: domain of transitioning clabbe@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=clabbe@baylibre.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@baylibre-com.20150623.gappssmtp.com header.s=20150623 header.b=1I/GO6Ol;
       spf=softfail (google.com: domain of transitioning clabbe@baylibre.com does not designate 209.85.220.65 as permitted sender) smtp.mailfrom=clabbe@baylibre.com
X-Google-Smtp-Source: AH8x225FsI8pCeMteAgPbDCCQ1/lNX0dAYa6bgKBpvYyuObyxWeTixWaEgKr8pK7sLuwxIA2P60sdA==
From: Corentin Labbe <clabbe@baylibre.com>
To: eric@anholt.net,
	gregkh@linuxfoundation.org,
	stefan.wahren@i2se.com
Cc: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] staging: vc04_services: remove unused files
Date: Thu,  1 Feb 2018 20:39:03 +0000
Message-Id: <1517517543-34957-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591232500704415558?=
X-GMAIL-MSGID: =?utf-8?q?1591232500704415558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All thoses files are not used by anybody.
Lets just remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../interface/vchiq_arm/vchiq_build_info.h         | 37 --------------
 .../interface/vchiq_arm/vchiq_memdrv.h             | 59 ----------------------
 .../interface/vchiq_arm/vchiq_version.c            | 59 ----------------------
 3 files changed, 155 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_build_info.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_memdrv.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_version.c

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_build_info.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_build_info.h
deleted file mode 100644
index df645813bdae..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_build_info.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-const char *vchiq_get_build_hostname(void);
-const char *vchiq_get_build_version(void);
-const char *vchiq_get_build_time(void);
-const char *vchiq_get_build_date(void);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_memdrv.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_memdrv.h
deleted file mode 100644
index c233b866725b..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_memdrv.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef VCHIQ_MEMDRV_H
-#define VCHIQ_MEMDRV_H
-
-/* ---- Include Files ----------------------------------------------------- */
-
-#include <linux/kernel.h>
-#include "vchiq_if.h"
-
-/* ---- Constants and Types ---------------------------------------------- */
-
-/* ---- Variable Externs ------------------------------------------------- */
-
-/* ---- Function Prototypes ---------------------------------------------- */
-
-VCHIQ_STATUS_T vchiq_memdrv_initialise(void);
-
-VCHIQ_STATUS_T vchiq_userdrv_create_instance(
-	const VCHIQ_PLATFORM_DATA_T * platform_data);
-
-VCHIQ_STATUS_T vchiq_userdrv_suspend(
-	const VCHIQ_PLATFORM_DATA_T * platform_data);
-
-VCHIQ_STATUS_T vchiq_userdrv_resume(
-	const VCHIQ_PLATFORM_DATA_T * platform_data);
-
-#endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_version.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_version.c
deleted file mode 100644
index 994b81798134..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_version.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-#include "vchiq_build_info.h"
-#include <linux/broadcom/vc_debug_sym.h>
-
-VC_DEBUG_DECLARE_STRING_VAR(vchiq_build_hostname, "dc4-arm-01");
-VC_DEBUG_DECLARE_STRING_VAR(vchiq_build_version, "9245b4c35b99b3870e1f7dc598c5692b3c66a6f0 (tainted)");
-VC_DEBUG_DECLARE_STRING_VAR(vchiq_build_time,    __TIME__);
-VC_DEBUG_DECLARE_STRING_VAR(vchiq_build_date,    __DATE__);
-
-const char *vchiq_get_build_hostname(void)
-{
-   return vchiq_build_hostname;
-}
-
-const char *vchiq_get_build_version(void)
-{
-   return vchiq_build_version;
-}
-
-const char *vchiq_get_build_date(void)
-{
-   return vchiq_build_date;
-}
-
-const char *vchiq_get_build_time(void)
-{
-   return vchiq_build_time;
-}
-- 
2.13.6
