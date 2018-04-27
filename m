Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-389341-1524843731-2-17399675879332045428
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524843731; b=f/Z+kWeAodJVzrQ88HF7rwoDyAei3fFsmMt4snP4vPat6mQrHN
    8rQ3v24P2RfOAXKA3h0eNsVuF8H1v+HC5Y8VYoDONECFfxA5da/7jcTAIixNXOWN
    mwMCJJjnrcZu45+DjBPhTRSf9jF/i6YrHGyOA7ZZocEZuRmn4LiSelB/MD9DwAe8
    d0oth+4E9D5r3mhudKorCpapKtVSP9ws5sfoB0rAs0zhvqwVYC7DSLgUhnI22oxx
    ScaSqnymighr2b1O0ldsELFj6yVBv59TItYZGSarS9cHSm+rxjrjiW4LqHrrTojT
    wLbVRjyOvOuu7oV8OKeSOM1/LTUbiv5izXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524843731;
    bh=+jwDYqNoKf9mwPAAtJ/g98OxGv7mnYu0QFyIP8e2Ozs=; b=YKntrhFV8LNi
    jHaejEaqLaCOpuFfTfHvVJNYH17mQ3SqRiXGl6ezjSfSphWDtgednj8LPeVe8UZ1
    F/4W2s6CxfcsD/cppaSNRPpAcHRFDzHciE3OzKZxrdlojW6/x/0wd15Gtfvab5YJ
    0UYAakEz09dxpOquLBXRkfxyL/QmIz65jvEW5tmwVYLeNRu9yKJVkpxM4cnVuqlK
    U2rgrDeUbBii9z4VoSIhFhwFOFHFf3BBRF5Y1mLIwSNL0TBA61wYHIV9nGEk01pU
    E7FiPmushQI99Y4VcIvhPIKBFfZ4Z3XEShsCkzUJ12VR2tddjzWIieIvF+6sc4mC
    xZHbAxS9Hw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOWXnJhZMFH4z/TCrcJP5rGVP+wpwm2dFqC8hAvUpPp2z6WhzldjUqrf6QEAapMn0EsBMCTwePGxKRzvxs57quH993mLwsJb+hT1Z1aRojjnE+I02Kqd
    RpwhQqK07KtPKnuiejV2203p169gCNqqLd00LkYUa54DqdWDibyAUiTAbwvhGwl1yNEcI9GdkioQBcNGpxfA8LLtLsbH5j1n7Cy+wuJFGY6w0AumpqB8Di26
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=iyTxTt5tka-Z_1w64HUA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758521AbeD0PmI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757457AbeD0PmH (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 11:42:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19007218C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 28 Apr 2018 00:42:02 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 4/7] kprobes: Replace %p with other pointer types
Message-Id: <20180428004202.4297e781304b5eda53100f67@kernel.org>
In-Reply-To: <20180427065636.ells635z7cw4b4oz@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481130062.22588.10747314456340608852.stgit@devbox>
        <20180427065636.ells635z7cw4b4oz@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 08:56:36 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > @@ -712,7 +712,7 @@ static void reuse_unused_kprobe(struct kprobe *ap)
> >  	op = container_of(ap, struct optimized_kprobe, kp);
> >  	if (unlikely(list_empty(&op->list)))
> >  		printk(KERN_WARNING "Warning: found a stray unused "
> > -			"aggrprobe@%p\n", ap->addr);
> > +			"aggrprobe@%pS\n", ap->addr);
> 
> Is this a kernel bug? If yes then please convert this to a WARN_ON_ONCE() that 
> doesn't print any kernel addresses.

OK, I will do.

> 
> >  	/* Enable the probe again */
> >  	ap->flags &= ~KPROBE_FLAG_DISABLED;
> >  	/* Optimize it again (remove from op->list) */
> > @@ -985,7 +985,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
> >  	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
> >  				   (unsigned long)p->addr, 0, 0);
> >  	if (ret) {
> > -		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
> > +		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
> > +			 p->addr, ret);
> >  		return ret;
> 
> Can this happen during normal use? If yes then just remove the warning message.

Yes, it can, for example probing on live-patched function.

> 
> >  	}
> >  
> > @@ -1025,7 +1026,8 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
> >  
> >  	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
> >  			   (unsigned long)p->addr, 1, 0);
> > -	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
> > +	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
> > +	     p->addr, ret);
> 
> As this is a signal of a kernel bug, just convert this to a regular WARN_ONCE() 
> that doesn't print any kernel addresses.

Would you mean just replace WARN with WARN_ONCE as below?

WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
	     p->addr, ret);

Anyway, without printing kprobe->addr, it may be meaningless for this case.

> 
> > +/* Caller must NOT call this in usual path. This is only for critical case */
> >  void dump_kprobe(struct kprobe *kp)
> >  {
> > -	printk(KERN_WARNING "Dumping kprobe:\n");
> > -	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
> > -	       kp->symbol_name, kp->addr, kp->offset);
> > +	pr_err("Dumping kprobe:\n");
> > +	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
> > +	       kp->symbol_name, kp->offset, kp->addr);
> 
> No, this function should just go away and be replaced by a WARN() in 
> reenter_kprobe().

Would you consider to use pr_err() here? If so, I'll move this
dump as you suggested.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
