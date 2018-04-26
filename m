Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756891AbeDZSRK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:17:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:46053 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754014AbeDZSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:17:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,331,1520924400";
   d="scan'208";a="51087925"
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from
 PROT_EXEC
To: Thomas Gleixner <tglx@linutronix.de>,
        Shakeel Butt <shakeelb@google.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172727.025EBF16@viggo.jf.intel.com>
 <CALvZod5NTauM6MHW7D=h0mTDNYFd-1QyWrOxnhiixCgtHP=Taw@mail.gmail.com>
 <alpine.DEB.2.21.1804261054540.1584@nanos.tec.linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        stable@kernel.org, linuxram@us.ibm.com, mpe@ellerman.id.au,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <e42df34f-3711-df42-55a9-61b147f17dce@intel.com>
Date: Thu, 26 Apr 2018 11:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804261054540.1584@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 01:55 AM, Thomas Gleixner wrote:
>> Hi Dave, are you planning to send the next version of this patch or
>> going with this one?
> Right, some enlightment would be appreciated. I'm lost in the dozen
> different threads discussing this back and forth.

Shakeel, thanks for the reminder!

I'll send an updated set.  I got lost myself and thought this had been
picked up.

There were a few minor comments on the [v2] set that I've addressed.
I'll also check with Ram to make sure he's OK with this on ppc.  We had
some dueling patches at some point.
