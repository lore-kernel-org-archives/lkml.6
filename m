Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeCNJdl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:33:41 -0400
Received: from ozlabs.org ([103.22.144.67]:35901 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeCNJ1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:43 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 47d703e1d55f068c737c0c9f0c18f080fb08242b
In-Reply-To: <20180130142351.23511-1-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [v2] macintosh: Add module license to ans-lcd
Message-Id: <401RG55bn7z9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:41 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 14:23:51 UTC, Larry Finger wrote:
> In kernel 4.15, the modprobe step on my PowerBook G4 started complaining that
> there was no module license for ans-lcd.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/47d703e1d55f068c737c0c9f0c18f0

cheers
