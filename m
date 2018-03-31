Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753249AbeCaOER (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:04:17 -0400
Received: from ozlabs.org ([103.22.144.67]:59577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753197AbeCaOEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:04:15 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3a52f6f980c45b0dfa667f30d3ff034d033d260f
In-Reply-To: <alpine.LNX.2.21.1803291117110.30@nippy.intranet>
To: Finn Thain <fthain@telegraphics.com.au>,
        Jiri Kosina <trivial@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: macintosh/adb: Use C99 initializers for struct adb_driver instances
Message-Id: <40D0bK43kZz9s44@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:12 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-29 at 00:36:04 UTC, Finn Thain wrote:
> No change to object files.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3a52f6f980c45b0dfa667f30d3ff03

cheers
