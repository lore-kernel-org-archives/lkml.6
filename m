Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEGGye (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:54:34 -0400
Received: from exmail.andestech.com ([59.124.169.137]:61106 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeEGGyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:54:32 -0400
From: Nickhu <nickhu@andestech.com>
To: <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <green.hu@gmail.com>, <vincentc@andestech.com>
CC: Nickhu <nickhu@andestech.com>
Subject: [PATCH 0/2] nds32:Renaming file and fixing the unaligned access handler
Date: Mon, 7 May 2018 14:45:00 +0800
Message-ID: <cover.1525673368.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w476bJiI068160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of /proc/sys/nds32/unaligned_acess spelled wrong, so we renaming it
to /proc/sys/nds32/unaligned_access.

The unaligned access handler in nds32 goes wrong when the immediate field of
load/store instruction is negative. We fix it by recongnizing whether the
immediate field is positive or negative and then change the value of immediate
filed to unsigned integer number.

Nickhu (2):
  nds32: Renaming the file for unaligned access
  nds32: Fix the unaligned access handler

 arch/nds32/mm/alignment.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.0
