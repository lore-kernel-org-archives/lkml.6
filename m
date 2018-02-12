Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeBLU6n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:58:43 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40701 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbeBLU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:58:41 -0500
X-Google-Smtp-Source: AH8x227mw+4t6ujuIx3oe8i5itH9r3ZEpQusWQIGAaId9QWnrcOqeSfL3nGnGvuX/SXdCqQZ7ekHgw==
From: Brendan Higgins <brendanhiggins@google.com>
To: linux@armlinux.org.uk, avifishman70@gmail.com, tmaimon77@gmail.com,
        venture@google.com, yuenn@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v1 0/2] arm: npcm: add low-level debug support for NPCM7XX
Date: Mon, 12 Feb 2018 12:58:31 -0800
Message-Id: <20180212205833.151019-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adds low-level debug support for Nuvoton's NPCM7XX architecture.

Change has been tested on Nuvoton's NPCM750 EVB.
