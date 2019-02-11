Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9AC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182F21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="dgvsZFf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBKXK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:10:26 -0500
Received: from cock.li ([185.100.85.212]:33306 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfBKXKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:10:22 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1549926618; bh=cyUyNAeBaCYHSmS5Er3Eqs/EPYZ9Sv9SHOGwB/6j7e8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dgvsZFf3RjGhg7LY2r9NfksLmNAbQqT37dBTukdm6C5CZkf8/lQComL30JGbH+9sM
         uxxSfJ8260THL4nL+985a2vfZtsy/FZfUAeCSp7/czKBExq3NIYfG3t7uOFs+0deWr
         C40jmOKkfjDo/QczHQ7kriSXSFCrErkync6IWqDkeuJ/vWVHCUUT6p4mthOlmCgcT0
         CZ9BVvegojwbWD8A11HZmO8/AYanVV+x25YQ2GQMWnDqfQhgOITP8BHU3oDgodsJXT
         sSp8x4yh58A24Ja7gI7soeORiTpcQDK9nWX3VrL5z9O1jzWtaD8DO9ZgrKLJXMXyAk
         rKSwXUlY8TFwA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Feb 2019 23:10:18 +0000
From:   mikeeusa@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     freebsd-chat@freebsd.org, misc@openbsd.org, editor@lulz.com,
        news@theregister.co.uk, esr@thyrsus.com, torvalds@osdl.org,
        rms@gnu.org
Subject: Re: DMCA takedown notice
In-Reply-To: <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5812163@github.com>
References: <5c51daed7c023_2fcf3fe7576d45c417207b@github-lowworker-89d05ac.cp1-iad.github.net.mail>
 <5c51ee838b18f_74e53fd6ff0d45c41780e2@github-lowworker-5909e27.cp1-iad.github.net.mail>
 <5c522f5b6cb8a_60733fc5256d45b412831@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c534f0336ca6_19ae3fcbf5cd45b4186161@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <5c535110f0f30_3aa13fafe46d45c4222962@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <061a28afa26cf5ad7d11f8074353a9cf@redchan.it>
 <5c5489478eb20_56f33fd9e9ad45b43146ec@github-lowworker-4f62d42.cp1-iad.github.net.mail>
 <5c55ecdcb298_3a283fd6dfcd45c4309246@github-lowworker-63e61ec.cp1-iad.github.net.mail>
 <5c563190ae6cc_18c33fcb464d45bc1523b0@github-lowworker-39ccb07.cp1-iad.github.net.mail>
 <5c586b095281b_4c6d3ffba28d45b8120450@github-lowworker-e51511d.cp1-iad.github.net.mail>
 <5c58a56f8ded7_36e93f9cb4ad45b8932e7@github-lowworker-e55e3e3.cp1-iad.github.net.mail>
 <312c3d91f6c4a71c34b96728a2efb385@redchan.it>
 <5c5b1609a1561_1ac23fbe2d6d45b88762d0@github-lowworker-dcc078e.cp1-iad.github.net.mail>
 <discussions/31b6c69e24b211e98081e6b282f84ff2/comments/5812163@github.com>
Message-ID: <2ba97dc3492f9c2eac75f118782c04f3@redchan.it>
X-Sender: mikeeusa@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You take it down or I sue you, simple as that.

I have revoked the license from a number of people, including the John 
Doe who has chosen to violate my copyright thence-forth.

I have signed using my 2 decades long held pen-name.

The U.S. Code defines an electronic signature for the purpose of US law 
as "an electronic sound, symbol, or process, attached to or logically 
associated with a contract or other record and executed or adopted by a 
person with the intent to sign the record."

My signing with my pen-name suffices for this purpose. What is important 
is my intent to sign the record, which I have evinced.

I have also posted the information on my long-held project page, so that 
you may know that I am me:
https://sourceforge.net/projects/gpcslots2/files/notes/

https://sourceforge.net/projects/gpcslots2/files/notes/tkdnreq_github.txt/download
https://sourceforge.net/projects/gpcslots2/files/notes/takedownreq_vs_johndoe-of-8ch.txt/download

(I have also uploaded this response to said /notes/ directory)

In addition to many other places.
Your contention that I must do anything greater at this point is legally 
inefficacious.

I _DEMAND_ that you take the offending material down immediately.

--MikeeUSA--
(Author of GPC-Slots 2)
(electronic signature)

On 2019-02-06 21:20, GitHub Staff wrote:
> Hi MikeeUSA,
> 
> Thank you for your notices, the most recent of which is included below
> for reference.
> 
> This DMCA notice is incomplete. It lacks "A physical or electronic
> signature of a person authorized to act on behalf of the owner of an
> exclusive right that is allegedly infringed" and "Information
> reasonably sufficient to permit the service provider to contact the
> complaining party."
> 
> Unfortunately, an electronic signature must be a legal name, not a
> monicker or username, and we cannot accept disposable or temporary
> email addresses as reliable contact information for a DMCA notice.
> 
> Once you've revised your notice to include the required details,
> please send back the entire revised notice, and not only the corrected
> sections. Once we've received a complete and actionable notice, we'll
> process it expeditiously.
> 
> Thanks,
> 
> GitHub Staff
> -------------------------
> 
> I have a good faith belief that use of the copyrighted materials
> described above on the infringing web pages is not authorized by the
> copyright owner, or its agent, or the law. I have taken fair use into
> consideration.
> 
> I swear, under penalty of perjury, that the information in this
> notification is accurate and that I am the copyright owner, or am
> authorized to act on behalf of the owner, of an exclusive right that
> is allegedly infringed.
> :
> 
> As you may know, In the United States; a license, absent an attached
> interest, is revocable.
> 
> A "John Doe" had his non-exclusive license regarding the game
> "GPC-Slots2" terminated by the copyright owner (me: MikeeUSA).
> The copyright owner may do this as-of-right, unless there is an
> attached interest (ie: unless the licensee paid good consideration for
> the license).
> 
> The "John Doe" then proceeded to belligerently upload a copy of
> "GPC-Slots2" to your host, GitHub.
> This violated Author's (my) copyright, since "John Doe"'s gratuitous
> bare license had been terminated by the copyright holder (me).
> 
> The "John Doe" then proceeded to modify my work, which again violated
> my copyright since I had previously revoked his license.
> The license flows from me, the copyright owner, not any text. It is
> permission to use, redistribute, modify, etc. Instructions on how to
> use my property.
> When such permission is not supported by any consideration, it may be
> rescinded by the owner, at his will.
> (/Regardless/ of the "terms". "Terms" are only enforceable against the
> grantor if the licensee has paid consideration for them, essentially,
> under US law.)
> 
> I have done so.
> 
> I reiterated to the "John Doe" that his license had been terminated.
> 
> "John Doe" then informed me that I "can't do that". I tried to explain
> to him US law.
> "John Doe" declared that he did not care and would keep the violating
> work up, in defiance of me.
> (IE: he would "pirate" it)
> 
> He then cited works from a discredited paralegal while I cited
> published works by lawyers studied in their field.
> 
> (Note: I make no claim to PERL, the color ansi library, any supporting
> libraries, or the -2 split screen function. My copyright covers the
> game code of GPC-Slots2. I (MikeeUSA) am the original author of the
> work and never signed over copyright to the work.)
> (Note: "obeying the terms" (obeying the copyright holders instructions
> regarding the use of his property) is not consideration: it is a
> preexisting legal duty: outside of the "terms" there is no right for
> the licensee to copy, modify, make derivative works, distribute,
> distribute derivative works)
> 
> [Additionally "John Doe" registered a fraudulent account under my
> long-held non-de-gurre, adding a Code of Conduct ("CoC"), something I
> would never do (being opposed to "CoC" for gratis projects on
> principal)]
> 
> I now have no choice but to issue a DMCA take-down request, to you,
> GitHub.
> 
> Regrettably;
> --MikeeUSA--
> (electronic signature)
> Jan 29, 2019
> 
> (Addendum: "John Doe" then uploaded the modified work to gitlab.com
> and bitbucket.org
> 
> Contact information:
> email: mikeeusa@redchan.it
> 
> infringing content: github.com/MikeeUSA/GPC-Slots-2
> gitlab.com/MikeeUSA/GPC-Slots-2
> bitbucket.org/MikeeUSA/gpc-slots-2
> The material is not authorized by me, the copyright owner of the
> GPC-Slots2 game code, as I explicitly rescinded the license from the
> "John Doe", and he acknowledged that I had informed him of such and
> communicated that he would defy my will regarding my property and
> copyright.
> Everything stated within this above communication is accurate to the
> best of my knowledge and ability.
> 
> Some notices to you, github (and now gitlab and bitbucket):
> 1) Yes I viewed your page at:
> https://help.github.com/articles/guide-to-submitting-a-dmca-takedown-notice/
> 2) Yes this is "opensource" code.
> 3) No that does not matter:
> The GPL(any version), being a bare license, is revocable
> ("retroactively").
> Just as any bare license, not supported by an interest, in the US.
> The "John Doe" is not in privity of contract with me and has paid me
> no consideration.
> He cannot "bind" me (the grantor) to the terms.
> It is his duty to abide by my instructions regarding my property.
> I did not transfer my property away, the license is just that: a
> license (temporary permission, that can be rescinded unless a "term"
> was indeed "purchased")
> It is also his duty to cease all use, modification, distribution of my
> property at my demand.
> I have made such a demand.
> 4) Yes I will consider taking legal action against you if you do not
> heed my request.
> Cite the paralegal from groklaw, ZDnet, the FSF, and the SFConservancy
> all you want.
> They are wrong on the law and have been wrong for 10 years.
