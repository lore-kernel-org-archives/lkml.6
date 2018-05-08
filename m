Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933079AbeEHQr2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:47:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:18669 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932634AbeEHQr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:47:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39658497"
Subject: Re: [PATCH 8/8] mm/pkeys, x86, powerpc: Display pkey in smaps if arch
 supports pkeys
To: Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-9-mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <cd58dbfe-55f9-bb9a-d907-0f92740a8c2e@intel.com>
Date: Tue, 8 May 2018 09:47:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508145948.9492-9-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 07:59 AM, Michael Ellerman wrote:
> Currently the architecture specific code is expected to display the
> protection keys in smap for a given vma. This can lead to redundant
> code and possibly to divergent formats in which the key gets
> displayed.
> 
> This patch changes the implementation. It displays the pkey only if
> the architecture support pkeys, i.e arch_pkeys_enabled() returns true.


For this, along with 6/8 and 7/8:

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
