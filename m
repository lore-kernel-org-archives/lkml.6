Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B37C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763B42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763B42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeGSMM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:12:26 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14828 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbeGSMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:12:25 -0400
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory, and
 IO v2
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
CC:     Daniel Drake <drake@endlessm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux@endlessm.com>, <linux-block@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, <kernel-team@fb.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180716155745.10368-1-drake@endlessm.com>
 <20180717112515.GE7193@dhcp22.suse.cz> <20180718222157.GG2838@cmpxchg.org>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <143db4db-2613-345d-9b8e-1794b6d8c4fe@sony.com>
Date:   Thu, 19 Jul 2018 13:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718222157.GG2838@cmpxchg.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 12:21 AM, Johannes Weiner wrote:
>
> Yes, we currently use a userspace application that monitors pressure
> and OOM kills (there is usually plenty of headroom left for a small
> application to run by the time quality of service for most workloads
> has already tanked to unacceptable levels). We want to eventually add
> this back into the kernel with the appropriate configuration options
> (pressure threshold value and sustained duration etc.)
Is that the same application as googles lmkd for android? Any source
that you might share?

