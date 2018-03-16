Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521229229; cv=none;
        d=google.com; s=arc-20160816;
        b=xvCDnGUCvjHpqzlg0Op0kGeNjyiBmMRA2BasZ1n3M0D7deJXiujCA6OMhePdEmV6Sx
         GxltZV/m41IWHjzHqcYx+yo2tYWVEZXHhF5qEy6WoLnPyeLyzzaIB/hw892hMOkvqjjn
         RZG1hMYlLXljlwMjOCHtmAo8qV4+Vpa+XB8RfRmALhHe015L9sBz5i383kD0cro+sMOb
         8uURrilQPwF9ZsTYAnQyhOicdixV4Y3oO4+qkZq/QuP8UW/4rR5W+CkjhwHrT2Uoqpi9
         DSaMWyN7OIQOOjQ1mEV72kJAkyb7fcFSc/Lhj+ScgAoTBRH0b7e4RhI1oXRIfiJE9EMF
         602g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=Ogn9JsNNdqsB7cgevdNVS/HErVDveJPfEID6iObh8RE=;
        b=D72Tg7KleRWYdKkF3dCKY1afJMPJSDGmw5K5+MydE+m6jFWCvrM19QkbvMNcwJTvbc
         feb05SCsSj9pBQ9oPmuIPNVftcP/9JIjUWYghdP6LNvGL9V9hN4S+DxZSKbVAUGiYeel
         KtsL2HM7bQirFqhVeRc/hYvKG+VfSOry3j6ZG/KWGkTcCfElV8fYpyrKWLI9GmOOZsCP
         CqLPRMIiYhuRqjIGzZg5ePvw5rspifz3Ow3qFBz8rK5P86fVmjTWTuKzqVIwCnjD5CcQ
         7UBhqLe7HBEcYTNUDYYIB8UgHjeDZhEj7TwkQozP5AXSt2cjAuzFPPS0GakFaE27bsn5
         uzoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DQKIJZxN;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DQKIJZxN;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtpxJmHT8dsyiv/yzGfU5iJMvx7l8dV0KyOmE3z2iSCk0AjEVwVdaGyJPlHtCA9+dwyi3kdbgsZhOsjXkuJiKI=
MIME-Version: 1.0
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 17 Mar 2018 01:10:28 +0530
Message-ID: <CA+G9fYtjgL5GWOnu0_2zfKBP=FN=vQDdGYTE8-4SsJMv_13V+w@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>, peter.ujfalusi@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595109030771020666?=
X-GMAIL-MSGID: =?utf-8?q?1595124460385769160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16 March 2018 at 20:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.28 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.28-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.14.28-rc1
>
> Anusha Srivatsa <anusha.srivatsa@intel.com>
>     drm/i915/glk: Disable Guc and HuC on GLK
>
> Sinan Kaya <okaya@codeaurora.org>
>     dmaengine: qcom_hidma: check pending interrupts
>
> Arnd Bergmann <arnd@arndb.de>
>     IB/mlx5: revisit -Wmaybe-uninitialized warning
>
> Mimi Zohar <zohar@linux.vnet.ibm.com>
>     ima: relax requiring a file signature for new files with zero length
>
> Davidlohr Bueso <dave@stgolabs.net>
>     locking/locktorture: Fix num reader/writer corner cases
>
> SeongJae Park <sj38.park@gmail.com>
>     rcutorture/configinit: Fix build directory error message
>
> Mahesh Bandewar <maheshb@google.com>
>     ipvlan: add L2 check for packets arriving via virtual devices
>
> Christophe Leroy <christophe.leroy@c-s.fr>
>     Fix misannotated out-of-line _copy_to_user()
>
> Adrian Hunter <adrian.hunter@intel.com>
>     mmc: mmc_test: Ensure command queue is disabled for testing
>
> Dan Carpenter <dan.carpenter@oracle.com>
>     ASoC: nuc900: Fix a loop timeout test
>
> Horia Geant=C4=83 <horia.geanta@nxp.com>
>     crypto: caam/qi - use correct print specifier for size_t
>
> Luca Coelho <luciano.coelho@intel.com>
>     mac80211: remove BUG() when interface type is invalid
>
> Adiel Aloni <adiel.aloni@intel.com>
>     mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED
>
> Chris Wilson <chris@chris-wilson.co.uk>
>     agp/intel: Flush all chipset writes after updating the GGTT
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     arm64: dts: renesas: salvator-common: Add EthernetAVB PHY reset
>
> Nicholas Piggin <npiggin@gmail.com>
>     powerpc/64: Don't trace irqs-off at interrupt return to soft-disabled=
 context
>
> Josh Poimboeuf <jpoimboe@redhat.com>
>     powerpc/modules: Don't try to restore r2 after a sibling call
>
> Yong Zhao <yong.zhao@amd.com>
>     drm/amdkfd: Fix memory leaks in kfd topology
>
> Stephen Hemminger <stephen@networkplumber.org>
>     veth: set peer GSO values
>
> John Fastabend <john.fastabend@gmail.com>
>     net: sched: drop qdisc_reset from dev_graft_qdisc
>
> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>     virtio_net: Disable interrupts if napi_complete_done rescheduled napi
>
> Gustavo A. R. Silva <garsilva@embeddedor.com>
>     media: davinci: vpif_capture: add NULL check on devm_kzalloc return v=
alue
>
> Dan Carpenter <dan.carpenter@oracle.com>
>     media: cpia2: Fix a couple off by one bugs
>
> Heinz Mauelshagen <heinzm@redhat.com>
>     dm raid: fix raid set size revalidation
>
> Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>     media: vsp1: Prevent suspending and resuming DRM pipelines
>
> Xose Vazquez Perez <xose.vazquez@gmail.com>
>     scsi: dh: add new rdac devices
>
> Xose Vazquez Perez <xose.vazquez@gmail.com>
>     scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
>
> Bart Van Assche <bart.vanassche@wdc.com>
>     scsi: core: scsi_get_device_flags_keyed(): Always return device flags
>
> Michael Chan <michael.chan@broadcom.com>
>     bnxt_en: Don't print "Link speed -1 no longer supported" messages.
>
> Tobias Jordan <Tobias.Jordan@elektrobit.com>
>     spi: sun6i: disable/unprepare clocks on remove
>
> Julien BOIBESSOT <julien.boibessot@armadeus.com>
>     tools/usbip: fixes build with musl libc toolchain
>
> Ben Greear <greearb@candelatech.com>
>     ath10k: fix invalid STS_CAP_OFFSET_MASK
>
> Limin Zhu <liminzhu@marvell.com>
>     mwifiex: cfg80211: do not change virtual interface during scan proces=
sing
>
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>     clk: qcom: msm8916: fix mnd_width for codec_digcodec
>
> Monk Liu <Monk.Liu@amd.com>
>     drm/amdgpu:fix virtual dce bug
>
> Sara Sharon <sara.sharon@intel.com>
>     iwlwifi: mvm: avoid dumping assert log when device is stopped
>
> Thomas Richter <tmricht@linux.vnet.ibm.com>
>     perf annotate: Fix objdump comment parsing for Intel mov dissassembly
>
> Thomas Richter <tmricht@linux.vnet.ibm.com>
>     perf annotate: Fix unnecessary memory allocation for s390x
>
> Takeshi Kihara <takeshi.kihara.df@renesas.com>
>     pinctrl: sh-pfc: r8a7795-es1: Fix MOD_SEL1 bit[25:24] to 0x3 when usi=
ng STP_ISEN_1_D
>
> Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>     pinctrl: sh-pfc: r8a7791: Add can_clk function
>
> Jernej Skrabec <jernej.skrabec@siol.net>
>     drm/sun4i: Fix format mask in DE2 driver
>
> Axel Lin <axel.lin@ingics.com>
>     pwm: stmpe: Fix wrong register offset for hwpwm=3D2 case
>
> Li Dongyang <dongyang.li@anu.edu.au>
>     scsi: ses: don't ask for diagnostic pages repeatedly during probe
>
> Monk Liu <Monk.Liu@amd.com>
>     drm/amdgpu:fix random missing of FLR NOTIFY
>
> Peter Ujfalusi <peter.ujfalusi@ti.com>
>     dmaengine: amba-pl08x: Use vchan_terminate_vdesc() instead of desc_fr=
ee
>
> Peter Ujfalusi <peter.ujfalusi@ti.com>
>     dmaengine: bcm2835-dma: Use vchan_terminate_vdesc() instead of desc_f=
ree

arm and arm64 build broken due to this patch for 4.14 and 4.15

drivers/dma/bcm2835-dma.c:815:3: error: implicit declaration of function
'vchan_terminate_vdesc' [-Werror=3Dimplicit-function-declaration]
   vchan_terminate_vdesc(&c->desc->vd);
   ^
cc1: some warnings being treated as errors

FYI, build using GCCVERSION =3D "linaro-6.2"
