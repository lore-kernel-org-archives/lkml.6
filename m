Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755737AbeDWONJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:13:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37931 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755526AbeDWOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:11:13 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 0/4] drm/panel: otm8009a: backlight fixes & improvements
Date: Mon, 23 Apr 2018 16:10:49 +0200
Message-ID: <20180423141054.13128-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serie fixes 2 backlight issues and adds the new
backlight api support.

Philippe Cornu (4):
  drm/panel: otm8009a: fix backlight updates
  drm/panel: otm8009a: fix glitches by moving backlight enable to
    otm8009a_enable()
  drm/panel: otm8009a: no message if probe success
  drm/panel: otm8009a: use new backlight api

 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 58 ++++++++++++------------
 1 file changed, 30 insertions(+), 28 deletions(-)

-- 
2.15.1
