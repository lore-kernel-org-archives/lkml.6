Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeECMkO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:40:14 -0400
Received: from 8bytes.org ([81.169.241.247]:54106 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbeECMkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:40:12 -0400
Date: Thu, 3 May 2018 14:40:10 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCHv4 1/2] iommu/vt-d: Ratelimit each dmar fault printing
Message-ID: <20180503124010.n73opdv2k7qrpfoo@8bytes.org>
References: <20180331003312.6390-1-dima@arista.com>
 <1525227744.14025.6.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525227744.14025.6.camel@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 03:22:24AM +0100, Dmitry Safonov wrote:
> Hi Joerg,
> 
> is there anything I may do about those two patches?
> In 2/2 I've limited loop cnt as discussed in v3.
> This one solves softlockup for us, might be useful.

Applied the first patch, thanks. Please re-work the second one according
to the comments.


Thanks,

	Joerg
