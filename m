Date: Thu, 26 Apr 2018 14:57:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.5
Message-ID: <20180426125759.GA12833@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.5 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                   |    2 -
 arch/x86/kernel/acpi/boot.c                |    4 ++
 arch/x86/kernel/tsc.c                      |    2 -
 arch/x86/kvm/mmu.c                         |    2 -
 drivers/clocksource/timer-imx-tpm.c        |    2 -
 drivers/gpu/drm/drm_dp_dual_mode_helper.c  |   39 ++++++++++++++++++----
 drivers/gpu/drm/i915/gvt/dmabuf.c          |    1=20
 drivers/gpu/drm/i915/gvt/kvmgt.c           |    2 -
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 -
 drivers/gpu/drm/i915/intel_audio.c         |    2 -
 drivers/gpu/drm/i915/intel_bios.c          |   13 +++++--
 drivers/gpu/drm/vc4/vc4_bo.c               |    2 +
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |    1=20
 drivers/infiniband/hw/mlx5/qp.c            |    3 +
 drivers/net/wireless/mac80211_hwsim.c      |    7 ++-
 fs/btrfs/delayed-ref.c                     |   19 +++++++---
 fs/btrfs/delayed-ref.h                     |    1=20
 fs/btrfs/extent-tree.c                     |   16 ++++++---
 fs/btrfs/inode.c                           |   20 ++++++-----
 fs/cifs/dir.c                              |    9 ++---
 fs/cifs/smbdirect.c                        |    2 +
 fs/super.c                                 |    9 ++---
 include/linux/netfilter/x_tables.h         |    3 +
 include/linux/shrinker.h                   |    7 ++-
 kernel/events/callchain.c                  |   21 ++++++-----
 kernel/events/core.c                       |    4 +-
 kernel/time/alarmtimer.c                   |   34 ++++++++++++++-----
 kernel/time/posix-cpu-timers.c             |    4 +-
 mm/vmscan.c                                |   21 +++++++++++
 net/bridge/netfilter/ebtables.c            |   10 ++++-
 net/ipv4/netfilter/arp_tables.c            |   12 ++++--
 net/ipv4/netfilter/ip_tables.c             |   10 +++--
 net/ipv6/netfilter/ip6_tables.c            |   12 ++++--
 net/netfilter/x_tables.c                   |   51 +++++++++++++++++++++++-=
-----
 34 files changed, 254 insertions(+), 95 deletions(-)

Anson Huang (1):
      clocksource/imx-tpm: Correct -ETIME return condition check

Benjamin Beichler (1):
      mac80211_hwsim: fix use-after-free bug in hwsim_exit_net

Daniel J Blueman (1):
      drm/vc4: Fix memory leak during BO teardown

David Sterba (1):
      btrfs: fix unaligned access in readdir

Dou Liyang (1):
      x86/acpi: Prevent X2APIC id 0xffffffff from being accounted

Florian Westphal (5):
      netfilter: x_tables: cap allocations at 512 mbyte
      netfilter: x_tables: add counters allocation wrapper
      netfilter: compat: prepare xt_compat_init_offsets to return errors
      netfilter: compat: reject huge allocation requests
      netfilter: x_tables: limit allocation requests for blob rule heads

Gaurav K Singh (1):
      drm/i915/audio: Fix audio detection issue on GLK

Gerd Hoffmann (1):
      drm/i915/gvt: throw error on unhandled vfio ioctls

Greg Kroah-Hartman (1):
      Linux 4.16.5

Imre Deak (1):
      drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state

Jani Nikula (1):
      drm/i915/bios: filter out invalid DDC pins from VBT child devices

Jiri Olsa (2):
      perf: Fix sample_max_stack maximum check
      perf: Return proper values for user stack errors

Laura Abbott (1):
      posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated

Leon Romanovsky (1):
      RDMA/mlx5: Fix NULL dereference while accessing XRC_TGT QPs

Long Li (1):
      cifs: smbd: Check for iov length on sending the last iov

Nikolay Borisov (1):
      btrfs: Fix race condition between delayed refs and blockgroup removal

Sean Christopherson (1):
      Revert "KVM: X86: Fix SMRAM accessing even if VM is shutdown"

Steve French (1):
      cifs: do not allow creating sockets except with SMB1 posix exensions

Tetsuo Handa (1):
      mm,vmscan: Allow preallocating memory for register_shrinker().

Thomas Gleixner (1):
      alarmtimer: Init nanosleep alarm timer on stack

Tina Zhang (1):
      drm/i915/gvt: Add drm_format_mod update

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Xidong Wang (1):
      drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrhzNIACgkQONu9yGCS
aT6Q5Q//TzpwjJiYhZM7UXrta8YUEyUEe9vjWND0Ef8yDS5WZocU2EOTJVpS2j6W
9cesLkGQKErD534maB9qyZF7nWkZYyuZWvyhDfCxx0mJzXb8GTBJGiH49obcZRdB
ImaiQKjXDnQOVSbgq6z9ocK8Yc5JUlAy+3lUaSkOHgq64DfaIM96WnL4gX1xPISf
h5HHVr8u/BYbNe6DV8UD6z0EjXMTZ1VyoqFISJIwGG4uFWjQNL9tv4rVvaL3ss2I
JfjG37sPdhHbCrQjCWWqbeqIZ0T8ct4zkai61fsEbSl1eqCGy3u0xhNDd2tBktRc
6gdrpwy+jQwyTWl6TLrexmDDyGyBfNln/wfuSZJvkXNQ3joUFvEO3HrivXvGKJuK
OMARg9kDqwbD6pfefyzOPTigtOhpDRUbBGrYp95HIzm1JQOkabvZyqho58s2abg5
znF8Y6jdzhZg+tglv1gnEpfUMMSYcXMVsjMcHVaAofhVhLsZqzD2zIFs33WTP2X8
TbO3T3yngeNYwWdwx7HTsVnSkZbSMZFULQa8umVEnPCHK3gEmoLW4+Gk/6xBEZG9
lrq0bCMAFzbEv70EqUPMxup/4hCm+6LHT2YfBqU33Xr5dc5DL+0NW4kV52pJP5Da
KR/oI1cTTeK47JQ11DMxXM8GAScItvJy3+ppxsatNFHYOCku4FY=
=4Kzd
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
