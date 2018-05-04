Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeEDCYC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:24:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751340AbeEDCX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:23:59 -0400
Date: Fri, 4 May 2018 10:23:52 +0800
From: Peter Xu <peterx@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>
Subject: Re: [PATCH v2 2/3] intel-iommu: generalize __mapping_notify_one()
Message-ID: <20180504022352.GK29580@xz-mi>
References: <20180418083953.21492-1-peterx@redhat.com>
 <20180418083953.21492-3-peterx@redhat.com>
 <20180503131424.jsn4qvfuwur7adcb@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503131424.jsn4qvfuwur7adcb@8bytes.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 03:14:24PM +0200, Joerg Roedel wrote:
> On Wed, Apr 18, 2018 at 04:39:52PM +0800, Peter Xu wrote:
> > Generalize this new helper to notify one newly created mapping on one
> > single IOMMU.  We can further leverage this helper in the next patch.
> 
> You introduce the function, you do not generalize it. Please fix that in
> the subject and description.
> 
> Also, please drop patch 1, I don't like this pr_debug stuff in the
> code. And please also fix the subject line in general to match the form:
> 
> 	iommu/vt-d: _I_ntroduce __mapping_notify_one()
> 
> When that is done, please re-send.

Will do.  Thanks, Joerg.

-- 
Peter Xu
