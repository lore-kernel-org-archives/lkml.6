Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeFAMB4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:01:56 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40943 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeFAMBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:01:53 -0400
X-Google-Smtp-Source: ADUXVKL5nBqoNwxjzf/9FhPgap1LrfQGdkv1xNx0wagnrZ7YvuotXtxU8xeWTLoqYppGb4f7c25t/A==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: remove unnecessary bio_get/put
Date: Fri,  1 Jun 2018 14:01:45 +0200
Message-Id: <1527854506-8708-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matias,

Here you have the patch, rebased on top of your tree. Please pick up for
4.18

Thanks!
Javier

Changes since V1
  - Rebase on top of Matias for-4.18/core
  - Rename error tags on the modified code to be compliant with the rest
  of pblk

Javier González (1):
  lightnvm: pblk: remove unnecessary bio_get/put

 drivers/lightnvm/pblk-read.c | 65 +++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

-- 
2.7.4
