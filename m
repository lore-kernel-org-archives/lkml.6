Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeBTFZE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:25:04 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35241 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTFZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:25:02 -0500
X-Google-Smtp-Source: AH8x224nkMY1T/XmVMQZ+E0uOk/mbdXCJXtZ1t7wXaQqUMi+/ZU6N8TI8dNn674ygLWatGy3nqpeNA==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] fujitsu-laptop: Miscellaneous cleanups
Date: Tue, 20 Feb 2018 06:24:47 +0100
Message-Id: <20180220052454.11134-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains miscellaneous cleanups which I think are
worth getting done before splitting fujitsu-laptop into two separate
modules.

Changes from v1:

  - [6/7] Rename BACKLIGHT_POWER to BACKLIGHT_PARAM_POWER.

  - [6/7] Use BACKLIGHT_OFF instead of a numeric constant.

  - [7/7] Include <linux/bitops.h> due to the use of BIT().

 drivers/platform/x86/fujitsu-laptop.c | 180 +++++++++++++++++-----------------
 1 file changed, 91 insertions(+), 89 deletions(-)

-- 
2.16.1
