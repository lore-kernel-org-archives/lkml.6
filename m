Return-Path: <lukas.bulwahn@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-591578-1517523205-2-11074962136351118423
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.82.52', Host='mail-wm0-f52.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: cc='ISO-8859-15', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: lukas.bulwahn@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517523204; b=IW6M/+num0mS4xzLJ3+9zKkP6uuP6cM9oTcLRninxKDhiBV
    uwPenMfkyVrUJ6lhcgHY7vFiyKlhyWqM+Eyp/pbgGV46aQs2iGIgC9guFo8cf6N4
    k3WISPoNdLtOfgnwhLsorzc/8U/gRzsOfEtM0Qh/yHSg7lqb71cqIRSZJHtXHR5c
    vTpqM9JQyI/cHi8fNGL95gz3sjgaZP4fBxHr4j3Pb4Tyi8Dn92RSuD0K02G5MzHP
    D1DdCGVSAQ7i4ASzXGPLDmYbbgnBOmiHrVv1fJ4DCBZQj4BqtY2yawrL6MngFpPP
    gjNJeH1p4BLJ39+ujvAHy4huSAHqSTFAYIl5hHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type; s=arctest; t=
    1517523204; bh=bg5vgmfZNhY7LOS3KuWjqr6BYqo0ormH5ZD2rgw8xwA=; b=Q
    fT4HDUPIpP7FDq71BQw4qD2MqYKc9uBZeDJJ49snZyxjrWRacFwfOy+rpyuEa57H
    TL3v6UiZOaMej0gyP65xy+TNpnnrxnjyza8pm07kIMCknLQZz4eltroob1xFe/Iw
    WPXqaln/8VQ/tqXsYGwy8HQj9vf5UJmhUm93l6AOeD198qBKEICckePkvnxRuUO8
    zDX13QEOhRhBXJDKUtXW8iZyvDvMAnWHAkmq8QF3BeHVBkpxkiB+amVuUzsTXA+k
    cm/n4s4E1DisaxEKi0OB020WEtNuxsCZPwtb3IbAYPfZD7uoY4gY+URDr4pw/LxL
    8CfGLygbvAE2vP5dl7HhQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pTVNAUfy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.82.52 (mail-wm0-f52.google.com);
    spf=pass smtp.mailfrom=lukas.bulwahn@gmail.com smtp.helo=mail-wm0-f52.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Top1TNiz;
    x-ptr=pass x-ptr-helo=mail-wm0-f52.google.com x-ptr-lookup=mail-wm0-f52.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pTVNAUfy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.82.52 (mail-wm0-f52.google.com);
    spf=pass smtp.mailfrom=lukas.bulwahn@gmail.com smtp.helo=mail-wm0-f52.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Top1TNiz;
    x-ptr=pass x-ptr-helo=mail-wm0-f52.google.com x-ptr-lookup=mail-wm0-f52.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x226T5fOSRVygbgL8qXyj09NKw6gvkBxJmOajTLjsOt1q3shaPXKxBm9jKqpRdozDdh0X2lt35g==
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@hsp>
Date: Thu, 1 Feb 2018 23:13:09 +0100 (CET)
To: Greg KH <greg@kroah.com>
cc: Ozan Alpay <ozyalpy@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
    =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
    sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
    David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
    llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
    dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
    lukas.bulwahn@gmail.com
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
In-Reply-To: <20180201180240.GA28042@kroah.com>
Message-ID: <alpine.DEB.2.20.1802012045570.29994@hsp>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca> <20180201180240.GA28042@kroah.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-376312225-1517523200=:29994"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-376312225-1517523200=:29994
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


Hi Greg,

On Thu, 1 Feb 2018, Greg KH wrote:

> On Thu, Feb 01, 2018 at 06:33:30PM +0100, Ozan Alpay wrote:
> > Dear Rodrigo Vivi, Ville Syrjälä,
> > 
> > My name is Ozan Alpay, and I am a student mentored by Lukas Bulwahn. We 
> > intend to use static analysis tools on the kernel source to identify, 
> > analyze and report issues. As a very first step, we are looking into 
> > clang compiler warnings and will then move to more sophisticated tools. 
> >
> > [...]
> >
> > Linux 4.15 is shipped with this clang warning, but we don't see the 
> > crucial need to provide a backport commit to the stable branch for 4.15. 
> > We just wanted to inform you about our analysis of this clang warning. 
> > Ultimately the final call if you would like to address this clang warning 
> > in 4.15 is yours.
> 
> Note, I have not taken "clang warning fixes" for stable kernel updates
> in the past, and I doubt I will in the future, unless the tree "builds
> clean" with clang.  If it eventually gets there, then yes, I will do
> that.
> 
> Note, if you are going to email this out to everyone who fixes a warning
> message, you might want to reconsider it.  That's going to be a lot of
> work, and for people who have already fixed an issue, it's kind of
> pointless to just remind them of work they have done in the past, right?
> 
> What is the goal of these types of emails?
> 

We are interested in providing useful information on potential bugs or bug 
patterns that we get from static analysis tools, after we pre-assess them 
and manually select them to send to the review process of the patch 
submission.

For me, the clang warnings were an easy starting point for a student to 
set up and look at, compared to much more sophisticated tools, such as 
coccinelle, sparse or new tools for the kernel development, such as CMBC 
or facebook's Infer.

Once we really understand which tools are useful and which information can 
be quickly pre-assessed and sent out in a useful way without just creating 
more noise in the discussion, I would have contacted the 0-day 
infrastructure team or the kernelci.org team to continue the discussion 
how to include our first setup into a proper semi-automated service.

Using the clang warnings, I wanted to explore how this would even 
potentially work.

Considering clang, of course, currently, we cannot compile the whole 
kernel with all possible kernel configurations with clang, but I believe 
Nick Desaulniers, Matthias Kaehlcke and others are already working on 
that and are getting close to this goal. Hence, assuming they will be 
successful soon, I wanted to explore the next step of using static 
analysis tools around the clang/LLVM compiler.

Actually, v4.15 builds almost "cleanly" with clang: For defconfig, there 
are only two clang compiler warnings and the one that we looked into 
deeper here is already resolved in linux-next, so chances are actually 
high that we might get to this "builds clean" soon-ish, at least for 
defconfig.

Concerning clang warnings and how to progress towards that goal of 
building cleanly, my strategy is to identify when new clang compiler
warnings are introduced and just point these warnings out as code smells 
during the review discussion before they are merged into the 
first maintainer tree. If we manually inspect these clang warnings
to make sure that they are genuine code smells of some "imprecise 
implementation" before we send them to the mailing list, I would hope that 
they are of some value for the developer in the submission process and 
he/she could address the warning in a patch v2 while he/she is reacting to 
the other review comments from the human reviewers.

At best, I always considered them as useful information during the review 
process, but I certainly DO NOT want to start patching the kernel due to 
clang warnings. The chances/risk that we just break more due to naively 
fixing warnings without proper understanding is much higher than the  
benefit of actually improving the situation. If I recall correctly, I 
think this is also one of the lessons learned from motivating newcomers 
to address warnings in previous kernel newbies activities.

Greg, do you think it is worthwhile to invest some effort to move 
towards the goal "kernel builds cleanly with clang"?
Would you agree that providing information during the patch review is a 
good way to move forward to this goal if we find a suitable manner to 
provide this feedback quickly and cleanly at this very early stage of 
development?

If not, we will immediately stop to move in this direction and this is the 
first and last email that you have seen of this kind, and we will have to 
come up with better/other ideas around work on the Linux kernel.

If so, we will continue in the direction sketched above, and I think I 
just have to point out and apologize for the two obvious things that we 
did wrong in this specific case here:

  - We noticed that there were further changes in linux-next, but we
    thought that our investigation on v4.15 was valuable nevertheless
    for the developers that had touched the source code that we looked at,
    although, there is nothing to be done if commits from linux-next are
    merged into Linus' tree soon. Taking your response, we have clearly 
    been WRONG here, overestimating our contribution versus the noise 
    ratio that we contribute to.
  
  - We looked at a clang warning, for which we could only provide the 
    information on this clang warning at this very late stage, i.e., when
    the commit under investigation has already been merged and the kernel 
    was released. So pointing out shortcoming of that kind seems to have 
    no value, as you, Greg, would not backport commits to stable anyway.

This has been both errors on my side as a mentor. After my student
has started this week and has worked hard for a week learning a lot about 
Linux kernel development and all the tools around it, I did not want to 
discourage him and say that the goal set at the beginning of the week to 
identify and report a code smell on one commit on the mailing list has 
not been achieved as for the reasons above. Instead, we decided to send it 
out and were interested in the general reception of our work of this first 
week.

I apologize for that and hope we can leave the specific reported issue now 
just rest in peace.

This experiment shows that I still need to improve my understanding how 
to contribute properly to the kernel development. At least to me, the  
policy on clang warnings was not clear; and I have learned this now in 
this more indirect way.

We only sent out this one email to see if clang warnings are of interest 
at all, and we are glad that you came back to us so quickly with feedback.

Greg, if you can continue to be a sparing partner and point out when 
we are moving in the wrong direction, we will try our best to understand
how we can contribute to turn results from bug finders and static analysis 
tools with the manual pre-assessment we can do into valuable contributions 
on the mailing list and the linux kernel development.

We certainly do not intend to spam the mailing list with reports of 
findings nobody cares about.

Best regards,

Lukas
--8323329-376312225-1517523200=:29994--
