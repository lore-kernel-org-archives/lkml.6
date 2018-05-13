Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeEMIfi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:35:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:43903 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeEMIfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:35:37 -0400
Date: Sun, 13 May 2018 10:35:34 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] swiotlb: Silent unwanted warning "buffer is full"
Message-ID: <20180513103534.0102b240@endymion>
In-Reply-To: <20180512100240.GA5703@lst.de>
References: <20180503235446.6a3d3118@endymion>
        <20180512100240.GA5703@lst.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2018 12:02:40 +0200, Christoph Hellwig wrote:
> Thanks.
> 
> I manually applied this for 4.17-rc, as the mail unfortunately was
> garbled.

Sorry about that. Because of the umlauts in the Cc list, the mail was
encoded as quoted-printable instead of 7bit. I guess this is what
caused the problem on your end.

You would think our tools are able to deal with accentuated characters
properly in 2018 but apparently not :-(

-- 
Jean Delvare
SUSE L3 Support
