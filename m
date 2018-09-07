Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6367C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840A320857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840A320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeIGG4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:56:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:22361 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbeIGG4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:56:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 19:18:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="71018280"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.13])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2018 19:17:58 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-kernel@vger.kernel.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, <alex.kogan@oracle.com>,
        <akpm@linux-foundation.org>, <boqun.feng@gmail.com>,
        <brouer@redhat.com>, <dave@stgolabs.net>, <dave.dice@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>, <ktkhai@virtuozzo.com>,
        <ldufour@linux.vnet.ibm.com>, <Pavel.Tatashin@microsoft.com>,
        <paulmck@linux.vnet.ibm.com>, <shady.issa@oracle.com>,
        <tariqt@mellanox.com>, <tglx@linutronix.de>,
        <tim.c.chen@intel.com>, <vbabka@suse.cz>, <longman@redhat.com>,
        <yang.shi@linux.alibaba.com>, <shy828301@gmail.com>,
        <subhra.mazumdar@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        <jwadams@google.com>, <ashwinch@google.com>, <sqazi@google.com>,
        Shakeel Butt <shakeelb@google.com>, <walken@google.com>,
        <rientjes@google.com>, <junaids@google.com>,
        Neha Agarwal <nehaagarwal@google.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
        <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
        <877ejzqtdy.fsf@yhuang-dev.intel.com>
        <01000165af54d553-33f33ce2-7b36-4d67-a928-e53b10247e1d-000000@email.amazonses.com>
Date:   Fri, 07 Sep 2018 10:17:57 +0800
In-Reply-To: <01000165af54d553-33f33ce2-7b36-4d67-a928-e53b10247e1d-000000@email.amazonses.com>
        (Christopher Lameter's message of "Thu, 6 Sep 2018 14:41:37 +0000")
Message-ID: <87d0tqoxt6.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Lameter <cl@linux.com> writes:

> On Thu, 6 Sep 2018, Huang, Ying wrote:
>
>> > Certainly interested in attending but this overlaps supercomputing 2018 in
>> > Dallas Texas...
>>
>> Sorry to know this.  It appears that there are too many conferences in
>> November...
>
>  I will try to get to it in the middle of SC18, RDMA track and RISC V
> track... Sign me up.

Great to know this!  Looking forward to meet you in the microconference.

Best Regards,
Huang, Ying
