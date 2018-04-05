Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1401901-1522887651-2-7721505088037259982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522887651; b=l9agN0F9DCNyqbUGSMlH6zWF/gp8Mb0Q2DdJ8v8bzgjsbMncmN
    gW5xcPpcgX6cbvMX7yHGj3SJnlCeIz5VETEQWwlNTN30WC8BEXQRAso5jNAfLbWU
    bPsBjDEKAp2gmvYnlJh06jzZI0KpEEjRvgOO56R252Pdxq3zbvqCdDPT8HTI5oyX
    zKHZLgffOaD5cjrHEI9ns2ztS462g2RijpbNg232i46To1kY1lGF5L9mHPTuyqxx
    wDori+CO7BVrDT1QKXk40OsC2g00KyXk96VwuO1iopempXHHTfu6zhEiP2HkksXl
    MKTKODcmkVe1eDZg7fMj0SKxTFeARcxJPGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522887651; bh=lzP4pb6WHarbtX5tWzMcL+MwxUPQ5Aqji4NMvZtZNJ
    A=; b=rg55i3r6tX7qKOjhp7L4y6Uh+lEK3ZEs0XGkYsCPCajwnkrrmQRPSeWDrT
    PICr1a5F03lsPAZJLEH55IaAS4aayexObv9sS66cIKXd5cHXgH66d5K+HqBlgp22
    8JbXqjGxNDuO6XSzDomDiWyC8Ii0Mxo2d1htIkO/rMoAinU96/CfpgICLDdfGtgE
    iOg8Sce+/WbVyT4rl0d9a3kkrwbPeUyvNmg5B3At5mcnga4xiArr9DKQdhVgASoD
    iqJlGS4rQSyC7kiFqzbxinm1JSj8adzCFeNWJu93Yn4PPe8p+g4nzH+mIIIu8kfO
    WQl4aRziGUHKgeaNX8ZICYbwb7qA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=WHoLdRFw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dC/2bqrc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=WHoLdRFw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dC/2bqrc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEMDe3Aa0J7ETZlcUGBrPJUAv0YgIBg2IHsXtDcFZtESux9XJxvUe7RckbJP5e2eYdgRR+TVB0rn/9iOlwMHPKle6pzEKXEV4RaPKHAdY8HBH0or6W+S
    ek68qX4pIg5oEnf1heoXVIGGXY19QSh+Xr5HFa7WArSZ0YR7TS5V+kzIby0cecgBIcFe/bRH7qUeS7s9rGKrYCHFeEqaodBlijtd3+t9CCSbGaHalVe93uJS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=U8gRQ1uq2NncIcglQDoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDEAUt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 20:20:49 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33665 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeDEAUs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 20:20:48 -0400
X-Google-Smtp-Source: AIpwx4+EMOaafJlqtcCU7FuGTy7P+Z1bA9JlecHWlf64xPBSXS0d+v07qxAfrkw3m3H6h26Ynen6NNv7gCQW0IK6bGI=
MIME-Version: 1.0
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <24353.1522848817@warthog.procyon.org.uk> <20180404135251.GD16242@thunk.org>
 <CACdnJuuGRRUt-a3i89o906ka3RDOhs+_7tz_G8LTG8Jc0DXAyQ@mail.gmail.com> <CANA3KFWLCfe=KYPBhKj+g698=frt4E-u-Hq2--5jFkHnkNoBnA@mail.gmail.com>
In-Reply-To: <CANA3KFWLCfe=KYPBhKj+g698=frt4E-u-Hq2--5jFkHnkNoBnA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Thu, 05 Apr 2018 00:20:36 +0000
Message-ID: <CACdnJut330=gdaSOR8VdLJeNEiL7uupUMZYqVYy5YoE1J-w2vQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Peter Dolding <oiaohm@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        jmorris@namei.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 5:05 PM Peter Dolding <oiaohm@gmail.com> wrote:

> > If you don't have secure boot then an attacker with root can modify your
> > bootloader or kernel, and on next boot lockdown can be silently
disabled.

> Stop being narrow minded you don't need secure boot to protect
> bootloader or kernel the classic is only boot from read only media.

And if you use another protected path you can set the appropriate bootparam
flag or pass the appropriate kernel command line argument and gain the same
functionality.
