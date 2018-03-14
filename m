Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeCNPqt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:46:49 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeCNPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:45:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH 22/47] cpufreq: remove blackfin driver
Date: Wed, 14 Mar 2018 16:35:35 +0100
Message-Id: <20180314153603.3127932-23-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Nn03z8Fh0A91dd1Fuey0Sp6epsQkjR5+wqcW7kW3Sre+9l19VkX
 alsTZR9y6nJkp3aFDNwXoxil9KeAUrAac4HWPWlQHzU/O+mujwkgOxQXbz4nynmRii/9o8f
 4+ZJvnE+sw+EshXKq6zUrCooh/xsVo58GU9Mx4gLdAKlA/VCH7a2vZ29czyzaLPtdjl/csx
 F45+u8epS+hcPMmVM8jOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XxyVJnyC9wc=:E8jgju2XZ+B788kXRbstOP
 y1akVhwm7LIOvY6R9xyisWRgcFufAqWSCebbYfiyXQyGnG3s1OQ3OAch+BViMJZ5qmCVK05ur
 gUJQ+XXAFASyFPGKUs9jBZ733XzkWlEN4cORvh/ZehxEuv+GjBhrrjmQNQhZ7789buh/HmV2b
 llm6rP2FL58IqJVjxoQbrQUBvPrTUsrkzsUb2Ai9XzydSU6wUt7kbha1LRhSGHlNWhQbq83ps
 digFkEiey6rMrJvrgoL2MNBTZgvvo/JTlIZYY6YXt6FG+SFv9VaeenzPzXxJZf7KVhPyhZw9f
 jmQOPRS5R8f5Fb14ZJC2WjL+11by/s0r04PTBqJrJEvXBJ+dSAY8tt9rPpu5u+7r1aI9IbZJD
 Tz2Gxr0yHDAxhEw9dNaBbg0xG+zHnwUVcWyNjcan4rg36T5uKSYTORxcHrkiC6S3rTXRaZeCH
 Gn3o929QE1/7hyOSxkV1bBo8hxOd4inQkskGoUtm8PHeJzJRBY8qBgmjH/tbUSbexJZ/n/dMf
 oi7eF0ItZWVMBdJMfBJfvXAZaj3YSboLL2clFq5cc4apZjANn4hAZrsK13RrHv02LHhvx3BWW
 pgiu3oFwe1dHMXlZx7mE6b0Jn/d/USgWRKLMZPK0DLsE+yvPS78BvSJyFsclZPlpfPymenpVZ
 Oa7Hi/qncgZlHokB4HqLLGp6TMCj/BVC9i3OUooJ/eTEIJkXhsdPhPNHh4a8VbjsMOzJqZGPW
 Jo2VUc/1Pyd+MJI5yT+3Ah9v+zlJ36c1kAhHmQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blackfin architecture is getting removed, so this driver is
now obsolete.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Makefile           |   1 -
 drivers/cpufreq/blackfin-cpufreq.c | 217 -------------------------------------
 2 files changed, 218 deletions(-)
 delete mode 100644 drivers/cpufreq/blackfin-cpufreq.c

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 4987227b67df..2e4495cf9aa8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -101,7 +101,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 
 ##################################################################################
 # Other platform drivers
-obj-$(CONFIG_BFIN_CPU_FREQ)		+= blackfin-cpufreq.o
 obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
 obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
deleted file mode 100644
index 12e97d8a9db0..000000000000
-- 
2.9.0
