Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbeCSIuN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:50:13 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:51526 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbeCSIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:50:11 -0400
Date: Mon, 19 Mar 2018 09:50:09 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net,
        arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Subject: Re: [PATCH 02/19] csky: Exception handling and syscall
Message-ID: <20180319085009.GA32603@isilmar-4.linta.de>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define __ARCH_WANT_SYSCALL_DEPRECATED
> +#define __ARCH_WANT_SYSCALL_OFF_T
> +#define __ARCH_WANT_SYSCALL_NO_AT
> +#define __ARCH_WANT_SYSCALL_NO_FLAGS

Does this arch *really* want these deprecated and obsolete syscalls? See the
commend in include/uapi/asm-generic/unistd.h

 * All syscalls below here should go away really,
 * these are provided for both review and as a porting
 * help for the C library version.

Thanks,
	Dominik
