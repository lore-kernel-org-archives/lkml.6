Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933511AbeEIB5K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:57:10 -0400
Received: from ozlabs.org ([203.11.71.1]:55427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933185AbeEIB5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:57:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Hansen <dave.hansen@intel.com>, linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] mm/pkeys, x86, powerpc: Display pkey in smaps if arch supports pkeys
In-Reply-To: <cd58dbfe-55f9-bb9a-d907-0f92740a8c2e@intel.com>
References: <20180508145948.9492-1-mpe@ellerman.id.au> <20180508145948.9492-9-mpe@ellerman.id.au> <cd58dbfe-55f9-bb9a-d907-0f92740a8c2e@intel.com>
Date: Wed, 09 May 2018 11:57:08 +1000
Message-ID: <87lgctzj4b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 05/08/2018 07:59 AM, Michael Ellerman wrote:
>> Currently the architecture specific code is expected to display the
>> protection keys in smap for a given vma. This can lead to redundant
>> code and possibly to divergent formats in which the key gets
>> displayed.
>> 
>> This patch changes the implementation. It displays the pkey only if
>> the architecture support pkeys, i.e arch_pkeys_enabled() returns true.
>
>
> For this, along with 6/8 and 7/8:
>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>

Thanks for reviewing them all.

cheers
