Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4113313-1523375282-2-4017208530726524425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523375282; b=IHsEHJqnLLC9UxVQOHjC/dChD2pcIYZWR0TIj28Wpxy4Dx59RU
    1/1ZYMTVc66GOBSrbL5GIYWozOzp0xiIqoS9/Sbo/R7AxcT9lWLWr4vZwwg3uc4C
    Nl5VBKw+gYmJMjNuBK/eWFNoj+5zrMLitEe/KymrG6mUnXuMR02twAf7IQF/qbHP
    GOx4eqdFFWifcQyrOgl7/rCgsA7RwDmoXt62Jxi1rF6TVEau8LzWaDtB742ouKc3
    P52ZRC+c596U3bIzjvdco3xmXMB7+0+bUYw49zOeiLy+fhvnGl9ZHb2y4zL4LuYT
    TsRDgcXjwa4MX5mZbdKJuS5stL3YsXEZnUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523375282; bh=qrUxqc1rKav6HsKH9q6q2u14gINpr+
    cPYUGuER2Inl4=; b=tYLoKKYjArakW8LIXUnmKk4eNaWvPbtNYr4sNyEO9nztOs
    rNYHQ4D6PDaNw/W9iwZmxYaNcZg9Ray99j+8AXH0LDT+OYbCU2IS8yLZ0kOvv4o5
    af9QE3fgbfssxQSxb0kP6ONi4I0pz0aqR5yjTzX4VFDutZeLtYumx9oc4AauOuU2
    j+FnS915HnXO2KzO4BtttueU9735J6voqxyMN0OC58wJulTNUwNtEIi8ee6MIRR9
    27oT+f00Zob7R0RTx+9iebicTQLpCzjwMc/BwRrlJ8hTOZD4MHOopKV0JCVQnSg/
    HkTwu+hFjfFBdnTWn6tXycjuFl5zdkAjS6GPByFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHkC+gMoAGiZHI+h/RcQLBaRX4d2002HThyYp/Kw7sL1lDd4qfA9ZyRf1vyu7hkl0cawgSGshM50n1+pri3QtKKm0VTBz0RWJSZDPN1Wuvm3guY+hhkG
    kSpsekGdwACf2Cvqh4tO2L8lbC32HdjXJrgEKc6hyn6lfRJxrRgoH11RWEaauosEzMNZE0p9WtrAdxHk2t/e0/WHGO9Sc8IugfvJ4Qz2cC1JyGtzkSwSYeuq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=OMrEOvu6eqHIufIISc4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbeDJPr7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 11:47:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeDJPr6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 11:47:58 -0400
Date: Tue, 10 Apr 2018 17:47:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bp@suse.de, thomas.lendacky@amd.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com
Subject: Re: [4.15 & 4.14 stable 00/12] Series to update microcode loading.
Message-ID: <20180410154751.GA11614@kroah.com>
References: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523039426-3938-1-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 11:30:14AM -0700, Ashok Raj wrote:
> Hi Greg
> 
> Here is a series that addresses microcode loading stability issues post
> Spectre. All of them are simply cherry-picked and the patches themselves
> have the upstream commit ID's. 
> 
> I checked this for Intel platforms and thanks to Boris for checking
> on AMD platforms. 

Thanks, now queued up.

> I'm still working on a 4.9 backport, will send those once i get them to 
> work. stop_machine differences seem big enough that i might choose a 
> different approach for the 4.9 backport.

Ick, be careful, it's best to stick with almost identical code where
ever possible.  Otherwise you are almost always guaranteed to break
something :(

greg k-h
