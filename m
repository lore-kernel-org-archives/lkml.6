Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0872CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8752082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8752082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLBJuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:50:04 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:45672 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:50:04 -0500
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 6xpy1z0083XaVaC01xpy3m; Sun, 02 Dec 2018 10:49:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gTONy-0003vg-Jx; Sun, 02 Dec 2018 10:49:58 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gTO7c-00012d-GU; Sun, 02 Dec 2018 10:33:04 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>,
        Bart Van Assche <bvanassche@acm.org>,
        Pavel Machek <pavel@ucw.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] code-of-conduct: Remove explicit list of discrimination factors
Date:   Sun,  2 Dec 2018 10:32:57 +0100
Message-Id: <20181202093257.3918-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing an explicit list of discrimination factors may give the false
impression that discrimination based on other unlisted factors would be
allowed.

Furthermore, this list is already overly long, polarizing,
politically-laden, and reinstating the concept of human races.
None of these is related to the goals of the Linux kernel project.

Avoid any ambiguity or political undertone by removing the list, to
ensure "a harassment-free experience for everyone", period.

Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Frank Rowand <frowand.list@gmail.com>
Acked-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Acked-by: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Acked-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
v3:
  - Add 2 Acked-bys,
  - Add more rationale to the patch description.

v2:
  - Add 3 Acked-bys.
---
 Documentation/process/code-of-conduct.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index be50294aebd5db37..4379cce85faa804d 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -8,10 +8,7 @@ Our Pledge
 
 In the interest of fostering an open and welcoming environment, we as
 contributors and maintainers pledge to making participation in our project and
-our community a harassment-free experience for everyone, regardless of age, body
-size, disability, ethnicity, sex characteristics, gender identity and
-expression, level of experience, education, socio-economic status, nationality,
-personal appearance, race, religion, or sexual identity and orientation.
+our community a harassment-free experience for everyone.
 
 Our Standards
 =============
-- 
2.17.1

