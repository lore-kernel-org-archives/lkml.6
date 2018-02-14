Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966491AbeBNBv3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:51:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:56121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966387AbeBNBvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498941"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 3/9] MAINTAINERS: adding Hyper_DMABUF driver section in MAINTAINERS
Date: Tue, 13 Feb 2018 17:50:02 -0800
Message-Id: <20180214015008.9513-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper_DMABUF DRIVER
M:      Dongwon Kim <dongwon.kim@intel.com>
M:      Mateusz Polrola <mateuszx.potrola@intel.com>
L:      linux-kernel@vger.kernel.org
L:      xen-devel@lists.xenproject.org
S:      Maintained
F:      drivers/dma-buf/hyper_dmabuf*
F:      include/uapi/linux/hyper_dmabuf.h
F:      Documentation/hyper-dmabuf-sharing.txt
T:      https://github.com/downor/linux_hyper_dmabuf/

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4fdcb12616c..155f7f839201 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6468,6 +6468,17 @@ S:	Maintained
 F:	mm/memory-failure.c
 F:	mm/hwpoison-inject.c
 
+Hyper_DMABUF DRIVER
+M:	Dongwon Kim <dongwon.kim@intel.com>
+M:	Mateusz Polrola <mateuszx.potrola@intel.com>
+L:	linux-kernel@vger.kernel.org
+L:	xen-devel@lists.xenproject.org
+S:	Maintained
+F:	drivers/dma-buf/hyper_dmabuf*
+F:	include/uapi/linux/hyper_dmabuf.h
+F:	Documentation/hyper-dmabuf-sharing.txt
+T:	https://github.com/downor/linux_hyper_dmabuf/
+
 Hyper-V CORE AND DRIVERS
 M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
-- 
2.16.1
