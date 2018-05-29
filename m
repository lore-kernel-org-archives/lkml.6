Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966115AbeE2SJm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:09:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38513 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965678AbeE2SJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:09:36 -0400
X-Google-Smtp-Source: AB8JxZrkUjPYFruY0GHwp/AW96t86uVAFxFCMbKIrlnYD8rUqSwZdWmCW9pUzpWFP2FOdPwjPL6U+Q==
Message-ID: <5b0d975e.1c69fb81.ef133.94d5@mx.google.com>
X-Google-Original-Message-ID: <20180529180932.GA718@bhanusreemahesh@gmail.com>
Date: Tue, 29 May 2018 23:39:32 +0530
From: Bhanusree Pola <bhanusreemahesh@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH] staging: comedi: comedi_usb.h: SPDX License Identifier is
 added in the first line
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX License Identifier is added in form of a comment.

Signed-off-by: Bhanusree Pola <bhanusreemahesh@gmail.com>
---
 drivers/staging/comedi/comedi_usb.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/comedi_usb.h b/drivers/staging/comedi/comedi_usb.h
index 50287de..601e29d 100644
--- a/drivers/staging/comedi/comedi_usb.h
+++ b/drivers/staging/comedi/comedi_usb.h
@@ -1,6 +1,5 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * comedi_usb.h
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* comedi_usb.h
  * header file for USB Comedi drivers
  *
  * COMEDI - Linux Control and Measurement Device Interface
-- 
2.7.4
