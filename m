Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B14C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603D21736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="eAY6rGPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeLXQWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:22:54 -0500
Received: from cock.li ([185.100.85.212]:49174 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbeLXQWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:22:53 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1545668569; bh=Chgzr6OyDFUO1zcAU1tUkB6WaY/UuwOvkccObQi8HgM=;
        h=Date:From:To:Subject:From;
        b=eAY6rGPCyqvexl3siIfksJJOzHTQSn9OCk41U4U6oaHK45pLPiHwdyFBKpXrEmwTo
         I3ZvGf4JxnlkQ+Eiw7WEsaMKC8aEp+NM7aXR0mz3fZ8ypp/ceG70slj7T/M2ju2hKl
         QOmN0lAzKVmJIb0znpZD7k6AJ5oLUEybD8/ce5fgypsdK0ydtap0ENKgFiF20zQ/GY
         +sEmPS3MKlPSgdghGd/Z+oZ5HxituJU6Fkuwyodb7GsPI8tPG9aI/kb0sbKdu+9yMe
         EG++DQUfyhtSsD9HLIrtgxAqRrecBwYMNGgnKL2gMrgbNYs8dKHQr7/H6Muwz0Hv+K
         AfCgI3CGzpZ5Q==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Dec 2018 16:22:49 +0000
From:   vnsndalce@memeware.net
To:     dng@lists.dyne.org, linux-kernel@vger.kernel.org
Subject: Re: [DNG] 2 months and no response from Eben Moglen - Yes you can
 rescind your grant. -- The CoC regime is a License violation - Additional
 restrictive terms
Message-ID: <d346c097c905ec7b9bd1d887d5fc047a@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hendrik Boom, are you a lawyer?
No? How about you shut your fucking mouth about things you have no clue 
of?

Sound like a plan, ignorant lay person?

Below is an explanation of just how it is a violation of the 
rights-holder's grant. The courts are not fooled by "clever" verbiage 
written up by laypersons such as yourself and such as the drafter of the 
CoC. They see things for what they are.

Hendrik Boom wrote:
> 
> Actually, no. It has no effect on what you can do with your copy of
> the Linux kernel. It just restricts your ability to participate fully
> in its development. But you can continue to use, modify, and
> distribute your copies as much as before, as provided by the license.
> 
> -- hendrik


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


