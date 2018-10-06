Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46636ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE652087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="S7CMOzyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE652087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeJGEkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:40:32 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55172 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbeJGEkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:40:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 189E98EE2BB;
        Sat,  6 Oct 2018 14:35:40 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kcX0Fvp9dibV; Sat,  6 Oct 2018 14:35:39 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B065E8EE2AF;
        Sat,  6 Oct 2018 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538861739;
        bh=gN3uQyT9uD5nsGQp7ZhSD5CedLtYIx3Kk+wRJccflWI=;
        h=Subject:From:To:Cc:Date:From;
        b=S7CMOzyyd9Tk/1k/Ahd5UZsb3hd4ZjaJeBGOjhrHhw7oXg1qTXpOum+uwX1gg4Mtf
         EOVhgOTKHQTGFnX1/BPYyoA65HIz2P5TbeOBcACE2P9BV5WKOQZ2cGmJqT+g2BqlPw
         6MNSGgoD8T6TkYBLNrWt/vTTZoctm+wBZcvp66gU=
Message-ID: <1538861738.4088.5.camel@HansenPartnership.com>
Subject: [PATCH 0/2] code of conduct fixes
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 06 Oct 2018 14:35:38 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

James Bottomley (2):
  code-of-conduct: Fix the ambiguity about collecting email addresses
  code-of-conduct: Strip the enforcement paragraph pending community
    discussion

 Documentation/process/code-of-conduct.rst | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)
