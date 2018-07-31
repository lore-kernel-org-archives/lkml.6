Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D97620894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D97620894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeGaUpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:45:25 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:59396 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbeGaUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:45:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B3F2F6094C2D;
        Tue, 31 Jul 2018 21:03:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VaWMBoIbrC8u; Tue, 31 Jul 2018 21:03:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5ED426094C3B;
        Tue, 31 Jul 2018 21:03:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Go7DfuaqUNHy; Tue, 31 Jul 2018 21:03:42 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 2F1996094C2D;
        Tue, 31 Jul 2018 21:03:42 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Michal Hocko <mhocko@kernel.org>,
        linux-um@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] um: switch to NO_BOOTMEM
Date:   Tue, 31 Jul 2018 21:03:35 +0200
Message-ID: <1574741.Uvo42kyWiX@blindfold>
In-Reply-To: <20180731133827.GC23494@rapoport-lnx>
References: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com> <20180731133827.GC23494@rapoport-lnx>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Juli 2018, 15:38:27 CEST schrieb Mike Rapoport:
> Any comments on this?
> 
> On Tue, Jul 24, 2018 at 04:23:12PM +0300, Mike Rapoport wrote:
> > Hi,
> > 
> > These patches convert UML to use NO_BOOTMEM.
> > Tested on x86-64.
> > 
> > Mike Rapoport (2):
> >   um: setup_physmem: stop using global variables
> >   um: switch to NO_BOOTMEM
> > 
> >  arch/um/Kconfig.common   |  2 ++
> >  arch/um/kernel/physmem.c | 22 ++++++++++------------
> >  2 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

