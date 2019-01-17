Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55131C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9BF20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfAQT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:26:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4525 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfAQT0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:26:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 260733F734;
        Thu, 17 Jan 2019 19:26:19 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F31995C8B8;
        Thu, 17 Jan 2019 19:26:12 +0000 (UTC)
Date:   Thu, 17 Jan 2019 14:26:10 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
Message-ID: <20190117192610.tswga6xweyt42hmq@madcap2.tricolour.ca>
References: <cover.1544477629.git.rgb@redhat.com>
 <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
 <20190117103255.1f640a42@ivy-bridge>
 <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
 <20190117170815.40131a69@ivy-bridge>
 <CAHC9VhQqT9HW=m5_sbru2Q7HoJC6oSrzMzrkRxgeDB7sWFLA-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQqT9HW=m5_sbru2Q7HoJC6oSrzMzrkRxgeDB7sWFLA-A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 17 Jan 2019 19:26:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-17 12:36, Paul Moore wrote:
> On Thu, Jan 17, 2019 at 11:08 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Thu, 17 Jan 2019 08:21:40 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > On Mon, 14 Jan 2019 17:58:58 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > Tie syscall information to all CONFIG_CHANGE calls since they
> > > > > > are all a result of user actions.

> I see you added LKML to the To/CC line.  Fun.  Unless they've been
> following the audit list for the past several years I'm not sure they
> have all the context to fully understand some of the things in this
> thread, but sure, why not.

I added LKML in the original patchset posting, not Steve.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
