Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeDPQqv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:46:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43506 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeDPQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:46:49 -0400
X-Google-Smtp-Source: AIpwx4/mMz8KpvRxzP7jfRmqGRbYZohpQspvYnVJOiV0yozGNXQaX/5/jnf+upuBWRsuZWhHE+RZ5A==
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, Javier Gonzales <javier@cnexlabs.com>,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 0/2] pblk bugfixes
Date: Mon, 16 Apr 2018 18:46:14 +0200
Message-Id: <1523897176-6241-1-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

This is a couple of bugfixes, nothing very urgent.

Hans Holmberg (2):
  lightnvm: pblk: only try to recover lines with written smeta
  lightnvm: pblk: kick writer on new flush points

 drivers/lightnvm/pblk-cache.c    | 10 ++++++----
 drivers/lightnvm/pblk-core.c     |  2 +-
 drivers/lightnvm/pblk-rb.c       |  4 ++--
 drivers/lightnvm/pblk-recovery.c | 30 +++++++++++++++++++++---------
 drivers/lightnvm/pblk.h          |  1 +
 5 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.7.4
