Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031465AbeEZILa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:11:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36685 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031131AbeEZIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:11:27 -0400
X-Google-Smtp-Source: AB8JxZrAziVG/4GX14xW92cJjKf3Tjr+iqPX2s5YnliGXkuMc8GMMsTmmirx2WiWG9qgOLf5A1OaoA==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Cc: colin.king@canonical.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging:  rtl8192e: Coding style changes
Date: Sat, 26 May 2018 09:10:14 +0100
Message-Id: <20180526081019.4738-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

five patches with simple coding style changes to the file
drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c

The last two patches should probably have been combined as both dealt with the
addition or removal of blank lines, but I missed one style issue on the first
pass. In that situation I guess I should possibly roll back the previous
commit and re-edit?
