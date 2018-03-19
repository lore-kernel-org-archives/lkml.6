Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbeCSBlA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:41:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32862 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755099AbeCSBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:40:55 -0400
X-Google-Smtp-Source: AG47ELvX8R4IKdpOgg7G/1ZS/bfVAAXxUIWmRFN9kSGAXgzMzWWlS4Zf3tBBgWUsElTC9kyY3ffzZg==
From: Alexey Roslyakov <alexey.roslyakov@gmail.com>
To: andrew@lunn.ch, kvalo@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com, arend.vanspriel@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com
Subject: [PATCH net-next v2 0/2] brcmfmac: add new dt entries for SG SDIO settings
Date: Mon, 19 Mar 2018 08:40:30 +0700
Message-Id: <20180319014032.9394-1-alexey.roslyakov@gmail.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2: don't check of_property_read_* return values since it
doesn't change the value if property not found.
Suggested by Andrew Lunn.
