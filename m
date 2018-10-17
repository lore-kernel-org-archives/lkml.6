Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA77CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F63A2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kFPblzwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F63A2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJQXpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:45:36 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53320 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbeJQXpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:45:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE1B58EE2EC;
        Wed, 17 Oct 2018 08:49:17 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id evRBtEwDzxvp; Wed, 17 Oct 2018 08:49:17 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 538858EE0D2;
        Wed, 17 Oct 2018 08:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539791357;
        bh=4D0PHBOAn1C9vypOtrdXPEVr2Q4If3Bamahksgp/CF0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kFPblzwNAQmsjIzsZSPuEB9uy389tkavCsleeLP7MbWb8cy3t2PTvT2DF/dvod4ZK
         XWYUTLJscN/SRz5xdIDXEb+Wr0vj5c2biEBNumcExHHQsB0BdFWRrUm5A8wEW34Txb
         F8K/C1wBC+kKWgDsPk82K0hluuhk4VMJyp/4tGXs=
Message-ID: <1539791355.3769.35.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Josh Triplett <josh@joshtriplett.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org, tomi.valkeinen@iki.fi
Date:   Wed, 17 Oct 2018 08:49:15 -0700
In-Reply-To: <20181017152101.GA17531@localhost>
References: <20181017071902.30102-1-geert@linux-m68k.org>
         <20181017091325.GA15991@localhost>
         <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
         <20181017152101.GA17531@localhost>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 08:21 -0700, Josh Triplett wrote:
> People in underrepresented and commonly marginalized groups,
> especially those more commonly overlooked, don't always know if a
> given group has taken their particular group into account or given
> any thought to it. Explicit inclusion helps, and this is a standard
> guideline often cited for good codes of conduct.

Actually, that's not a good thing to do in a vacuum: you have to be
really careful about how you do this from a legal point of view.  The
argument over whether enumerating specific rights or classes disparages
others has been going on for centuries.  To give you an example of how
far back it goes: it's the reason for the ninth amendment to the US
constitution.

The commonly accepted legal way of doing this today is the statement

"examples of X include but are not limited to: ..."

which is thought to work in most jurisdictions and is what you'll find
in all US corporate codes of conduct or ethics.

James

