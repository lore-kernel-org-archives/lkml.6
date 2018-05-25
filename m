Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936068AbeEYNwp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:52:45 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53876 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935969AbeEYNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:52:43 -0400
X-Google-Smtp-Source: ADUXVKJoPyZmCZAuU4LILMaSkKBhPBYS4mH6GZXX5tP/7OtWCLXDPMExrMp7dDWwjNm/htJGQm/WMA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] regmap: slimbus: minor fixes.
Date: Fri, 25 May 2018 14:50:35 +0100
Message-Id: <20180525135037.30638-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 2 minor fixes for regmap slimbus.

Thanks,
srini

Srinivas Kandagatla (2):
  regmap: add missing prototype for devm_init_slimbus
  regmap: slimbus: allow register offsets up to 16 bits

 drivers/base/regmap/regmap-slimbus.c |  2 +-
 include/linux/regmap.h               | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.16.2
