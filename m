Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeECN1G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:27:06 -0400
Received: from 8bytes.org ([81.169.241.247]:54626 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECN1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:27:02 -0400
Date: Thu, 3 May 2018 15:27:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: changbin.du@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: fix shift-out-of-bounds in bug checking
Message-ID: <20180503132700.djfqox2gokzqybct@8bytes.org>
References: <1524202195-4656-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524202195-4656-1-git-send-email-changbin.du@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 01:29:55PM +0800, changbin.du@intel.com wrote:
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  drivers/iommu/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied and put a patch on-top to change the BUG_ON to a WARN_ON_ONCE.
