Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1985518-1525538296-2-13695635880837178435
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
    1525538295; b=evZJH86FNkGyNbzEUJPfU+aMEabZX/W8AdJ33wJTNutT3+f76i
    Ug3fosGwz0QaQN7gXp1PjbydD2q8zf0RrF5Py+a39o16bTbXXwPZ/n+bbjQHdCNx
    jBIX/AA1+ES/BiCZJyBQEfDA/8Qz39600qYu9RzymELPMQLXSpuloHzwLbJFBku8
    Quu33EcT3v+Gwa0r5vJT547Yk48mnPhcKI+nuePlkb/PC75byaQG56ZwrJR33ExK
    uHr5oOompEnJvssCpbW51rQsxAnManH3o3hoUO+tVDefP48T1Nkps/x9m6lSLPbC
    1yxpgmFO7DwHO0m9HD3+OZsF358ytXEGA/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525538295; bh=bnKyy
    WrbiGzLdRyto+ZgwSsiApv45dtkBRnc9Q4+zow=; b=aQJ3niTWLIOQinFsFRNl8
    hYMchFgJ3yEroptskciXtobxUZi5t1uw5ie4/WXNxj1EppUbGYUyvRTHa79qq+9C
    sm3YiWf2erPYR1RkA6URSx0GeBRFGB9qn1n32f1R6NlIb3DD9kGQbbbyYsCKWT7R
    ZoIrNBJ5IFLeVVROC55i0z0BoSFehvFQYs69kZdr27RHwjGp/t3eRp/hCun+6BRh
    nsSVH3yk07WRq3gEfxAgVkhpY9LROHtIOVUkGGYJfypUMVcrrEHUvkSbeChqT4X4
    VwlOoQcA/rMAQbNTsNzmMMom+vAvzcFpc7PRFBgnloCgJbgpYAjspo8HfpbC882f
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=hvVqOj4c x-bits=1024
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=hvVqOj4c x-bits=1024
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
X-CM-Envelope: MS4wfPwlbaPDlwhlA0+4KfTRxXDWeujXxON6uNJvJUrOdCNjg/g18i69CfhKQTz3yTWQsSkyaefadxgQn0LrEbf8kI+0mVigzzlxV1pfaXPz7La6m0Xi4175
    RnLQjqEtQXitUp2zdTK9uOP289UdU+HY8UhXYaKnPICGv6ghTO1SLVpoQIMYxUsdL6NjBofjvzgcYgDWcrG6m4szARrdfyKuBHE3xoq8l14TVRkspsrhIxik
    0VgeczpV7nVuXwW3fPnWJQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=azJkvMfNwdyqcwNGkpQA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Date: Sat, 5 May 2018 09:37:56 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180505163756.GC7746@kroah.com>
References: <8669.1525427874@warthog.procyon.org.uk> <87fu377gbu.fsf@intel.com>
	<20180504130932.GI29205@thunk.org>
	<20180504174055.GF4649@kroah.com>
	<20180504211317.GK29205@thunk.org>
	<1525469881.4114.5.camel@HansenPartnership.com>
	<20180504215111.GX18390@sasha-vm>
	<20180504233542.GM29205@thunk.org> <20180505042356.GA24575@1wt.eu>
	<878t8y8zk8.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878t8y8zk8.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Remote-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_HI autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Willy Tarreau <w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sat, May 05, 2018 at 12:02:47AM -0500, Eric W. Biederman wrote:
> So the way I use headers today is:
> Cc: stable@vger.kernel.org
> Fixes: sha1hash "commit subject"

And that makes my life _so_ much easier.  The Fixes: tag is great
(thanks James!), I have scripts that I use to track if a fix was applied
to a stable tree to know if it needs to go into that branch as well.
Without that, the "# 4.9" marking just doesn't work, as it doesn't tell
me if that commit got backported to 4.4.y as well.  I used to do that
type of detection by hand, but automating it is so much better and I
miss less patches that way.

Anyway, just my two cents, let's try to keep this simple for both
maintainers, and stable developers, if at all possible.  I think what we
have now works well, but if people think the documentation should be
cleaned up, great, send patches :)

thanks,

greg k-h
_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
