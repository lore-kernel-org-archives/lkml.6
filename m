Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeEZEDM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 00:03:12 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35661 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeEZEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 00:03:10 -0400
X-Google-Smtp-Source: ADUXVKK3xe6haGVShqKYe/0q2/E+PvIwlYCID59VtfgPaZ1T8g1cIUjCZFT0VL1FlanFBtV9NdiIzw==
Subject: Re: linux-next: Signed-off-by missing for commits in the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
References: <20180526135004.00b19986@canb.auug.org.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fc204457-1e79-131b-d166-5fec6d0cc734@kernel.dk>
Date: Fri, 25 May 2018 22:03:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180526135004.00b19986@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/18 9:50 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> Commits
> 
>   287a63ebbe7c ("nvme: mark the result argument to nvme_complete_async_event volatile")
>   750dde4472e4 ("nvme-pci: simplify nvme_cqe_valid")
>   d1f06f4ae041 ("nvme-pci: move ->cq_vector == -1 check outside of ->q_lock")
>   1ab0cd6966fc ("nvme-pci: split the nvme queue lock into submission and completion locks")
>   1eae349d18fc ("nvme-pci: drop IRQ disabling on submission queue lock")
> 
> are missing a Signed-off-by from their committer.

Thanks for the heads up. Not a huge problem for these particular commits,

-- 
Jens Axboe
