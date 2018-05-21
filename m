Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeEUKD2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:03:28 -0400
Received: from ozlabs.org ([203.11.71.1]:56061 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752879AbeEUKB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:01:28 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e4f2419fac381c5a7659834169dbe79659da2d0d
In-Reply-To: <20170803125934.14960-1-peda@axentia.se>
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Peter Rosin <peda@axentia.se>
Subject: Re: powerpc/fsl/dts: fix the i2c-mux compatible for t104xqds
Message-Id: <40qDnX3tdWz9s33@ozlabs.org>
Date: Mon, 21 May 2018 20:01:20 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2017-08-03 at 12:59:34 UTC, Peter Rosin wrote:
> The sanctioned compatible is "nxp,pca9547".
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4f2419fac381c5a7659834169dbe7

cheers
