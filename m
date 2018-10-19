Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B041ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C202083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C202083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeJSXrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:47:06 -0400
Received: from mail5.windriver.com ([192.103.53.11]:41602 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeJSXrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:47:06 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w9JFb9AZ005141
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 19 Oct 2018 08:37:19 -0700
Received: from [128.224.162.232] (128.224.162.232) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Oct 2018
 08:36:58 -0700
Subject: Re: [PATCH V2] perf arm64: Fix generate system call table failed with
 /tmp mounted with noexec
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        =?UTF-8?Q?S=c3=a9bastien_Boisvert?= <sboisvert@gydle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kim.phillips@arm.com>, <brueckner@linux.ibm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <mpe@ellerman.id.au>, <peterz@infradead.org>,
        <ravi.bangoria@linux.vnet.ibm.com>, <tmricht@linux.vnet.ibm.com>,
        <namhyung@kernel.org>
References: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
 <1539915379-11910-1-git-send-email-hongxu.jia@windriver.com>
 <9da3ccbf-ec36-c676-7472-fe7d642cd7e0@gydle.com>
 <20181019153000.GC5565@redhat.com>
From:   Hongxu Jia <hongxu.jia@windriver.com>
Message-ID: <68f6a3b7-9dfe-3ed0-7582-5fc923b2d56b@windriver.com>
Date:   Fri, 19 Oct 2018 23:36:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019153000.GC5565@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/19 下午11:30, Arnaldo Carvalho de Melo wrote:
> Exactly.
>
> So, to move forward, just send a new patch specifically for this part,
> i.e. the removal of the harmless but unneeded extra slash, the other
> part I already took care of.

Got it, I will send a new patch for the removal of the harmless

Thank a huge for all your guys to help me to improve commit message.

//Hongxu


>
> - Arnaldo
>   


