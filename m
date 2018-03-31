Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeCaODr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 10:03:47 -0400
Received: from ozlabs.org ([103.22.144.67]:40783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbeCaODq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 10:03:46 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7ab96c0a083f3a298ae595ea142058a20c6e34f6
In-Reply-To: <20180206123707.13715-1-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: powerpc: wii: Probe the whole devicetree
Message-Id: <40D0Zm3JrXz9s2R@ozlabs.org>
Date: Sun,  1 Apr 2018 01:03:44 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 12:37:04 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> Previously, wii_device_probe would only initialize devices under the
> /hollywood node. After this patch, platform devices placed outside of
> /hollywood will also be initialized.
> 
> The intended usecase for this are devices located outside of the
> Hollywood chip, such as GPIO LEDs and GPIO buttons.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7ab96c0a083f3a298ae595ea142058

cheers
