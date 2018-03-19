Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032559AbeCSWXG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:23:06 -0400
Received: from ozlabs.org ([103.22.144.67]:42923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032544AbeCSWXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:23:02 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 890ae7979758568734881ad0f382c4064e2386c3
In-Reply-To: <20180221214633.2012-1-alexandre.belloni@bootlin.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/time: stop validating rtc_time in .read_time
Message-Id: <404rDL3m5Dz9sVZ@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:56 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-21 at 21:46:33 UTC, Alexandre Belloni wrote:
> The RTC core is always calling rtc_valid_tm after the read_time callback.
> It is not necessary to call it just before returning from the callback.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/890ae7979758568734881ad0f382c4

cheers
