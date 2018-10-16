Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43959C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E42E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko/OIuE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E42E21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJQAoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQAoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:44:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9AC2205C9;
        Tue, 16 Oct 2018 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539708786;
        bh=qeOIAJTmOn0k5o+SGOgqo4Ko+QwYNLbEWjvwrrvf92s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ko/OIuE8aY3kERP885lCc5fMnJFvfmYHWWE2sW0Qw1Z4se/JubRXW2tHAszyFwhMc
         QoVKYs+mHj0+lx7pUYWRayJD4/71lQLXEQdwthofyYUsZPcMO6VpPSgjUQVpLtkXMF
         XnCLza28/2cUeU1cw2rlm2lvpEFYx1aWC7YU/mPo=
Date:   Tue, 16 Oct 2018 18:53:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] SELinux fixes for v4.19 (#1)
Message-ID: <20181016165304.GD9547@kroah.com>
References: <CAHC9VhRDmorDGkUkXv5f4YT-PxBdspbqmo+fYpu7-P-xzC2FxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRDmorDGkUkXv5f4YT-PxBdspbqmo+fYpu7-P-xzC2FxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:28:04PM -0400, Paul Moore wrote:
> Hi Greg,
> 
> We've got one SELinux "fix" that I'd like to get into v4.19 if
> possible.  I'm using double quotes on "fix" as this is just an update
> to the MAINTAINERS file and not a code change.  From my perspective,
> MAINTAINERS updates generally don't warrant inclusion during the -rcX
> phase, but this is a change to the mailing list location so it seemed
> prudent to get this in before v4.19 is released.
> 
> If you don't want this for v4.19 let me know and I'll queue it up for
> the upcoming merge window.

Not a problem, now merged, thanks.

greg k-h
