Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536FECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE732087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nN2ua65t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE732087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJGEmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:42:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55228 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbeJGEmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:42:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D52F08EE2BB;
        Sat,  6 Oct 2018 14:37:31 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C0HVFiBfsBh1; Sat,  6 Oct 2018 14:37:31 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8B04F8EE2AF;
        Sat,  6 Oct 2018 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538861851;
        bh=d2kVCss03zzJ4x8NharAivFEtZnTfBcC7zPsoJV50O4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nN2ua65tv8ILsWWc+4OVihaj2Zcut2HJYaQ1Ds3r850zaGgpxFUyey6HobEwxVP/B
         c1UYqcyWvf6Eeu6/Z6RH+KgFK+KfcgISQxzghIznbP5bzWWnrXnGarztmblYew0LZ1
         XwZLcjHsG62k5Yv4pvp8nMcEszrQZ4hjuZkJNR1s=
Message-ID: <1538861851.4088.7.camel@HansenPartnership.com>
Subject: [PATCH 2/2] code-of-conduct: Strip the enforcement paragraph
 pending community discussion
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 06 Oct 2018 14:37:31 -0700
In-Reply-To: <1538861738.4088.5.camel@HansenPartnership.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Significant concern has been expressed about the responsibilities outlined in
the enforcement clause of the new code of conduct.  Since there is concern
that this becomes binding on the release of the 4.19 kernel, strip the
enforcement clauses to give the community time to consider and debate how this
should be handled.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 Documentation/process/code-of-conduct.rst | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index aa40e34e7785..4dd90987305b 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -59,21 +59,6 @@ address, posting via an official social media account, or acting as an appointed
 representative at an online or offline event. Representation of a project may be
 further defined and clarified by project maintainers.
 
-Enforcement
-===========
-
-Instances of abusive, harassing, or otherwise unacceptable behavior may be
-reported by contacting the Technical Advisory Board (TAB) at
-<tab@lists.linux-foundation.org>. All complaints will be reviewed and
-investigated and will result in a response that is deemed necessary and
-appropriate to the circumstances. The TAB is obligated to maintain
-confidentiality with regard to the reporter of an incident.  Further details of
-specific enforcement policies may be posted separately.
-
-Maintainers who do not follow or enforce the Code of Conduct in good faith may
-face temporary or permanent repercussions as determined by other members of the
-project’s leadership.
-
 Attribution
 ===========
 
-- 
2.13.7

