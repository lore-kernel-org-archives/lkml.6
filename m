Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3435361-1524791683-2-7707307963573382024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524791683; b=kU5/uBQJ+PHTWXB01mWY+vxVmdyQOEiiiLhzS6f5w2nUcqW3bc
    HHtPJXe25/lqCvtNJ8Z/Ks5ozIYruPSxKMxfffe1fmsbsOJ2kA/Bh0gII76HhYu3
    plKji+i36EbgSKKb5ZLAaUIcl7BWCKWP7yDT5LdU+f7xAby9kGC0wUFamInbLauT
    TeJuXanljRi724jaS/uQUxK9kKuMV569ROSvA/52d5637KErNqA1PZ5od42431HC
    6acS5mpbyBzdXVy74HncB69FLMpB/0CC3i01V7WPILPrzk3HE9JOswglWi38TbNL
    TFmADKjr9x/ewU8pSLWn9IvdToaHnD/t17VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524791683;
    bh=odbM3cVmAI+vRlsRyKrlEK363HEN/Tx7L5JAmLWZxUA=; b=RwVoXTBmeiVg
    XIyyDvjgLUJNFQknf4IkjyDjU6bHk3jil2yM0i+1iMZePtwH+XgCipoNM8GTVAsz
    SnRTv2xFz5T08h9hkzPdYvguoqf6FS+md8EcmNQWeK9xYZQDtpcd7GzOLDjtBqvp
    0Ku4WFDe+H5J/GFdekaJHPu3Mmis8pRxN+1hKOyduw6bT0UzowC7IFuky1C7ehJr
    z27ueiwrPOk4CS1JQJwyz29pxfMg2EyXmsKRV1cAZOv6WQP0ZOjcXMR3ybvwXPi0
    D/SLoR0IY+1uvXFeIiIw648jNkFyxmAgNdmp8FDQ9QOyvlvuNUA3RrqhAPWJRxzW
    YucDFlGa5w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG8TO48/4kWm2wvAzQs6JSCnUF35Y+34sVGLkhK9wSo/haHPSWLcL1X2dcL/m04wP3o11tzrrGEy80wS0UZTMe8wOeSCFTzdqygX1u8Xl/ECYEYgAgx4
    YEXPC6FethuUiyTIlyzJXbNiOxWHaPpL9oe2QK3MH/d/2gqDsC4UfRTa+GCOSpCe6lpgScgO1GjfgSfqNXVXjWZ+eg5ez5uQpI2mnkVoz8udshi7dAzU/NBW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=tDKwcr9Ron9koPkCpfcA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756544AbeD0BOk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 21:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754824AbeD0BOj (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 21:14:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A379D2184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 26 Apr 2018 21:14:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
        akpm@linux-foundation.org, acme@kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH -tip v2 0/7] kprobes: Fix %p in kprobes
Message-ID: <20180426211434.140fa33d@vmware.local.home>
In-Reply-To: <20180426084022.GA6777@kroah.com>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <20180426084022.GA6777@kroah.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 10:40:22 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Is it because he didn't add the Cc: stable@vger.kernel.org tag?

-- Steve
