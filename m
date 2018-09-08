Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81BCC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8863E2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 08:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8863E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeIHNOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 09:14:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIHNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 09:14:09 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 089A6AF3;
        Sat,  8 Sep 2018 08:29:12 +0000 (UTC)
Date:   Sat, 8 Sep 2018 10:29:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harsh 'Shandilya <harsh@prjkt.io>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/29] 3.18.122-stable review
Message-ID: <20180908082910.GB23082@kroah.com>
References: <20180907210909.523240901@linuxfoundation.org>
 <5188E506-7DCF-46B1-BE91-086EB2356D69@prjkt.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5188E506-7DCF-46B1-BE91-086EB2356D69@prjkt.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 10:53:22AM +0530, Harsh 'Shandilya wrote:
> On 8 September 2018 2:40:21 AM IST, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >This is the start of the stable review cycle for the 3.18.122 release.
> >There are 29 patches in this series, all will be posted as a response
> >to this one.  If anyone has any issues with these being applied, please
> >let me know.
> >
> >Responses should be made by Sun Sep  9 21:08:52 UTC 2018.
> >Anything received after that time might be too late.
> >
> >The whole patch series can be found in one patch at:
> >	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.122-rc1.gz
> >or in the git tree and branch at:
> >	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >linux-3.18.y
> >and the diffstat can be found below.
> >
> >thanks,
> >
> >greg k-h
> Cleanly merges and builds with Werror in my oneplus3 tree. No
> immediate regressions noticed. Thanks for the update.

Thanks for testing and letting me know.

greg k-h
