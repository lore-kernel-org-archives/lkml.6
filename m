Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3548C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D8621569
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bn9nFkZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D8621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeJHWmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:42:38 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43806 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728350AbeJHWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:42:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5EDAC8EE0FD;
        Mon,  8 Oct 2018 08:30:21 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yVDZqPhit-7B; Mon,  8 Oct 2018 08:30:21 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E251D8EE2EC;
        Mon,  8 Oct 2018 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1539012621;
        bh=ZWZyUQHuRroN9Mhy2av6hXrS5rfHm11McFWsX2TLRjw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bn9nFkZtht+Vy/Xor4OwbZ4b8AmDnG9gebBwkd3hdNVRHfKTJTm6aram1S3wnWlDP
         wDmaIXkhyewVUuBzV1kL+V8JP/wKajiUZ/CTD5ggVNSFGWe1WLJoZZTh07w/d65aIo
         ZB9F7mzL9eEpRRw0mgJoD+7h6ZjbJCQs2Zc5iX/s=
Message-ID: <1539012620.4344.5.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Mon, 08 Oct 2018 08:30:20 -0700
In-Reply-To: <20181008152043.GA5796@localhost>
References: <1538861738.4088.5.camel@HansenPartnership.com>
         <1538861799.4088.6.camel@HansenPartnership.com>
         <20181008152043.GA5796@localhost>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 08:20 -0700, Josh Triplett wrote:
> On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley wrote:
> > The current code of conduct has an ambiguity in the it considers
> > publishing private information such as email addresses unacceptable
> > behaviour.  Since the Linux kernel collects and publishes email
> > addresses as part of the patch process, add an exception clause for
> > email addresses ordinarily collected by the project to correct this
> > ambiguity.
> 
> Upstream has now adopted a FAQ, which addresses this and many other
> questions. See https://www.contributor-covenant.org/faq .
> 
> Might I suggest adding that link to the bottom of the document,
> instead? (And then, optionally, submitting entries for that FAQ.)

We can debate that as part of everything else, but my personal opinion
would be we should never point to an outside document under someone
else's control for guidance as to how our community would enforce its
own code of conduct.

James

