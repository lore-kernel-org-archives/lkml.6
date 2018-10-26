Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A8C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1620848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="stbuG/qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C1620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJZTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:10:51 -0400
Received: from cock.li ([185.100.85.212]:58536 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeJZTKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:10:51 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1540550043; bh=+TsGdtBenHz1l0zCn89bH0uQNFDMl4AVpJqc4CPWxKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=stbuG/qp5yWyJ1ngDL7mFNb0jbIRZHFWRWrBPb9hkNKsP1g4vNWpf87pZrVn2kiKC
         BiQ/5ISKcGk5TaqBuMs81XS2eLWguIVEPtE1YIoXFZh6dl1GKlMoyVkohABN1RuHHy
         a5uuxNlUn4yT7SQU+545PLm26XGVHZppTCdRo/u96bhZ1qq0Xbrfh8Nnzsu2Ap1twk
         44BtSkqwPfsreG/ox82Ko3vjWPFxVl0nNFF3/9Q4NplhC9LPIP2PaQwCVjBJN+F7F9
         K683dkOzZHLpfwzcoRw4f+Z4xlKVMN10q81ok6TQvwzX+L/93w3JrgQW7i17jaJtOd
         w3IKW3EQaB3gw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Oct 2018 10:34:02 +0000
From:   visionsofalice@redchan.it
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, rms@gnu.org,
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
In-Reply-To: <20181025081911.GB11343@kroah.com>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com>
Message-ID: <b97b01e9ff4e2e6f2c6878429f6153ac@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes they can, greg.

The GPL v2, is a bare license. It is not a contract. It lacks 
consideration between the licensee and the grantor.

(IE: They didn't pay you, Greg, a thing. YOU, Greg, simply have chosen 
to bestow a benefit upon them where they suffer no detriment and you, in 
fact, gain no bargained-for benefit)

As a bare license, (read: property license), the standard rules 
regarding the alienation of property apply.

Therein: a gratuitous license is revocable at the will of the grantor.

The licensee then may ATTEMPT, as an affirmative defense against your 
as-of-right action to claim promissory estoppel in state court, and 
"keep you to your word". However you made no such promise disclaiming 
your right to rescind the license.

Remeber: There is no utterance disclaiming this right within the GPL 
version 2. Linus, furthermore, has chosen both to exclude the "or any 
later version" codicil, to reject the GPL version 3, AND to publicly 
savage GPL version 3 (he surely has his reasons, perhaps this is one of 
them, left unstated). (GPLv3 which has such promises listed (not to say 
that they would be effective against the grantor, but it is an attempt 
at the least)).




The Software Freedom Conservancy has attempted to mis-construe clause 4 
of the GPL version 2 as a "no-revocation by grantor" clause.

However, reading said clause, using plain construction, leads a 
reasonable person to understand that said clause is speaking 
specifically about the situation where an upstream licensee loses their 
permission under the terms due to a violation of the terms; in that case 
the down-stream licensee does not in-turn also lose their permission 
under the terms.

Additionally, clause 0 makes it crystal clear that "You" is defined as 
the licensee, not the grantor. Another issue the SFConservancy's public 
service announcement chooses to ignore.

Thirdly, the SFConservancy banks on the ignorance of both the public and 
the developers regarding property alienation. A license does not impinge 
the rights of the party granting the license in a quid-pro-quo manner 
vis a vis the licensee's taking. A license merely grants permission, 
extended from the grantor, to the licensee, regarding the article of 
property that is being impinged. A license is NOT a full nor is it a 
permanent alienation of the article(property) in question. The impinged 
property, being under a non bargained-for temporary grant, can be taken 
back into the sole dominion of the owner - at his election to do so.



Now as to the 9th circuit appellate court's decision in Jacobsen v. 
Katzer . While the court waxes eloquently about opensource licenses, 
even mentioning the word "consideration" in it's long dicta, when it 
comes time to make the binding decision the court found that the lower 
(district) court was in _ERROR_ regarding the application of 
contract-law principals to the Artistic License, regarding the case, and 
instructed the lower court to instead construe said license as a 
Copyright License.

The SFConservancy, and Bruce Perens have chosen to:
1) Rely on the dicta. (non-binding - "some things could be contracts - 
opensource is great")
2) Ignore the actual ruling. (Binding - Copyright License - Not 
Contract)
3) Ignore that this case was about the AL, not the GPLv2
4) Ignore the existence of different jurisdictions.
(Why file in the roll-the-dice 9th district if you can file in a 
district that has personal-juristicion over the defendant and is much 
more consistent in it's rulings?)
5) Ignore all established law regard property licensing, contract 
formation, meeting of the minds, what consideration is etc.

Which is not surprising considering the desire of people like Bruce 
Perens is to rob MEN of EVERY benefit of their Labour and every speck of 
happiness in life and to transfer those benefits to WOMEN and those who 
support women.

(This is why people who are like Bruce Perens, the SFConservancy 
menbers, and the CoC supporters, banned men from taking female children 
as brides: in contrivance to the law of YHWH (Devarim chapter 22 - - 
verse 28 (na'ar (LXX: padia)), and continue to uphold that ban 
world-wide, and seek to destroy ALL cultures that do no bend to their 
will.... who are not idolators of Women)




Look, you may love your users, you may love the people who edit your 
code in their home or office; but the fact of the matter is...

They have done nothing for you, they have promised nothing to you. They 
CANNOT hold YOU.

You have the right to rescind at any time, and remove your work from any 
future versions of Linux. And you might consider doing so if YOU are 
done harm.

Don't let the insatiable, never-satisfied, public fool you into thinking 
otherwise.

And, yes, I am a lawyer.
And, no, unlike the SFConservancy, I did not have to call upon outside 
counsel to analyze the fact pattern. (And even then all they could come 
up with was statements using weasel words "may" etc: not even wanting to 
commit to their clearly-disingenuous publication)


(Note: If you would like to read a nice discussion on the topic, here is 
one http://illinoisjltp.com/journal/wp-content/uploads/2013/10/kumar.pdf 
)

On 2018-10-25 08:19, Greg Kroah-Hartman wrote:
> On Thu, Oct 25, 2018 at 07:56:26AM +0000, visionsofalice@redchan.it 
> wrote:
>> The linux devs can rescind their license grant.
> 
> No they can not, please do not keep spreading false information.
> 
> greg k-h
