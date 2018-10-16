Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BFBC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="jVTtp5AJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853F3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJPWrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36926 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727086AbeJPWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 221CB8EE2BB;
        Tue, 16 Oct 2018 07:57:02 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aUW3zPlzZ3O6; Tue, 16 Oct 2018 07:57:01 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AB23D8EE0BA;
        Tue, 16 Oct 2018 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539701821;
        bh=QIYEbFX3RzCuw5CAgO8uVWtY1K5IHjZTi+9VOurJMeM=;
        h=Subject:From:To:Cc:Date:From;
        b=jVTtp5AJe73MYogSGoz+wF5GUvwYP5ft0TuKem+b43tIJ+6hoGycPvop8UJAE/reX
         2pvj6J3qbcKkQQ2SAakEYN1V2t8ksfRoQCtq1FxQCoKUZl44ZAIoD8QA4oSPGQUzKB
         rSQvfiIZ7mHPiCLDirlC8vuYVZQ5s3jy9EsqA6BM=
Message-ID: <1539701820.2805.6.camel@HansenPartnership.com>
Subject: [PATCH v3 0/3] code of conduct fixes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Oct 2018 07:57:00 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend to modify the third patch to add (except where required by law)
and accumulate more tags

---

Previous cover letter:

Resend to show accumulated tags and also to add a third patch listing
the TAB as the reporting point as a few people seem to want.  If it
gets the same level of support, I'll send it in with the other two.

---

Previous cover letter:


We've had several threads discussing potential changes to the code of
conduct but Mauro is the only person to have proposed an actual patch. 
In order to move the debate on, I'm presenting two patches, one to fix
the email problem Mauro identified and the other to strip the
enforcement section pending community discussion as Shuah suggested.

I'll take responsibility for collecting any tags people want to add
(review/ack/sign off, etc) and sending the patch in as a signed pull
request before 4.19 final if they get enough community support.

Note, I've sent both patches in as a series to facilitate review and
discussion, but they are separable if one is looked on with less favour
than the other.

It was also a bit unclear which list to send this to, but I finally
settled on linux-kernel as the catch all and ksummit-discuss since
that's where most of the current discussion is.  I can add other lists
as people suggest them.

James

---


James Bottomley (3):
  code-of-conduct: Fix the ambiguity about collecting email addresses
  code-of-conduct: Strip the enforcement paragraph pending community
    discussion
  code-of-conduct: Add back the TAB as the central reporting point

 Documentation/process/code-of-conduct.rst | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.13.7


