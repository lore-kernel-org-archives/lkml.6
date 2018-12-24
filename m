Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5FC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B5521736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="BDytPErg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeLXQ1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:27:00 -0500
Received: from cock.li ([185.100.85.212]:53362 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbeLXQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:26:59 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1545668816; bh=EHnhNQfdd3IE5IbzFeplj2eUdomn1c/MYomV9PYYF0A=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=BDytPErgWf/ZgOvfF7xoo+YH3BSDj+MdMtWvR0cRimsXhV5HFgaVVXvqLaV/csPzi
         5/c8I3zZv0bZKo4gE8QdUIFMXd3DPPKx+V3sCExg4IZAo79/jfiOb+iac19Y08sZcx
         xkCtwrKXqU2HrQxUan+PY7e55hw8jODJKRUkedzkkzge2cszZ0ABEnUtA+NI/fzdDF
         UFiGU728BepK7f1XKKaGcu9CdL8cIxoc7JXk62KRZGfyI4tVZAQJHz2G/gjX9WqD/P
         J/UO4SmY6Pw5MPHXQ6Do7APN1aRA94zFeFn9MsTTSHvcs18vXm9HRDEzr7QibiagVO
         iUsJl6t/kjDJw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Dec 2018 16:26:56 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org
Subject: Fwd: Re: [DNG] 2 months and no response from Eben Moglen - Yes you
 can rescind your grant. -- The CoC regime is a License violation - Additional
 restrictive terms
In-Reply-To: <b4a43367df247392937554a69157b57b@memeware.net>
References: <b4a43367df247392937554a69157b57b@memeware.net>
Message-ID: <3707ee8a658610c4c42cfbaf6014e677@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-------- Original Message --------
Subject: Re: [DNG] 2 months and no response from Eben Moglen - Yes you 
can rescind your grant. -- The CoC regime is a License violation - 
Additional restrictive terms
Date: 2018-12-24 16:24
 From: vnsndalce@memeware.net
To: dng@lists.dyne.org

Version 2 of the GPL forbids the incorporation of additional
restrictive terms, relating to the distribution, modification, etc of
the article licensed under the terms.

Those that violate this section are declared, by operation of the
terms, to have their grant automatically revoked.

An additional term need-not be present in the same writing. Such terms
simply need to be present to or made known to the taker(sub-licensee) by
the distributor. They may be proffered in writing, orally, or
implied in the course of doing business dealings. They simply must
relate back or involve  the article in question (the licensed code or
product.)

The proffering of additional restrictive terms is a violation of the
text of the license grant  in and of itself.

Here  we have a situation where an additional writing has been
proffered. The additional  writing promises both in it's own text and
by implication consequences against those who violate the terms of
this additional writing.

The  additional writing restricts those subject to it from expressing
certain views publicly - promising retribution against those who do.

No consideration  is paid to those subject to the additional writing
for their assent; it is simply imposed unilaterally against the
subjects.

The violators  of the additional writing are promised:
Additional, unwanted, public scrutiny (to which they were not subject
to prior)
Public ridicule.
Loss of public standing.
as-well as an implied loss of future income.

These are the  enforcement mechanisms of the additional writing to
enforce its restrictions against those who publish derivative works of
the kernel.

The additional  writing is activated when (with the prerequisite of
being a derivative work of the linux kernel) the work of a rights-holder
is incorporated into the kernel, when such a work is made known to the
kernel-team to exist where any one person on this earth has seen fit
to present it for inclusion, or by simple prior-inclusion into the
kernel.

Thus all  current and past rights-holders who have code in, or have
published for distribution, derivative works of the kernel are subject
to the retributive promises made to them in the additional writing,
drafted to restrict their actions and utterances.

This is  tantamount to an additional restrictive term regarding the
modification and distribution of works under the linux kernel license
grant.

It is a violation of the license terms of the rights-holders past
incorporated works in much the same way that GRSecurity's
Contributor Access Agreement was and is.


_______________________________________________
Dng mailing list
Dng@lists.dyne.org
https://mailinglists.dyne.org/cgi-bin/mailman/listinfo/dng
