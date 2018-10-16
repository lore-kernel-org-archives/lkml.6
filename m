Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F6EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C35C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ib3Q4SI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C35C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJPWuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:50:05 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37074 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbeJPWuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:50:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 87EF68EE2BB;
        Tue, 16 Oct 2018 07:59:15 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WGo6yhrEpLAh; Tue, 16 Oct 2018 07:59:15 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 350198EE0BA;
        Tue, 16 Oct 2018 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539701955;
        bh=1r4jyqzV7ZgkdcFeG86e5al1FKANymopOwKFL9OFcB4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ib3Q4SI73jm7tPukR+LnNAvxXN2225QJ1Izt4v66iCMp9+Zd0CE7OOMF5Gj/YcUNz
         IAtMF0ReRcyu6mxzpFhOej6Z/paG887ujxDm4iFrsyM6EdxHebt+VDcA6Kihbyab5c
         t5rcp/cDRmUTHw5XTFHaF6lXfPuCd1yl5TcWKVvE=
Message-ID: <1539701954.2805.9.camel@HansenPartnership.com>
Subject: [PATCH v3 2/3] code-of-conduct: Strip the enforcement paragraph
 pending community discussion
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Oct 2018 07:59:14 -0700
In-Reply-To: <1539701820.2805.6.camel@HansenPartnership.com>
References: <1539701820.2805.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
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

Note, this patch is expected to be the starting point for a discussion not the
end point, so there is an expectation that an Enforcement section will be
added again to our code of conduct once we have sufficient community consensus
on what it should say.

Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
Acked-by: Shuah Khan <shuah@kernel.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: Added additional commit paragraph clarifying we do expect eventually to
    have an enforcement section (as requested by Shuah)
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

