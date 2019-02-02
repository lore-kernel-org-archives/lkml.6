Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076392146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfBBKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:34:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfBBKek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:34:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EF43C7C39;
        Sat,  2 Feb 2019 10:34:39 +0000 (UTC)
Received: from krava (ovpn-204-77.brq.redhat.com [10.40.204.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0FE2A5D9CC;
        Sat,  2 Feb 2019 10:34:36 +0000 (UTC)
Date:   Sat, 2 Feb 2019 11:34:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Message-ID: <20190202103435.GA7240@krava>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava>
 <20190131082711.GC24233@krava>
 <20190201074353.GA8778@krava>
 <4e816b25-1763-ec23-0642-19e6258e6ac5@linux.ibm.com>
 <a95f952c-ed3b-4838-315b-45f758398894@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95f952c-ed3b-4838-315b-45f758398894@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 02 Feb 2019 10:34:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 08:54:35AM +0530, Ravi Bangoria wrote:
> 
> 
> On 2/1/19 1:24 PM, Ravi Bangoria wrote:
> > I ran fuzzer for couple of hours but I didn't see any crash with
> > your previous patch.
> > 
> > I'll try this newer one as well.
> 
> I ran fuzzer for ~8 hrs and no lockup so far.

yep looks good, mine's running for 2 days now
I'll put together some changelog and send it proper patch

jirka
