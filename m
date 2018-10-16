Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A9DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3F6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RutvyTzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3F6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJPWvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:51:07 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37136 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbeJPWvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:51:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 534BC8EE2BB;
        Tue, 16 Oct 2018 08:00:17 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6PKa4A7qgQ7T; Tue, 16 Oct 2018 08:00:17 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7B27D8EE0BA;
        Tue, 16 Oct 2018 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539702016;
        bh=7HLSwqMidK8PcoQvLd3rQX+7fyme2YiYWgljhJj6wO8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RutvyTzHoLVBCoyxQr6S9ssgsJaVJ8v1iJrgNzxhzRqX4WQniZRfGdIcj+h+atZ5X
         KODSrg1TwEm/e48M9u61FHao9SYHCuS9waXXd0ThLhNcRrgf4C+9w7b1wxmB7AznvT
         Gt6PKDUxFwQhrkH0Jd3/przJUI17vJkgH601ccf4=
Message-ID: <1539702015.2805.10.camel@HansenPartnership.com>
Subject: [PATCH v3 3/3] code-of-conduct: Add back the TAB as the central
 reporting point
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Oct 2018 08:00:15 -0700
In-Reply-To: <1539701820.2805.6.camel@HansenPartnership.com>
References: <1539701820.2805.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Reporting section where the Enforcement section used to be.  The
intention is still to debate what should go here, but in the meantime, this
gives us back the central reporting point we had in the old code of conflict.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: Added this patch to allay concerns we were stripping the reporting
    mechanism entirely.
v3: Add (where required by law) as a qualifier to the confidentiality
    requirement
---
 Documentation/process/code-of-conduct.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index 4dd90987305b..eec768471a4d 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -59,6 +59,17 @@ address, posting via an official social media account, or acting as an appointed
 representative at an online or offline event. Representation of a project may be
 further defined and clarified by project maintainers.
 
+Reporting
+=========
+
+Instances of abusive, harassing, or otherwise unacceptable behavior may be
+reported by contacting the Technical Advisory Board (TAB) at
+<tab@lists.linux-foundation.org>. All complaints will be reviewed and
+investigated and will result in a response that is deemed necessary and
+appropriate to the circumstances. The TAB is obligated to maintain
+confidentiality with regard to the reporter of an incident (except where
+required by law).
+
 Attribution
 ===========
 
-- 
2.13.7

