Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486420020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E486420020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967018AbeFSRHC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:07:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:50172 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966695AbeFSRHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:07:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 10:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48296064"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.129]) ([10.24.14.129])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 10:06:58 -0700
Subject: Re: [PATCH V5 00/38] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1527593970.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1806191853510.10546@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <85f6cdc2-e801-2def-def8-112be862b3a7@intel.com>
Date:   Tue, 19 Jun 2018 10:06:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806191853510.10546@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/19/2018 9:57 AM, Thomas Gleixner wrote:
> On Tue, 29 May 2018, Reinette Chatre wrote:
>>
>> The last patch of this series depends on the series:
>> "[RFC PATCH 0/3] Interface for higher order contiguous allocations"
>> submitted at:
>> http://lkml.kernel.org/r/20180212222056.9735-1-mike.kravetz@oracle.com
>> A new version of this was submitted recently and currently being discussed
>> at:
>> http://lkml.kernel.org/r/20180417020915.11786-1-mike.kravetz@oracle.com
>> Without this upstream MM work (and patch 39/39 of this series) it would
> 
> There are only 38 patches and none which might depend on Mikes work :)

I am sorry for adding confusion by keeping the changelog from previous
versions with each new submission. v3 had 39 patches with the last patch
depending on Mike's work. I removed that final patch in v4, planning to
resubmit it when Mike's work has been merged since it seems the API I
used may change.

> So the whole thing is self contained and just limited to 4MB, right?

Correct.

Reinette

