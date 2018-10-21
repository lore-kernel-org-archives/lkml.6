Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C0CECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5838520869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7PKeszS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5838520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJURg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeJURg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:36:56 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA31D20838;
        Sun, 21 Oct 2018 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540113796;
        bh=6vVUwD/weMehUhSlhjKVQVemPuacnl1O8k2dWvMR5d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7PKeszScpCSst9VDjZIbL81+nxOzDEcbEUZyjNEnNRt7GvScQTrIjsXqnWZ6r+uH
         IlVgvfDHzI10wFB36WnStTheUDqZ6s/wl9G5gczg1m+Od+68HUNi2xdPPCTLsVasIh
         Ycs8RR/TkBOVtTdu331AGxMGcIRdT/nNirRhh9WU=
Date:   Sun, 21 Oct 2018 11:23:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "jonsmirl@gmail.com" <jonsmirl@gmail.com>, trondmy@hammerspace.com,
        gnomes@lxorguk.ukuu.org.uk, mishi@linux.com,
        ksummit-discuss@lists.linuxfoundation.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
 contact email address
Message-ID: <20181021092314.GB26386@kroah.com>
References: <20181020134908.GA32218@kroah.com>
 <20181020135118.GG32218@kroah.com>
 <20181020192845.48b8b860@alans-desktop>
 <dfabf8b10d3e825c9a7f6c110e042dc72e50217d.camel@hammerspace.com>
 <CAKON4OxLLhUkPGGbSF_ZtBC18fzZo44t1gUSsbYA0d2vCPfosg@mail.gmail.com>
 <20181021082757.GB1617@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021082757.GB1617@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 04:27:57AM -0400, Theodore Y. Ts'o wrote:
> On Sat, Oct 20, 2018 at 03:14:20PM -0400, jonsmirl@gmail.com wrote:
> > 
> > Which is why the lawyers need to go over this document and I haven't
> > seen anything posted from them. In the same vein Mauro is concerned
> > that the way this is code is written it is a binding contract in
> > Brazil.
> 
> My understanding is that lawyers from the Linux Foundation have gone
> over both the CoC and as well as the changes in this patchset, and
> that this happened before they were sent out.

That is correct.
