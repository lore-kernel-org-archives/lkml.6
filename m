Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6837D214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfA2Jie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:38:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfA2Jid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:38:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D11E826A373
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 00/12] platform/chrome: switch to SPDX license and some minor cleanup
Date:   Tue, 29 Jan 2019 10:38:11 +0100
Message-Id: <20190129093823.27137-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After the patchset to move cros_ec sysfs attributes to its own drivers,
I'd like to do some cleanup and switch to the SPDX license on all the
platform/chrome drivers.

Best regards,
  Enric

Changes in v3:
- Add Reviewed-by tags.
- cros_ec_i2c: Fix SPDX license tag.
- cros_ec_spi: Fix SPDX license tag.

Changes in v2:
- Removed the patches that removed the unnused includes (were wrong).
- Add patches for all files in platform/chrome that didn't switch yet.

Enric Balletbo i Serra (12):
  platform/chrome: cromeos_pstore: switch to SPDX identifier
  platform/chrome: cros_ec_debugfs: switch to SPDX identifier
  platform/chrome: cros_ec_lightbar: switch to SPDX identifier
  platform/chrome: cros_ec_sysfs: switch to SPDX identifier
  platform/chrome: cros_ec_vbc: switch to SPDX identifier
  platform/chrome: cros_ec_i2c: switch to SPDX identifier
  platform/chrome: cros_ec_lpc: switch to SPDX identifier
  platform/chrome: cros_ec_proto: switch to SPDX identifier
  platform/chrome: cros_ec_spi: switch to SPDX identifier
  platform/chrome: cros_kbd_led_backlight: switch to SPDX identifier
  platform/chrome: cros_ec_lightbar: remove pr_fmt() define
  platform/chrome: cros_ec_sysfs: remove pr_fmt() define

 drivers/platform/chrome/chromeos_pstore.c     | 17 ++++------
 drivers/platform/chrome/cros_ec_debugfs.c     | 22 +++---------
 drivers/platform/chrome/cros_ec_i2c.c         | 22 ++++--------
 drivers/platform/chrome/cros_ec_lightbar.c    | 24 +++----------
 drivers/platform/chrome/cros_ec_lpc.c         | 34 +++++++------------
 drivers/platform/chrome/cros_ec_lpc_mec.c     | 26 +++-----------
 drivers/platform/chrome/cros_ec_lpc_mec.h     | 20 ++---------
 drivers/platform/chrome/cros_ec_lpc_reg.c     | 26 +++-----------
 drivers/platform/chrome/cros_ec_lpc_reg.h     | 20 ++---------
 drivers/platform/chrome/cros_ec_proto.c       | 19 +++--------
 drivers/platform/chrome/cros_ec_spi.c         | 20 +++--------
 drivers/platform/chrome/cros_ec_sysfs.c       | 26 +++-----------
 drivers/platform/chrome/cros_ec_vbc.c         | 24 +++----------
 .../platform/chrome/cros_kbd_led_backlight.c  | 19 +++--------
 14 files changed, 67 insertions(+), 252 deletions(-)

-- 
2.20.1

