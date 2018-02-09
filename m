Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeBIX6r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:58:47 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:54396 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbeBIX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:58:43 -0500
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.123.133) smtp.mailfrom=rabel@robertabel.eu smtp.helo=buildbert.robertabel.eu
From: Robert Abel <rabel@robertabel.eu>
To: miguel.ojeda.sandonis@gmail.com
Cc: linux-kernel@vger.kernel.org, Robert Abel <rabel@robertabel.eu>
Subject: [PATCH 0/3] auxdisplay: charlcd: miscellaneous patches
Date: Sat, 10 Feb 2018 00:50:09 +0100
Message-Id: <20180209235012.4993-1-rabel@robertabel.eu>
X-Mailer: git-send-email 2.11.0
X-PPP-Message-ID: <20180209235035.28592.77201@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at charlcd I noticed some little bits here and there that might
be corrected or improved.

Robert Abel (3):
  auxdisplay: charlcd: fix hex literal ranges for graphics command
  auxdisplay: charlcd: use null character instead of zero literal to
    terminate strings
  auxdisplay: charlcd: replace octal literal with form-feed escape
    sequence

 drivers/auxdisplay/charlcd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.11.0
