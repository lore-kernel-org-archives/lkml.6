Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbeELJBB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 05:01:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELJBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 05:01:00 -0400
Date: Sat, 12 May 2018 11:00:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org
Subject: Re: [RFC PATCH v4 1/3] EDAC, GHES: Remove unused argument to
 ghes_edac_report_mem_error
Message-ID: <20180512090033.GA27593@pd.tnic>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180430213358.8319-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 04:33:50PM -0500, Alexandru Gagniuc wrote:
> The use of the 'ghes' argument was removed in a previous commit, but
> function signature was not updated to reflect this.
> 
> Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  drivers/edac/ghes_edac.c | 3 +--
>  include/acpi/ghes.h      | 5 ++---
>  3 files changed, 4 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
