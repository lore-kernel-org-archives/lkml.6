Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94811C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3513F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OuPDGtBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3513F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeJKDbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:31:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57276 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727478AbeJKDbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:31:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8CEB58EE303;
        Wed, 10 Oct 2018 13:07:34 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eCbcbPILmxLB; Wed, 10 Oct 2018 13:07:34 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3BE2D8EE0C7;
        Wed, 10 Oct 2018 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539202054;
        bh=vGInqjBjcy0QDZE0ighwmRKXcXbrOC3uzP0ZevZkNlc=;
        h=Subject:From:To:Cc:Date:From;
        b=OuPDGtBC5Bgd973zrRGItzTP9Or4BsF6CoXdVzim8D2ch9TG6IGty73FmGCHW1e/v
         Y2gOBymu1XAnRp7qrf/Nhywvyz1aRZOTXYa8JQ11e+Ym9YyK4ftuzC0k6hWw3B9ABf
         AnHwVveFz4GnT7ABpeuP1Gr8oKVw1LP+2EUoI6kU=
Message-ID: <1539202053.12644.8.camel@HansenPartnership.com>
Subject: [PATCH v2 0/3] code of conduct fixes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Oct 2018 13:07:33 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 Documentation/process/code-of-conduct.rst | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

-- 
2.13.7

