Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBHObE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:31:04 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32839 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751424AbeBHObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:31:02 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v1 0/2] drm/panel: Add support for Raydium rm68200 panel
Date: Thu, 8 Feb 2018 15:30:24 +0100
Message-ID: <20180208143026.23009-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Raydium Semiconductor Corporation RM68200 is a 5.5" 720x1280
TFT LCD panel connected using a MIPI-DSI video interface.

Philippe Cornu (2):
  dt-bindings/display/panel: Add support for Raydium rm68200 dsi panel
  drm/panel: Add support for Raydium rm68200 panel driver

 .../bindings/display/panel/raydium,rm68200.txt     |  25 ++
 drivers/gpu/drm/panel/Kconfig                      |   8 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      | 464 +++++++++++++++++++++
 4 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
 create mode 100755 drivers/gpu/drm/panel/panel-raydium-rm68200.c

-- 
2.15.1
