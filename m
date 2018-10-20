Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_WORDY,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B288BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1C2215E6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dqC12tvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1C2215E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeJUEZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:25:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39194 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725198AbeJUEZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:25:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B226A8EE0CC;
        Sat, 20 Oct 2018 13:13:55 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WqsKjMjoiDG4; Sat, 20 Oct 2018 13:13:55 -0700 (PDT)
Received: from [192.168.11.218] (ip-64-134-136-40.public.wayport.net [64.134.136.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 27FBB8EE0C8;
        Sat, 20 Oct 2018 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540066435;
        bh=NF2aOwufa/CnAzAihQJ5eA9DhnZGOlxGL7HJvaonR7g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dqC12tvIHMGa9k+5ivZrl2MqC2DABTT0cXklaF/9BcnL1Fe3Du1eXHJCoIc2Wgvzx
         evxucMFWC3F900KbzYt10XYbm5aj3qO+iyoK+oIgG1gx9xurEGaZ6rHds0WXuhIqoG
         FwSDrfbOWb/bhZpHOphrb4+u2y7mpsa+fS/SQmaE=
Message-ID: <1540066434.3464.21.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
 contact email address
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 20 Oct 2018 13:13:54 -0700
In-Reply-To: <20181020192845.48b8b860@alans-desktop>
References: <20181020134908.GA32218@kroah.com>
         <20181020135118.GG32218@kroah.com> <20181020192845.48b8b860@alans-desktop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-20 at 19:28 +0100, Alan Cox wrote:
> > +to the circumstances. The Code of Conduct Committee is obligated
> > to
> > +maintain confidentiality with regard to the reporter of an
> > incident.
> > +Further details of specific enforcement policies may be posted
> > +separately.
> 
> Unfortunately by ignoring the other suggestions on this you've left
> this bit broken.
> 
> The committee can't keep most stuff confidential so it's misleading
> and wrong to imply they can. Data protection law, reporting laws in
> some countries and the like mean that anyone expecting an incident to
> remain confidential from the person it was reported against is living
> in dreamland and are going to get a nasty shock.
> 
> At the very least it should say '(except where required by law)'.

I've got a solution for this: the patches I've been curating also
modify the section so the merger will look like what I have below.

The intent of the series I'm curating was only the beginning to show
desire to change in 4.19 but to correct the obvious defect before we
started the debate, so after suitable discussion, this one can be
the final set.

> There is a separate issue that serious things should always go to law
> enforcement - you are setting up a policy akin to the one that got
> the catholic church and many others in trouble.
> 
> You should also reserving the right to report serious incidents
> directly to law enforcement. Unless of course you want to be forced
> to sit on multiple reports of physical abuse from different people
> about someone - unable to tell them about each others report, unable
> to prove anything, and in twenty years time having to explain to the
> media why nothing was done.

I think we should debate that.  Most legal systems provide significant
deference to victims wishing for confidentiality and we should both
respect that and remember that an automatic crime report is a
significant deterrent  to vulnerable people in a lot of places.

James

---

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index eec768471a4d..8913851dab89 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -59,19 +59,27 @@ address, posting via an official social media account, or acting as an appointed
 representative at an online or offline event. Representation of a project may be
 further defined and clarified by project maintainers.
 
-Reporting
-=========
+Enforcement
+===========
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
-reported by contacting the Technical Advisory Board (TAB) at
-<tab@lists.linux-foundation.org>. All complaints will be reviewed and
-investigated and will result in a response that is deemed necessary and
-appropriate to the circumstances. The TAB is obligated to maintain
-confidentiality with regard to the reporter of an incident (except where
-required by law).
+reported by contacting the Code of Conduct Committee at
+<conduct@kernel.org>. All complaints will be reviewed and investigated
+and will result in a response that is deemed necessary and appropriate
+to the circumstances. The Code of Conduct Committee is obligated to
+maintain confidentiality with regard to the reporter of an incident
+(except where required by law). Further details of specific enforcement
+policies may be posted separately.
+
 
 Attribution
 ===========
 
 This Code of Conduct is adapted from the Contributor Covenant, version 1.4,
 available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
+
+Interpretation
+==============
+
+See the :ref:`code_of_conduct_interpretation` document for how the Linux
+kernel community will be interpreting this document.
