Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525373747-2-916808122173848895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3,
  SPF_HELO_PASS -0.001, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525373747; b=NG7anB6A/dISP1hfMublDCGTerTVLOHIPOa3irYzoeXBH3F7eD
    jSxhmvwhjfTPLwqv+akH52BO3ATPBYCPHy5r58cRIo2utorJpZAWGH1f6H/zbfMg
    F8gjj/11LHjDsFXEpzdOduczi8MrjsrlgXY/WTdsIhDLbKXNZ05POsXBXHCGNHPH
    39nwPkz5T1GBGsODZ9HRVTFoKFtC47UYbeWITm+VMSuQrOBSWN8Xhg7K8aILcp+a
    1fjRuneQJxLVVz8b6dbYixjK8VdFjAxfWUQspexrdoGbW4a9MRrI5Z8S04Ej4m+e
    2sGqrT/IguiQg7HrnWcfTFPvILUM8TjpB+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525373747; bh=Od388
    M2dJwJUuGWvX+L4uSv6+Z693r9//D69TyLk3mI=; b=YH/HtJ6vJ0Cfxr49FR0TL
    8pcVLBBnOseqtwJb4DmKdbjF7RcgHkhAWGNc19eZ9CIJkz3hR4hYzfINVjMz9vS1
    sMYYUabjC5hRHyhaaUsFlrnNuKXWI7yErHqtvXuaWiYu5aivRuZhcLkZ+ewSNYj2
    BYFajVdnYRKWiWHToBOYfS3ggQ//s9IDtVzCRJMHNm1lpdQSuiwHn6brQA1O4v+y
    OP7m8aYZGqirJEIuzSjqTld0Z+1BRLT9dvyqqsXjTbUp8pWYbdG6CC8g0jdJnDrV
    fSWSZdGciUX53paoOK4llOQP7ugCtuPGq5NeCEzBGv++pgwgICiNrIbfoSFR3Bat
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=o5SixRAW x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=o5SixRAW x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJpplS9FaPKXUYehc1D56Gj27L4vwEX/1w17GoesXp8AmYqkJaR7zgRjc3RoaS7kNlJ6OiqJgeEYzrCboAgh5uBk0qTQQAO+HSbbaQU0/3UtqgjGECm/
    BnNvdaduQkvDeWLh09D+FtegTpgD1zByXCTfzVi8ZVsM7+Wvs1Mt2P0+tMtJXDG7YtqrcyoHzE7L9+zmiGFG2QdE3twd0JukxiAwHfXP9TaqrNNctw75jfkR
    Hn8VxVxWxL14qXGejLZLeA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=AA6hShJ2oi5sRv-mHm0A:9
    a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 3 May 2018 11:55:29 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20180503185529.GB15247@kroah.com>
References: <20180501163818.GD1468@sasha-vm>
	<CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
	<20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
	<20180503144612.GJ18390@sasha-vm>
	<20180503165446.GB30522@ZenIV.linux.org.uk>
	<20180503173422.GR18390@sasha-vm>
	<20180503182039.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180503182039.GC30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_HI autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
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

On Thu, May 03, 2018 at 07:20:39PM +0100, Al Viro wrote:
> On Thu, May 03, 2018 at 05:34:24PM +0000, Sasha Levin wrote:
> 
> > >Moreover, what the hell do you suggest in situation when
> > >	* foofs_barf() is b0rken in quite a few ways.  There's an
> > >easily triggerable memory corruptor that can be fixed locally as well
> > >as something else that needs a change of e.g. ->mkdir() calling
> > >conventions to take care of.  The change is mechanical and fairly
> > >simple, but it's already -rc4.
> > 
> > I'm not advocating to forcefully block people from submitting patches
> > after -rc4 (that was Ted's suggesting).
> 
> I am, though - change of a method signature when we have several dozens
> of instances does *not* belong in -rc5; if nothing else, it guarantees
> a nightmare pile of conflicts with individual filesystem trees.
> 
> > I'm just saying that as a maintainer, you should use your brain and
> > figure out how critical the bug is, how good is the fix and how well was
> > it tested, and decide if you want to merge it in or not.
> > 
> > If it fixed the bug and didn't introduce a regression, great! If it
> > messed something else, you'd have some input on how to address it better
> > in the future.
> > 
> > I'm trying to come up with a tool/system to help maintainers with
> > this task because right now it's not working too well. I'm not trying to
> > introduce arbitrary rules to make your life miserable.
> 
> And I am asking you what kind of rules do you want/expect/would prefer
> for Fixes: pseudo-header.  *I* do not give a flying fuck for its
> contents; I can put it in, if there is a good reason, though.  And
> the obvious consumers of that thing are -stable maintainers.  Including
> yourself.  Which is why I am asking you what should go in there in
> situation described above.  And no, that's not a rhetorical question;
> I really want to know.
> 
> Let me describe it again:
> 	* a bunch of holes is found in a function; all of them go back
> several years
> 	* a clean fix for the whole pile is a composition of
> 1) local fix of trivially triggered memory corruptor
> 2) tree-wide mechanical change of method signature + matching modifications
> of callers of that method (say, all five of them).
> 3) further changes in the function in question and its caller (which happens
> to be an instance of the method modified by (2).
> 	* dependencies between parts: (1) is standalone, (3) has a hard
> dependency on (2), (1) can be reordered past (2)+(modified 3), but modifications
> needed in (1) and (3) are not trivial.
> 	* the crap fixed by (1) is much more severe than that fixed by (3)
> (and (2) is an equivalent transformation which does not affect behaviour of
> anything).
> 	* too late in the cycle for tree-wide patches like (2).
> 
> As far as I'm concerned (and if it makes -stable folks' lives unpleasant,
> too fucking bad)

Don't care about me for stuff like this.  Fix it correctly and I'll
worry about any dependancy issues later :)

greg k-h
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
