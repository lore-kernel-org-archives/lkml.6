Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeEPNix (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:38:53 -0400
Received: from ozlabs.org ([203.11.71.1]:53525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbeEPNiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:38:51 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 942cc40ae4354fee1e97137346434a2697d97e02
In-Reply-To: <20180510155439.16582-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: macintosh/windfarm: fix spelling mistake: "ttarged" -> "ttarget"
Message-Id: <40mFrn3sMLz9s3G@ozlabs.org>
Date: Wed, 16 May 2018 23:38:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 15:54:39 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in debug messages of a structure
> field name
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/942cc40ae4354fee1e97137346434a

cheers
