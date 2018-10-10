Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF27C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829AC2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="u1b9RRt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829AC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJKDeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:34:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57360 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727567AbeJKDeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:34:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A8A9E8EE303;
        Wed, 10 Oct 2018 13:10:31 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kImVxJkYc2bU; Wed, 10 Oct 2018 13:10:31 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5616E8EE0C7;
        Wed, 10 Oct 2018 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539202231;
        bh=Ihl6fTALZlvQH0hJxO5Ad9tbXqd2WKNUf242cL9+pq0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u1b9RRt58zXdodcSQb9jwVqTb7WqtI1FkydxC44jIpYhCEMKaYDGly+sI9IHjPhPe
         HdNrEMY4LJa36sEq7kSI8bNmhsZYStpFe9wBoHJl8wzLNOTbDYOz+8Suw8Pv+O1UK8
         F+bd59kFY48jS7vYoHFp50knDexqgiBGdwtoFKh8=
Message-ID: <1539202230.12644.12.camel@HansenPartnership.com>
Subject: [PATCH v2 3/3] code-of-conduct: Add back the TAB as the central
 reporting point
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Oct 2018 13:10:30 -0700
In-Reply-To: <1539202053.12644.8.camel@HansenPartnership.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
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

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: Added this patch to allay concerns we were stripping the reporting
    mechanism entirely.
---
 Documentation/process/code-of-conduct.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index 4dd90987305b..2000bdc2a6ad 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -59,6 +59,16 @@ address, posting via an official social media account, or acting as an appointed
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
+confidentiality with regard to the reporter of an incident.
+
 Attribution
 ===========
 
-- 
2.13.7

