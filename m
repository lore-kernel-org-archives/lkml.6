Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CE8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6B72086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6B72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeIKAWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:22:36 -0400
Received: from muru.com ([72.249.23.125]:55890 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbeIKAWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:22:36 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CFE4C80B6;
        Mon, 10 Sep 2018 19:31:06 +0000 (UTC)
Date:   Mon, 10 Sep 2018 12:26:58 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression in next with filesystem context concept
Message-ID: <20180910192658.GX5662@atomide.com>
References: <20180907161023.GF5662@atomide.com>
 <20180906164358.GI5659@atomide.com>
 <9053.1536310046@warthog.procyon.org.uk>
 <11959.1536420266@warthog.procyon.org.uk>
 <20180910160836.GT5662@atomide.com>
 <20180910183146.GA17726@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910183146.GA17726@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [180910 18:35]:
> On Mon, Sep 10, 2018 at 09:08:36AM -0700, Tony Lindgren wrote:
> > OK thanks for tracking that down, next-20180910 boots again
> > for me.
> > 
> 
> Did you try to shutdown and/or reboot ?
> 
> You might see something like the attached if you try.

Hmm not seeing that here with next-20180910 on ARM at least.

Regards,

Tony
