Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeEOJ6A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:58:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41552 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeEOJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:57:57 -0400
X-Google-Smtp-Source: AB8JxZp1sevBJrIobB/N9kbz+/7nnmzHiVZYrXOjMKLN7dyj6TLceX+XEZ5SJvMNKphlqWCTEB+jKQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mmc: meson-gx: add device reset
Date: Tue, 15 May 2018 11:57:46 +0200
Message-Id: <20180515095748.6794-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the optional reset of the meson-gx mmc controller and
the related documentation.

Changes since v1: [0]
 * Correct typo in the documentation
 * Separate code and documentation patches
 * Error on reset failure.

[0]: https://lkml.kernel.org/r/20180426103817.12675-1-jbrunet@baylibre.com

Jerome Brunet (2):
  dt-bindings: mmc: meson-gx: add reset
  mmc: meson-gx: add device reset

 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 2 ++
 drivers/mmc/host/meson-gx-mmc.c                            | 9 +++++++++
 2 files changed, 11 insertions(+)

-- 
2.14.3
