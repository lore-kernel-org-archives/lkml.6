Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2513731-1524554498-2-7340787398249327543
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
    1524554498; b=kbzg+Im6Rsgtr/CacjAAG8NOdM9ouxrBhoPcpxFUYtb4jz4w7g
    fgoC8WrM+WocJRQwD8PfOijx8GYkNatvbXNxL4CzGpmalFuA6J+steozw0bfvjNo
    8vFOQ5hs7nheQVwWgeas/6kBheG273UWpVdQEh6KnVc7hcSmM9Tnbhf6SsfFlFtH
    L2jhlJl0zv1FRwj2SZC8Kb+Iuo0XLIqaa2TKkxPeN2hKFfbUJ5HMxHpkD9NVSQ6p
    QNu3eX2h5dfIuh2XBvqPEiohttbwTRZPLvUIVd76xBr/k3E98A6UOkVUOsgvW02l
    BfBgvSRwqPzfgIT9+Ev23cf7lf8AbPXeTEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524554498; bh=UQvRzcH4D2Hj9Ksn6JHsddqCP4u/pt
    ku3eHcVcs2SmE=; b=GZSDr66NRmvMf7VK946UGqQ5Frsx91UjwYavUyVIRpW94N
    GkNgiaISAYKyi84Hy4+0lbdEHzoA5jP+9waKXAvGqxcU2oGoGh0HhdaO9eHiwxRd
    sLdHAtfM9oL3VFF5wpG3TZltgLkucPq3ZQYwwLiqKMMIJN0oN7TL+5BCWYkd00nU
    jhWglrEqe/I2y+tApm7YmZQfMkcH7g12ZxQigXVP6tIil0upI1O6GsvdXYdyZBJz
    2B9xqX89XL6ePuAcy1ip//iMyIywlPvpcmcmk+B+ZW4ACWvfOzdqwp3sjdXbdfUy
    4HAvv0ukb6Px6mZQQcAyRCprk5wY2fR7e+3docdg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHwAFdCAr++opCD+Bb2Qtt5s34cbhsjBVuJLk+J/TVEqySptpijP4PMNLxCBMFHzPdVW19dWMOetPbSApVm9TO1V5qd7R+SXn01ZEabzrbkSJcmRjZVE
    28tjzgIq+rJLEGeForsyno9DxLNZR1dlb7pM+ksbFPaqRyc6f40lWRSEtUxhPT5zRWrkSoiDcAmJES3sEs46yMXTP+9/8P4wiIDUn22eMys1Mdvuxrcj6+pq
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ZaTRFeOpYqnaFzG1ML8A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755224AbeDXHVf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 03:21:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeDXHVf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 03:21:35 -0400
Date: Tue, 24 Apr 2018 09:21:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180424072128.GD17825@kroah.com>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180423180312.GA27081@kroah.com>
 <4527fda9-f123-f8b7-8294-991a0a66af16@kernel.org>
 <f603cd95-c0a6-c283-09cf-f9d3cd4a5a53@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f603cd95-c0a6-c283-09cf-f9d3cd4a5a53@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 06:32:03PM -0600, Shuah Khan wrote:
> On 04/23/2018 02:07 PM, Shuah Khan wrote:
> > On 04/23/2018 12:03 PM, Greg Kroah-Hartman wrote:
> >> On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
> >>> This is the start of the stable review cycle for the 4.16.4 release.
> >>> There are 196 patches in this series, all will be posted as a response
> >>> to this one.  If anyone has any issues with these being applied, please
> >>> let me know.
> >>>
> >>> Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> >>> Anything received after that time might be too late.
> >>>
> >>> The whole patch series can be found in one patch at:
> >>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc1.gz
> >>> or in the git tree and branch at:
> >>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> >>> and the diffstat can be found below.
> >>
> >> There is a -rc3 out now, to fix some issues reported with -rc1 and -rc2
> >> (I forgot to announce -rc2, sorry.):
> >>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc3.gz
> >>
> >>
> >>
> > 
> > I just tried rc1 - will try rc3. Has the lock problem seen already: ( I will
> > try rc3 and if I setill see the problem, will start bisect)
> > 
> 
> rc3 looks good. Compiled and booted on my test system. No dmesg regressions.

Oh good.  Thanks for testing two rounds of these for all of these
kernels and letting me know.

greg k-h
