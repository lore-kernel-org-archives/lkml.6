Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A1C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E1E20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="kypGpR9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E1E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeJ0Pcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:32:46 -0400
Received: from cock.li ([185.100.85.212]:46964 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeJ0Pcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:32:46 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1540623164; bh=XOjG2JaT0pu3bj2tKf1U45c+BkbUPHkrUCqY5WMny/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kypGpR9VbxDCfT7XH3yNqh+vKWXK8Bym1t9gRulkUTn8giNUXH1OWr4PBuT6l43Ho
         vfVVA64m9651lCZTtUa939E6woDAI8psYsu0Evvgd0uIVLdVbKU3ahiafEy9ny2LrY
         +rLN0GmjOqJSiyuJ5fKn0JaEzgVtQYXmz2KiJqqggaPu+AY8x5z/E06cKQoX3k1sHX
         Q/YJcdNTNWHFNWx6rvox95vvv6BtW2mYH75t8kPjyeUWxtI6tEpRFzFMj+fYoR+eaw
         X8kT7Ij1TF5HCXSVBj28xu+6t74rGU/H9f7KOlzA9amTvYZGW7lOyCV5w47UtJ3hyX
         PdrB/wu188y2g==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 Oct 2018 06:52:44 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     esr@thyrsus.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, rms@gnu.org,
        bruce@perens.com, moglen@columbia.edu, bkuhn@sfconservancy.org,
        editor@lwn.net, NeilBrown <neil@brown.name>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: <20181025230656.GJ32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com>
 <20181025204718.GB25649@thunk.org> <20181025214123.GA2448@thyrsus.com>
 <20181025230656.GJ32577@ZenIV.linux.org.uk>
Message-ID: <75eb4a46c8a2c1d4a927760fd1f2009d@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al: the FSF was so insistent on the adoption of the GPL version 3
because the GPL version 2 is not operative against the grantor.

This deficiency was, in their eyes, so fatal to the purposes that they
envisioned that they, as you have pointed out, elected to employ
enhanced means of converting projects to version 3.

Eben Moglen's contention that the GPL 3 exists to internationalize the
GPL is a lie of omission.

It is true that that is a partial reason-to-be for the GPL version 3
but it is not the main nor most important reason for the insistence on
version 3 or "v2 or any later version".

The very heart of the GPLv3 is the addition of the "irrevocable by
grantor" clause and the "term of years" clause.

Additionally the contention by the FSF and, as I recall, Eben Moglen
that the reason the FSF only accepts code where the copyright is
transferred to the FSF - is so they may have standing to sue - is
another lie by omission.

Yes, standing to sue is vital, if you are going to sue.
But the real beating heart of the copyright assignment policy is to
prevent a programmer from rescinding license-to-use regarding his
freely given code.

Without copyright assignment, any contributor to the GNU project could
elect to rescind the gratis license grant at his pleasure, at any
time, as of right.

Without an "irrevocable by grantor" clause (as seen in the GPL version
3, but omitted in GPL version 2 due to a mis-assumption on the part
of the drafter) there is not even an affirmative defense of promissory
estoppel.

We come to lie number three. (Neccecitated by:)
The incorrect assumption made by the
drafter of version 2 of the GPL and memorandized by Eben Moglen in
this very thread in an attempt to protect the error in drafting.
Lie number three: If terms regarding termination are proffered in a
copyright license they are the only means of termination.

This is true... If those terms are supported by bargained-for
consideration.
That is: the words Eben Moglen wrote were true; as regards to
commercial software, where the licensee has paid valuable
consideration for the terms offered.

The drafter of version 2 of the GPL was familiar with such commercial
licensing agreements. He failed in his due-diligence if RMS did
indeed request an irrevocable-by-grantor license. The drafter stopped
his research at the typical copyright license stage, and did not
research further into what underlays the construction there-of.

And thus we have the lie of omission number 3.

(All, naturally, to protect Eben Moglen's former client and to
discourage litigation where there is, indeed, good and sufficient
cause for such litigation) (Which is all part of an attorney's
duties, I can assure you)


On 2018-10-25 23:06, Al Viro wrote:
> On Thu, Oct 25, 2018 at 05:41:23PM -0400, Eric S. Raymond wrote:
> 
>> I do not have any facts with which to dispute this specific claim.
>> However, I do notice that a significant number of long-time
>> contributors have put themselves in the anti-CoC camp. I note Al Viro
>> as a recent example.
> 
> *snort*
> 
> For the record:
> 	* CoC is a piss-poor match for the structure of community
> 	* Linus had essentially tossed a live grenade into an outhouse on
> his way to vacation, with quite predictable results - all kinds of
> interesting coprophagous fauna dropping by to feed, including 
> cartooneys
> of the sort I hadn't seen since NANAE days.
> 	* As idiotic gambits go, "try and revoke the license on my
> contributions, so that they'll have to revoke CoC" is... impressive.
> Sadly, my command of English has turned out to be woefully inadequate,
> and I can't even blame that on not being a native speaker; I'm just as
> incapable of producing a coherent (let alone printable) description of
> that cunning plan in any language, Russian included.  I've tried.  
> Really.
> 	* in case it needs to be spelled out: I am not at all interested
> in that kind of stunts.  One of the reasons I thoroughly despise RMS
> and his bunch is the leverage game they tried to play with GPLv3;
> damned if I'm going to lower myself to their level.
