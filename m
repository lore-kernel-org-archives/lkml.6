Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971675AbeCSUxr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:53:47 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:16685 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971632AbeCSUxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:53:41 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Mar 2018 21:53:39 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: masaki.ota@jp.alps.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] HID: alps: Fix some bugs and improve code around  't4_read_write_register()'
Date: Mon, 19 Mar 2018 21:53:25 +0100
Message-Id: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All is said in the subject and below.

These patches are untested. Especially, patch 1 slightly changes the behavior
of 't4_read_write_register()'.
This looks logical to me, but please, review it carefully.

Christophe JAILLET (4):
  HID: alps: Report an error if we receive invalid data in
    't4_read_write_register()'
  HID: alps: Save a memory allocation in 't4_read_write_register()' when
    writing data
  HID: alps: Check errors returned by 't4_read_write_register()'
  HID: alps: Fix some style in 't4_read_write_register()'

 drivers/hid/hid-alps.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.14.1
