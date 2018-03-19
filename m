Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220729-1521445169-2-6676726992368710914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521445169; b=vMabDvDWRHh8cM5CpSE+kBjIsZethw8ZHHMvix9LT0bucI4
    r3/f3xyDhFgsKURhoY3wIs52ajy2+aGOl+0PcYz5cm1zgCnVSWgA+8WTK8U1euFs
    AjeM3jX7T6OXNaeLZF8LbuzcjvpZRUfmen5vNha/5joU/9hidjm+Njf+2yW1FSv5
    Wvk35+1TbE0nVFTkYai56Z8U+w3BzZU39tVDggb+nmPyiF3ZXu7e3LerC+qi2nQp
    x+PQmeO9lFuBOur4ypTROe+W3gQ+E6SAxigZkPDYk+hWY9O1o961QGRyJybet16H
    ycUK9QmLXQ5eN92kaqn0crhS7DI0zlnjcrJeOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521445169; bh=tFo6iTY8ZAHKfq5eIfrna0SFb2
    XyW436G4WxaryGdWU=; b=QFfnDl3gyv2FcjkQXPjl0Q/x9VezhQfZgk6oFnrxHd
    RHux/yZzyExGDDEIRzrB6sB6IANKjoyhh0q/J1oXyd+UckeyD0PHHkOzjKY43l1x
    ZQeAZO6jtJE2aivSgMv2GGBo03oWRooiCf1GTxtHtGtF8a+dyBqOV/CWJghHN4at
    Z/MQhnLsr8d+GbVBVbmMg5Ga07QfFmADuBAXlh93+8Sb9LF2dr6zF+MnN8ozMBHb
    C0LeqwLba2/Df471RNMcT4aTtkONKXQ1xuqIynzLhTUUsw1O0qsBeWgUp8TRRXKp
    14V01DiihUmavBTm6o/1t5dw4JLfqWWIzZTGsUv+9eHg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpefirhgvghcumfhrohgrhhdqjfgrrhhtmhgrnhcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvddvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedruddvgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpefirhgvghcumfhrohgrhhdqjfgrrhhtmhgrnhcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvddvtdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeCSHj0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 03:39:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932380AbeCSHj0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 03:39:26 -0400
Date: Mon, 19 Mar 2018 08:39:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180319073925.GB30340@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180318102454.GB30164@kroah.com>
 <20180318111442.GA4607@kroah.com>
 <3113502c-0d76-e625-4216-03726117d05f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3113502c-0d76-e625-4216-03726117d05f@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 03:39:38PM -0700, Guenter Roeck wrote:
> On 03/18/2018 04:14 AM, Greg Kroah-Hartman wrote:
> > On Sun, Mar 18, 2018 at 11:24:54AM +0100, Greg Kroah-Hartman wrote:
> > > On Fri, Mar 16, 2018 at 04:22:29PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.14.28 release.
> > > > There are 109 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > > and the diffstat can be found below.
> > > 
> > > -rc2 is out to fix a build problem on some configs:
> > >   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc2.gz
> > 
> > Ok, that sucked, let's try this again...
> > 
> > -rc3 is out, and this time it at least passed _my_ build tests:
> >    	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc3.gz
> > 
> 
> For v4.14.27-108-gde586f0:
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0

Thanks for testing both of these again and letting me know.

greg k-h
