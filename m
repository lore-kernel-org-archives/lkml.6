Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2F5C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05AF214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 07:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGT6t/pQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05AF214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJTPRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 11:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeJTPRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 11:17:49 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082DC214C2;
        Sat, 20 Oct 2018 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540019304;
        bh=JfqbBcb7y82nRsUSioj3QZ9srPJV31DyqNpz8osnmm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGT6t/pQRl92baeuiejIRoG3EnZqxvqhv+cLk0cYfC9oCbCoGOwxx/bx5sAB6F5Pk
         VTJxpQI7PJrRpiq7q/w+7lmOdjYXZVV547OAuZ29mYQvxEgjm3yrAFiPADIX3xPtNn
         eT+7lSssr/cjApJa2EOElqoGAEJiSUMioSai0isw=
Date:   Sat, 20 Oct 2018 09:08:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for v4.19-rc8
Message-ID: <20181020070822.GD15318@kroah.com>
References: <20181019174508.GA47209@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019174508.GA47209@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:45:08AM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> to receive updates for the input subsystem. Just an addition to elan
> touchpad driver ACPI table.

Now merged, thanks.

greg k-h
