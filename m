Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeBUX67 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:58:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45910 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBUX66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:58:58 -0500
Subject: Re: mmotm 2018-02-21-14-48 uploaded (mm/page_alloc.c on UML)
To: akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        richard -rw- weinberger <richard.weinberger@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
References: <20180221224839.MqsDtkGCK%akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7bcc52db-57eb-45b0-7f20-c93a968599cd@infradead.org>
Date: Wed, 21 Feb 2018 15:58:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221224839.MqsDtkGCK%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 02:48 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-02-21-14-48 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (4.x
> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

um (or uml) defconfig on i386 and/or x86_64:

../mm/page_alloc.c: In function 'memmap_init_zone':
../mm/page_alloc.c:5450:5: error: implicit declaration of function 'memblock_next_valid_pfn' [-Werror=implicit-function-declaration]
     pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
     ^


probably (?):
From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: mm: page_alloc: skip over regions of invalid pfns on UMA


-- 
~Randy
