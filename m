Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeFDHD7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753324AbeFDHDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/47] 4.16.14-stable review
Date: Mon,  4 Jun 2018 08:58:12 +0200
Message-Id: <20180604065549.468488465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.14-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.14-rc1
X-KernelTest-Deadline: 2018-06-06T06:55+00:00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.16.14 release.
There are 47 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Jun  6 06:55:34 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.14-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.14-rc1

Hugh Dickins <hughd@google.com>
    mm: fix the NULL mapping case in __isolate_lru_page()

Al Viro <viro@zeniv.linux.org.uk>
    fix io_destroy()/aio_complete() race

Ondrej Zary <linux@rainbow-software.org>
    drm/i915: Disable LVDS on Radiant P845

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915/lvds: Move acpi lid notification registration to registration phase

Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
    drm/psr: Fix missed entry in PSR setup time table.

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Use correct device when freeing buffers

Stanislaw Gruszka <sgruszka@redhat.com>
    Revert "rt2800: use TXOP_BACKOFF for probe frames"

Hugh Dickins <hughd@google.com>
    mm/huge_memory.c: __split_huge_page() use atomic ClearPageDirty()

Parav Pandit <parav@mellanox.com>
    IB/core: Fix error code for invalid GID entry

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    hwtracing: stm: fix build error on some arches

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Use vmalloc for the master map

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: scsi_transport_srp: Fix shost to rport translation

Maciej W. Rozycki <macro@mips.com>
    MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Mathias Kresin <dev@kresin.me>
    MIPS: lantiq: gphy: Drop reboot/remove reset asserts

Eugen Hristev <eugen.hristev@microchip.com>
    iio: adc: select buffer for at91-sama5d2_adc

Eugen Hristev <eugen.hristev@microchip.com>
    iio: adc: at91-sama5d2_adc: fix channel configuration for differential channels

Fabrice Gasnier <fabrice.gasnier@st.com>
    iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock

Fabrice Gasnier <fabrice.gasnier@st.com>
    iio: adc: stm32-dfsdm: fix successive oversampling settings

Martin Kelly <mkelly@xevo.com>
    iio:kfifo_buf: check for uint overflow

Martin Kelly <mkelly@xevo.com>
    iio:buffer: make length types match kfifo types

Hans de Goede <hdegoede@redhat.com>
    iio: hid-sensor-trigger: Fix sometimes not powering up the sensor after resume

Michael Nosthoff <committed@heine.so>
    iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ

Matthias Kaehlcke <mka@chromium.org>
    rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c

Matthias Kaehlcke <mka@chromium.org>
    drm/amd/powerplay: Fix enum mismatch

Eric Biggers <ebiggers@google.com>
    cfg80211: further limit wiphy names to 64 bytes

Sachin Grover <sgrover@codeaurora.org>
    selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Max Gurtovoy <maxg@mellanox.com>
    nvme: fix extended data LBA supported setting

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Make the snapshot trigger work with instances

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix crash when freeing instances with event triggers

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    Input: elan_i2c_smbus - fix corrupted stack

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    Input: synaptics - add Lenovo 80 series ids to SMBus

Aaron Ma <aaron.ma@canonical.com>
    Input: synaptics - add Intertouch support on X1 Carbon 6th and X280

Edvard Holst <edvard.holst@gmail.com>
    Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with Elantech trackpoints should use RMI

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices should use RMI

Brian Foster <bfoster@redhat.com>
    xfs: detect agfl count corruption and reset agfl

Dave Chinner <dchinner@redhat.com>
    xfs: convert XFS_AGFL_SIZE to a helper function

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "pinctrl: msm: Use dynamic GPIO numbering"

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix host logging / guestinfo reading error paths

Himanshu Jha <himanshujha199640@gmail.com>
    drm/vmwgfx: Use kasprintf

Borislav Petkov <bp@suse.de>
    x86/MCE/AMD: Cache SMCA MISC block addresses

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD: Carve out SMCA get_block_address() code

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Fix "noreturn" detection for recursive sibling calls

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Detect RIP-relative switch table references, part 2

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Detect RIP-relative switch table references

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Support GCC 8 switch tables

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Support GCC 8's cold subfunctions


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/mips/kernel/process.c                         |   4 +
 arch/mips/kernel/ptrace.c                          |   2 +-
 arch/mips/kernel/ptrace32.c                        |   2 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |  72 ++++-----
 .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c  |   8 +-
 .../amd/powerplay/hwmgr/smu7_clockpowergating.c    |   2 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   1 +
 drivers/gpu/drm/i915/intel_lvds.c                  |  51 +++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |  59 ++++----
 drivers/hwtracing/intel_th/msu.c                   |   6 +-
 drivers/hwtracing/stm/core.c                       |   7 +-
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/ad7793.c                           |  75 +++------
 drivers/iio/adc/at91-sama5d2_adc.c                 |  41 ++++-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  17 ++-
 drivers/iio/buffer/industrialio-buffer-dma.c       |   2 +-
 drivers/iio/buffer/kfifo_buf.c                     |  11 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   8 +-
 drivers/infiniband/core/cache.c                    |   2 +-
 drivers/input/mouse/elan_i2c_smbus.c               |  22 +--
 drivers/input/mouse/synaptics.c                    |   6 +
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c   |   7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/rf.c    |   3 -
 drivers/nvme/host/core.c                           |   2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   2 +-
 drivers/scsi/scsi_transport_srp.c                  |  22 ++-
 drivers/soc/lantiq/gphy.c                          |  36 -----
 fs/aio.c                                           |   3 +-
 fs/xfs/libxfs/xfs_alloc.c                          | 125 ++++++++++++++-
 fs/xfs/libxfs/xfs_alloc.h                          |   2 +
 fs/xfs/libxfs/xfs_format.h                         |  13 +-
 fs/xfs/scrub/agheader.c                            |   6 +-
 fs/xfs/xfs_fsops.c                                 |   2 +-
 fs/xfs/xfs_mount.h                                 |   1 +
 fs/xfs/xfs_trace.h                                 |   9 +-
 include/linux/iio/buffer_impl.h                    |   6 +-
 include/uapi/linux/nl80211.h                       |   2 +-
 kernel/trace/trace.c                               |  12 +-
 kernel/trace/trace.h                               |  11 ++
 kernel/trace/trace_events_trigger.c                |  15 +-
 mm/huge_memory.c                                   |   2 +-
 mm/vmscan.c                                        |   2 +-
 security/selinux/ss/services.c                     |   2 +-
 tools/objtool/check.c                              | 167 ++++++++++++---------
 tools/objtool/elf.c                                |  42 +++++-
 tools/objtool/elf.h                                |   2 +
 47 files changed, 572 insertions(+), 327 deletions(-)
