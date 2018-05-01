Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-3702424-1525208102-2-13687467733170972324
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525208101; b=eW76rjUdXoQ+t42qJgIE3lmfPiIgUVowjw3WvIdRmizQEirX9s
    l8cDgo256E7C2dqmfdGMAVbOUMXArhOsv32EWgvVTuHsTYMFdwVd1dtt2SHuG0qM
    a01N7YdCAyarGY/BD3iX68WgtMmc0A2I1JdcKdtVD3dq3o+rSQimdcNoSN3/UCkN
    z3mw2QOT43oVmYLe5+El14Nqkgdo6OGrVCLrH8Un6vvD/tJZ4sSuXnZTBxaZOLb4
    Z19EqnnjGxvtElVPrAvx4jANxygEFst3D/zlkzXCTvqst3/1/H5IbrAws5vubaGL
    X55QbFUw4WcaGg1qi2k8HW5xMpUbQNAxG8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525208101; bh=EOxU2
    cjvmAU1T3Tj5lxx6zUnyxY/vCBmMvDVGah1iwQ=; b=B5XgbCxCMthbmoIqvijBN
    eaux5N9VE8fRWYvpOEQfiKqrU/zpbeAC7X0l5zVBR36c9EHomV8CR6ElQyk+ux2f
    yY2LZLj9xr9kDQrdi1KCTzRtNuDIu5MzB4wLLnhXT0zCN8S+fTcb8jmcQIacg4Aw
    Pa9DecJFAfXV2PqtxZQtg4oEJJyoBzZ5ibKU4B4QTrQujoMKD9pkzGPLz3vZhLN7
    lBlwiu/mFQNYnFdOCzeyM18rSAGBkfBIH0A5GjF8VUIbPDEfsMLYvIw+/PSvIr+m
    vGoGa9ltFz7TGgakBPai6eCvNDWXhyHsdFctwiBZglkURFgPyGbZrpQ7Hclexz3K
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=NGeDTNlr x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=mit.edu header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=NGeDTNlr x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=mit.edu header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBvS+91eUTyx65ipqsOTGMMVQOwqjSuA80c8Le7C1UhCU5gL5etUgnYvRpXsBZ1DOcG1wLS500ixAT2OAytHgWrqtJl+NkWcA0JvtVMd4Ib++CmvnkxK
    Z08U2CiomlhebBPlvtItJTd+LDlR/pJhNdpFLbrGx0CKks4f+p/92Mcxb9Ys1Xop3fdUP0Ukt50Kylc+F0iBb3SHKan0yHVid+FN+UNG66KiS/l364BUmuJx
    D1Z03rY8LlsdvUZq2/327w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=07d9gI8wAAAA:8
    a=ag1SF4gXAAAA:8 a=J08iiUO3UqFeIJMw_-UA:9 a=CjuIK1q_8ugA:10
    a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Tue, 1 May 2018 16:54:48 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Message-ID: <20180501205448.GE10479@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180501200019.GA7397@sasha-vm>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-Remote-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 08:00:21PM +0000, Sasha Levin wrote:
> 
> Yes, linux-next users want it fixed *now* and I completely agree it
> should be done that way, but the fix should not be immediately pushed to
> Linus as well.

I should have linux-head/linux-rc said testers, sorry.  The fact that
we have very few live users testing linux-next is a separate problem,
which I accidentally conflated.  But if a user who is testing -rc2
finds a problem, it is highly desirable to send a fix for -rc3,
instead of making that user wait to -rc4 or -rc5.  And *that* is more
important than AUTOSEL.

> I've just finished reading an interesting article on LWN about the
> PostgreSQL fsync issues (https://lwn.net/Articles/752952/). If you
> look at Willy's commit, he wrote the final version of it about 5 days
> ago, Jeff merged it in 3 days ago, and Linus merged it in the tree
> today. Did it spend any time getting -next testing? nope.

I agree that having the errseq patch go straight into Linus's tree is
certainly unfortunate.  The justification was this was a regression
fix, which I don't think it qualifies, since errseq_t went in some 9+
months ago.

It might be a good thing to quantify whether the patches you are
talking about are new features, bug fixes, or fixing a bug that was
introduced during the merge window or subsequently (e.g., a
regression).

> What's worse is that that commit is tagged for stable, which means
> that (given Greg's schedule) it may find it's way to -stable users
> even before some -next users/bots had a chance to test it out.

Well, it used to be that things tagged for stable most-merge window
are *supposed* to marinate for at least a week or before they would
get pulled into a stable release.  Part of the whole problem is that
people are wanting to be a lot more aggressive (both in time and
volume) in shovelling things into stable.

> This is less about AUTOSEL, and more about asking maintainers to
> improve the testing commits get before they are sent to Linus.
> Linus would rant about commits during merge window that didn't go
> through -next, but for -rc commits this rule is somehow forgiven,
> which is what I'm trying to change.

I do think it's about AUTOSEL, because when I'm dealing with a
regression, I want to get it fixed fast.  Because the alternative is
the merge-window commit getting reverted.  AUTOSEL seems wants perfect
patches that it can cherry pick once, as opposed to a case where if the
user confirms that it fixes the regression, I want to send it to Linus
quickly.  I do *not* want it to marinate in linux-next for 1-2 weeks.
I would much rather that *stable* hold off on picking up the patch for
1-2 weeks, but get it fixed in Linux HEAD sooner.  If that means that
the regression fix needs a further clean up, so be it.

Post -rc3 or -rc4, in my opinion bug fixes should wait until the next
merge window before they get merged at all.  (And certainly features
bugs should be Right Out.)  And sure, bug fixes should certainly get
more testing.  So I guess my main objection is your making a blanket
statement about all fixes, instead of breaking out regression fixes
versus bug fixes.  Since in my opinion they are very different animals...

       	   	   	       	       	    - Ted

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
