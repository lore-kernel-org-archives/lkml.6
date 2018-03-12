Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeCLDie (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 23:38:34 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:32902 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932703AbeCLDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 23:38:29 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <cover.1520825708.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 0/3] m68k/mac: Miscellaneous clean-ups and fixes
Date: Sun, 11 Mar 2018 23:38:28 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Finn Thain (3):
  m68k/mac: Clean up whitespace and remove redundant parentheses
  m68k/mac: Enable RTC for 100-series PowerBooks
  m68k/mac: Remove bogus "FIXME" comment

 arch/m68k/mac/misc.c | 138 +++++++++++++++++++++++++++++----------------------
 1 file changed, 78 insertions(+), 60 deletions(-)

-- 
2.16.1
