Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032571AbeCSWXj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:23:39 -0400
Received: from ozlabs.org ([103.22.144.67]:41641 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933957AbeCSWW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:22:56 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7004263bd4f4c79da9ca2a1d04d38d4d6ed609ab
In-Reply-To: <20180216234323.27601-1-alexandre.belloni@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] powerpc/5200: dts: digsy_mtc.dts: fix rv3029 compatible
Message-Id: <404rDF3D4sz9sVl@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:52 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-16 at 23:43:23 UTC, Alexandre Belloni wrote:
> The proper compatible for rv3029 is microcrystal,rv3029.
> 
> Acked-by: Anatolij Gustschin <agust@denx.de>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7004263bd4f4c79da9ca2a1d04d38d

cheers
