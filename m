Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeBDVKL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 16:10:11 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35313 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBDVKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 16:10:03 -0500
X-Google-Smtp-Source: AH8x225JkBM0qUvDKJSswmHqY9bc47E3OAdFyzHNQ2jkkTOkeP3OB3gykVogDs4xqcnyjhgfDsjrYA==
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH v2 0/5] lite fixes for ath3k
Date: Mon,  5 Feb 2018 00:09:42 +0300
Message-Id: <20180204210947.31002-1-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204205934.12117-4-mussitantesmortem@gmail.com>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the last series of patches

Maxim Zhukov (5):
  drivers: bluetooth: ath3k: replace hardcode numbers with define
  drivers: bluetooth: ath3k: do not init variables
  drivers: bluetooth: ath3k: remove blank line after if
  drivers: bluetooth: ath3k: Fix warning: quoted string split across lines
  drivers: bluetooth: ath3k: fix checkpatch warning

 drivers/bluetooth/ath3k.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
2.16.1
