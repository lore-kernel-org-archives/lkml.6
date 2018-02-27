Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeB0BJg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 20:09:36 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36978 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeB0BJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 20:09:35 -0500
X-Google-Smtp-Source: AG47ELtxvdzAE5y/GJN+uE6G0ybGXjojaHoZ+OWLgQUiqSr7s+g7cW5Udn82eWDgRaNQDVZWQQ8Szi7YQT7bPAzmn6M=
MIME-Version: 1.0
In-Reply-To: <1519658691-10401-1-git-send-email-minyard@acm.org>
References: <1519658691-10401-1-git-send-email-minyard@acm.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 27 Feb 2018 11:39:13 +1030
X-Google-Sender-Auth: F_jIXsEIWaSSdUVcQMC4NbKhUsU
Message-ID: <CACPK8XdQtbkJHSNMYGcL73X9ZSgDO7+8DJcH=EzJjLE0+X9wdA@mail.gmail.com>
Subject: Re: [PATCH] ipmi: Add or fix SPDX-License-Identifier in all files
To: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>, Kees Cook <keescook@chromium.org>,
        Alistair Popple <alistair@popple.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Rocky Craig <rocky.craig@hp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 1:54 AM,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> And get rid of the license text that is no longer necessary.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Alistair Popple <alistair@popple.id.au>
> Cc: Jeremy Kerr <jk@ozlabs.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Rocky Craig <rocky.craig@hp.com>
> ---
>
> Just a cleanup of these things.
>
>  drivers/char/ipmi/bt-bmc.c           |  6 +-----
>  drivers/char/ipmi/ipmi_bt_sm.c       | 22 ++--------------------
>  drivers/char/ipmi/ipmi_devintf.c     | 22 +---------------------
>  drivers/char/ipmi/ipmi_kcs_sm.c      | 22 +---------------------
>  drivers/char/ipmi/ipmi_msghandler.c  | 22 +---------------------
>  drivers/char/ipmi/ipmi_powernv.c     |  6 +-----
>  drivers/char/ipmi/ipmi_poweroff.c    | 22 +---------------------
>  drivers/char/ipmi/ipmi_si.h          |  1 +
>  drivers/char/ipmi/ipmi_si_hardcode.c |  1 +
>  drivers/char/ipmi/ipmi_si_hotmod.c   |  1 +
>  drivers/char/ipmi/ipmi_si_intf.c     | 22 +---------------------
>  drivers/char/ipmi/ipmi_si_mem_io.c   |  1 +
>  drivers/char/ipmi/ipmi_si_parisc.c   |  1 +
>  drivers/char/ipmi/ipmi_si_pci.c      |  1 +
>  drivers/char/ipmi/ipmi_si_platform.c |  1 +
>  drivers/char/ipmi/ipmi_si_port_io.c  |  1 +
>  drivers/char/ipmi/ipmi_si_sm.h       | 22 +---------------------
>  drivers/char/ipmi/ipmi_smic_sm.c     | 24 ++----------------------
>  drivers/char/ipmi/ipmi_ssif.c        |  6 +-----
>  drivers/char/ipmi/ipmi_watchdog.c    | 22 +---------------------
>  20 files changed, 22 insertions(+), 204 deletions(-)
>
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index c95b93b..8328c82 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -1,10 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0

IBM's preferred licence is GPL-2.0+ (as indicated in the text below).

Reading through the rest of the patch, it looks like there's some
other 2+ you missed.

Cheers,

Joel


>  /*
>   * Copyright (c) 2015-2016, IBM Corporation.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
>   */
>
>  #include <linux/atomic.h>
> diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
> index feafdab..6e63819 100644
> --- a/drivers/char/ipmi/ipmi_bt_sm.c
> +++ b/drivers/char/ipmi/ipmi_bt_sm.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   *  ipmi_bt_sm.c
>   *
> @@ -5,26 +6,7 @@
>   *  of the driver architecture at http://sourceforge.net/projects/openipmi
>   *
>   *  Author:    Rocky Craig <first.last@hp.com>
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.  */
> + */
>
>  #include <linux/kernel.h> /* For printk. */
>  #include <linux/string.h>
> diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
> index 5f1bc91..e21565b 100644
> --- a/drivers/char/ipmi/ipmi_devintf.c
> +++ b/drivers/char/ipmi/ipmi_devintf.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_devintf.c
>   *
> @@ -8,27 +9,6 @@
>   *         source@mvista.com
>   *
>   * Copyright 2002 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
>  #include <linux/module.h>
> diff --git a/drivers/char/ipmi/ipmi_kcs_sm.c b/drivers/char/ipmi/ipmi_kcs_sm.c
> index 1da61af..fe1ce1d 100644
> --- a/drivers/char/ipmi/ipmi_kcs_sm.c
> +++ b/drivers/char/ipmi/ipmi_kcs_sm.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_kcs_sm.c
>   *
> @@ -8,27 +9,6 @@
>   *         source@mvista.com
>   *
>   * Copyright 2002 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
>  /*
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index e0b0d7e..898d2b7 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_msghandler.c
>   *
> @@ -8,27 +9,6 @@
>   *         source@mvista.com
>   *
>   * Copyright 2002 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
>  #include <linux/module.h>
> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
> index bcf493d..d2c2c76 100644
> --- a/drivers/char/ipmi/ipmi_powernv.c
> +++ b/drivers/char/ipmi/ipmi_powernv.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * PowerNV OPAL IPMI driver
>   *
>   * Copyright 2014 IBM Corp.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
>   */
>
>  #define pr_fmt(fmt)        "ipmi-powernv: " fmt
> diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
> index 38e6af1..e46b821 100644
> --- a/drivers/char/ipmi/ipmi_poweroff.c
> +++ b/drivers/char/ipmi/ipmi_poweroff.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_poweroff.c
>   *
> @@ -9,27 +10,6 @@
>   *         source@mvista.com
>   *
>   * Copyright 2002,2004 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
> index 17ce5f7..f52d6e0 100644
> --- a/drivers/char/ipmi/ipmi_si.h
> +++ b/drivers/char/ipmi/ipmi_si.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ipmi_si.h
>   *
> diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
> index fa9a478..e0c02e1 100644
> --- a/drivers/char/ipmi/ipmi_si_hardcode.c
> +++ b/drivers/char/ipmi/ipmi_si_hardcode.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/moduleparam.h>
>  #include "ipmi_si.h"
> diff --git a/drivers/char/ipmi/ipmi_si_hotmod.c b/drivers/char/ipmi/ipmi_si_hotmod.c
> index fc03b9b..414a64a 100644
> --- a/drivers/char/ipmi/ipmi_si_hotmod.c
> +++ b/drivers/char/ipmi/ipmi_si_hotmod.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_si_hotmod.c
>   *
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index af2da23..4a1285b 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_si.c
>   *
> @@ -10,27 +11,6 @@
>   *
>   * Copyright 2002 MontaVista Software Inc.
>   * Copyright 2006 IBM Corp., Christian Krafft <krafft@de.ibm.com>
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
>  /*
> diff --git a/drivers/char/ipmi/ipmi_si_mem_io.c b/drivers/char/ipmi/ipmi_si_mem_io.c
> index 8796396..dfb5650 100644
> --- a/drivers/char/ipmi/ipmi_si_mem_io.c
> +++ b/drivers/char/ipmi/ipmi_si_mem_io.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/io.h>
>  #include "ipmi_si.h"
> diff --git a/drivers/char/ipmi/ipmi_si_parisc.c b/drivers/char/ipmi/ipmi_si_parisc.c
> index 6b10f0e..07b5509 100644
> --- a/drivers/char/ipmi/ipmi_si_parisc.c
> +++ b/drivers/char/ipmi/ipmi_si_parisc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/module.h>
>  #include <asm/hardware.h>      /* for register_parisc_driver() stuff */
> diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
> index fff1e0f..5f9f889 100644
> --- a/drivers/char/ipmi/ipmi_si_pci.c
> +++ b/drivers/char/ipmi/ipmi_si_pci.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_si_pci.c
>   *
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index f421487..995794c 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_si_platform.c
>   *
> diff --git a/drivers/char/ipmi/ipmi_si_port_io.c b/drivers/char/ipmi/ipmi_si_port_io.c
> index e5ce174..9290427 100644
> --- a/drivers/char/ipmi/ipmi_si_port_io.c
> +++ b/drivers/char/ipmi/ipmi_si_port_io.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>
>  #include <linux/io.h>
>  #include "ipmi_si.h"
> diff --git a/drivers/char/ipmi/ipmi_si_sm.h b/drivers/char/ipmi/ipmi_si_sm.h
> index aa8d88a..de8ceb5 100644
> --- a/drivers/char/ipmi/ipmi_si_sm.h
> +++ b/drivers/char/ipmi/ipmi_si_sm.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ipmi_si_sm.h
>   *
> @@ -11,27 +12,6 @@
>   *         source@mvista.com
>   *
>   * Copyright 2002 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
>  #include <linux/ipmi.h>
> diff --git a/drivers/char/ipmi/ipmi_smic_sm.c b/drivers/char/ipmi/ipmi_smic_sm.c
> index 8f7c73f..5c82ce0 100644
> --- a/drivers/char/ipmi/ipmi_smic_sm.c
> +++ b/drivers/char/ipmi/ipmi_smic_sm.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_smic_sm.c
>   *
> @@ -18,28 +19,7 @@
>   * copyright notice:
>   * (c) Copyright 2001 Grant Grundler (c) Copyright
>   * 2001 Hewlett-Packard Company
> - *
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.  */
> + */
>
>  #include <linux/kernel.h> /* For printk. */
>  #include <linux/string.h>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 5da345e..2babf56 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_ssif.c
>   *
> @@ -13,11 +14,6 @@
>   *
>   * Copyright 2003 Intel Corporation
>   * Copyright 2005 MontaVista Software
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
>   */
>
>  /*
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index a58acdc..db06cef 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ipmi_watchdog.c
>   *
> @@ -8,27 +9,6 @@
>   *         source@mvista.com
>   *
>   * Copyright 2002 MontaVista Software Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under the terms of the GNU General Public License as published by the
> - *  Free Software Foundation; either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *
> - *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
> - *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> - *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> - *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> - *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> - *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
>  #include <linux/module.h>
> --
> 2.7.4
>
