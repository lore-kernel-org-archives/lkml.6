Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD113C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB012229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549912426;
	bh=bXfWZwIpTavcxjFHSjNqtf609+ILqH6i+/QsFhv/OSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TZTlAvwk+fy+ccmYmmigsFSXEC4a0QabMbZX+7jIrRKtPtmcrGf+nOf4MdJ7btPAc
	 f6zaLENkfrglXE5vrBl7mMTwObe7VQuS6KHzsCqA9JyrYT/NBev9p59PhD240Y7LyJ
	 pvXSPAEheeo0rsJqIxddUInqqhWDd7oukyqIOfLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfBKTNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731861AbfBKTNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:13:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6FB21B68;
        Mon, 11 Feb 2019 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549912423;
        bh=bXfWZwIpTavcxjFHSjNqtf609+ILqH6i+/QsFhv/OSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6dFSXmg7U3zznGCk9N6RO+TU1ileez4YKCceweKxQ/BYhoFAagf727lMksYkwOH/
         uxNYqGBGyx9i5TrBclaiGGyEfGnd1fOu5QhfR7zhIVpzxqhJTiXUSQhN3/VUghYv/d
         ctkzlyarDpadBfGtBGiKIHeoCLn3Bo+0NSxTDazI=
Date:   Mon, 11 Feb 2019 20:13:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
Message-ID: <20190211191341.GA13134@kroah.com>
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
 <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
 <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:41:40PM -0600, Alan Tull wrote:
> On Fri, Nov 9, 2018 at 12:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> 
> What LTSI's are these patches likely to end up in?  Just to be clear,
> I'm not pushing for any specific answer, I just want to know what to
> expect.

I have no idea what you are asking here.

What patches?  What is "LTSI's"?

confused,

greg k-h
