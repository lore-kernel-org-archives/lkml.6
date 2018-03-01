Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967171AbeCAJzy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:55:54 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54045 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967092AbeCAJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:55:51 -0500
Subject: Re: [PATCH] ata: add Amiga Gayle PATA controller driver
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3@epcas2p3.samsung.com>
 <2188399.T539WJDZNr@amdc3058>
 <19df19ad-47e8-1f17-6b7f-39365cd0d4df@physik.fu-berlin.de>
Message-ID: <4c590675-71dc-d7f1-b40f-3b0ee124082a@physik.fu-berlin.de>
Date: Thu, 1 Mar 2018 10:55:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <19df19ad-47e8-1f17-6b7f-39365cd0d4df@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 160.45.32.140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02/18/2018 05:18 PM, John Paul Adrian Glaubitz wrote:
> Is there any progress on this? Is it just the SDPX headers now that
> are missing?

Would it be okay if re-send the patch with the SPDX headers added?

Or can we get the patch merged, then I'll send a patch to add the
SPDX headers?

Thanks,
Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
