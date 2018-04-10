Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeDJFUP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:20:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751595AbeDJFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:20:13 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 0/2] drm/bridge: sii902x: add optional power supplies
Date: Tue, 10 Apr 2018 07:19:25 +0200
Message-ID: <20180410051927.8268-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.58]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the 3 optional power supplies to the sii902x
drm bridge driver.

Philippe Cornu (2):
  dt-bindings/display/bridge: sii902x: add optional power supplies
  drm/bridge: sii902x: add optional power supplies

 .../devicetree/bindings/display/bridge/sii902x.txt |  3 ++
 drivers/gpu/drm/bridge/sii902x.c                   | 39 +++++++++++++++++++---
 2 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.15.1
