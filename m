Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C363C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5100D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="wnRlZTZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfANKsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:48:17 -0500
Received: from cock.li ([185.100.85.212]:47322 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfANKsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:48:17 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1547462892; bh=swMDnb6ErJsPVri0dqrT63UdurINMPJ4ZcF20EfXjIY=;
        h=Date:From:To:Cc:Subject:From;
        b=wnRlZTZB33I02rXh9brfqi3GSrgMz2yt07IMBw8bmAXr9kBK7r4pN9uo69ubr4OMd
         KSZBqhbclPYbCoGINCAcJWT4JdcpL/Lwf1QcgAZqb6no/Wi4zF+VKxDuI9m0HdiDyI
         FqrdyM9NrWTL4ViwPsHrPs3Z7dWr72+o7eb8CBbtku/bVNIaErPnv8vD68oWmJlQXz
         s5NQUMf3cjpCPxCfAMs8UiHsBYsPxUX/YxfJzbEHRRmEfDwHC5XCITleKHNebcJOtB
         qcN1X2EzPeSOd3S1FIIyHzOX3zqheI3sDLI3/wYStZ9i3d0si3IQBT6ReYxuxtzG/v
         O4PcHOlX6SYmQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Jan 2019 10:48:11 +0000
From:   sicevar@redchan.it
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Cc:     freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        misc@openbsd.org
Subject: Author rescinds license from "Geek Feminists" -- Updates: Explicit
 rescission from named persons.
Message-ID: <73f0d9a3b3c1596b0bb8399f72b51d4c@redchan.it>
X-Sender: sicevar@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The author of the GPL licensed text-mode casino game "GPC-Slots 2" has 
rescinded the license from the "Geek feminist" collective.
( https://slashdot.org/submission/9087542/author-recinds-gpl )

[Notice: the revocation of the "Geek Feminists"'s license /just/ 
occurred. 2019. January.]

The original author, after years of silence, notes that the "Geek 
Feminist" changed[1] a bunch of if-then statements which were preceded 
by a loop waiting for string input to a switch statement. The author 
reportedly noted that to use a switch statement in such an instance is 
no more preformant than the if-thens. Switch statements should be used 
where the input to the switch statement is numerical, and of a 
successive nature, for most efficient use of the jump table that is 
generated from said code.

The author reportedly was offended, after quiet observation of the 
group, that the "Geek Feminists" mocked his code, mocked his existence 
as a male, and never did any work on the code afterwards and never 
updated to include new slot machines added to the original code by 
author subsequently.

The author notes that he neither sought nor received any compensation 
for the granted license, that is was a gratuitous license, and that 
there never was any refutation of his default right to rescind given. (A 
right founded in the property law of licenses.)

The copyright owner has reportedly watched quietly as each year the 
"Geek Feminists" published a recount of their heroic efforts regarding 
his code.[2][3] Presumably he has now had enough of it all...

The author notes that the SF Conservancy attempts to construe a 
particular clause in the GPL version 2 license text as a "no revocation 
by grantor clause", however that clause states that if a licensee 
suffers and automatic-revocation by operation of the license, that 
licensees down stream from him do not suffer the same fate. The author 
of "GPC-Slots 2" reportedly notes that said clause does only what it 
claims to do: clarifies that a downstream licensee, through no fault of 
his own, is not penalized by the automatic revocation suffered by a 
licensee he gained a "sub-license" from (for lack of a better term.)

The author reportedly notes that version 3 of the GPL did not exist when 
he published the code, additionally the author notes that even if there 
was a clause not to revoke, he was paid no consideration for such a 
forbearance of a legal right of his and thus said clause is not 
operative against him, the grantor, should it exist at all.

(Editor's note: GPL version 3 contains an explicit 
"no-revocation-by-grantor" clause, in addition to a term-of-years that 
the license is granted for. Both absent in version 2 of the GPL)

The author reportedly has mulled an option to register his copyright and 
then to seek damages from the "Geek Feminists" if they choose to violate 
his copyright post-hence.

(Editors note: Statutory damages for willful copyright infringement can 
amount to $150,000 plus attorney's fees for post registration violations 
of a differing nature to pre-registration violations.)

[1]https://geekfeminism.org/2009/10/19/
[2]https://geekfeminism.org
[3]http://geekfeminism.wikia.com

GPC-Slots 2 is a text console mode casino game available for linux with 
various slot machines, table games, and stock market tokens for the 
player to test his luck. For the unlucky there is a Russian Roulette 
function.

[Notice: the revocation of the "Geek Feminists"'s license /just/ 
occurred. 2019. January.]






Addendum: Statements from the program author:

"It's my right to rescind the permission I extended.
I have done so.

You speak as if me controlling my property is a criminal act.
And to you people, perhaps it is.

If the "geek feminists" wanted a secured interest, they would have to 
pay for one."




"I did rescind the license, yesterday"




> Reportedly
"I did rescind the license, yesterday


Not "reportedly" anymore."




"
> Then you should have used them.
Not necessary, the language used in the press release identifies them 
easily.

> should
As if I somehow can't just rescind using their names either.

License to use/modify/etc the GPC Slots 2 code is hereby terminated for. 
Alex "Skud" Bayley, and Leigh Honeywell.
(Note: this termination is not to be construed as a lifting of the 
previously issued termination regarding the "Geek Feminism collective", 
this termination is an addendum)
"


------------------------------------------------------------

p46 "As long as the project continues to honor the terms of the licenses 
under which it recieved contributions, the licenses continue in effect. 
There is one important caveat: Even a perpetual license can be revoked. 
See the discussion of bare licenses and contracts in Chapter 4"
--Lawrence Rosen

p56 "A third problem with bare licenses is that they may be revocable by 
the licensor. Specifically, /a license not coupled with an interest may 
be revoked./ The term /interest/ in this context usually means the 
payment of some royalty or license fee, but there are other more 
complicated ways to satisfy the interest requirement. For example, a 
licensee can demonstrate that he or she has paid some consideration-a 
contract law term not found in copyright or patent law-in order to avoid 
revocation. Or a licensee may claim that he or she relied on the 
software licensed under an open source license and now is dependent upon 
that software, but this contract law concept, called promissory 
estoppel, is both difficult to prove and unreliable in court tests. (The 
concepts of /consideration/ and /promissory estoppel/ are explained more 
fully in the next section.) Unless the courts allow us to apply these 
contract law principles to a license, we are faced with a bare license 
that is revocable.
--Lawrence Rosen

p278 "Notice that in a copyright dispute over a bare license, the 
plaintiff will almost certainly be the copyright owner. If a licensee 
were foolish enough to sue to enforce the terms and conditions of the 
license, the licensor can simply revoke the bare license, thus ending 
the dispute. Remeber that a bare license in the absence of an interest 
is revocable."
--Lawrence Rosen

Lawrence Rosen - Open Source Licensing - Sofware Freedom and 
Intellectual property Law



p65 "Of all the licenses descibed in this book, only the GPL makes the 
explicity point that it wants nothing of /acceptance/ of 
/consideration/:
...
The GPL authors intend that it not be treated as a contract. I will say 
much more about this license and these two provisions in Chapter 6. For 
now, I simply point out that the GPL licensors are in essentially the 
same situation as other open source licensors who cannot prove offer, 
acceptance, or consideration. There is no contract."
--Lawrence Rosen

