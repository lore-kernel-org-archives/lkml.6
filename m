Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B521A7E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="qUszLI55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392684AbeLVRkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:40:06 -0500
Received: from cock.li ([185.100.85.212]:33232 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391557AbeLVRkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:40:04 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1545487419; bh=I4vP7l9jNMwf7OWrG6nTibWapArcPs6Z39Rqz+4Kii0=;
        h=Date:From:To:Subject:From;
        b=qUszLI55X/r1cTaf6MwU9xVSfdorgrJZ4at6HqhbzBoZ+9sdLdqHRW8DbH6B4/44q
         lKcwZHizp/nl44e7bfUAl5YvgdOeGPKClzUCLzpTOFAHZGjPRUTmE5ouCA8lfyY3h3
         h+xhT0+9LdYla+OrfsahXwj8Bi1GD8tMncId0FDofpyw2bwYaTTuczO2MkWAHIKjfV
         X/WuFrR0upg7cg2ktUNSJqM2n0WL8C1Wk3+k0xQInMfj1gam+8U+Fq+1H8JCmjHCPa
         eLEBUDoGkPApAvDQ1mkc/iJ5Mx1RGlcITzCRFj5iCdG3CxlfNLpo9JV8sYLxP8Bjis
         iTAaGOpRlNUNw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 22 Dec 2018 14:03:39 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: Yes: The linux devs can rescind their license grant.
Message-ID: <37735c3628424c581805d17a49f3babc@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your new explanation was refuted 5 hours after it was published.

---

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



On 2018-10-29 22:31, Bradley M. Kuhn wrote:
> On Thu, Oct 25, 2018 at 07:56:26AM +0000, visionsofalice@redchan.it 
> wrote:
>> The linux devs can rescind their license grant.
> Greg KH responded on Thu, 25 Oct 2018 09:19:11 +0100:
>>> No they can not, please do not keep spreading false information.
> 
> I was explicitly cc'ed on this thread by visionsofalice.  I've read the
> whole thread, and the only useful thing I can contribute here is to 
> agree
> with Greg and additionally provide some backup research on the point:
> https://sfconservancy.org/news/2018/sep/26/GPLv2-irrevocability/
> 
> Software Freedom Conservancy engaged our legal counsel to write a new
> section for the Copyleft Guide that further explains the irrevocability 
> of
> GPLv2.  We published this when others raised these specious claims back 
> in
> September.  Direct link to new section:
> https://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4
> 
> 
> HTH,
