Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9978BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D253267BC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D253267BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeFZJYw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:24:52 -0400
Received: from osg.samsung.com ([64.30.133.232]:52482 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933677AbeFZJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:24:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 144A130B36;
        Tue, 26 Jun 2018 02:24:46 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9i4A1vQBAs73; Tue, 26 Jun 2018 02:24:44 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id 96C8530B24;
        Tue, 26 Jun 2018 02:24:44 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkDK-0000Xk-3i; Tue, 26 Jun 2018 06:24:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Subject: [PATCH 4/4] alsa: Fix references to Documentation/.*/MultiSound
Date:   Tue, 26 Jun 2018 06:24:40 -0300
Message-Id: <167fc9011e09d3db32e21a03a6a0edb4c949e963.1530004939.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1530004939.git.mchehab+samsung@kernel.org>
References: <cover.1530004939.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the documentation/script file got restored, fix the
references within the Kernel tree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sound/alsa-configuration.rst | 2 +-
 sound/isa/Kconfig                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 4d83c1c0ca04..4a3cecc8ad38 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -1568,7 +1568,7 @@ joystick_io
 The driver requires firmware files ``turtlebeach/msndinit.bin`` and
 ``turtlebeach/msndperm.bin`` in the proper firmware directory.
 
-See Documentation/sound/oss/MultiSound for important information
+See Documentation/sound/cards/multisound.sh for important information
 about this driver.  Note that it has been discontinued, but the 
 Voyetra Turtle Beach knowledge base entry for it is still available
 at
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 43b35a873d78..d7db1eeebc84 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -459,7 +459,7 @@ config SND_MSND_CLASSIC
 	  Say M here if you have a Turtle Beach MultiSound Classic, Tahiti or
 	  Monterey (not for the Pinnacle or Fiji).
 
-	  See <file:Documentation/sound/oss/MultiSound> for important information
+	  See <file:Documentation/sound/cards/multisound.sh> for important information
 	  about this driver.  Note that it has been discontinued, but the
 	  Voyetra Turtle Beach knowledge base entry for it is still available
 	  at <http://www.turtlebeach.com/site/kb_ftp/790.asp>.
-- 
2.17.1

