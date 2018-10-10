Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120162082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vR76brfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120162082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeJKEnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:43:00 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58022 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbeJKEnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:43:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 907F28EE303;
        Wed, 10 Oct 2018 14:19:01 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1IUI3QKx2JWE; Wed, 10 Oct 2018 14:19:01 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 241FD8EE0C7;
        Wed, 10 Oct 2018 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539206341;
        bh=dIviYvgw74yVjKOXItvrsq91dlcOGAtJOqiOmUoxEzA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vR76brfad5dIDcl+d/eshIfyeqrhTUEgQxkyBengOoqCR9STx66iWEZ+2mkUW+Zkz
         CbNdBGdor4V1okE7SkUe/LBtytytzJt4pyc5r7jrso3/h0jWrfHypDkzFvNQCtYNIn
         EPtksM5xdxgv5zNrkolU2t87IQf1kNROpxkNaFRU=
Message-ID: <1539206340.12644.20.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 2/3] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Oct 2018 14:19:00 -0700
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D40E4F6@ORSMSX107.amr.corp.intel.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
         <1539202180.12644.10.camel@HansenPartnership.com>
         <3908561D78D1C84285E8C5FCA982C28F7D40E4F6@ORSMSX107.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-10 at 21:04 +0000, Luck, Tony wrote:
> > the enforcement clause of the new code of conduct.  Since there is
> > concern that this becomes binding on the release of the 4.19 kernel
> 
> Is there some logic behind that concern?

Well, yes, Linux as a project goes through numbered releases, so
releases are the usual official points we try to stop changing stuff,
so if we want to reset the expectation the committed CoC is final,
doing it before the release is helpful.

>  What's magic about the release of 4.19?

It's the first one after the CoC change.

> Our benevolent dictator committed that patch. Didn't it take effect
> as soon as he ran "git push" to make it visible to the world

Not usually: people usually have to agree to a change like this.  Of
course "agree" is a variable concept and can be as simple as not object
by a certain time or by using certain infrastructure.

James

