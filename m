Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeBAKnK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:43:10 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22024 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751748AbeBAKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:43:07 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Fabien Dessenne <fabien.dessenne@st.com>,
        Mickael Reulier <mickael.reulier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v1 0/2] drm/stm: ltdc: add non-alpha color formats
Date: Thu, 1 Feb 2018 11:42:41 +0100
Message-ID: <20180201104243.20726-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds non-alpha color format support taking into
account older hw versions.

Philippe Cornu (2):
  drm/stm: ltdc: add non-alpha color formats
  drm/stm: ltdc: remove non-alpha color formats on layer 2 for older hw

 drivers/gpu/drm/stm/ltdc.c | 53 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/stm/ltdc.h |  1 +
 2 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.15.1
