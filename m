Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeFDKdC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:33:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41362 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeFDKdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:33:01 -0400
Date: Mon, 4 Jun 2018 11:33:32 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 0/5] Fix issues with huge mapping in ioremap for ARM64
Message-ID: <20180604103332.GF9482@arm.com>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1a648674-da56-6664-bf3c-0cdf825ad1e3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a648674-da56-6664-bf3c-0cdf825ad1e3@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chintan,

On Mon, Jun 04, 2018 at 11:26:28AM +0530, Chintan Pandya wrote:
> Just curious to know, is there anything that I should be addressing
> in these patches ? For now, I don't see anything from my side that
> requires modification, unless one has some more review comments on
> this.
> 
> Status so far on and around this:
>  - Status of Toshi's series of patches is still not clear to me.
>    However, if this series can get through first, there won't
>    be conflicting scenarios as far as arm64 is concerned.
>  - I've rebased these patches on tip
>  - Also re-tested these patches for long duration tests with
>    1 GB mapping case also exercised enough. Test ended positively.

I'll try to review this version today.

Will
