Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17088ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB4721502
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6eo5urO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB4721502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeJTPtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 11:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeJTPtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 11:49:06 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24CE214C3;
        Sat, 20 Oct 2018 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540021176;
        bh=hp1OEIX7P7laeG33+Qpfs/DKUZ+b3UZG62y6FFEwics=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6eo5urO4awFYQXXNTW6grRLbJWxpnHP0Qmdt7zAE5YT65/3dGnFjRLqWVFurfzTJ
         U9I0BjOPs4JBtw6SzY4H4JD0fQMkPaRJ+PW3JRFxsqBnbpqluMAkFeVFU+JhjfPZoP
         VgsrolM2Se69Drpl+VCrm5Xk05sGFrdZykf7zaaw=
Date:   Sat, 20 Oct 2018 09:39:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] [GIT PULL] tracing: A few small fixes to synthetic
 events
Message-ID: <20181020073934.GA9710@kroah.com>
References: <20181020012958.223064271@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020012958.223064271@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 09:29:58PM -0400, Steven Rostedt wrote:
> 
> Linus (aka Greg),
> 
> Masami found some issues with the creation of synthetic events.
> The first two patches fix handling of unsigned type, and handling
> of a space before an ending semi-colon.
> 
> The third patch adds a selftest to test the processing of synthetic events.
> 
> Please pull the latest trace-v4.19-rc8-2 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> trace-v4.19-rc8-2

Now pulled, thanks.

greg k-h
