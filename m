Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755537AbeEHQpu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:45:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:36865 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932815AbeEHQpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:45:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39658243"
Subject: Re: [PATCH 5/8] x86/pkeys: Move vma_pkey() into asm/pkeys.h
To: Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-6-mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <f9240079-2ff2-9d3f-ba15-fefe65c67779@intel.com>
Date: Tue, 8 May 2018 09:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508145948.9492-6-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 07:59 AM, Michael Ellerman wrote:
> Move the last remaining pkey helper, vma_pkey() into asm/pkeys.h

Fine with me, as long as it compiles. :)

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
