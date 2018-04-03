Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1905978-1522773003-2-4716163581933692563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522773003; b=Yk1o1EX4nJ4IuOV4MVY7JONyaZZbBPSo5o2Xwld3CffLGxgDZb
    JKISdczhG2P/kSsKKwlOwoXqyQz5N/FWuwKSsVoiWAjZFTHwB1JjM1kLUGcFYzs9
    SQdWp4ZbDlhu/ylhgZoMbaprx8hmaE8j9GYBCEyuph8j6V5vXR93ZZD32qsqhwn2
    t+3uaenpP57/GjiDY2V/X1sIhNwzt9z0sPnIu1HdSQS0GnutwFNu8BQPo7TV+aYH
    8vpKq1ofmlD0HN7gyZMGK+IEGJKP1o3T/N7Zg+/UIIIkSolyvZPrJMloJ8/iAA2e
    Q6uRBCC6oNvmUJYwL9gBpuZphf/AWCAB3EpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522773003; bh=ftY4YLCvmVIXmzxGOfI1xAdYaa86O9I5yDd0maLRVa
    g=; b=HQAFWaLTP/kF6IaMnkC0pDTuv75jgnXpQnBbphcXjMFK3gy3sFd/ztXZsZ
    AHYfsyxrL0V3NnYOeQuTUfrwP9jdaCTCcKz23IG4MhRzUWlvHv364JtpDhue0HG9
    hTKxcdCQ9hvcAzZU7PdpfXxBns3nKaC/N2xjI+ZdsI6MxfFTk83cVUIXNaUf2HjZ
    vO5JjhME3OR0DdvxbOzukqZLkop8bMrVWpgrCu0xAY99JEHh/wOreGOOSLraVoD7
    N2dFXyIilbppSIlNUzzK6j0LFNeAIfvCoOo/HnODztRTVWeDwBCD9KijsWnDZYRV
    egyZaDtV2hT0pXXMYZfu8r1NMXpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=uJt/Ga0c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HmzAI67Y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=uJt/Ga0c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HmzAI67Y;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLbx2bOyPtZL08uCfEQt9LpS53yPv34Ffb53wdeALDB6XD0wStYGWxY+NYnyxrhKY0vLVNS5RTW83cIvXlORHQqf1fOJLw3JqE7kgrTvZ66UJ37A5k77
    TQlfAyYup+jfPvCdDgGAXuNLPf1Q7yrsc2tHF+T+B/O9qwbkKkCJAgJ/dgZq1mcog+t1rFjAIcf8Hl3WOcmdrX2i59LIwplBDPDUrmJBHekQ4wPbLv06ZYn4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=-2StxpqBuYWn2ZcpPNYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeDCQaB (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 12:30:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53904 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbeDCQ37 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 12:29:59 -0400
X-Google-Smtp-Source: AIpwx4/exvGfslObJMvl6s47TIDaF+ZK8nS6/WnOm27VGTthVzZ8sR2WB+U6Vvyja+KGkeuoPoM9osmI4Fd2i5MTeUI=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
In-Reply-To: <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 16:29:48 +0000
Message-ID: <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: luto@kernel.org
Cc: David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 8:11 AM Andy Lutomirski <luto@kernel.org> wrote:
> Can you explain that much more clearly?  I'm asking why booting via
> UEFI Secure Boot should enable lockdown, and I don't see what this has
> to do with kexec.  And "someone blacklist[ing] your key in the
> bootloader" sounds like a political issue, not a technical issue.

A kernel that allows users arbitrary access to ring 0 is just an
overfeatured bootloader. Why would you want secure boot in that case?
