Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDOJb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:09:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34063 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeDDOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:09:30 -0400
Date: Wed, 4 Apr 2018 16:09:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: olpc: fix inconsistent MFD_CS5535 configuration
In-Reply-To: <20180404124539.3817101-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1804041608150.2056@nanos.tec.linutronix.de>
References: <20180404124539.3817101-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018, Arnd Bergmann wrote:

> This Kconfig warning appeared after a fix to the Kconfig validation.
> The GPIO_CS5535 driver depends on the MFD_CS5535 driver, but the former
> is selected in places where the latter is not:

And why does GPIO_CS5535 not select MFD_CS5535 if it depends on it?

Thanks,

	tglx
