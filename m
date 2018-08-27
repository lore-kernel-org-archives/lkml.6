Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B817208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B817208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeH0Xec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:34:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0Xdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:47 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LlFaA-1fKlSG2Mwo-00b2w1; Mon, 27 Aug 2018 21:45:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/14] asm-generic: Remove empty asm/unistd.h
Date:   Mon, 27 Aug 2018 21:45:25 +0200
Message-Id: <20180827194531.3796559-9-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:2EVCHoabxR8FT28jD6zrmEoQz6SAw/UnZzYWPCZrUFliV5+7nAW
 ASbCPL8NeIuCUDNT3LBLYZXzyyzSSTyVRbaAEpe5zH/8r67kjN5I6Qk11PVcW1xC1MB4Az/
 z2AyIAjRojjUoqEysAzx+7svD3wXdurjK0jGsgKvqLAm3rg19f75yxocNOToE7hm2tb3Bpd
 nOXzydleJoXgFvtJ+TNQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YxGxJtvL1yw=:+BIfcRqKnoK64JagiEAPHv
 YXzPp9lrpQCVR9G63MzQQ9x2BhbVVCZW2cWYxTf3ePINjRwUxbT1+4Bvb8I1gP8NPkskeXIQY
 lTdBsoJnd0BgPGkY/illPFO+nJg/twVRupL/ITVy60Uf6hPeMmh+yVRyHDBOcxaTdI3W3L1Lq
 zZ25iKZvneQMKdRiH7BKrq2w/yKM4DmxqUAZtIB8yqF2X2EuHWbqPysX1i6XZ6ciM6HIgTxwn
 YXa0SlIsk0vSCahei8D6B2nm7jys0VZGgoojh4EYwIVznFFf6jF4oZxeSWN8UdQO80M3FOglU
 PJr620XlS3WvA2X/sGnROHshv45+couG2JtB+CqkP804saiQkOn0X1VndkoOxIXhD1pJTvylp
 v1sr8UQxJZ36lPyLTaMPupOgnBL//l4DATMhYJ7ylNjlSRV/YUuUvBqq7TOqYKjtiD3Tn9fY7
 S4pAwOTRsp+ehO6OI/ltNvydDwkKttlCoKc1VUzOf56OSpWK4bXC8GEllJprEQQCGH7Q5TvpQ
 KH1R9LWnNi2gEmAEQMCg/cgZluwHg2XwiJVL3pwFmW7AJlC6aYujKUslx6ksTGxVFWyChbVbg
 XPcdRa496fS2jMa6HAQoHnStpWlnSGhe0TyacE5UHEdzcmLi3IhPDNWM2Ll3AlKT+GFZRnZsi
 oCtA3mzubpjDyIuCTv2Kd0Htr4s1W2FSUIMc525974UNgHw2rFsgWirTd+xcV/9V8HWg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing is left in asm/unistd.h except for the redirect to
uapi/asm/unistd.h, so removing the file simply leads to that one being
used directly.  The linux/export.h inclusion is a leftover from commit
e1b5bb6d1236 ("consolidate cond_syscall and SYSCALL_ALIAS declarations")
and should not be used anyway.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/unistd.h | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 include/asm-generic/unistd.h

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
deleted file mode 100644
index 71d2fcf9dbcd..000000000000
--- a/include/asm-generic/unistd.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <uapi/asm-generic/unistd.h>
-#include <linux/export.h>
-- 
2.18.0

