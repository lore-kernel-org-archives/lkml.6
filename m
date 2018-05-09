Return-Path: <parri.andrea@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525886110; cv=none;
        d=google.com; s=arc-20160816;
        b=dIZK7nbR8XORcqnqnESrh9yiR/yVduqm6ru9JvB1MDzq/+VenQzwflheV/AgeVHHX/
         y9C+va6IE5kA417GQ7vaLdygT2QPJJOwFn/8nv+dXVQvpKzZfD4uAxc/c6UGRVm9kNTB
         eClv+F2qV9iVpF8CVmJFpAjemlUkQEd6HLPwKBbcvbOmQZVbDtZcTG/A5GlMaUCPS5/e
         PmS2uKAv8lT0djDiRPCHipPlilabeCbmIB5qXWXYDeCl6VoJdLYh5DeVgfXNQKFON0TV
         hVOcDZrczWxclTuflfc/oAHS+r8+/8V5N5No1uSr7k/x3f1VRyhgQ2N+D0yXUpnshgZe
         eZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+wZ/SH9dPMwTJzuNZcTvWMKjKe00a92ZP4EMzMr6U1c=;
        b=Oh7pVHv/pzO/wSPAn3nRP2+I+V9vXkmW6QFVMu7J7nMhhBDsPQhcMp0zCQKk4sIN2b
         G5cBMFHvA2RIWpBcyOM4HwPz/VriHh3TqfK6yLttUWQM4K8rYi9+xGsRU09fYbVDOZGz
         3gDXDO8Z4S8JzYwUpNRm+qXCOXHc1XFQs/HwPeJ8atELT7gJmuUkyNVG4M7UNY0pXTml
         acLqjzNTu4TUAQegtEwIvwYbNyhNysTsXPggZK9FZJNlBZa6p7WqdoVUo/42vsQRi13k
         ok1pY/a00yHbEIiKPaS+EToKHyVj8E0nNBN+5Tv9ICTuxLtlssMWQM+KjEbMFDF9SVER
         XdfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JDot1qdI;
       spf=pass (google.com: domain of parri.andrea@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=parri.andrea@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JDot1qdI;
       spf=pass (google.com: domain of parri.andrea@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=parri.andrea@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqgXY3Ru8D67SsqpeZQJC8FIuuslCsftkVaFCbp9W6ylsnQ6Mn0QaNq5fQFBe/atiwh71t4Fw==
Date: Wed, 9 May 2018 19:15:01 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Harry Wei <harryxiyou@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Michal Simek <monstr@monstr.eu>,
	Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
	Guan Xuetao <gxt@pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@linux.ie>,
	Gustavo Padovan <gustavo@padovan.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sean Paul <seanpaul@chromium.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	Matias Bjorling <mb@lightnvm.io>, Michael Lyle <mlyle@lyle.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Antoine Jacquet <royale@zerezo.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>, Li Zefan <lizefan@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	Eric Paris <eparis@parisplace.org>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@zh-kernel.org,
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
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
Message-ID: <20180509171501.GA17405@andrea>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
 <e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992730865491295?=
X-GMAIL-MSGID: =?utf-8?q?1600007554784513397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 10:18:52AM -0300, Mauro Carvalho Chehab wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
> 	./scripts/documentation-file-ref-check --fix-rst
> 
> Manually checked if the produced result is valid, removing a few
> false-positives.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thank you again for doing this,


> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++--
>  .../bindings/input/rotary-encoder.txt         |  2 +-
>  Documentation/driver-api/gpio/consumer.rst    |  2 +-
>  Documentation/kprobes.txt                     |  4 ++--
>  Documentation/trace/coresight.txt             |  2 +-
>  Documentation/trace/events.rst                |  2 +-
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
>  drivers/input/joystick/iforce/Kconfig         |  2 +-
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
>  tools/memory-model/README                     | 10 +++++-----

As mentioned in the previous thread, I am for keeping the current
references: the REAMDE is listing the doc files, as well as other
files in tools/memory-model/, relatively to that directory.

  Andrea
