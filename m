Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932663AbeCISnw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:43:52 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38008 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeCISnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:43:50 -0500
X-Google-Smtp-Source: AG47ELv+W0RRsjqu0aXRYpNrGI1Tk1XebML0TETZAX8NivgUDZp/WYR/8vRCsMDYgcFJBPaqY4HxcQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 7/8] counter: stm32-timer-cnt: Add sysfs documentation
Date: Fri,  9 Mar 2018 13:43:44 -0500
Message-Id: <d85788df126b716b05fe1d56fca292933fee1db2.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

In addition of the generic sysfs-bus-counter ABI stm32-timer-cnt
offerts three functionality:
- enable the counter
- set preset value
- allow to read counter direction

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-stm32-timer-cnt   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt b/Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt
new file mode 100644
index 000000000000..73328e8e6d7e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt
@@ -0,0 +1,21 @@
+What:		/sys/bus/counter/devices/counterX/countY_direction
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the count direction of
+		Count Y. Two count directions are available: Forward and
+		Backward.
+
+What:		/sys/bus/counter/devices/counterX/countY_enable
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y inputs A and B are enabled. Valid attribute
+		values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/countY_preset
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports preset registers, the preset
+		count for channel Y is provided by this attribute.
-- 
2.16.2
