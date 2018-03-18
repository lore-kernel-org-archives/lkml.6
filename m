Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeCRAtx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 20:49:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:55052 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbeCRAtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 20:49:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,322,1517904000";
   d="scan'208";a="24934723"
Subject: Re: [PATCH 1/3] x86, pkeys: do not special case protection key 0
To: Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180316214654.895E24EC@viggo.jf.intel.com>
 <20180316214656.0E059008@viggo.jf.intel.com>
 <20180317232425.GH1060@ram.oc3035372033.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f3de330c-e0b4-2210-1a93-f0fb6b5a5b3c@intel.com>
Date: Sat, 17 Mar 2018 17:49:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317232425.GH1060@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/2018 04:24 PM, Ram Pai wrote:
> So the difference between the two proposals is just the freeing part i.e (b).
> Did I get this right?

Yeah, I think that's the only difference.
