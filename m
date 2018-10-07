Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BEEC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38772088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38772088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJGP60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 11:58:26 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:54430 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJGP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 11:58:26 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id kYro1y01n3XaVaC06YroNA; Sun, 07 Oct 2018 10:51:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g94my-0008E0-5p; Sun, 07 Oct 2018 10:51:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g94my-0004eA-4P; Sun, 07 Oct 2018 10:51:48 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] code-of-conduct: Remove explicit list of discrimination factors
Date:   Sun,  7 Oct 2018 10:51:02 +0200
Message-Id: <20181007085102.17795-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing an explicit list of discrimination factors may give the false
impression that discrimination based on other unlisted factors would be
allowed.

Avoid any ambiguity by removing the list, to ensure "a harassment-free
experience for everyone", period.

Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
The use of "race" may also conflict with the United Nation's views on
this matter, cfr. e.g. the UNESCO's "Four statements on the race
question"[1][2] and "Declaration on Race and Racial Prejudice"[3].

[1] https://en.wikipedia.org/wiki/The_Race_Question
[2] http://unesdoc.unesco.org/images/0012/001229/122962eo.pdf
[3] http://portal.unesco.org/en/ev.php-URL_ID=13161&URL_DO=DO_TOPIC&URL_SECTION=201.html
---
 Documentation/process/code-of-conduct.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index ab7c24b5478c6b30..e472c9f86ff00b34 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -6,10 +6,7 @@ Our Pledge
 
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

