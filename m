Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DA9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC322177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="rqtTv07F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfA2JKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:10:46 -0500
Received: from cock.li ([185.100.85.212]:43996 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2JKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:10:46 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548753041; bh=yZmDgvkHbyEClAbkWnWXPyK/jH1XgNVK2Ky5VL0tzAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rqtTv07FYDPBE7Y/GysSMjq6UUUiJRvonrEdypVsOhBKpg5127N09za+Gykogh6S7
         Aek41o6/k9QVvGobDGkE8q8vZPt6E42At7XyNl6TsDqZDcakGpvZb1mdbSlfof3XBo
         zE7M9Nm2kKij461qqqgz/56WBsKX1FHN01rwxKmq/9opx8vc9+/l/h+mBb39el6h9Z
         IkSDn8k1xr+aQr/ZnY4spzVd4T9JjMM8JpXlNYLD+IvsYIvAfIvNGUX4SO03Nh9K4Y
         Y9ia9t77Oc1Vga/XFRAOrL6ju618g46/7v6k4xpV/Penyt6QHks0BP8pwpcImaixAJ
         Kt4zQJ+gyrivA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Jan 2019 09:10:41 +0000
From:   linuxgpletc@redchan.it
To:     editor@lulz.com, editor@lwn.net, news@theregister.co.uk
Cc:     misc@openbsd.org, freebsd-chat@freebsd.org,
        linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org
Subject: Re: Author of GPC-Slots2 promises to sue "John Doe" who violated GPL
 recission. (update)
In-Reply-To: <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
References: <fe8a4e103943d671ff0ce2c4f09609f9@redchan.it>
 <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
Message-ID: <8c67b91bfc1d70626f4e753e1d11857f@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some updates (2):

http://8ch.net/tech/res/1018729.html#1024398


Anonymous  01/29/19 (Tue) 08:47:02 No.1024601
>> 1024597
> HOW MUCH DID YOU FUCKING PAY ME?
Nothing. Thank God for that.
> ARE WE IN A CONTRACT?
No.
> IT IS A BARE LICENSE.
Is this lawyer speak? I'm not a lawyer, sorry.
> I CAN RESCIND IT AT ANY TIME.
wrong
> THE CODE IS NOT YOUR PROPERTY. IT IS _MY_ PROPERTY.
It is your intellectual property that you have licensed to me under the 
GPLv2+.
> I ALLOWED YOU A LICENSE TO USE IT.
correct
> I HAVE NOW REVOKED THAT LICENSE FROM YOU YOU [...].
no
> Show me a case otherwise.
why???????????
> Gratis licenses, without an attached interest, are revocable.
sorry m8. you are wrong




Anonymous  01/29/19 (Tue) 09:03:54 No.1024602
>> 1024601
> >ARE WE IN A CONTRACT?
> No.
Then explain to me, if we are not in a contract, how you can bind me to 
a "no revocation" clause. Explain it to me, slowly, please.
> >IT IS A BARE LICENSE.
> Is this lawyer speak? I'm not a lawyer, sorry.
Ignorance of the law is no excuse.
A bare license is simply permission.
When you allow someone to enter your house you are giving them a (bare) 
license to enter your house. When you tell them to leave you are 
rescinding that license. You can do so at any time.
Now if they pay you for "I can enter your house for 30 days", then 
because there is consideration, and a contract, you cannot then reneg on 
that term.
> >I CAN RESCIND IT AT ANY TIME.
> wrong
You just agreed that we are not in a contract, how can you now declare 
that I cannot rescind the license. Please explain you reasoning
> sorry m8. you are wrong
Give you legal reasoning.




