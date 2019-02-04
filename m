Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F136C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CFB2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="c/FY7rF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBDU41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:56:27 -0500
Received: from cock.li ([185.100.85.212]:38012 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfBDU41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:56:27 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1549313781; bh=9D6AFZRXDJ2JranI/gi5VgLfj2C+YmUtdAnz8ajMhME=;
        h=Date:From:To:Cc:Subject:From;
        b=c/FY7rF/dY9Nzt2vEidbcJHFAAndXChBvbHJQMNYA3xTJUuQ2sq5zUxQqWYbimb6q
         glE6up63eGh7DaON/+MMyYx5mpzCn3/shZse1wXXjeOY7shQ1Z7DQL3DueUpy+HaCE
         4sFrqpvQkz0yRUFC99h5gdh67Ab/iatC+1uCUn5gUbzy7rX1mHTUVlPmxyxIOuCqop
         E2UuB+bvtAtnbgs4gzD6CB4gQc+brd83mdbki4tzAGt90Qtssl3jd8U3jiWBRM7Jly
         /6MxLCOhn2HznRtmWXQobdy+/BTYbjX6zw9VfG3vbhoaMUt155aNTi+xqzAPGg5gpv
         Q1WeZaxF7hKNA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Feb 2019 20:56:21 +0000
From:   mikeeusa@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     legal@github.com, legal@microsoft.com, copyright@microsoft.com,
        misc@openbsd.org, gentoo-user@lists.gentoo.org, rms@gnu.org,
        moglen@columbia.edu, bkuhn@sfconservancy.org, esr@thyrsus.com,
        editor@lwn.net, torvalds@osdl.org, news@theregister.co.uk,
        editor@lulz.com, blukashev@sempervictus.com, tcallawa@redhat.com,
        compliance@sfconservancy.org, freebsd-chat@freebsd.org
Subject: I have rescinded the GPL from a number of people (regarding GPC-Slots
 2)
Message-ID: <690fe1b6215162c245d23c41bc74176b@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some decisions I have made regarding my GPC-Slots 2 game:

I had chosen, as was my want, to rescind the license I extended from a 
few choice individuals. I can do this because GPC-Slots 2 is my 
copyrighted work. I built it. I never transferred the copyright over to 
anyone.

The individuals are:
"JohnDoe" from 8chan (he knows who he is)
comphacker from here, reddit (if he violates, I'll know who he is after 
the subpoenas during discovery)
Leigh Honeywell
Alex "Skud" Bayley
the "Geek feminist" collective (I believe they are identifiable, and a 
small group, so no harm using this closed-class identification)

I will continue to rescind the license from anyone who adds a "Code of 
Conduct" anywhere near my code (to "fight sexism".). I wholeheartedly 
/support/ sexism, as-long as it is not against men. Since men are now 
being assaulted as thanks for their ceaseless decades-long work on 
opensource by people who did not put in the time, men should /support 
sexism/ by revoking license to their gratis licensed copyrighted code 
from any project that adds a "Code of Conduct".

--MikeeUSA--
(electronic signature)

----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- 
----- ----- ----- ----- ----- -----
Some notes:
A license without an attached interest is revocable in the US (other 
countries have different laws, which is why many OSS repos kept out of 
the US in the past, it is also why the FSF is both a 501(c)(3) charity 
and also requires copyright assignment to them for any contribution they 
accept (otherwise an author who was still the copyright owner of the 
code could rescind the license to the code)).

Opensource friends like to bring up the recent district court decision 
in california to try to argue the the GPL is a contract. (It's also 
interesting that they started adding CoC's right after said decision, to 
push out the men who created OpenSource) They are wrong. Acquiescing to 
a preexisting duty is insufficient for consideration. They like to quote 
this part:

> "Not so. The GNU GPL, which is attached to the complaint,provides that 
> the
Ghostscript user agrees to its terms if the user does not obtain a 
commercial
license" (Artifex v. Hancom, Case No.16-cv-06982-JSC, page 4 line 17)


This is false on its face.

The GNU GPL contains no such language.

The /business agreement writing/ that Artifex wrote up and posted on its 
webpage includes such language. The court here is conflating "The GNU 
GPL" with the writing Artifex published on it's webpage. It is an error 
on the courts case. A typo by whomever who drafted the decision perhaps 
(conflating Artifex's contract language with the GPL itself).

The court goes on to allow Artifex to recover on either 
breach-of-contract grounds (for the amount a commercial license is 
worth) OR to go forward with a statutory copyright infringement action. 
If the GPL alone was a contract, there would simply be two different 
state-law breach of contract theories to pursue (breach of the "business 
offer" writing or breach of the GPL "contract", and the court would 
dispose of the case that way).

----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- 
----- ----- ----- ----- ----- -----

David McGowan Esq. made a correct statement of the law:

> David McGowan, Professor of Law, University of Minnesota Law School:

> "Termination of rights

> [...] The most plausible assumption is that a developer who releases 
> code under the GPL may terminate GPL rights, probably at will.

> [...] My point is not that termination is a great risk, it is that it 
> is not recognized as a risk even though it is probably relevant to 
> commercial end-users, accustomed to having contractual rights they can 
> enforce themselves.


----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- 
----- ----- ----- ----- ----- -----

Lawrence Rosen Esq. got it right the first time:
( 
https://www.amazon.com/Open-Source-Licensing-Software-Intellectual/dp/0131487876 
  )

> p46 "As long as the project continues to honor the terms of the 
> licenses under which it recieved contributions, the licenses continue 
> in effect. There is one important caveat: Even a perpetual license can 
> be revoked. See the discussion of bare licenses and contracts in 
> Chapter 4"
--Lawrence Rosen

> p56 "A third problem with bare licenses is that they may be revocable 
> by the licensor. Specifically, /a license not coupled with an interest 
> may be revoked./ The term /interest/ in this context usually means the 
> payment of some royalty or license fee, but there are other more 
> complicated ways to satisfy the interest requirement. For example, a 
> licensee can demonstrate that he or she has paid some consideration-a 
> contract law term not found in copyright or patent law-in order to 
> avoid revocation. Or a licensee may claim that he or she relied on the 
> software licensed under an open source license and now is dependent 
> upon that software, but this contract law concept, called promissory 
> estoppel, is both difficult to prove and unreliable in court tests. 
> (The concepts of /consideration/ and /promissory estoppel/ are 
> explained more fully in the next section.) Unless the courts allow us 
> to apply these contract law principles to a license, we are faced with 
> a bare license that is revocable.
--Lawrence Rosen

> p278 "Notice that in a copyright dispute over a bare license, the 
> plaintiff will almost certainly be the copyright owner. If a licensee 
> were foolish enough to sue to enforce the terms and conditions of the 
> license, the licensor can simply revoke the bare license, thus ending 
> the dispute. Remeber that a bare license in the absence of an interest 
> is revocable."
--Lawrence Rosen

Lawrence Rosen - Open Source Licensing - Sofware Freedom and 
Intellectual property Law



> p65 "Of all the licenses descibed in this book, only the GPL makes the 
> explicity point that it wants nothing of /acceptance/ of 
> /consideration/:
> ...
> The GPL authors intend that it not be treated as a contract. I will say 
> much more about this license and these two provisions in Chapter 6. For 
> now, I simply point out that the GPL licensors are in essentially the 
> same situation as other open source licensors who cannot prove offer, 
> acceptance, or consideration. There is no contract."
--Lawrence Rosen
