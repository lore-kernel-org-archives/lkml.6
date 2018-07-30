Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5349C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFAC20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFAC20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeG3Nsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:48:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:38907 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbeG3Nsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:48:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 05:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="58990028"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2018 05:13:55 -0700
Received: from [10.252.212.58] (unknown [10.252.212.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 42BE458014B;
        Mon, 30 Jul 2018 05:13:54 -0700 (PDT)
Subject: Re: [PATCH] [RESEND] perf/x86/intel/uncore: Fix the index of PCU.3
 Broadwell CPUs
To:     Ingo Molnar <mingo@kernel.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     kan.liang@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        m.mizuma@jp.fujitsu.com
References: <20180710233158.21037-1-msys.mizuma@gmail.com>
 <20180715223444.GA16209@gmail.com>
 <7d97606b-67b6-4eb7-48ca-99250edc3fba@linux.intel.com>
 <376d5419-9ba5-ef5e-3089-f841fbb1772b@gmail.com>
 <55fd243f-7c3c-1a02-65d4-3fae3c540d50@linux.intel.com>
 <1677c9ca-a522-ae7e-6a1f-86c3767a35f8@gmail.com>
 <3aed5057-7328-90aa-3c35-7c143866aaf0@gmail.com>
 <20180730100648.GA16689@gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <7d0397c4-b701-7165-357e-5d58b18a16ce@linux.intel.com>
Date:   Mon, 30 Jul 2018 08:13:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730100648.GA16689@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2018 6:06 AM, Ingo Molnar wrote:
> 
> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
>> Hi Ingo,
>>
>> Is the following Kan's patch ready to merge...?
> 
> Looks good at first sight - but it was whitespace damaged here so I couldn't apply it.
> 
> Kan, mind re-sending it properly as a standalone patch, with Masayoshi's Reported-by, Debugged-by and Tested-by
> tags added?
> 

Sure, I will re-send the patch.

Thanks,
Kan
