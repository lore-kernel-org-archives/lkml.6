Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbeAaQuV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:50:21 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33727 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752743AbeAaQuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:50:19 -0500
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@stlinux.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 0/2] ASoC: stm32: spdifrx: change dai name
Date: Wed, 31 Jan 2018 17:47:01 +0100
Message-ID: <1517417223-21899-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset changes spdifrx dai name and fixes a typo issue.

Olivier Moysan (2):
  ASoC: stm32: spdifrx: fix typo in function name.
  ASoC: stm32: spdifrx: Use default dai name

 sound/soc/stm/stm32_spdifrx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
1.9.1
