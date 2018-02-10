Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeBJIj7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 03:39:59 -0500
Received: from verein.lst.de ([213.95.11.211]:60699 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeBJIj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:39:58 -0500
Date: Sat, 10 Feb 2018 09:39:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, hch@lst.de,
        christian.koenig@amd.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: fix build failure with CONFIG_SWIOTLB
Message-ID: <20180210083956.GA27696@lst.de>
References: <1518118760-5224-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518118760-5224-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I'll send this along to Linus with other dma-mapping fixes.
