Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525371656-3-5490771132881659809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='uk', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525371656; b=HKzLibp9L+3wtXou+DK1fipZSvXwXFsIr/WzVJpzDCqA0WXiBz
    2MoRA4EREDE5j9/FOCbE9Y6si65+fXUws6khGA+OPJA8J/kg/QySojioNoevxSn8
    1rdpyFB/ifO48SGX6s68tNBSvEbsLvhDMmDblJAyElSe9UQJhTktxmTkGw9E3aL3
    S8fvuUChxWx4yW1Xgt+G3pubGcxDFKwNFf+UKG+iTNIuN2S2/wxrtJ2D9jwKCnxW
    L5HJzudzgxn9IaU3WAFuH7ra/z3A5wvfr71ziyKLJ+utjSfK2SvkmnunwelTrSFZ
    gJXfs0Dy4XRz2uXXHt2WYMhy2HvVXwYn12GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525371656; bh=F2YK9
    71dS1anKBuynUQ/Kc8kyRu56lTwaK4hwK+aOkI=; b=BlSQRD/sTwZ2Y/GjqrtqI
    f25WLndlRfUUcpZqf31xV1DKyhT1+YOjDC/J+hQCqRy0x6oDlhHc8q09WMVRh25f
    oSWUEaJuMLQSNF5G2r/PGyZJ9le9AbQG6vZmkVQyh2p+s/ybfGsBEBumi6v8YjG0
    nJVIaZVupqALq71ybYqpsYzTrdHYjZT6ia6leKPDbPKq0iDO3ezdlOcXWN29MR5E
    BRvGG8U1gb+H9qqgRuew6a7eO1S4SQeZGLGeWCrFkqbKi/ofYlw5hgbCAKQPzkKS
    g20i2Yv/GDDUPZkBDV9X6VB5bFDBhj4E153n1Rqi9dqP9qljgOD/wy6Wkgj0XaD6
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=zeniv.linux.org.uk
    header.mx.error=NOERROR header.result=warn
    header_org.domain=linux.org.uk header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=zeniv.linux.org.uk
      header.mx.error=NOERROR header.result=warn
      header_org.domain=linux.org.uk header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMygoS7DLn+EohAOEx8ZyhfESRoXOp+k32kPQ7T6rwPiF+k0QB5Uiu+x1SrgVcfSxrB5x0RlYimbpcDpQUr30sFtPYrpca9kjEa1iMZ80d6MAVvAICd9
    dVY5dZ/RipGPZmnCFnf3ZCyDr9uAgQST0VjYt7xQt3wZcRiRH7YaH84vcLtPC01hb1ylYarJNKv3kpIZYXpT//6CXFMjhgsfWfkOD+6zOOWaabegvp+TWyXc
    vCa5P4QfDBmWAXQbRUrLrQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=r0fUSEbNQvjbH44sa2wA:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 3 May 2018 19:20:39 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Message-ID: <20180503182039.GC30522@ZenIV.linux.org.uk>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
	<20180503144612.GJ18390@sasha-vm>
	<20180503165446.GB30522@ZenIV.linux.org.uk>
	<20180503173422.GR18390@sasha-vm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180503173422.GR18390@sasha-vm>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Remote-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED
	autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"w@1wt.eu" <w@1wt.eu>
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

On Thu, May 03, 2018 at 05:34:24PM +0000, Sasha Levin wrote:

> >Moreover, what the hell do you suggest in situation when
> >	* foofs_barf() is b0rken in quite a few ways.  There's an
> >easily triggerable memory corruptor that can be fixed locally as well
> >as something else that needs a change of e.g. ->mkdir() calling
> >conventions to take care of.  The change is mechanical and fairly
> >simple, but it's already -rc4.
> 
> I'm not advocating to forcefully block people from submitting patches
> after -rc4 (that was Ted's suggesting).

I am, though - change of a method signature when we have several dozens
of instances does *not* belong in -rc5; if nothing else, it guarantees
a nightmare pile of conflicts with individual filesystem trees.

> I'm just saying that as a maintainer, you should use your brain and
> figure out how critical the bug is, how good is the fix and how well was
> it tested, and decide if you want to merge it in or not.
> 
> If it fixed the bug and didn't introduce a regression, great! If it
> messed something else, you'd have some input on how to address it better
> in the future.
> 
> I'm trying to come up with a tool/system to help maintainers with
> this task because right now it's not working too well. I'm not trying to
> introduce arbitrary rules to make your life miserable.

And I am asking you what kind of rules do you want/expect/would prefer
for Fixes: pseudo-header.  *I* do not give a flying fuck for its
contents; I can put it in, if there is a good reason, though.  And
the obvious consumers of that thing are -stable maintainers.  Including
yourself.  Which is why I am asking you what should go in there in
situation described above.  And no, that's not a rhetorical question;
I really want to know.

Let me describe it again:
	* a bunch of holes is found in a function; all of them go back
several years
	* a clean fix for the whole pile is a composition of
1) local fix of trivially triggered memory corruptor
2) tree-wide mechanical change of method signature + matching modifications
of callers of that method (say, all five of them).
3) further changes in the function in question and its caller (which happens
to be an instance of the method modified by (2).
	* dependencies between parts: (1) is standalone, (3) has a hard
dependency on (2), (1) can be reordered past (2)+(modified 3), but modifications
needed in (1) and (3) are not trivial.
	* the crap fixed by (1) is much more severe than that fixed by (3)
(and (2) is an equivalent transformation which does not affect behaviour of
anything).
	* too late in the cycle for tree-wide patches like (2).

As far as I'm concerned (and if it makes -stable folks' lives unpleasant,
too fucking bad) the merge order is: (1) as soon as it's sufficiently
reviewed and tested, (2) and (3) - next merge window.  The only question
is what kind of metadata should go into commit messages to minimize the
PITA for -stable folks, *given* *that* *merge* *timing*.
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
