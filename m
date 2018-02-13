Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933235AbeBMBoQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:44:16 -0500
Received: from verein.lst.de ([213.95.11.211]:42721 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933083AbeBMBoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:44:14 -0500
Date: Tue, 13 Feb 2018 02:44:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] ia64: Remove pci-swiotlb.o from kernel Makefile
Message-ID: <20180213014412.GA3303@lst.de>
References: <1518474733-2972-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518474733-2972-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Guenter,

I actually got a similar report a few days ago and prepared the same
patch as part of the dma-mapping fixup series I'm about to send out:

	http://git.infradead.org/users/hch/misc.git/commitdiff/f9f787e3fe227329d27768566e925e4d94c5f517
