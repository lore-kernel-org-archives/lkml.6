Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbeBSWYD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:24:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:46789 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932130AbeBSWYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:24:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,537,1511856000";
   d="scan'208";a="19311349"
Subject: Re: [RFC PATCH V2 01/22] x86/intel_rdt: Documentation for Cache
 Pseudo-Locking
To: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <9416db57e47e2040a7108ba269f5432d0c91f1f7.1518443616.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1802192104210.1853@nanos.tec.linutronix.de>
 <ae0a9584-2b3c-4f8c-dc1e-cf7b82758254@intel.com>
 <alpine.DEB.2.21.1802192318540.1853@nanos.tec.linutronix.de>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cb4b07d9-9be5-4c8e-675b-a0fecbe9a7f3@intel.com>
Date: Mon, 19 Feb 2018 14:24:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802192318540.1853@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 2/19/2018 2:19 PM, Thomas Gleixner wrote:
>> It is required that the user space application self sets affinity to
>> cores associated with the cache. This is also highlighted in the example
>> application code (later in this patch) within the comments as well as
>> the example usage of sched_setaffinity(). The enforcement done in the
>> kernel code is done as a check that the user space application did so,
>> no the actual affinity management.
> 
> Right, but your documentation claims it's enforced. There is no enforcement
> aside of the initial sanity check.

I see the confusion. I will fix the documentation to clarify that it is
a sanity check.

Thank you

Reinette
