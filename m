Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0482C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EDC26800
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EDC26800
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeF0D2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:28:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:36894 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeF0D2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:28:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5R3Rb7C002154;
        Tue, 26 Jun 2018 22:27:39 -0500
Message-ID: <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org
Cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Jun 2018 13:27:37 +1000
In-Reply-To: <874lhp6i4d.fsf@concordia.ellerman.id.au>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
         <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
         <874lhp6i4d.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
> > I will rewrite patch 10/12 after Arnd's fixes and this series have all 
> > made their way through both powerpc and m68k trees, and submit it 
> > separately.
> 
> drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
> series is high on his todo list.

We need at least to pull out a couple of powerbooks we have sitting in
drawers and try it out.

> 
> Should it just go in via the m68k tree?
> 
> Or I can create a topic branch to share it between ppc and m68k?
