Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeEHQpF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:45:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:43944 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932815AbeEHQpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:45:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39658122"
Subject: Re: [PATCH 4/8] mm/pkeys, powerpc, x86: Provide an empty vma_pkey()
 in linux/pkeys.h
To: Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-5-mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <1a37801a-fde1-53a3-0082-735834d1e9a4@intel.com>
Date: Tue, 8 May 2018 09:45:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508145948.9492-5-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 07:59 AM, Michael Ellerman wrote:
> Consolidate the pkey handling by providing a common empty definition
> of vma_pkey() in pkeys.h when CONFIG_ARCH_HAS_PKEYS=n.
> 
> This also removes another entanglement of pkeys.h and
> asm/mmu_context.h.

Looks fine to me.  Thanks for consolidating these.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
