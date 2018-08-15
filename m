Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904ECC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4998E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4998E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeHOWHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:07:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeHOWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:07:49 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C967425A;
        Wed, 15 Aug 2018 19:14:22 +0000 (UTC)
Date:   Wed, 15 Aug 2018 21:14:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Sven Joachim <svenjoac@gmx.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815191418.GD23260@kroah.com>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 08:27:00PM +0200, Sebastian Gottschall wrote:
> if i fix the other error (can be reproduced with disable smp on standard
> i386 build)
> 
> another raises up again related to smp. to be serious. this patchset of x86
> patches is absolutelly broken and put together without any care. not a
> simple compile test has been done

That's just not true at all.  Gift horse, mouth.

> sorry for beeing a little bit upset. i'm sure i will find other bugs if i go
> deeper

Testing is always great to have.  Perhaps just move to 4.14.y or Linus's
tree if 4.9 does not work for you?  THere's only so much testing we
could do before the embargo, sorry.  We are very lucky to even have
these patches for 4.9 in the first place.

thanks,

greg k-h
