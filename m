Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758794AbeD0Qze (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:55:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43758 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757569AbeD0Qzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:55:33 -0400
Date: Fri, 27 Apr 2018 17:55:53 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chandan Vn <vn.chandan@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, CHANDAN VN <chandan.vn@samsung.com>,
        catalin.marinas@arm.com, Takahiro Akashi <takahiro.akashi@linaro.org>,
        james.morse@arm.com, robin.murphy@arm.com, steve.capper@arm.com,
        kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH 1/1] arm64: To remove initrd reserved area entry from
 memblock
Message-ID: <20180427165552.GC5286@arm.com>
References: <CGME20180406045340epcas1p1ae6416dc25823212303c9109d125c018@epcas1p1.samsung.com>
 <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
 <ff125919-66f7-6658-e9b1-817188c1bdd9@redhat.com>
 <CADYJ94eQyN7dtnnVN_AF0VixaJh3x52068xYtq54hsS4BpdwFg@mail.gmail.com>
 <CADYJ94e=gFhSF+tQ-1f0Dy61urHjG=UNoWYPq7bsT+-VTR1nDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYJ94e=gFhSF+tQ-1f0Dy61urHjG=UNoWYPq7bsT+-VTR1nDw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:30:49AM +0530, Chandan Vn wrote:
> May I know when this patch would be taken for merging?

Please can you send a new version, stating in the commit message that
this only affects accountinga and debugging, rather than plugging an
actual memory leak?

Cheers,

Will
