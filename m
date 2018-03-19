Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032585AbeCSWXz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:23:55 -0400
Received: from ozlabs.org ([103.22.144.67]:42403 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933893AbeCSWWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:22:53 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 45ddea8a73a25461387eb8e87f3e0ecca084799b
In-Reply-To: <20180213195327.GA10678@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
        linux-kernel@vger.kernel.org
Subject: Re: Fix cleanup when VAS is not configured
Message-Id: <404rDC6Q1Mz9sWB@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:50 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-13 at 19:53:27 UTC, Sukadev Bhattiprolu wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Fri, 9 Feb 2018 11:49:06 -0600
> Subject: [PATCH 1/1] powerpc/vas: Fix cleanup when VAS is not configured
> 
> When VAS is not configured, unregister the platform driver. Also simplify
> cleanup by delaying vas debugfs init until we know VAS is configured.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45ddea8a73a25461387eb8e87f3e0e

cheers
