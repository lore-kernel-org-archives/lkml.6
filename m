Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0472C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 05:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B5B20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 05:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="0Gh2xMCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B5B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeJ0Nnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 09:43:49 -0400
Received: from cock.li ([185.100.85.212]:37316 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeJ0Nnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 09:43:49 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1540616641; bh=1SO8YGgFRAj9AnsA5beJpBbTdGKQClzR0ePA7TqYNCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Gh2xMCYRCE6/ddQfcqovKx71aB3BE/Y5P3ltwr3rTG2xAdbVMKg6YtwsMM2NpQOH
         hPPjHrlRdC8DHmBjcwdzLLSoiRXJdITB5aNG1rYU/kcFLWvxJgmofbpclXn4nYtFuF
         dcOEBRGEkqkBAzMbVjmv+l0jX7b09MEfFzrGVqBl5GbzuF9B2rd4nSuaWYOq4C9D6Y
         Vl8N2B9IfqsEZUg2TiQf4FyYRfck6bEOLoGiWRGNWKml9sn7TeiHNk2hLO4BAS0/Vz
         cKFcC4qYG+hNTL3DWCk+snTKj3CaF4JJPQ4V8XGpe43Smg05ztmJYZzIkBT0bOekyR
         Sk2kEy5T1yMZQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 Oct 2018 05:04:00 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     rms@gnu.org, bruce@perens.com, moglen@columbia.edu,
        bkuhn@sfconservancy.org, editor@lwn.net,
        NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant. - Additional
 restrictive terms
In-Reply-To: <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
Message-ID: <6d01319820290f9379cb886bb8bb379b@redchan.it>
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

