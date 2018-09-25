Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4627EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047C420843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047C420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeIYRQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:16:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:57952 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbeIYRQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:16:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 04:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="73530196"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2018 04:09:56 -0700
Subject: Re: [PATCH 0/2] perf script python: Database export fixes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20180911114504.28516-1-adrian.hunter@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b7a7a61a-9b2b-5f93-9d12-01b52d6034e4@intel.com>
Date:   Tue, 25 Sep 2018 14:08:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911114504.28516-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/18 14:45, Adrian Hunter wrote:
> Hi
> 
> Here are a couple of database export fixes.
> 
> 
> Adrian Hunter (2):
>       perf script python: Fix export-to-postgresql.py occasional failure
>       perf script python: Fix export-to-sqlite.py sample columns
> 
>  tools/perf/scripts/python/export-to-postgresql.py | 9 +++++++++
>  tools/perf/scripts/python/export-to-sqlite.py     | 6 +++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)

Please consider these
