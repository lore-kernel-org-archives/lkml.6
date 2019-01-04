Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1AB2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfADVrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:47:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43774 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfADVrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:47:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so37737423wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 13:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=++Y7dNmJN9/7rF+FGAjBU64OF/wTbh/TNZ6mMmg3qwU=;
        b=sx75+PVr5JrOq6VcggbmAmejDEWBj/goZRzrt07kaOXBlL7X6yiuTkHkfCaTItZwOZ
         VGA0zdlzANgk8+WR7rUbP6DAI07UWepwrEhngvShI9pm8fmX1pkpyKTVRuCTR2m9rGza
         JpJeXCBq1fXpT956NJBjO5fDoiDBcX0mG9GRVjXW1P80n4ForvLnwwzvmNBqUenIbZMT
         wLYaTEZqppX6bNB11NOlbtGJl5gC35mowNs9uKV17H8q7uGUkdjqsTH2oTSu345m/QZl
         Z29qf/j1wSGE9rE9alMi3NZ2oGDJEe28lkPlqdium7JrgB1wIyY8SGA879WIkgzpnf20
         9BXw==
X-Gm-Message-State: AJcUukdc/7xnLXL3LMp9bldEhi73Y6o8tubjUm9jf6yKbOtXWQjECYvq
        lnoR3MEICfvL9mYRbSEhfks4fw==
X-Google-Smtp-Source: ALg8bN6FMdn+/zZu9nykoJ/EmpTszm0v1GNPO8jfBbLiFi7PrdzWsotFwDIVPq5adpzAK50RQiGsiQ==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr48076435wra.100.1546638449758;
        Fri, 04 Jan 2019 13:47:29 -0800 (PST)
Received: from mcroce-redhat.redhat.com (host177-2-dynamic.16-87-r.retail.telecomitalia.it. [87.16.2.177])
        by smtp.gmail.com with ESMTPSA id z12sm43540987wrh.35.2019.01.04.13.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 13:47:29 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] kernel/sysctl.c: fix typo
Date:   Fri,  4 Jan 2019 22:47:27 +0100
Message-Id: <20190104214727.29431-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistake: "lenght" -> "length"

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1825f712e73b..6b2691f5d4c9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -191,7 +191,7 @@ extern int no_unaligned_warning;
  * 	file position 0 and the value must be fully contained in the buffer
  * 	sent to the write syscall. If dealing with strings respect the file
  * 	position, but restrict this to the max length of the buffer, anything
- * 	passed the max lenght will be ignored. Multiple writes will append
+ * 	passed the max length will be ignored. Multiple writes will append
  * 	to the buffer.
  *
  * These write modes control how current file position affects the behavior of
-- 
2.20.1

