Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752476AbeCNRBE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:01:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43828 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeCNQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:59:46 -0400
X-Google-Smtp-Source: AG47ELtbzr1KNg6q8KQjCrjXYwXSX6z9nmJgEFXjAOA/0E/JeN+1IzqvPlviOxkMPKUvMVYo2lCkVQ==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 23/25] MAINTAINERS: Update files for PSCI
Date: Wed, 14 Mar 2018 17:58:33 +0100
Message-Id: <1521046715-30683-24-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some new files have been for the PSCI firmware driver, let's make the
expression more generic to cover them all.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf..dda16cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11082,7 +11082,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci*
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.7.4
