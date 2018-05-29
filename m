Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936942AbeE2PpB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:45:01 -0400
Received: from foss.arm.com ([217.140.101.70]:43566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935434AbeE2Poz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:44:55 -0400
Date: Tue, 29 May 2018 16:45:24 +0100
From: Will Deacon <will.deacon@arm.com>
To: nixiaoming <nixiaoming@huawei.com>
Cc: catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com,
        steve.capper@arm.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, zhang.jia@linux.alibaba.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Message-ID: <20180529154523.GK17159@arm.com>
References: <20180529133615.26889-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529133615.26889-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:36:15PM +0800, nixiaoming wrote:
> mark_rodata_ro is only called by the function mark_readonly when
> CONFIG_STRICT_KERNEL_RWX=y,
> if CONFIG_STRICT_KERNEL_RWX is not set
> a compile warning may be triggered: unused function

How are you achieving this configuration? In our Kconfig we select this
unconditionally.

Will
