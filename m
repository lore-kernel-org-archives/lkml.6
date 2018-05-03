Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeECQMF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:12:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34046 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:12:04 -0400
X-Google-Smtp-Source: AB8JxZpgmvtOUNPK8or/AuQF6sSXeV9suFu4TYTbFlIC9b2uJKcAtNOSgEACpCuKl6tt98vfPytIaA==
Message-ID: <1525363921.14025.39.camel@arista.com>
Subject: Re: [PATCHv4 1/2] iommu/vt-d: Ratelimit each dmar fault printing
From: Dmitry Safonov <dima@arista.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Date: Thu, 03 May 2018 17:12:01 +0100
In-Reply-To: <20180503124010.n73opdv2k7qrpfoo@8bytes.org>
References: <20180331003312.6390-1-dima@arista.com>
         <1525227744.14025.6.camel@arista.com>
         <20180503124010.n73opdv2k7qrpfoo@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 14:40 +0200, Joerg Roedel wrote:
> On Wed, May 02, 2018 at 03:22:24AM +0100, Dmitry Safonov wrote:
> > Hi Joerg,
> > 
> > is there anything I may do about those two patches?
> > In 2/2 I've limited loop cnt as discussed in v3.
> > This one solves softlockup for us, might be useful.
> 
> Applied the first patch, thanks. Please re-work the second one
> according
> to the comments.

Will do.

-- 
Thanks,
             Dmitry
