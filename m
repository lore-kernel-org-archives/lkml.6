Date: Sun, 11 Mar 2018 17:46:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.9
Message-ID: <20180311164611.GA24041@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.9 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/virtual/kvm/cpuid.txt         |    4 +
 Documentation/virtual/kvm/msr.txt           |    3 -
 Makefile                                    |    2=20
 arch/arm64/net/bpf_jit_comp.c               |    5 +
 arch/powerpc/net/bpf_jit_comp64.c           |    1=20
 arch/x86/include/asm/nospec-branch.h        |   37 ++++++++++++
 arch/x86/include/uapi/asm/kvm_para.h        |    1=20
 arch/x86/kernel/kvm.c                       |    8 +-
 arch/x86/kvm/cpuid.c                        |    3 -
 arch/x86/net/bpf_jit_comp.c                 |    9 +--
 drivers/scsi/mpt3sas/mpt3sas_base.c         |    8 +-
 drivers/scsi/mpt3sas/mpt3sas_base.h         |    3 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        |   21 +++++--
 kernel/bpf/arraymap.c                       |   33 ++++++-----
 kernel/bpf/lpm_trie.c                       |   14 ++--
 kernel/bpf/verifier.c                       |   42 ++++++++------
 tools/testing/selftests/bpf/test_verifier.c |   84 +++++++++++++++++++++++=
+++++
 17 files changed, 221 insertions(+), 57 deletions(-)

Daniel Borkmann (5):
      bpf: fix mlock precharge on arraymaps
      bpf, x64: implement retpoline for tail call
      bpf, arm64: fix out of bounds access in tail call
      bpf: allow xadd only on aligned memory
      bpf, ppc64: fix out of bounds access in tail call

Eric Dumazet (1):
      bpf: add schedule points in percpu arrays management

Greg Kroah-Hartman (1):
      Linux 4.15.9

Mauricio Faria de Oliveira (1):
      scsi: mpt3sas: fix oops in error handlers after shutdown/unload

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      KVM: x86: fix backward migration with async_PF

Sreekanth Reddy (1):
      scsi: mpt3sas: wait for and flush running commands on shutdown/unload

Yonghong Song (2):
      bpf: fix memory leak in lpm_trie map_free callback function
      bpf: fix rcu lockdep warning for lpm_trie map_free callback


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqlXVIACgkQONu9yGCS
aT7yABAAsIAfFqjTX1m3G/vEsSRpoJJsWT4yG7fmOh2ak1kD5MMomxVMFP8FHpmq
RhnK0J1U5q2/d7v5cwuRTWa0s+knwWk1mDzD4AaQxkapCHcwFyfNZOzrpWY+7rEk
JbfmgotK4CiJZAcsT37YmO+VWukh79fo8ntMO9ybzFkrFYp/sd565aAQNxiVrjxd
wgsjDyvKouSjTztjkb3rU0R7m3B9bnBxvDdNfMvVjQ4FxRzasCeu5eMYju4GnpBd
YwNTeegTLplpLSKJKrjh4HHru3lKIpr11qnj0o9Uk+gwwv4gX695/XUnjlqFkpcq
tJlJfmJv/dcpke6k8z2D/8LuGq0aTscihe4WKsHKAlw/JR2HZJ3z4Wtou9ZsubRj
Yl6ms2oRUodTVRZqyXhexcYzfe7yUo7osVppiAU+VrpzUGTHhAtO3Fsf3u6nnl6a
sUWaBltyJeW14x6DVOL3IGYeYTe0809rjAcQc6tTUsQ9v+nHrBvByH0wEai5EOdy
GhMcYEe87PUhRN+/2tz/3LG8XDXvpkTlR1f343ftxTd0UXoEMyJCIQWG1/8XtQIZ
6ua9669O9n/Fd5n4du5qtYrFeRoX6a3TmQIgTJHzdzDTeZJMABqm18mWyx4c+mNQ
/qKnaLexBv5onrEuaij5nrgVcoBS843G8kqIzWiq21tKKTA+bFg=
=06mp
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
