Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeAaPd5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:33:57 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40642 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbeAaPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:33:43 -0500
X-Google-Smtp-Source: AH8x224sGZbhhPq+khhBMj90lWYW6cJIMvbOX9abwajre8Z1B/LAxTN8NfJxM5ssQ/CxPmpeCnSQzQ==
From: Antony Pavlov <antonynpavlov@gmail.com>
To: linux-mips@linux-mips.org
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] MIPS: use generic GCC library routines from lib/
Date: Wed, 31 Jan 2018 18:33:35 +0300
Message-Id: <20180131153337.29021-1-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 patch series (https://www.linux-mips.org/archives/linux-mips/2018-01/msg00567.html):

  * sort the CONFIG_GENERIC_* options in arch/mips/Kconfig alphabetically (v2).

Changes since v1 patch series (https://www.linux-mips.org/archives/linux-mips/2018-01/msg00394.html):

  * sort the CONFIG_* options in arch/mips/Kconfig alphabetically;
  * add notrace to lib/ucmpdi2.c.

Antony Pavlov (1):
  MIPS: use generic GCC library routines from lib/

Palmer Dabbelt (1):
  Add notrace to lib/ucmpdi2.c

 arch/mips/Kconfig       |  5 +++++
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/ashldi3.c | 30 ------------------------------
 arch/mips/lib/ashrdi3.c | 32 --------------------------------
 arch/mips/lib/cmpdi2.c  | 28 ----------------------------
 arch/mips/lib/lshrdi3.c | 30 ------------------------------
 arch/mips/lib/ucmpdi2.c | 22 ----------------------
 lib/ucmpdi2.c           |  2 +-
 8 files changed, 7 insertions(+), 144 deletions(-)
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

-- 
2.15.1
