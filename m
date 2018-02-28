Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934163AbeB1P5g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:57:36 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39825 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933979AbeB1P5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:57:34 -0500
X-Google-Smtp-Source: AH8x225dqPIbp/UvkyBP5rE8IsBruhmcuTZ9ipFNwnIMmRN6RDlhjRgwscULFUFKOD7WxbKFlUsshg==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: remove unused variable
Date: Wed, 28 Feb 2018 16:57:23 +0100
Message-Id: <1519833444-28160-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Changes since V1:
 - Rebase on top of latest 2.0 changes


Javier González (1):
  lightnvm: pblk: remove unused variable

 drivers/lightnvm/pblk-core.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.7.4
