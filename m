Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6192C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC43C20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbeLTQ5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:57:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbeLTQ5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:57:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4E5B7F771;
        Thu, 20 Dec 2018 16:57:41 +0000 (UTC)
Received: from redhat.com (ovpn-123-95.rdu2.redhat.com [10.10.123.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D20A626FDC;
        Thu, 20 Dec 2018 16:57:40 +0000 (UTC)
Date:   Thu, 20 Dec 2018 11:57:38 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [HMM-v25 07/19] mm/ZONE_DEVICE: new type of ZONE_DEVICE for
 unaddressable memory v5
Message-ID: <20181220165738.GE3963@redhat.com>
References: <20170817000548.32038-1-jglisse@redhat.com>
 <20170817000548.32038-8-jglisse@redhat.com>
 <CAA9_cmeag7n4yeiP6pYZSz80KyxqfwbsXJCWvyNE4PSaxCKA3A@mail.gmail.com>
 <20181220161538.GA3963@redhat.com>
 <CAPcyv4ipg7smdCZTLeEogKdsKJGrCpaDKaghbTjrM8wkZDaoSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4ipg7smdCZTLeEogKdsKJGrCpaDKaghbTjrM8wkZDaoSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 20 Dec 2018 16:57:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:47:39AM -0800, Dan Williams wrote:
> On Thu, Dec 20, 2018 at 8:15 AM Jerome Glisse <jglisse@redhat.com> wrote:
> [..]
> > > Rather than try to figure out how to forward declare pmd_t, how about
> > > just move dev_page_fault_t out of the generic dev_pagemap and into the
> > > HMM specific container structure? This should be straightfoward on top
> > > of the recent refactor.
> >
> > Fine with me.
> 
> I was hoping you would reply with a patch. I'll take a look...

Bit busy right now but i can do that after new years :)

Cheers,
Jérôme
