Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-440478-1525455677-2-8943395099634404173
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
    1525455676; b=F1lzMNJ8Z17ozlr4UABMIHCdM5gkcpxfNDi5PoqnjDjL6YelPC
    04+gDPiFvOrVIWYDCrlaDOIgiKjW7pQevagjam2JHVqWbHX5N4lxXiPVNJGY9+SZ
    C6ZuKsuMYr8QnWdc6shxEaSqUwnofBkkGPRA9WLU7lgLxyf9F1c4cosDaxAxoUNf
    sy9T9urBtCmuc2B9FTj2tkEOr3g2mdcXUif4bdULlApOcRuRIMWWmbXE246ZCc9k
    zUIyY2ourv3NY2deCToXg2eLUMkGrgwD5ppcuDSTPHmFe3H87CudXDa6SxmWQWx8
    pX0oKl14sOG50JD9+enTzwxayTuHEILh4uEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525455676; bh=InsDD
    lPx84svJdF943PLre0i6g/XKnTg3nYtoxjO/Ws=; b=VrUVzrft1xm4iEK1QtMIO
    slJE0nKFF3QFN/04uqlpW5RxTZJAZ2jyhbdGMyMiNUetTDCs6zijBR65fTljm69x
    KhdT/Be3rB+vyG9aSwtN71b2TRlLzzxOcn9sTBMwGzHSQaIcdPkCMXH/PoPRy4Pn
    lcX9D129lLp75tFpBF1lHQ46uNsFF8eJIUXuREa24G+1EBPcXCwoxLDLaghEpV9G
    qyY3ags23THbtOxJkU5/kxFo1eWJPirzQzXNGxxDZd3SqHgOydNtXqx800wjl3Dt
    U+FJeDfPgTnTnWGIQf5rY5eQj1EiKYLUT9ql4NhyMXnSSKCWU/rG4e4+nY7KQOB1
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=Bz4IQmQx x-bits=1024
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=Bz4IQmQx x-bits=1024
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
X-CM-Envelope: MS4wfD6mG/1zxHsph4QTJFnxU6fwKcQSlbwXWMtGvwHDpHlgRDvvF0kM3PVo3qulPxTU8cyqnNR+P/uC1o3xrwiwBe9KDSyEr/KIyz+tUb8Iod7tAL182xup
    Bdp/5VCsNuxRc/+XCIpchoFLK2lmaY4+jnp355nquo27WZI5n6BYXGYPpP/1pbleUOzHZdidXJu4Czi1K7CuBHnr46h723/2UBAlrCMzdYSd7BtQxfzT2cTm
    jclHMFGZB7mCL9DG7fUYQQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=wm28nWrcEwwkknKuGmYA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Fri, 4 May 2018 10:40:55 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Jani Nikula <jani.nikula@intel.com>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Message-ID: <20180504174055.GF4649@kroah.com>
References: <20180502195138.GC18390@sasha-vm>
	<CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	<20180503000620.GA29205@thunk.org>
	<20180503144612.GJ18390@sasha-vm>
	<20180503165446.GB30522@ZenIV.linux.org.uk>
	<20180503173422.GR18390@sasha-vm>
	<20180503182039.GC30522@ZenIV.linux.org.uk>
	<8669.1525427874@warthog.procyon.org.uk> <87fu377gbu.fsf@intel.com>
	<20180504130932.GI29205@thunk.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180504130932.GI29205@thunk.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_HI autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
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

On Fri, May 04, 2018 at 09:09:32AM -0400, Theodore Y. Ts'o wrote:
> On Fri, May 04, 2018 at 03:31:17PM +0300, Jani Nikula wrote:
> > On Fri, 04 May 2018, David Howells <dhowells@redhat.com> wrote:
> > > Sasha Levin via Ksummit-discuss wrote:
> > >
> > >> 	Cc: stable@vger.kernel.org # commit-id-of-(2)
> >
> > This has been documented since
> > 
> > commit 8e9b9362266dd16255473c080d846b13e27247bf
> > Author: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> > Date:   Sun Dec 6 12:24:31 2009 +0100
> > 
> >     Doc/stable rules: add new cherry-pick logic
> > 
> > in v2.6.33 so seems like there should have been enough time to fix the
> > tools.
> 
> The problem is that it's not being *used* that way.  In fact, that
> documentation is arguably out of date.  When it does get used, it's
> used to indicate which kernels the stable patch applies.  You have to
> go pretty far back before you find that suggested usage.  Run:
> 
> git log --grep stable@kernel.org | grep -i cc: | grep stable | grep \#
> 
> and see for yourself.  The first couple of hits:
> 
>     Cc: stable@kernel.org # 3.11
>     Cc: stable@kernel.org # 4.8+
>     Cc: stable@kernel.org # 4.8+
>     Cc: stable@kernel.org # 4.13+
>     Cc: stable@kernel.org # 4.8+
>     Cc: stable@kernel.org   # 4.13 - together with 890da9cf0983
>     Cc: stable@kernel.org # 4.13
>     Cc: stable@kernel.org # 4.13
>     Cc: stable@kernel.org   # v4.8+
>     Cc: stable@kernel.org # v4.10+
>     Cc: stable@kernel.org # v4.10+
>     Cc: stable@kernel.org # v4.10+
>     Cc: stable@kernel.org  # reverted commits were marked for stable
>     Cc: stable@kernel.org   # for the backport of the original commit
>     Cc: stable@kernel.org # v4.8+
> 
> At this point, my suggestion would be to delete the text added by the
> above-mentioned commit, and add a new syntax.  We're much more willing
> to support multiple headers, so something like this:
> 
> Stable-prereq: DEADBEEF1234: subsystem: bork bork bork....
> 
> With multiple Stable-preeq: lines allowed, where the order is
> significant, might be one way to do things.

Ugh, what?  I don't understand what you are proposing here, what we have
today is just fine, what is broken with it?

thanks,

greg k-h
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
