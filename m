Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750950AbeELJ6r (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 05:58:47 -0400
Received: from verein.lst.de ([213.95.11.211]:56416 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeELJ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 05:58:47 -0400
Date: Sat, 12 May 2018 12:02:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] swiotlb: Silent unwanted warning "buffer is full"
Message-ID: <20180512100240.GA5703@lst.de>
References: <20180503235446.6a3d3118@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503235446.6a3d3118@endymion>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

I manually applied this for 4.17-rc, as the mail unfortunately was
garbled.
