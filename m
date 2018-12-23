Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD702184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="Jk5lue9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeLWQFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:05:32 -0500
Received: from cock.li ([185.100.85.212]:55474 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbeLWQFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:05:32 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1545581129; bh=1SO8YGgFRAj9AnsA5beJpBbTdGKQClzR0ePA7TqYNCQ=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=Jk5lue9l6ZhjV59/HnXcbX71CpTh5KtGsnSWe8cUkIpXmd14JS5jnK04zy27PaCVz
         1wfh3cPny75794QLhvl18ndmCqlKTbuy8k192inyH+g39i7u4lR8RSnBl4h/lJEyG4
         cdZZOEPnTEyXAUiVMxI/eFdwDZRssA0bBugXYuk9nqsxAvcWTpaIASf0pS4CZnpcPd
         f0jVCDSaeLctf7C5bnHdWQYLAKvNbLg1UGqTzgIRcwfaeKcpRnAs1+PdrosunFUysi
         GrhJt6e0SwMwalHbc3/U7R844qoTd5eE2+2+LRoRyFerOYd5nlHYSD/D3kGy6uk1X8
         08kbV4ruSXvtw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 23 Dec 2018 16:05:29 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: The CoC regime is a License violation - Additional restrictive terms
In-Reply-To: <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
Message-ID: <70e300347917922eadf6e944893802f6@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2 of the GPL forbids the incorporation of additional
restrictive terms, relating to the distribution, modification, etc of
the article licensed under the terms.

Those that violate this section are declared, by operation of the
terms, to have their grant automatically revoked.

An additional term need-not be present in the same writing. Such terms
simply need to be present to or made known to the taker(sub-licensee) by
the distributor. They may be proffered in writing, orally, or
implied in the course of doing business dealings. They simply must
relate back or involve the article in question (the licensed code or
product.)

The proffering of additional restrictive terms is a violation of the
text of the license grant in and of itself.

Here we have a situation where an additional writing has been
proffered. The additional writing promises both in it's own text and
by implication consequences against those who violate the terms of
this additional writing.

The additional writing restricts those subject to it from expressing
certain views publicly - promising retribution against those who do.

No consideration is paid to those subject to the additional writing
for their assent; it is simply imposed unilaterally against the
subjects.

The violators of the additional writing are promised:
Additional, unwanted, public scrutiny (to which they were not subject
to prior)
Public ridicule.
Loss of public standing.
as-well as an implied loss of future income.

These are the enforcement mechanisms of the additional writing to
enforce its restrictions against those who publish derivative works of
the kernel.

The additional writing is activated when (with the prerequisite of
being a derivative work of the linux kernel) the work of a rights-holder
is incorporated into the kernel, when such a work is made known to the
kernel-team to exist where any one person on this earth has seen fit
to present it for inclusion, or by simple prior-inclusion into the
kernel.

Thus all current and past rights-holders who have code in, or have
published for distribution, derivative works of the kernel are subject
to the retributive promises made to them in the additional writing,
drafted to restrict their actions and utterances.

This is tantamount to an additional restrictive term regarding the
modification and distribution of works under the linux kernel license
grant.

It is a violation of the license terms of the rights-holders past
incorporated works in much the same way that GRSecurity's
Contributor Access Agreement was and is.

