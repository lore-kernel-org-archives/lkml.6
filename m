Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeFDHcb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeFDG7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:59:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.9 05/29] tools: enable endian checks for all sparse builds
Date: Mon,  4 Jun 2018 08:58:01 +0200
Message-Id: <20180604065802.370138169@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065802.157744637@linuxfoundation.org>
References: <20180604065802.157744637@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 376a5fb34b04524af501a0c5979c5920be940e05 upstream.

We dropped need for __CHECK_ENDIAN__ for linux,
this mirrors this for tools.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/include/linux/types.h |    4 ----
 1 file changed, 4 deletions(-)

--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -42,11 +42,7 @@ typedef __s8  s8;
 #else
 #define __bitwise__
 #endif
-#ifdef __CHECK_ENDIAN__
 #define __bitwise __bitwise__
-#else
-#define __bitwise
-#endif
 
 #define __force
 #define __user
