Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeFCQAo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:00:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36229 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeFCQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:00:43 -0400
X-Google-Smtp-Source: ADUXVKJ73sDZwPmU7d+IdzFHUDBrNZN/wHmDfthJjJs5HDIFIB799fRJdMeEZknFaBYFAixRLrikTw==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 0/7] staging: mt7621-pci: Fix coding style issues
Date: Sun,  3 Jun 2018 21:29:57 +0530
Message-Id: <cover.1528040188.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the following set of coding style 
issues found using checkpatch.

ERROR: space prohibited after that open parenthesis '('
ERROR: trailing whitespace
ERROR: space required before the open parenthesis '('
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: spaces required around that '==' (ctx:WxV)
ERROR: that open brace { should be on the previous line

Abdun Nihaal (7):
  staging: mt7621-pci: Remove space after open parenthesis
  staging: mt7621-pci: remove trailing whitespace
  staging: mt7621-pci: add space before open parenthesis
  staging: mt7621-pci: add space after comma symbol
  staging: mt7621-pci: add spaces around equal symbol
  staging: mt7621-pci: add space after '==' symbol
  staging: mt7621-pci: fix coding style error

 drivers/staging/mt7621-pci/pci-mt7621.c | 114 ++++++++++++------------
 1 file changed, 56 insertions(+), 58 deletions(-)

-- 
2.17.0
