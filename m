Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEUKDH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:03:07 -0400
Received: from ozlabs.org ([203.11.71.1]:35527 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752885AbeEUKB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:01:27 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c068e6b8caa0c796535cb12f64767cc521b20508
In-Reply-To: <20180510215919.27808-2-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [1/2] powerpc: flipper-pic: Don't match all IRQ domains
Message-Id: <40qDnc0ywpz9s3Z@ozlabs.org>
Date: Mon, 21 May 2018 20:01:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 21:59:18 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> On the Wii, there is a secondary IRQ controller (hlwd-pic), so
> flipper-pic's match operation should not be hardcoded to return 1.
> In fact, the default matching logic is sufficient, and we can completely
> omit flipper_pic_match.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c068e6b8caa0c796535cb12f64767c

cheers
