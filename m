Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE020878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="glG5CZrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AE020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firemail.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeJBL7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 07:59:30 -0400
Received: from cock.li ([185.100.85.212]:45664 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeJBL7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 07:59:30 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1538457485; bh=1IZ22LOhaC7GC3BO/Yt1gcHHNp7OcGlC0iyMINsIw8U=;
        h=Date:From:To:Cc:Subject:From;
        b=glG5CZrAOKq+VZVvnMBvQiKMiAE2SDMcs3nzASB2VEkiNlf4BmwpvXmchY61KJxU4
         cBzcvyjjkmm2gZHD2xf+qwOXBSMWoqj0Yuxz/dbJDFmmL3EG+RP0gXtB+szg23V5DD
         PXdQzd2oUHkF1Rx+zQhAHtc1wJLhvQJYLkRaQ51q+Zv3DgoVwqvqTXi3sJwDq2F2jI
         YZFJozR+0vEIgTsmZHvRu1qkcw8AkmjIjmdY1d4eFzU5k0j73sQWDN1NizYxM48v9A
         syhHM0pShpedEw3R9G79HLNzoPdoiM+jErNSXiXPPK9l5XkFWztPmUQibpMHmP+xe1
         a6lPYf6ZBfEWA==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 02 Oct 2018 05:18:05 +0000
From:   clarityabovecompulsion@firemail.cc
To:     linux-kernel@vger.kernel.org
Cc:     scott.ferguson.debian.user@gmail.com,
        debian-devel@lists.debian.org, debian-ctte@lists.debian.org,
        debian-vote@lists.debian.org, debian-project@lists.debian.org,
        pascal@plouf.fr.eu.org, yaro@marupa.net,
        cbannister@slingshot.co.nz, andreimpopescu@gmail.com,
        ghaverla@materialisations.com, debian-mirrors@lists.debian.org,
        debian-security@lists.debian.org
Subject: SFConservancy misleads in "update" explaining GPLv2.
Message-ID: <0443df8ab0d3d8f21ebf4c7d728a9fec@firemail.cc>
X-Sender: clarityabovecompulsion@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section 4 is not operative against the grantor of the license, and makes 
no claim to be so.

It is speaking only of licensees and what might be described as 
sub-licensees.

Section 0 confirms that "You" refers to licensees.

Section 4 simply states that if a licensee loses his license, that does 
not cause the sub-licensee to lose his license in-turn.


---------------------------------
---------------------------------


The software freedom conservancy has tendered its response:
http://sfconservancy.org/news/2018/sep/26/GPLv2-irrevocability/
http://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4


""
"The GPLv2 have several provisions that, when taken together, can be 
construed as an irrevocable license from each contributor. "
""

It cites:


           " That license granted to downstream is irrevocable, again 
provided that the downstream user complies with the license terms: 
"[P]arties who have received copies, or rights, from you under this 
License will not have their licenses terminated so long as such parties 
remain in full compliance" (GPLv2§4). "

However this is disingenuous

The full text of section 4 is as follows:

""
   4. You may not copy, modify, sublicense, or distribute the Program
except as expressly provided under this License.  Any attempt
otherwise to copy, modify, sublicense or distribute the Program is
void, and will automatically terminate your rights under this License.
However, parties who have received copies, or rights, from you under
this License will not have their licenses terminated so long as such
parties remain in full compliance.
""



The "You" in section 4 is speaking of the licensee regarding 
sub-licensees, it is not speaking to the licensor/copyright-holder.

IE: if the licensee loses his license, through operation of the 
automatic-revocation provisions, the sub-licensees do not also lose 
their licenses.

IE: The language is disclaiming a chain topography for license 
distribution, and instead substituting a hub-and-spoke topography (all 
licenses originating from the copyright holder, not the 
previous-in-line)

GPLv3 added a no-rescission clause for a reason: the reason being to 
attempt to create an estoppel defense for the licensees against the 
licensor. You will notice that Eben Moglen never speaks on these issues. 
(He preumably is aware of the weaknesses vis a vis the US copyright 
regime.)

Section 6 further clarifies the hub-and-spoke model:
""
    6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.
""

The memorandum posted then goes on to a discussion of estoppel, 
detrimental reliance, etc; noting that users may have relied on the 
software and their licenses may be estopped from being revoked from said 
users since doing so might cause them unanticipated loss. This is 
speaking of already published, existent, versions of the program used by 
end users.

The memorandum seems to ignore what happens to "upstream" once said 
project  receives a revocation notice. Thought it may be possible that 
users of a published piece of software may have defenses to license 
revocation, the same is not true regarding the rescinded property 
vis-a-vis future prospective versions of the software nor of future 
prospective licensees of said software.

That is: once the grant to use the code in question is rescinded, future 
versions of the software may not use that code. Current users of the 
software may be-able to raise an estoppel / detrimental reliance defense 
regarding the current published software, however the programmers 
working on the next version of said software cannot continue to use the 
property in future versions of the software (such would be a copyright 
violation once the gratuitous license is rescinded by the grantor).

Additionally, prospective-licensees, once the grant was rescinded and 
such was published, would have no same-such estoppel defense (not being 
user-licensees at the time of revocation).

(Ignoring this eventuality in the published memorandum, is, of-course, 
by design.)
(Now, to note: the free-software movement is focused on the freedom of 
the user, not the progenitors of the software, so one could certainly 
say that ignoring some developer-focused analysis is consistent with 
their prerogative...)


---------------------------------
---------------------------------

In reference to the SFConservancy's argument which disingenuously 
suggests that a clause operative only against licensees is operative 
against the grantor:




Gnu GPL version 2, section 0:
"Each licensee is addressed as "you". "

The "you" is not referring to the licensor (copyright owner). It is 
referring to the licensees and then future 
sub-licensees/additional-licensees receiving the work from said previous 
licensee.

It is independently clear from the context of the clauses if you read 
them in full.

...and then section 0 comes around and makes it _explicit_ that "you" 
refers to the licensee. (if you had any doubt)

Additionally, you should know that the copyright owner is not bound by 
the gratuitous license he proffers to potential licensees regarding his 
property. The licensees are bound to his terms: he is the owner. They 
take at his benefaction.

<blockquote>
                     GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

   0. This License applies to any program or other work which contains
a notice placed by the copyright holder saying it may be distributed
under the terms of this General Public License.  The "Program", below,
refers to any such program or work, and a "work based on the Program"
means either the Program or any derivative work under copyright law:
that is to say, a work containing the Program or a portion of it,
either verbatim or with modifications and/or translated into another
language.  (Hereinafter, translation is included without limitation in
the term "modification".)  Each licensee is addressed as "you".
</blockquote>

---------------------------------
---------------------------------

Licenses and revocability, in a paragraph or less.

As has been stated in easily accessible terms elsewhere:
"Most courts hold that simple, non-exclusive licenses with unspecified 
durations that are silent on revocability are revocable at will. This 
means that the licensor may terminate the license at any time, with or 
without cause." +

Version 2 of the GPL specifies no duration, nor does it declare that it 
is non-revocable by the grantor.

(Also note: A perpetual license may violate the rule against 
perpetuities in various jurisdictions where it is applied not only to 
real property but additionally to personal property (and the like), 
which is why the GPL-3's term of duration is set as the duration of 
copyright on the program (and not "forever"))

+[https://www.sidley.com/en/insights/newsupdates/2013/02/the-terms-revocable-and-irrevocable-in-license-agreements-tips-and-pitfalls]




---------------------------------
---------------------------------

The paramount reason Eben Moglen has the FSF accepting contributions 
only with copyright assignment is because the grantor of a license that 
is a gratuity (no consideration (read: usually money) given) can remove 
the permission regarding the use of his property at his pleasure.

(Regardless of the story that was promulgated for the public ("only to 
have standing to sue under copyright, since the GPL is a bare license 
and does not give rise to contract damages") - which was and is a 
half-truth only (Yes: you do need to own the rights to a work to sue 
under copyright, Yes the GPL is a bare license, No: that's not the whole 
reason why one would want the author to no-longer hold the copyright))

---------------------------------
---------------------------------

Stallman is wrong.

Gratuitous licenses are revocable.

The grantor was payed no consideration for his code, and he tendered no 
utterance which would induce a reasonable licensee* to rely on the 
existence of a continuance of permission for any length of time (Version 
2 of the GPL bears neither a no-rescission clause, nor does it even bear 
a clause giving a period to it's effect) (Version 3 of the GPL has both 
of these added (no-rescission by grantor, period of license is the term 
of copyright on the program), Linux is under version 2, the license the 
grantors granted regarding their property is version 2. Linus even 
publicly rejected GPLv3 with much grandstanding)

*(Note: Linux Licensees seem to not even bother reading the one page 
grant. This is their level of reasonableness)


