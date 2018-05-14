Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeENLZl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:25:41 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35722 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeENLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:25:38 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, goliath@sigma-star.at,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/5] mtd-utils: Add fastmap support to ubinize
Date: Mon, 14 May 2018 13:25:23 +0200
Message-Id: <20180514112528.24092-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the userspace side of my preseeded fastmap series.
ubinize can now created images with a preloaded fastmap on it.

Richard Weinberger (5):
  Sync ubi-media.h with Linux
  ubinize: Don't stat image file twice
  libubigen: Carry image path and size in volume info
  libubigen: Maintain a eraseblock association table
  ubinize: Add fastmap support

 include/libubigen.h     |  25 ++++-
 include/mtd/ubi-media.h | 158 +++++++++++++++++++++++++++++--
 lib/libubigen.c         | 241 ++++++++++++++++++++++++++++++++++++++++++++----
 ubi-utils/ubiformat.c   |   6 +-
 ubi-utils/ubinize.c     | 120 ++++++++++++++++--------
 5 files changed, 477 insertions(+), 73 deletions(-)

-- 
2.13.6
