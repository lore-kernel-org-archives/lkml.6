Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4A659C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E129C208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E129C208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936232AbeFOJGS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:06:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:44154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755675AbeFOJGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9C970AC89;
        Fri, 15 Jun 2018 09:06:04 +0000 (UTC)
Subject: Re: [PATCH v3 05/27] docs: Fix some broken references
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        x86@kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@zh-kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, linux-bcache@vger.kernel.org,
        linux-usb@vger.kernel.org, devel@driverdev.osuosl.org,
        xen-devel@lists.xenproject.org, cgroups@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <29adfe49571ad1395871a4f72154f45ef361297f.1528990947.git.mchehab+samsung@kernel.org>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4448f906-39d8-ac44-c116-cd702c4a9096@suse.de>
Date:   Fri, 15 Jun 2018 17:05:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <29adfe49571ad1395871a4f72154f45ef361297f.1528990947.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/15 12:08 AM, Mauro Carvalho Chehab wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
> 	./scripts/documentation-file-ref-check --fix
> 
> Manually checked if the produced result is valid, removing a few
> false-positives.
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++--
>  .../bindings/input/rotary-encoder.txt         |  2 +-
>  Documentation/driver-api/gpio/consumer.rst    |  2 +-
>  Documentation/kprobes.txt                     |  4 ++--
>  Documentation/trace/coresight.txt             |  2 +-
>  Documentation/trace/ftrace-uses.rst           |  2 +-
>  Documentation/trace/histogram.txt             |  2 +-
>  Documentation/trace/intel_th.rst              |  2 +-
>  Documentation/trace/tracepoint-analysis.rst   |  6 +++---
>  Documentation/translations/ja_JP/howto.rst    |  4 ++--
>  .../translations/zh_CN/magic-number.txt       |  4 ++--
>  .../zh_CN/video4linux/omap3isp.txt            |  4 ++--
>  MAINTAINERS                                   | 20 +++++++++----------
>  arch/Kconfig                                  |  2 +-
>  arch/arm/include/asm/cacheflush.h             |  2 +-
>  arch/arm64/include/asm/cacheflush.h           |  2 +-
>  arch/microblaze/include/asm/cacheflush.h      |  2 +-
>  arch/um/Kconfig.um                            |  2 +-
>  arch/unicore32/include/asm/cacheflush.h       |  2 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  2 +-
>  arch/xtensa/include/asm/cacheflush.h          |  4 ++--
>  block/Kconfig                                 |  2 +-
>  certs/Kconfig                                 |  2 +-
>  crypto/asymmetric_keys/asymmetric_type.c      |  2 +-
>  crypto/asymmetric_keys/signature.c            |  2 +-
>  drivers/char/Kconfig                          |  2 +-
>  drivers/clk/clk.c                             |  4 ++--
>  drivers/clk/ingenic/cgu.h                     |  2 +-
>  drivers/gpu/vga/Kconfig                       |  2 +-
>  drivers/gpu/vga/vgaarb.c                      |  2 +-
>  drivers/input/joystick/Kconfig                | 10 +++++-----
>  drivers/input/joystick/walkera0701.c          |  2 +-
>  drivers/input/misc/Kconfig                    |  4 ++--
>  drivers/input/misc/rotary_encoder.c           |  2 +-
>  drivers/input/mouse/Kconfig                   |  6 +++---
>  drivers/input/mouse/alps.c                    |  2 +-
>  drivers/input/touchscreen/wm97xx-core.c       |  2 +-
>  drivers/lightnvm/pblk-rb.c                    |  2 +-
>  drivers/md/bcache/Kconfig                     |  2 +-
>  drivers/md/bcache/btree.c                     |  2 +-
>  drivers/md/bcache/extents.c                   |  2 +-
>  drivers/media/dvb-core/dvb_ringbuffer.c       |  2 +-
>  drivers/media/pci/meye/Kconfig                |  2 +-
>  drivers/media/platform/pxa_camera.c           |  4 ++--
>  .../soc_camera/sh_mobile_ceu_camera.c         |  2 +-
>  drivers/media/radio/Kconfig                   |  2 +-
>  drivers/media/radio/si470x/Kconfig            |  2 +-
>  drivers/media/usb/dvb-usb-v2/lmedm04.c        |  2 +-
>  drivers/media/usb/zr364xx/Kconfig             |  2 +-
>  drivers/parport/Kconfig                       |  6 +++---
>  drivers/staging/media/bcm2048/TODO            |  2 +-
>  include/keys/asymmetric-subtype.h             |  2 +-
>  include/keys/asymmetric-type.h                |  2 +-
>  include/linux/assoc_array.h                   |  2 +-
>  include/linux/assoc_array_priv.h              |  2 +-
>  include/linux/circ_buf.h                      |  2 +-
>  include/linux/ftrace.h                        |  2 +-
>  include/linux/rculist_nulls.h                 |  2 +-
>  include/uapi/linux/prctl.h                    |  2 +-
>  include/xen/interface/io/kbdif.h              |  2 +-
>  kernel/cgroup/cpuset.c                        |  2 +-
>  kernel/trace/Kconfig                          | 16 +++++++--------
>  lib/Kconfig                                   |  2 +-
>  security/selinux/hooks.c                      |  2 +-
>  sound/core/Kconfig                            |  4 ++--
>  sound/drivers/Kconfig                         |  4 ++--
>  sound/pci/Kconfig                             | 10 +++++-----
>  tools/include/uapi/linux/prctl.h              |  2 +-
>  tools/lib/api/fs/fs.c                         |  2 +-
>  tools/perf/util/bpf-prologue.c                |  2 +-
>  .../config/custom-timeline-functions.cfg      |  4 ++--
>  71 files changed, 113 insertions(+), 113 deletions(-)

[snip]
> diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
> index 4d200883c505..17bf109c58e9 100644
> --- a/drivers/md/bcache/Kconfig
> +++ b/drivers/md/bcache/Kconfig
> @@ -5,7 +5,7 @@ config BCACHE
>  	Allows a block device to be used as cache for other devices; uses
>  	a btree for indexing and the layout is optimized for SSDs.
>  
> -	See Documentation/bcache.txt for details.
> +	See Documentation/admin-guide/bcache.rst for details.
>  
>  config BCACHE_DEBUG
>  	bool "Bcache debugging"
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 2a0968c04e21..547c9eedc2f4 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -18,7 +18,7 @@
>   * as keys are inserted we only sort the pages that have not yet been written.
>   * When garbage collection is run, we resort the entire node.
>   *
> - * All configuration is done via sysfs; see Documentation/bcache.txt.
> + * All configuration is done via sysfs; see Documentation/admin-guide/bcache.rst.
>   */
>  
>  #include "bcache.h"
> diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
> index c334e6666461..1d096742eb41 100644
> --- a/drivers/md/bcache/extents.c
> +++ b/drivers/md/bcache/extents.c
> @@ -18,7 +18,7 @@
>   * as keys are inserted we only sort the pages that have not yet been written.
>   * When garbage collection is run, we resort the entire node.
>   *
> - * All configuration is done via sysfs; see Documentation/bcache.txt.
> + * All configuration is done via sysfs; see Documentation/admin-guide/bcache.rst.
>   */
>  
>  #include "bcache.h"

For the bcache part, it is good to me.

Reviewed-by: Coly Li <colyli@suse.de>

Thanks for the fix.

Coly Li

