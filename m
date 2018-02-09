Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBIPLg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:11:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:40287 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752046AbeBIPLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:11:34 -0500
Date: Fri, 9 Feb 2018 09:11:16 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Albert Herranz <albert_herranz@yahoo.es>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/4] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180209151116.GQ21977@gate.crashing.org>
References: <20180209120732.17863-1-j.neuschaefer@gmx.net> <20180209120732.17863-3-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180209120732.17863-3-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 01:07:29PM +0100, Jonathan Neuschäfer wrote:
> The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> that supports a configurable number of pins (up to 32), interrupts, and
> some special mechanisms to share the controller between the system's
> security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> not supported.
> 
> This patch adds a basic driver for this GPIO controller. Interrupt
> support will come in a later patch.
> 
> This patch is based on code developed by Albert Herranz and the GameCube
> Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> has grown quite dissimilar.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Cc: Albert Herranz <albert_herranz@yahoo.es>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Looks just fine to me :-)


Segher
