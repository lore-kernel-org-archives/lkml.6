Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeEAICP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:02:15 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.47]:24424 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751171AbeEAICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:02:13 -0400
X-Authority-Reason: nr=8
From: Matheus Castello <matheus@castello.eng.br>
To: linus.walleij@linaro.org
Cc: linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1 0/2] pinctrl: generic: improve apply_setting error verbosity
Date: Tue,  1 May 2018 03:40:35 -0400
Message-Id: <1525160437-5222-1-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1fDPuT-001g0X-1T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:27442
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is for improve verbosity in debug for error cases using pinconf 
generic API. Legacy pinctrl-vendor drivers prints error messages with more 
verbosity when parse invalid or not supported sub-nodes properties. In this 
series we try to show messages with more information about the pinctrl-vendor 
driver and sub-nodes that returned error when applied.

Let me know your opinion about this.

Matheus Castello (2):
  pinctrl: generic: add API to solve generic sub-node property name
  pinctrl: generic: improve apply_setting error verbosity

 drivers/pinctrl/pinconf-generic.c       | 61 +++++++++++++++++----------------
 drivers/pinctrl/pinconf.c               | 15 +++++++-
 include/linux/pinctrl/pinconf-generic.h | 32 +++++++++++++++++
 3 files changed, 77 insertions(+), 31 deletions(-)

-- 
2.7.4
