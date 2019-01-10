Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E01720685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547106208;
	bh=O1oxiCX53N/PCtMzU9sy0NRdzwyqX+NbspDXh4So8Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uSQo0dv2gGx5nadjO+YZRAEroKWSmiE2CoZ5wf6kLKua++MLxmYgjTbtkChA/LYys
	 E/f6ddeF0DTGFdlz/m9qEdyCN180+orpQ3h/lQAea/aAEMsIibcI9BzMJEwBnx+9tj
	 VMP7EzAMFm7BDfusY35DZXpPSbddE221MbZp8knc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfAJHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfAJHn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:43:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B0D20685;
        Thu, 10 Jan 2019 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547106206;
        bh=O1oxiCX53N/PCtMzU9sy0NRdzwyqX+NbspDXh4So8Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3oCdhvR4jzGPCo3XhP/Xl0T45ChpMp7RoLzPvCSCwUGIXbRiZpeoWDQ+mT0fWtFl
         eNaN/iQ1zspa3V+1gUIX3KTvWclrk9QJGOtKejFNMvxpL64lgK+kbasN8RUR4/L1ie
         ZmIZC7ZDWYedWkwhc6btP+jmFD/6RenxffrSIrc0=
Date:   Thu, 10 Jan 2019 08:43:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] Hyper-V commits for 5.0
Message-ID: <20190110074323.GB20273@kroah.com>
References: <20190110070547.BE9A620657@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110070547.BE9A620657@mail.kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 02:05:46AM -0500, Sasha Levin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hi Greg,
> 
> Three bug fixes for different parts of the hyper-v code:
> 
>  - Fix for a lockup when changing NIC's MTU from Dexuan.
>  - Fix of use of uninitialized memory from Dexuan.
>  - Fix for memory corruption caused by ballooning from Vitaly.
> 
> All 3 were tested internally.
> 
> - --
> Thanks,
> Sasha
> 
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed
> 
> for you to fetch changes up to b5679cebf780c6f1c2451a73bf1842a4409840e7:
> 
>   vmbus: fix subchannel removal (2019-01-09 19:20:31 -0500)
> 
> - ----------------------------------------------------------------
> hyperv-fixes-signed
> 
> - ----------------------------------------------------------------

What changed?  In the tag, the above "one line" message is all that is
there, just like in the first version of this pull request.

That's what I asked to be changed, please put the information you have
above "Three bug...", in the tag itself.

Then, when I do a 'git pull' I can see that in the changelog message and
I do not have to go and manually cut/paste from the email, into the git
commit terminal, the needed information.

As it is, again, only the one line "hyperv-fixes-signed" shows up in the
commit log when I want to do the pull.

Try it yourself and see what I mean.

thanks,

greg k-h
