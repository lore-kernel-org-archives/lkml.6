Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeBAWpR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:45:17 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35922 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBAWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:45:12 -0500
X-Google-Smtp-Source: AH8x224ckzJTaYsygBVhve04yh3g6W62K4xLyJS1+6B/eR9c9qfznCAONi+FxhurRFfWZS4m32AC4g==
Date: Fri, 2 Feb 2018 01:45:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: condemn myself to MAINTAINERS
Message-ID: <20180201224508.GA12914@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll regret it.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11045,6 +11045,14 @@ W:	http://wireless.kernel.org/en/users/Drivers/p54
 S:	Obsolete
 F:	drivers/net/wireless/intersil/prism54/
 
+PROC FILESYSTEM
+R:	Alexey Dobriyan <adobriyan@gmail.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/proc/*
+F:	include/linux/proc_fs.h
+
 PROC SYSCTL
 M:	"Luis R. Rodriguez" <mcgrof@kernel.org>
 M:	Kees Cook <keescook@chromium.org>
