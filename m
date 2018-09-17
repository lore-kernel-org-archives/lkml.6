Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92562ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384AB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384AB208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hexapodia.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeIQFw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:52:56 -0400
Received: from straum.hexapodia.org ([216.252.162.53]:57818 "EHLO
        straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeIQFw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:52:56 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 01:52:56 EDT
Received: by straum.hexapodia.org (Postfix, from userid 22448)
        id E19504CAD; Sun, 16 Sep 2018 17:20:21 -0700 (PDT)
Date:   Sun, 16 Sep 2018 17:20:21 -0700
From:   Andy Isaacson <adi@hexapodia.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [...] an apology, and a maintainership note
Message-ID: <20180917002021.GA8515@hexapodia.org>
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
X-Old-GPG-Fingerprint: 1914 0645 FD53 C18E EEEF C402 4A69 B1F3 68D2 A63F
X-GPG-Fingerprint: A5FC 6141 F76D B6B1 C81F  0FB7 AFA0 A45F ED3D 116D
X-GPG-Key-URL: http://web.hexapodia.org/~adi/gpg.txt
X-Domestic-Surveillance: money launder bomb tax evasion
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 12:22:43PM -0700, Linus Torvalds wrote:
>This is where the "look yourself in the mirror" moment comes in.
>
>So here we are, me finally on the one hand realizing that it wasn't
>actually funny or a good sign that I was hoping to just skip the
>yearly kernel summit entirely, and on the other hand realizing that I
>really had been ignoring some fairly deep-seated feelings in the
>community.
>
>It's one thing when you can ignore these issues.  Usually it’s just
>something I didn't want to deal with.
>
>This is my reality.  I am not an emotionally empathetic kind of person
>and that probably doesn't come as a big surprise to anybody.  Least of
>all me.  The fact that I then misread people and don't realize (for
>years) how badly I've judged a situation and contributed to an
>unprofessional environment is not good.
>
>This week people in our community confronted me about my lifetime of
>not understanding emotions.  My flippant attacks in emails have been
>both unprofessional and uncalled for.  Especially at times when I made
>it personal.  In my quest for a better patch, this made sense to me.
>I know now this was not OK and I am truly sorry.
>
>The above is basically a long-winded way to get to the somewhat
>painful personal admission that hey, I need to change some of my
>behavior, and I want to apologize to the people that my personal
>behavior hurt and possibly drove away from kernel development
>entirely.
>
>I am going to take time off and get some assistance on how to
>understand people’s emotions and respond appropriately.

Thank you for writing this, Linus.  I have personal experience how 
difficult it is to be honest, especially publicly, about difficult 
topics and admitting one's own mistakes.  You deserve huge kudos for the 
journey you've already taken to write the above, and I look forward to 
the improvements in the lkml culture that are certain to come as a 
result.

The culture of lkml that came about in large part due to your behavior 
that you alluded to above was a culture that I found amenable, and 
absorbed, and replicated in other communities and relationships for many 
years.  It took a lot of soul searching and growth to realize for myself 
that it wasn't healthy, fair, equitable, or amenable to folks from other 
backgrounds, and to change my own behavior.  A big part of that 
realization and process was that I stepped away from the kernel 
community completely.  I'm still working on getting healthier around 
this stuff, and that will be a lifelong process I'm sure.

If I can help in any way (for example, I have some suggested reading, I 
can point to therapists and counselors who helped me, and I'm happy to 
have in depth one on one or small group conversations about these 
topics), please feel free to reach out.  (That goes for others on lkml 
as well, but I will be fairly guarded about engaging with folks who I 
don't know or who I don't have confidence are engaging in good faith).

-andy
