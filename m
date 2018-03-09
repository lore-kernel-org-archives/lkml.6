Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeCIKvp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:51:45 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34859 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCIKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:51:44 -0500
X-Google-Smtp-Source: AG47ELsCEEuoUiBoh/dcL2oeBd92NAiOLiIsIlBLHQYtehuLyJGB0JmS6T6LRA2GWqUuaSgV1X44hg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 0/2] mtd: use put_device() if device_register fail
Date: Fri,  9 Mar 2018 16:20:47 +0530
Message-Id: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Arvind Yadav (2):
  [PATCH 1/2] mtd: use put_device() if device_register fail
  [PATCH 2/2] mtd: ubi: use put_device() if device_register fail

 drivers/mtd/mtdcore.c | 1 +
 drivers/mtd/ubi/vmt.c | 1 +
 2 files changed, 2 insertions(+)

-- 
1.9.1
