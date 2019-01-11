Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF166C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4A42146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547184820;
	bh=87y3t+Sr7bcxLc3Qv5o6z5HgzHBecJvvmq1YVGwbsYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yE1AqPcSWatJ52IPQTVAyzBFL1gDTL6IO166kFCFZKiknqub7EMuoAVN1haOdX3rC
	 FbGoCDlJQkJy7/W+z88PJYMiVv6t4v7rRxEEDP2gDPyTL20d7fhGymxsBg9B7Y+Qrs
	 9c9xR4D/jFINteIeWzHHHtrJqGWMsUuIk01RdYsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfAKFdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfAKFdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:33:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 025F820870;
        Fri, 11 Jan 2019 05:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547184818;
        bh=87y3t+Sr7bcxLc3Qv5o6z5HgzHBecJvvmq1YVGwbsYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOtw4gAIwpAlsLW3stVrHc9EHM6wS0abSXux3mfxi3I1dCJWi5AOC0p5UYhJg225f
         XOce66PyaLKsZdccn3ms/HPOtdwm9raRO/rTY8V2gVgs0C4Q+FWURzYob9n12X+Lk6
         iKaT5pH80lyPI9/cotLUDzFnE3vmbGoAuPtNyps0=
Date:   Fri, 11 Jan 2019 06:33:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: Patch series for 4.19 to compile powerpc with Clang
Message-ID: <20190111053334.GA24945@kroah.com>
References: <20190110171738.GA15747@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110171738.GA15747@flashbox>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:17:38AM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Attached is an mbox with a series of patches to allow building the
> powerpc kernel with Clang. We have been running continuous integration
> that builds and boots the kernel in QEMU for almost two months now with
> no regressions. This is on top of 4.19.14, there should be no conflicts
> but let me know if I messed something up.
> 
> I will send a series for 4.14 in a little bit as well.

All now queued up for 4.19 as well.

thanks,

greg k-h
