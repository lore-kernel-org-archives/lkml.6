Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965663AbeBMUKM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:10:12 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:36515 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965611AbeBMUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:10:09 -0500
X-Google-Smtp-Source: AH8x2266k2+2LRwpepMU2RctnRsZDZhSJrXQ750mT2j1HrXZwp6mktNSUlO5Uz4ffiD9JghOA8z4Bg==
From: Brendan Higgins <brendanhiggins@google.com>
To: robh+dt@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        tmaimon77@gmail.com, avifishman70@gmail.com, f.fainelli@gmail.com,
        julien.thierry@arm.com, pombredanne@nexb.com, arnd@arndb.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: [PATCH v10 0/3] arm: npcm: add basic support for Nuvoton BMCs
Date: Tue, 13 Feb 2018 12:09:56 -0800
Message-Id: <20180213200959.160157-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed comments from:
 - Joel: https://www.spinics.net/lists/arm-kernel/msg634074.html
 - Arnd: https://www.spinics.net/lists/arm-kernel/msg634091.html

Summary of changes since previous update:
 - Replaced "nuvoton,npcm7xx-smp" compatibility string with
   "nuvoton,npcm750-smp".
 - Fixed some whitespace issues.
 - Added EVB DTS to Makefile.

All changes tested on Nuvoton NPCM750 EVB.
