Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2195308-1528171766-2-8419392723411838201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528171766; b=hFtYsnSvNuIk6Xoh+wEuK38VXzi9P4kfHAmYjDqHA39ka6PWA6
    Iq6ofP529p63YKH1B1JOLSE2oEbX9dBIUQPkaHSB7H9nGsaBkF7FFITrFbG9DXuH
    ump7wnENXLDTXM4uIDn+hSNTW1Fgw5Q2grHLkT1wj6/Xpj+DD5FzuQIMaWAbVy1b
    tf4SrTTOne54jryXkaIlGafTnivdi9MknwzS2evFZAqr7ABdEzEGkiRHPOHjiVKp
    X9kae9WXumcgK15LZG6n6yUIkPr4ji1lL/jWRO6AZYiwVI2noYA6gpciWe76WwQQ
    z3cJcnTgkDgFN7fDPNDXsbqPX1wMPXmrX6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528171766; bh=vA7lEDPdvt7rk+Bu5A2NflK3pun768
    VS0LEG5B/RiDQ=; b=WNmq7ZDhNdI/2dur1nSUbWQq+rZdeZVD5lIltjCLXgcG0k
    8pyNy2gAuyQoP6yQKo0PjXeTNJFg7wXzC732sDHfTZLuBX9vWVh/I4CCVAvLKrXJ
    OJ7sH3SqdrEBAuANBLYz0Z1WrPbMJLdoZFi6OZfxabDOqIskC/h2u8upLJWzXsqY
    1atuKn9o9QG1B3XXGvn8JS0I5Id2JLVePOu4aieSET65QiDrlDVDwyJs1H8kT6Uj
    zC89p6fbxP4xLCHvpGYWLnKu3wMtn6Qa56JS0b6uUpByc7LLNGmZFrNL2rNxj6Bt
    vnqbEKQw3HUnwBaYfRMNQitN9D3n5EUSAuQ6pWiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMinBjGp72CtIXzxEtySqVViCfMBgqSikx4RAvD7Y76jrZ1b9JnZ7obe/jMqW4nZjt0fUQRi1tNMcG0ZxZMnlGZqzl/DFuanbFUJkeHfHAKYg5wQ5qGD
    W7V7hgSwnhsqOyBIZJieNIrdC7AMAS0ibRUnUcGRAmL0a2rA/NH0rW2I4ufpVHkTBL66BZ0jZ3H689hZ2d5Gar9vNoABArrP2fD4jN6Jm72hc60EvmbuoWED
    a3ESFsIjD0BjOu0drPaLfg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=cm27Pg_UAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=JcB7tTdapgqYs0HN3M8A:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeFEEJW (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 00:09:22 -0400
Received: from h2.hallyn.com ([78.46.35.8]:41648 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbeFEEJW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jun 2018 00:09:22 -0400
Date: Mon, 4 Jun 2018 23:09:20 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Kees Cook <keescook@chromium.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
Message-ID: <20180605040920.GA19747@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com>
 <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Kees Cook (keescook@chromium.org):
> On Mon, Jun 4, 2018 at 7:03 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Tue, 2018-05-29 at 14:01 -0400, Mimi Zohar wrote:
> >> Instead of adding the security_kernel_read_file LSM hook - or defining a
> >> wrapper for security_kernel_read_file LSM hook and adding it, or
> >> renaming the existing hook to security_kernel_read_data() and adding it
> >> - in places where the kernel isn't reading a file, this version of the
> >> patch set defines a new LSM hook named security_kernel_load_data().
> >>
> >> The new LSM hook does not replace the existing security_kernel_read_file
> >> LSM hook, which is still needed, but defines a new LSM hook allowing
> >> LSMs and IMA-appraisal the opportunity to fail loading userspace
> >> provided file/data.
> >>
> >> The only difference between the two LSM hooks is the LSM hook name and a
> >> file descriptor.  Whether this is cause enough for requiring a new LSM
> >> hook, is left to the security community.
> >
> > Paul does not have a preference as to adding a new LSM hook or calling
> > the existing hook.  Either way is fine, as long as both the new and
> > existing hooks call the existing function.
> >
> > Casey didn't like the idea of a wrapper.
> > James suggested renaming the LSM hook.
> >
> > The maintainers for the callers of the LSM hook prefer a meaningful
> > LSM hook name.  The "null" argument is not as much of a concern.  Only
> > Eric seems to be asking for a separate, new LSM hook, without the
> > "null" argument.
> >
> > Unless someone really objects, to accommodate Eric we'll define a new
> > LSM hook named security_kernel_load_data.  Eric, are you planning on
> > Ack'ing patches 1 & 2?
> 
> I'm sorry I'm late to review this series. Reading through what you
> have, it seems like the existing hook is fine. If the name has
> slipped, we can rename it, but I think adding another hook for the
> same logical action (loading something into the kernel) is confusing.

Personally I agree with Eric and prefer a new hook.  I don't feel strongly
enough about it to keep bikeshedding, but since this set already exists,
it seems like the way to go.

> It seems that only patches needed are 2 & 4 (new hook callsites), 5, 6
> & 7 (IMA coverage and policy). 1 and 8 seem needless to me. If the
> objection is that isn't use on non-file objects, sure, rename it. But
> I don't see a _logical_ difference between the proposed and existing
> callsites. enum kernel_read_file_id covers the "type" already....
> 
> -Kees
> 
> -- 
> Kees Cook
> Pixel Security
