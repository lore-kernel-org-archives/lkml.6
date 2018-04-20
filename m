Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDTSsg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:48:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14219 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDTSsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:48:35 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Apr 2018 11:48:34 -0700
From: Vladislav Zhurba <vzhurba@nvidia.com>
To: <linux-kernel@vger.kernel.org>
CC: <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        Vladislav Zhurba <vzhurba@nvidia.com>
Subject: [PATCH 0/1] Add two IR keymaps for NVIDIA devices
Date: Fri, 20 Apr 2018 11:47:46 -0700
Message-ID: <20180420184747.29022-1-vzhurba@nvidia.com>
X-Mailer: git-send-email 2.17.0
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds two IR keymaps for NVIDIA devices.
The RC types are SONY12 and NEC.

Jun Yan (1):
  media: rc: Add NVIDIA IR keymapping

 drivers/media/rc/keymaps/Makefile        |  2 +
 drivers/media/rc/keymaps/rc-nvidia-nec.c | 66 ++++++++++++++++++++++++
 drivers/media/rc/keymaps/rc-nvidia.c     | 66 ++++++++++++++++++++++++
 include/media/rc-map.h                   |  2 +
 4 files changed, 136 insertions(+)
 create mode 100644 drivers/media/rc/keymaps/rc-nvidia-nec.c
 create mode 100644 drivers/media/rc/keymaps/rc-nvidia.c

-- 
2.17.0
