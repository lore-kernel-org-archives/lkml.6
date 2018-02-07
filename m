Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754803AbeBGRQf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:16:35 -0500
Received: from zimbra.linuxprofi.at ([93.83.54.199]:45638 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754744AbeBGRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:16:32 -0500
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: [PATCH 0/3] hid: logitech-dj: code style improvements
Date: Wed,  7 Feb 2018 18:07:57 +0100
Message-Id: <20180207170800.15015-1-christoph@boehmwalder.at>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several rather trivial code style issues in the Logitech DJ HID
driver.  Most of these were reported by checkpatch, others are just
attempts to make the code adhere more to the kernel coding guidelines.

Signed-off-by: Christoph Böhmwalder <christoph@boehmwalder.at>

Christoph Böhmwalder (3):
  hid: logitech-dj: fix various style issues
  hid: logitech-dj: fix checkpatch issues
  hid: logitech-dj: delete unnecessary error messages

 drivers/hid/hid-logitech-dj.c | 318 +++++++++++++++++++++---------------------
 1 file changed, 161 insertions(+), 157 deletions(-)

-- 
2.13.6
