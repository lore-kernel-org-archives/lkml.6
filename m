Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeBEJqO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:46:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48015 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752494AbeBEJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:46:06 -0500
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
Subject: [PATCH v1 0/2] drm/panel: otm8009a: Add support for the optional power-supply
Date: Mon, 5 Feb 2018 10:45:30 +0100
Message-ID: <20180205094532.23547-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards use a dedicated voltage regulator for this panel.
Add & Document this related optional power-supply property and
add its support in the driver.

Philippe Cornu (2):
  dt-bindings/display/panel: otm8009a: Add optional power-supply
    property
  drm/panel: otm8009a: Add support for the optional power-supply

 .../bindings/display/panel/orisetech,otm8009a.txt       |  2 ++
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c        | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.15.1
