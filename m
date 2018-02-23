Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeBWKZH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:25:07 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33573 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeBWKYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:37 -0500
X-Google-Smtp-Source: AH8x224bBDruU2NBlM7Q6TlCnr6mYafGzFvg0b+av/Qnp2qnkSwexbF612W/qMp24BnvFNmBmJYqGA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: [PATCH V7 12/13] boot_constraint: Update MAINTAINERS
Date: Fri, 23 Feb 2018 15:53:51 +0530
Message-Id: <b10ab50d7c57f136c65013b991d8f24ee10ec2d7.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for boot constraint subsystem in MAINTAINERS.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76eadae9..e6a767245ea9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2723,6 +2723,15 @@ S:	Supported
 F:	drivers/net/bonding/
 F:	include/uapi/linux/if_bonding.h
 
+BOOT CONSTRAINT SUBSYSTEM
+M:	Viresh Kumar <vireshk@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.linaro.org/people/vireshk/linux.git
+F:	Documentation/driver-api/boot_constraint/
+F:	drivers/bootconstraint/
+F:	include/linux/boot_constraint.h
+
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
-- 
2.15.0.194.g9af6a3dea062
