Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E680DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB2D2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfA2JEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:04:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfA2JEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:04:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 689045F;
        Tue, 29 Jan 2019 09:04:41 +0000 (UTC)
Received: from krava (ovpn-204-171.brq.redhat.com [10.40.204.171])
        by smtp.corp.redhat.com (Postfix) with SMTP id 687DA5C25D;
        Tue, 29 Jan 2019 09:04:39 +0000 (UTC)
Date:   Tue, 29 Jan 2019 10:04:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] Don't print sample_type bits in non-group events not set
 in the group's was Re: [PATCH] perf, script: Fix crash with printing mixed
 trace point and other events
Message-ID: <20190129090438.GA30190@krava>
References: <20190118094919.GA28346@krava>
 <20190118125920.GG5823@kernel.org>
 <20190118130106.GH5823@kernel.org>
 <20190118134205.GI5823@kernel.org>
 <20190118161000.GC28346@krava>
 <20190118161140.z45vl3milw2vk4hy@two.firstfloor.org>
 <20190119153745.GA19542@krava>
 <20190128141301.GA26788@krava>
 <20190128170037.sbayc3mve66krzzd@two.firstfloor.org>
 <20190129084851.GC4344@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129084851.GC4344@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 29 Jan 2019 09:04:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:48:51AM +0100, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 28, 2019 at 09:00:37AM -0800, Andi Kleen escreveu:
> > > > also now it won't make sample for slave events
> > > > with zero value/period read
> > > > 
> > > > note the patch needs to be split into more patches,
> > > > sending it all together for discussion over the solution
> > > 
> > > any feedback on this one?
> > 
> > Looks good to me.
> > 
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > -Andi
> 
> Jiri, can you repost with a proper Subject line, Andi's reviewed-by,
> etc?

yes, I need to separate that change also.. just wanted
some ack on the output ;-)

jirka
