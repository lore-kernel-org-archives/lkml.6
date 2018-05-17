Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1861431-1526549180-3-16877168607539883472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526549180; b=a5eUhReubAKVLlrnhUfjx2q5Nzv+7S1k/xlnYh+MW2xaIlL0xz
    OcXEd3m7mdX4QvBG1ikyBzrXEH2GLsyNmbc4YcDcSpLr/p1mTlJaRz6JbEiqRr4o
    uepMI3PaffFbTmhKzhGfltOOQBf8BIucUZSYanM8hc5lI5AK0IJbV2nyvpL0uoFv
    oS6Wlm37b1KR4aKzW84KuheAITDNNZ+7BzlT8LwVl979h5LtnofzjczIwETjEoqc
    LHXO/nFcEplqHGwYhOcVUssFZy3boasyDWMBM2lYbZpiCiYoT1C9hza+AZRYhYbx
    deWi+xrhimk+iscuAUYOn8sTk3j/1TEGIO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526549180; bh=041J3l+f+qO
    fdqlT9tShgD47ky77UsFGd9HM4NuaQDw=; b=Ay/KG5GCQyJRBL3owEnjzwlR3dB
    sJay+1p7lTareJs4p4uY7m5cShdnqqPtZT8aScboyrhzCkhbD8kiXBl0CLG7OtZM
    NguHb0wF9hX/W1TQs8GroXdlNrKHOJ1Ni/B4FQ66R2OGXJR0OeG087NjFZuqPqdX
    q13YqOuLYraDjTLIkW5e/1Z8rqxWrX/kctxvpnkRp+wbjeXcC/kI4tzmQWINycf0
    ErMF4hqQSr+iXVkvOjBe3DfXhiRhzoskCRPf/QrAZpP6GKBNazPPcnOq3RiCIy0T
    kbup8gUPNgT90cVO8khQAWor7j5RGA/euYGdtRWYMyOCvRg70RgRho2Hczw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JXkAfPe7 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=JXkAfPe7 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxa2MFCN+3X+a98CZO7tiTFosaCEdWNMOkumRdXb0bIETjQsXqoTrfhTKA5JZ1yAVVS9aeEU0BO/sLcjDKEkxXn9BTjkyAOfhrkOs0qqHmYN/+cXu1t
    PydtHKCIjCpMr7wcsFGznI0fjCPw8w5RiXrIPItMSZnN3TqMiZLXm6ZleTIVBMhxrx3M8f+wqrUq4szQ901+agECsZPXUgqDDFeDHcksDKqJZ8767Ek9Ns8r
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=o2nqLNa1bK79t648I2MA:9 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeEQJ0D (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752063AbeEQJYZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 05:24:25 -0400
Date: Thu, 17 May 2018 11:24:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 099/190] arm64: futex: Fix undefined behaviour with
 FUTEX_OP_OPARG_SHIFT usage
Message-ID: <20180517092407.GI25318@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183556.339662900@linuxfoundation.org>
 <1526426136.9159.85.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526426136.9159.85.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 12:15:36AM +0100, Ben Hutchings wrote:
> On Wed, 2018-04-11 at 20:35 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > > From: Will Deacon <will.deacon@arm.com>
> > 
> > 
> > [ Upstream commit 5f16a046f8e144c294ef98cd29d9458b5f8273e5 ]
> > 
> > FUTEX_OP_OPARG_SHIFT instructs the futex code to treat the 12-bit oparg
> > field as a shift value, potentially leading to a left shift value that
> > is negative or with an absolute value that is significantly larger then
> > the size of the type. UBSAN chokes with:
> [...]
> > Whilst I think this catches all of the issues, I'd much prefer to remove
> > this stuff, as I think it's unused and the bugs are copy-pasted between
> > a bunch of architectures.
> [...]
> 
> Indeed.  That more complete fix was done upstream by:
> 
> commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Thu Aug 24 09:31:05 2017 +0200
> 
>     futex: Remove duplicated code and fix undefined behaviour
> 
> It's a bit big for stable - though most of the changes are deletions. 
> What do you think?

I think it makes a lot of sense, I've done the backport now, thanks.

greg k-h
