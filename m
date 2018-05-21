Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1401999-1526940611-2-17749659062090605370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526940611; b=RULZpqFSgrr7hgWsFYznX9J5479hxR2Fl5SX46qZ8txfp49bmV
    LsaJUPFeF8bVbin8EJ5A+mhGJxkvzPVrvdmmCCc/PWNxeeNKiZMSYxZIw/hWbGTD
    vU9EM5BQmtr6RuhqtJNZ1Uh12U0WxXnzGEeVuJwHYdV9K2MON4rNa5IlHuJE/GJp
    nsuOcjXb/JPmbJV0VavPLDg3BzSoR4Tced3DBuZYPtn0DoD1MP6d2AtT0ofyXhpl
    eV9TCpv2QSVPc4LNTBw2yQ2UIaVJby7B1iStbldaB460cMbuT1wQvvFZYWGHzty7
    btJFO/myRiFlrarQdkqrrEmbhIsQhD6SDEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526940611; bh=ppQ52+yjAwVkXsvx8zlDY1lnj4VtaBDLvzo8oat/kW
    4=; b=eVXakQWtpljeraV2XR2SxLd26mAx1HszHJLsKxPhSsDL9R/0w7qdPOsmIW
    t1FMmT/Klr+6wQ5/7xBZkLfS/BpjjBkAjT55le80FzbV4IdsWrfIv9UihlXmL/LY
    cke/BMy+V0VduprkmxaJG3q8nVAWVE7QyF081tTLef+WMQEdNJjlMfiuV31bjOs4
    NYtuDqP2og0cBC0R9VCnst23ne1quGrjzvAmmJrvkRuAa7jEjt+ULKaK/2DXBStg
    a9bq7i1bK8O2dX8cJZa3CBYUuwxGla3tCMrvOzCpp6sCsYd+/lvdFiyttcqvR0OB
    z0z0nqD3pTqMhV7NVAuiNWp6knqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=mI1Oh00Q x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ZYMMydTt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=mI1Oh00Q x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ZYMMydTt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbf8pN5BOonyxpOTcgC4DMbS4HCe4H13NAeM/uEFqSsUVIv5JcspA4f/FmqPx9N842zfjtxNN1W1q1CyNDqJeOoNc9ElnN5iH6JrrmUPc+Ck/K6+BI0
    kOk43sdmF+ZiULuA0TDKEwbMaFW56NqYZZkGJKDcejE8VDYaYUIlE1l9HX4NCmHJxKbj2nxzGjxEZ2fP2KLrNesm4/zkeD08fWLQDjkiS9Cys0VKGuosBtGD
    MMbCfjl1B5WM5Np7W0il0Q==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=i0EeH86SAAAA:8 a=9CzO8LN9AAAA:8
    a=DfNHnWVPAAAA:8 a=K6HrmWtEAAAA:8 a=hBqU3vQJAAAA:8 a=VwQbUJbxAAAA:8
    a=ScUUEN4DoVPer1bLtn0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=P75mTTWLD68A:10
    a=tBdNNUmHh4RtwhQgcGBh:22 a=rjTVMONInIDnV1a_A2c_:22 a=yV38gEssg_2GhkhKF82i:22
    a=WLjMIN4s_96MqnBbPenP:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbeEUWKH (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 18:10:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38112 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeEUWKE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 May 2018 18:10:04 -0400
X-Google-Smtp-Source: AB8JxZqdPl2qwgqK72FHue08WQt2SadKqRaLFbedKJowZTjngJqBQYsz9JmphD+OD7GkrbhU9EIN4ohQqVNqQPIuD/g=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:10:02 +0300
Message-ID: <CAHp75VdTq4XZNizUNNN=C1wzbkoGBvv6FVHDgCc-PFh4Q7dM0g@mail.gmail.com>
Subject: Re: [PATCH 26/33] apparmor: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

http://kernsec.org/pipermail/linux-security-module-archi

> Cc: John Johansen <john.johansen@canonical.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org

-- 
With Best Regards,
Andy Shevchenko
