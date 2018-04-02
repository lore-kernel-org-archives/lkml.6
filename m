Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbeDBUAZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:00:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35858 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbeDBUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:00:23 -0400
X-Google-Smtp-Source: AIpwx49g/M5TPvFoS9XSiQCWSF50/uY+YhwAuB8HzIHOxcmrW084kk7V2EsYvhLATtQkz0rwjwJV2w==
From: Nasser Afshin <afshin.nasser@gmail.com>
X-Google-Original-From: Nasser Afshin <Afshin.Nasser@gmail.com>
To: mchehab@kernel.org
Cc: Nasser Afshin <Afshin.Nasser@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] media: i2c: tvp5150: resolve checkpatch errors
Date: Tue,  3 Apr 2018 00:29:02 +0430
Message-Id: <20180402195907.14368-1-Afshin.Nasser@gmail.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series tries to resolve some checkpatch.pl errors and warnings.

Nasser Afshin (3):
  media: i2c: tvp5150: Add a space after commas
  media: i2c: tvp5150: Use the correct comment style
  media: i2c: tvp5150: Use parentheses for sizeof

 drivers/media/i2c/tvp5150.c | 159 +++++++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 77 deletions(-)

-- 
2.15.0
