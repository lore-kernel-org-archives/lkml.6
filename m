Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeCNJ1o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:27:44 -0400
Received: from ozlabs.org ([103.22.144.67]:40621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCNJ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:42 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2f65272a2a304ec6aa32ad9a45b1506929406321
In-Reply-To: <1516157443-17716-2-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
        linux-kernel@vger.kernel.org
Subject: Re: [1/5] powerpc/vas: Remove a stray line in Makefile
Message-Id: <401RG43HWbz9sVQ@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:39 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-17 at 02:50:39 UTC, Sukadev Bhattiprolu wrote:
> Remove a bogus line from arch/powerpc/platforms/powernv/Makefile that
> was added by commit ece4e51 ("powerpc/vas: Export HVWC to debugfs").
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2f65272a2a304ec6aa32ad9a45b150

cheers
