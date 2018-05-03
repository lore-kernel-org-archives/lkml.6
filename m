Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-2438926-1525349298-2-16264018739507686314
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
    1525349297; b=R50eKJkKmR+dl7LAyxsgpneOVgbjNJ2ojwfOOOE/aMPjwLW2Yy
    JgB6/yfjoCzdXYbeE1GBvFJ7itzwRzd7aMsNzUbk8NGx53h7CYDAlC5p2qvrKuHe
    5lyDAY4y8HEtgFnZrEHd5jdBf4nXuj2Z0bofWJbCXFjxx8qDuA6ii33OjbrQxWRs
    LWf42pkzlFdGRrdHDQfB+yPdkD6kf1YONGS7tsXLaeeeg93rlFVJooL69v1LczYK
    BK8F4ZLdC1ln/SaaxZoCQ/qz3/ab2RTRZW3fyFFF1RK5y/uku2adhDS2/Ln7rnwx
    g3y5srLxeFdg5qSQg3ZclzzXiDZLmi4NeqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525349297; bh=Wxjsm
    rEHGyhvOAVkiLq2hPXtCgjOoSPAnMtgsfYcrw0=; b=Ls3LTI/Tm6OYkmnF+AiPU
    SMHooQmHaiEBTkk2+Q7XQTiHCTDeqGkJbl54lcur24w05228DCkQrju94Ma1vnqP
    87gfjjpt8Ik5u/l5nmDHlFRqrj1mMASIh6iHFR9lcctueaWula1ZhKfEuOtqKrAV
    5rIhmEZvkdfcYEZ1cW3sh25CpuOxlzYT2JstluBux8Okl/rcs5x1Fm+LMCtbTKRl
    5sSwzFFVAk2rIA3dkY5rGr18I32yUX7gzV054CMvSoqJGoQPJ5zatu2qG2HtLoR6
    90aa8n8Xr1/hr23DEQ1FNN8fiMEf5BEwD+xJxcd5OCeVQ7OrDnOSZvq5imruvv+F
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=rLpapNCc x-bits=1024
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
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=rLpapNCc x-bits=1024
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNsumk3YK7mgN6+ui6CsU1oiekWadbQ9JHrtACQNSt6eHBIqT30xXl4CqhKGfdkPZmbT3wz6fVVlm665Pa7yd0WJ07fLajmcRiiK90eFslkd/ariDj7T
    xFt5irAXntNLWO9vl4CCXMu02WZ8hiAW/h4mqwUhtlyiG58MN0zNpD69U4JbU8L6F4qvEW6+2b0r5CJiWJpWzDlizEs/XJuUfZ8z4YwIbh7nRHD59xNQa8sN
    frmX5YElp5K1gWLtpWQNgQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=VgHFUb8h8JXuP9ARdAsA:9
    a=MeEwzBC_uXgZrlGi:21 a=xllMWbdS4qTuX15J:21 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Thu, 3 May 2018 05:03:29 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180503120329.GA7025@kroah.com>
References: <20180501163818.GD1468@sasha-vm> <20180501194450.GD10479@thunk.org>
	<20180501200019.GA7397@sasha-vm> <20180501205448.GE10479@thunk.org>
	<20180501211551.GI2714@sirena.org.uk>
	<CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_HI autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
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

On Wed, May 02, 2018 at 08:52:29PM -0700, Guenter Roeck wrote:
> On 05/02/2018 08:10 PM, Theodore Y. Ts'o wrote:
> > On Thu, May 03, 2018 at 11:05:50AM +0900, Mark Brown wrote:
> > > On Wed, May 02, 2018 at 07:46:34PM +0000, Sasha Levin wrote:
> > > 
> > > > As you said, the regression should be fixed "asap", not "immediately".
> > > > It should go through some sort of review and testing the maintainers are
> > > > happy with, but unfourtenately it doesn't happen now.
> > > 
> > > Doesn't happen some of the time.  It's not like this is a universal
> > > problem.
> > > 
> > > Especially for driver specific things there's at times no realistic
> > > prospect of getting useful independent review of fixes, the hardware
> > > isn't always widely available and if the fix isn't a pure software thing
> > > at some point you just have to trust the judgement of the vendor.
> > 
> > And sometimes the Demon Murphy will cause a regression fix for user A,
> > to cause breakage for slightly different hardware belonging to user B.  :-(
> > 
> 
> Believe me, I get my share of those. 7dac4a1726a9 ("ext4: add validity checks
> for bitmap block numbers") and its fix 22be37acce25 (" ext4: fix bitmap
> position validation") are pretty good examples. Yet, at the same time I had
> to deal with three additional CVEs in the ext4 code. Even though the initial
> fix for one of the four was buggy, I am glad that I got the other three through
> stable releases.
> 
> As for -next, me and others stopped reporting bugs in it, because when we do
> we tend to get flamed for the "noise". Is anyone aware (or cares) that mips
> and nds32 images don't build ? Soaking clothes in an empty bathtub won't make
> them wet, and bugs in code which no one builds, much less tests or uses, won't
> be found.
> 
> I can only repeat - what we need is more sophisticated testing, not a more
> restrictive process.

I agree, and people are working on this.  But we can always use more!

thanks,

greg k-h
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
