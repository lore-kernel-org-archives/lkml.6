Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBEX6P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:58:15 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:42865 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBEX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:58:06 -0500
X-Google-Smtp-Source: AH8x2279Y/sbT4Uf0xsCjuSyRMb06yzl9TAoWolSXMNn3sO2fGQIFnm6aZHN2McpWpg06th/3SpPmQ==
From: Brendan Higgins <brendanhiggins@google.com>
To: robh+dt@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
        tmaimon77@gmail.com, avifishman70@gmail.com, f.fainelli@gmail.com,
        julien.thierry@arm.com, pombredanne@nexb.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: [PATCH v9 0/3] arm: npcm: add basic support for Nuvoton BMCs
Date: Mon,  5 Feb 2018 15:57:54 -0800
Message-Id: <20180205235757.246758-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed comments from:
 - Philippe: https://www.spinics.net/lists/arm-kernel/msg621710.html

Summary of changes since previous update:
 - Now use SPDX ids instead of traditional license boilerplate. Top of file
   comments are now C++ style comments.
 - Changed reviewers listed in MAINTAINERS.
