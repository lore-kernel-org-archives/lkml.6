Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A422C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5FF21532
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5FF21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbeHWOvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:35648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbeHWOvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:51:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B057AFCE;
        Thu, 23 Aug 2018 11:21:45 +0000 (UTC)
Subject: Re: [PATCH] AMD perf PMU events for AMD Family 17h.
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
To:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Martin Jambor <mjambor@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <3ee15066-429e-b0f2-1255-aab100fad472@suse.cz>
Message-ID: <fc049074-595e-92d7-5bab-bcd00f8493e2@suse.cz>
Date:   Thu, 23 Aug 2018 13:21:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3ee15066-429e-b0f2-1255-aab100fad472@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May I please ping this.

Thanks,
Martin

On 08/06/2018 10:42 AM, Martin Liška wrote:
> Hello.
> 
> Following patch adds PMC events for AMD Family 17 CPUs as defined in [1].
> It covers events described in section: 2.1.13. Regex pattern in mapfile.csv
> covers all CPUs of the family.
> 
> Thanks,
> Martin
> 
> [1] https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> 
> ---
>  .../pmu-events/arch/x86/amdfam17h/cache.json  | 332 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdfam17h/core.json   | 124 +++++++
>  .../arch/x86/amdfam17h/floating-point.json    | 196 +++++++++++
>  .../pmu-events/arch/x86/amdfam17h/memory.json | 225 ++++++++++++
>  .../pmu-events/arch/x86/amdfam17h/other.json  |  51 +++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
>  6 files changed, 929 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
> 
> 

