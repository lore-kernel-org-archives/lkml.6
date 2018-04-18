Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeDRMGa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:06:30 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41957 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeDRMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:06:28 -0400
X-Google-Smtp-Source: AIpwx49sTKheGT6EQNidTohORHOJkjyKFRT0R3mSlmNG5GunhuQtEkzgIBoIVK1W2pnnAJ1l67Erew==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2]  lightnvm: pblk: take bitmap alloc. out of critical section
Date: Wed, 18 Apr 2018 14:06:07 +0200
Message-Id: <1524053168-30476-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V1 - from Matias:
 - rename a function to line__reinit
 - propagate error code
 - improve commit message

Javier González (1):
  lightnvm: pblk: take bitmap alloc. out of critical section

 drivers/lightnvm/pblk-core.c | 97 +++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 41 deletions(-)

-- 
2.7.4
