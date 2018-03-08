Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935840AbeCHLhI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:37:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935810AbeCHLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:37:07 -0500
Date: Thu, 8 Mar 2018 03:36:56 -0800
From: tip-bot for Jan Kiszka <tipbot@zytor.com>
Message-ID: <tip-e21c963c0fe3dc6d8a5c23474eb8f560b184132a@git.kernel.org>
Cc: hpa@zytor.com, jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, andy.shevchenko@gmail.com, bhelgaas@google.com,
        tglx@linutronix.de
Reply-To: andy.shevchenko@gmail.com, tglx@linutronix.de, bhelgaas@google.com,
        hpa@zytor.com, jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
In-Reply-To: <8be8af4084d862faa43d55c7bae94af7e0da1609.1520408357.git.jan.kiszka@siemens.com>
References: <8be8af4084d862faa43d55c7bae94af7e0da1609.1520408357.git.jan.kiszka@siemens.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] MAINTAINERS: Add entry for Jailhouse
Git-Commit-ID: e21c963c0fe3dc6d8a5c23474eb8f560b184132a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e21c963c0fe3dc6d8a5c23474eb8f560b184132a
Gitweb:     https://git.kernel.org/tip/e21c963c0fe3dc6d8a5c23474eb8f560b184132a
Author:     Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate: Wed, 7 Mar 2018 08:39:18 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:30:39 +0100

MAINTAINERS: Add entry for Jailhouse

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jailhouse-dev@googlegroups.com
Cc: linux-pci@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/8be8af4084d862faa43d55c7bae94af7e0da1609.1520408357.git.jan.kiszka@siemens.com

---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..272d8c98c0e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7521,6 +7521,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/dvb-frontends/ix2505v*
 
+JAILHOUSE HYPERVISOR INTERFACE
+M:	Jan Kiszka <jan.kiszka@siemens.com>
+L:	jailhouse-dev@googlegroups.com
+S:	Maintained
+F:	arch/x86/kernel/jailhouse.c
+F:	arch/x86/include/asm/jailhouse_para.h
+
 JC42.4 TEMPERATURE SENSOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
