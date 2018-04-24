Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeDXWqx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:46:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40892 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeDXWqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:46:51 -0400
X-Google-Smtp-Source: AIpwx4/uovkITpnxoAwmB6aBGm/moyGP5mZ6QfWPzN6dBxMZXgELkXivLCHGHlSmfGZDPkDpNFtAYg==
Date: Tue, 24 Apr 2018 15:46:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rslib: Document rs_control "buffers" field
Message-ID: <20180424224649.GA2250@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix htmldocs complaint about lack of documentation of the buffers field:

>> include/linux/rslib.h:56: warning: Function parameter or member 'buffers' not described in 'rs_control'

Fixes: 12a154e7697c ("rslib: Allocate decoder buffers to avoid VLAs")
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
Adding this to my vla/rslib tree...
---
 include/linux/rslib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 9dc36cae45e9..0ae635bc6d5a 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -48,6 +48,7 @@ struct rs_codec {
 /**
  * struct rs_control - rs control structure per instance
  * @codec:	The codec used for this instance
+ * @buffers:	Internal scratch buffers used in calls to decode_rs()
  */
 struct rs_control {
 	struct rs_codec	*codec;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
