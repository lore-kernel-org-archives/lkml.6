Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F83C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B492D214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B492D214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeIZQgp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:36:45 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:52311 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:36:45 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 2ACF93B89A9;
        Wed, 26 Sep 2018 12:24:28 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Christoph Conrads <contact@christoph-conrads.name>,
        Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Date:   Wed, 26 Sep 2018 12:24:27 +0200
Message-ID: <9226417.xpp7RkEYFI@merkaba>
In-Reply-To: <20180925132820.GA22767@amd>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net> <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name> <20180925132820.GA22767@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek - 25.09.18, 15:28:
> > > > > Your above argument that the Code of Conduct is problematic
> > > > > because of who wrote it seems to contradict your statement
> > > > > that we shall judge by code (or text) alone.
> > > > 
> > > > I think there are important differences between code to be run
> > > > by CPUs and a Code to be run by humans.  And when the author
> > > > goes on a victory lap on Twitter and declares the Code to be "a
> > > > political document", is it any surprise I'm worried?
> > > 
> > > Would you have link on that?
> > 
> > The CoC is a political document:
> > https://web.archive.org/web/20180924234027/https://twitter.com/coral
> > ineada/status/1041465346656530432
> > 
> > Possible victory lap 1:
> > https://web.archive.org/web/20180921104730/https://twitter.com/coral
> > ineada/status/1041441155874009093
> > 
> > Possible victory lap 2:
> > https://web.archive.org/web/20180920211406/https://twitter.com/coral
> > ineada/status/1042249983590838272
> Thanks!
> 
> I thought you was referring to this... http://archive.is/6nhps
> ... which is somehow even more disturbing to me.

That would be one of the main issues I see with that change: It did not 
went through the usual review process.

I did not know the Contributor Covenant was driven by people with such a 
strong agenda.

I still think that this newly adopted code of conduct document won´t 
kill Linux. As I have strong trust the community would redact or change 
that document if need be. I did not agree with the urgency behind the 
initial discussion especially as it was mostly initiated by who I´d 
consider by-standers, but I see benefit on carefully reviewing a code of 
conduct and I see that the hastily adopted Contributor Covenant may not 
be a good or the best choice.

I still adhere to "take the teaching, not the teacher". I do not care 
what kind of person the author of CoC is. So I´d review whether the 
actual document contents are appropriate for the kernel community.

I suggest reviewing the Code of Conducts of KDE¹ and Debian². Both 
projects seem to run pretty well with a Code of Conduct in place.

While what happens regarding a document is always the choice of people,
I think one of the most important aspects would be to make sure that the 
means of enforcement the code of conduct provides aligns with the 
highest good of the kernel community. Too strongly worded it opens up 
opportunities to abuse the code of conduct. Too weakly worded, it can 
render the code of conduct ineffective.

I think some of the enforcement wording in Contributor Covenant is not 
helpful. I don´t think that

"Project maintainers who do not follow or enforce the Code of Conduct in 
good faith may face temporary or permanent repercussions as determined 
by other members of the project’s leadership."

adds something useful to the code of conduct.

One major question for me is: Is the code of conduct based on fear of 
being hurt or harassed or does it aim at a friendly and supportive 
community? I do not think that a fear based code of conduct is useful. 
There is already quite some harmful stuff going on in the world for the 
apparent sake of security (but in the real interest of exercising power 
over people).


I think that is why I prefer wording of both Code of Conduct of KDE¹ and 
Debian² over the Contributor Covenant. I´d probably take more from those 
and less from Contributor Covenant.

Anyway, I see myself only as a by-stander… so of course those who are in 
charge are of course free to take anything from this mail they think is 
useful and discard the rest.


[1] https://www.kde.org/code-of-conduct/

Unlike noted here in the thread before, it does have a provision for 
leaders to enforce it:

"Leaders of any group, such as moderators of mailing lists, IRC 
channels, forums, etc., will exercise the right to suspend access to any 
person who persistently breaks our shared Code of Conduct."

But is has an important distinction in there: It is a *right*, not an 
*obligation*.

[2] https://www.debian.org/code_of_conduct

It also has a provision to enforce it:

"Serious or persistent offenders will be temporarily or permanently 
banned from communicating through Debian's systems. Complaints should be 
made (in private) to the administrators of the Debian communication 
forum in question. To find contact information for these administrators, 
please see the page on Debian's organizational structure."

Here is it written indirectly as an obligation.

Thanks,
-- 
Martin


