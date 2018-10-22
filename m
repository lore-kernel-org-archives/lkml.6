Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7CECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119F8205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119F8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeJVRIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:08:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeJVRIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:08:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C25DC04B928;
        Mon, 22 Oct 2018 08:51:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id D23655C22D;
        Mon, 22 Oct 2018 08:51:06 +0000 (UTC)
Date:   Mon, 22 Oct 2018 10:51:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Thomas Renninger <trenn@suse.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCH 00/10] tools: Various build flags fixes
Message-ID: <20181022085106.GC2452@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <1915425.8MElBxF9G6@house>
 <afaa611b-a44d-70f8-9908-8bad14986db4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afaa611b-a44d-70f8-9908-8bad14986db4@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 22 Oct 2018 08:51:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:28:16AM -0600, Shuah Khan wrote:
> On 10/17/2018 07:23 AM, Thomas Renninger wrote:
> > On Tuesday, October 16, 2018 5:06:05 PM CEST Jiri Olsa wrote:
> >> hi,
> >> while hardening some of the tools rpm, we noticed we
> >> can't pass build flags to some of them.
> >>
> >> Sending separate tools fixes for what we found. It's
> >> mostly override for CFLAGS and adding LDFLAGS to the
> >> build commands.
> > 
> > Looks fine for the cpupower patches 3/10 and 4/10.
> > (Feel free to add a Reviewed-by or Acked-by for them
> > if you have to resend).
> > 
> 
> Thanks Thomas.
> 
> Hi Jiri,
> 
> Same here for cpupower patches 3/10 and 4/10. Please let me know
> if you would like me to take these through the cpupower patch flow.

that would be great, any idea about 5/10?:
  tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS

it's power related and I haven't got any reply on that one

thanks,
jirka
