Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2490520857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2490520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIEPNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:13:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIEPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:13:32 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA009D96;
        Wed,  5 Sep 2018 10:43:52 +0000 (UTC)
Date:   Wed, 5 Sep 2018 12:43:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
Message-ID: <20180905104350.GA11612@kroah.com>
References: <20180903165719.499675257@linuxfoundation.org>
 <20180904193202.GB17786@kroah.com>
 <CA+G9fYun7J_BCZ390oa5tY6jp6faaknczzDBuc7w5v6o8+WWVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYun7J_BCZ390oa5tY6jp6faaknczzDBuc7w5v6o8+WWVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:08:35PM +0530, Naresh Kamboju wrote:
> On 5 September 2018 at 01:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Sep 03, 2018 at 06:55:44PM +0200, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 4.18.6 release.
> >> There are 123 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc1.gz
> >> or in the git tree and branch at:
> >>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
> >> and the diffstat can be found below.
> >
> > I have released -rc2 to fix a reported problem:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.6-rc2.gz
> 
> I get to see  4.18.6-rc1 not rc2.

Odd.  Something is up with the kernel.org mirroring right now.  Let's
wait for people to wake up to look into it...

> With the current results on given commit id are looking good.

Wonderful, thanks for testing and letting me know.

greg k-h
