Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BCF2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfAHQKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:10:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfAHQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:10:24 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ED9FE27DE7D
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org
Subject: [PATCH 00/10] platform/chrome: cros_ec: remove unused includes and switch to SPDX
Date:   Tue,  8 Jan 2019 17:10:06 +0100
Message-Id: <20190108161016.12361-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After the patchset to move cros_ec sysfs attributes to its own drivers
[1], I'd like to do some cleanup and switch to the SPDX license on these
files. This patchset applies on top of [1] and can go through the
platform-chrome repository once [1] is applied.

Best regards,
  Enric

[1] https://lkml.org/lkml/2018/12/12/679

Enric Balletbo i Serra (10):
  platform/chrome: cros_ec_debugfs: remove unused includes
  platform/chrome: cros_ec_lightbar: remove unused includes
  platform/chrome: cros_ec_sysfs: remove unused includes
  platform/chrome: cros_ec_vbc: remove unused includes
  platform/chrome: cros_ec_lightbar: remove pr_fmt() define
  platform/chrome: cros_ec_sysfs: remove pr_fmt() define
  platform/chrome: cros_ec_debugfs: switch to SPDX identifier
  platform/chrome: cros_ec_lightbar: switch to SPDX identifier
  platform/chrome: cros_ec_sysfs: switch to SPDX identifier
  platform/chrome: cros_ec_vbc: switch to SPDX identifier

 drivers/platform/chrome/cros_ec_debugfs.c  | 27 +++----------------
 drivers/platform/chrome/cros_ec_lightbar.c | 31 +++-------------------
 drivers/platform/chrome/cros_ec_sysfs.c    | 31 +++-------------------
 drivers/platform/chrome/cros_ec_vbc.c      | 28 +++++--------------
 4 files changed, 18 insertions(+), 99 deletions(-)

-- 
2.20.1

