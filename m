Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934613AbeBMQAY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:00:24 -0500
Received: from 8bytes.org ([81.169.241.247]:40926 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933698AbeBMQAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:00:23 -0500
Date: Tue, 13 Feb 2018 17:00:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Hook, Gary" <ghook@amd.com>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
Message-ID: <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
 <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:47:55AM -0500, Hook, Gary wrote:
> 
>         dev_err(&iommu->dev->dev, "ILLEGAL...

I think its more something like iommu->iommu->dev.


	Joerg
