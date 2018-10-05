Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B746C64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0D220854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0D220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeJEHdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:33:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeJEHdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:33:16 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1E1A5C79;
        Fri,  5 Oct 2018 00:36:58 +0000 (UTC)
Date:   Thu, 4 Oct 2018 17:36:36 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] drm fixes for 4.19-rc7 (part 2)
Message-ID: <20181005003636.GA31803@kroah.com>
References: <CAPM=9tyQkPpELE8C6Fcg7icLNO0b_vsWRMDJgyy_5NCveNuEjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyQkPpELE8C6Fcg7icLNO0b_vsWRMDJgyy_5NCveNuEjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 08:50:19AM +1000, Dave Airlie wrote:
> Hey Greg,
> 
> I was meant to take today off so sent the pull yesterday, but some
> more stuff came in and I'd rather not sit on it,
> 
> Two fixes for amdgpu:
> one corrects a use of process->mm
> one fix for display code race condition that can result in a crash
> 
> Two core fixes:
> One for a use-after-free in the leasing code
> One for a cma/fbdev crash.
> 
> Thanks,
> Dave.
> 
> drm-fixes-2018-10-05:
> amdgpu and two core fixes
> The following changes since commit d8938c981f58ee344687b7910a611ac345960045:
> 
>   Merge branch 'drm-tda9950-fixes' of
> git://git.armlinux.org.uk/~rmk/linux-arm into drm-fixes (2018-10-04
> 10:32:14 +1000)
> 
> are available in the Git repository at:
> 
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2018-10-05

Now pulled, thanks.

greg k-h
