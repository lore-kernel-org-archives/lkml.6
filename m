Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2DE23C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F082089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWhq3NsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F082089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934891AbeFLW1Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934627AbeFLW1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:27:22 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355132084E;
        Tue, 12 Jun 2018 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528842442;
        bh=3XFHhkPxWhq3O0CWxwMqGGBCnJIqjVYu+sRnBQ02lmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWhq3NsSLnMI1oWTPjiEMx47E04F9Q368EYjZCKba+zeXZaIyVCY0IYkAJ+aUw14i
         m7jmg+RCu2ZGw0DqxU2rX9T3ACO7YM7cd+8yPtxiMbLYJ4g2GPckVzwJHRGeGZyxRb
         /B3vlMr8sNJcFjulo5ET7bsNFuOQaTbMZsnNePGk=
Date:   Tue, 12 Jun 2018 17:27:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        shawn.lin@rock-chips.com
Subject: Re: [GIT PULL] PCI changes for v4.18, part 2
Message-ID: <20180612222718.GA96078@bhelgaas-glaptop.roam.corp.google.com>
References: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:08:53PM -0700, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 2:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   - squash AER directory into drivers/pci/pcie/aer.c (Bjorn Helgaas)
> 
> Could we please see *reasons* for this series of commits?
> 
> Those commit messages have trivial "what", but no explanations "why".

Sure, I'll update that branch and send a new pull request.
