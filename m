Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeFCNU0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 09:20:26 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38153 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCNUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 09:20:25 -0400
X-Google-Smtp-Source: ADUXVKKcxWjJhGeWt9ppeHoTIudvKy7Jxocg0mP8U5vyoqZXIF6Kmf+KA87OKTT95f6kG8aUwSIybQ==
From: Varsha Rao <rvarsha016@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH 0/3] message: fusion: Fix clang and checkpatch warnings
Date: Sun,  3 Jun 2018 18:50:09 +0530
Message-Id: <cover.1528031458.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes extraneous parentheses clang warning and few
checkpatch issues.

Varsha Rao (3):
  message: fusion: Remove extra parentheses
  message: fusion: Replace NULL comparison
  message: fusion: Fix line over 80 characters

 drivers/message/fusion/mptbase.c | 50 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

-- 
2.17.0
