Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeCZTbr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:31:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeCZTbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:31:46 -0400
Date: Mon, 26 Mar 2018 21:30:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 1/2] Revert "x86/mce/AMD: Collect error info even if
 valid bits are not set"
Message-ID: <20180326193052.GJ25548@pd.tnic>
References: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326191526.64314-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 02:15:25PM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> This reverts commit 4b1e84276a6172980c5bf39aa091ba13e90d6dad.
> 
> Software uses the valid bits to decide if the values can be used for
> further processing or other actions. So setting the valid bits will have
> software act on values that it shouldn't be acting on.
> 
> The recommendation to save all the register values does not mean that
> the values are always valid.

So what does that

"Error handlers should save the values in MCA_ADDR, MCA_MISC0,
and MCA_SYND even if MCA_STATUS[AddrV], MCA_STATUS[MiscV], and
MCA_STATUS[SyndV] are zero."

*actually* mean then?

It is still in the PPR.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
