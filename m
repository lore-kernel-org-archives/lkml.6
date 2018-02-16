Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757281AbeBPCkU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 21:40:20 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:40378 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeBPCkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 21:40:19 -0500
X-Google-Smtp-Source: AH8x226H/x7TWV39lRFml1sFJmvG6oN3KmG97JV4nUMuYUVwR77w/uLJpS5iatTnCN1Bn3TIN/7ZDA==
From: Brendan Higgins <brendanhiggins@google.com>
To: robh+dt@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        tmaimon77@gmail.com, avifishman70@gmail.com, julien.thierry@arm.com,
        pombredanne@nexb.com, arnd@arndb.de, olof@lixom.net,
        khilman@kernel.org
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v11 0/3] arm: npcm: add basic support for Nuvoton BMCs
Date: Thu, 15 Feb 2018 18:40:08 -0800
Message-Id: <20180216024011.189157-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Addressed comments from:
 - Arnd: https://www.spinics.net/lists/arm-kernel/msg634442.html
 - Joel: https://www.spinics.net/lists/arm-kernel/msg634554.html


Summary of changes since previous update:
 - More device tree and binding doc clean up.

All changes tested on Nuvoton NPCM750 EVB.

I went ahead and decided to submit a pull request to Arnd, Olof, and
Kevin, as requested since I figured that we were about at the end of
feedback and we want to get this in.
