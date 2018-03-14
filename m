Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCNJ1m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:27:42 -0400
Received: from ozlabs.org ([103.22.144.67]:38471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeCNJ1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:41 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1373cc31074dff09419d616c2ce911eea624cff5
In-Reply-To: <1513732229-10066-2-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [1/1] vas: vas_window_init_dbgdir: fix order of cleanup.
Message-Id: <401RG31qd3z9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:38 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2017-12-20 at 01:10:29 UTC, Sukadev Bhattiprolu wrote:
> Fix the order of cleanup to ensure we free the name buffer in case
> of an error creating 'hvwc' or 'info' files.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1373cc31074dff09419d616c2ce911

cheers
