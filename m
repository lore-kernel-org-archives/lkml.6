Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4DEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E88218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbfABLOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:14:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43652 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfABLOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:14:32 -0500
Received: from 79.184.255.240.ipv4.supernova.orange.pl (79.184.255.240) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 3f7cca0f01305708; Wed, 2 Jan 2019 12:14:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: [PATCH] cpufreq / Documentation: Update cpufreq MAINTAINERS entry
Date:   Wed, 02 Jan 2019 12:13:52 +0100
Message-ID: <7154380.sNYZWJVSaJ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the MAINTAINERS entry for cpufreq by making it clear that it
is not just drivers and adding current documentation records to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 MAINTAINERS |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -3888,7 +3888,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/ti/cpmac.c
 
-CPU FREQUENCY DRIVERS
+CPU FREQUENCY SCALING FRAMEWORK
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 L:	linux-pm@vger.kernel.org
@@ -3896,6 +3896,8 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
 B:	https://bugzilla.kernel.org
+F:	Documentation/admin-guide/pm/cpufreq.rst
+F:	Documentation/admin-guide/pm/intel_pstate.rst
 F:	Documentation/cpu-freq/
 F:	Documentation/devicetree/bindings/cpufreq/
 F:	drivers/cpufreq/

