Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-519016-1526486638-2-885961046442351133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526486636; b=FiKOwpF9mjmoD8KEcbRKXejZ7zXXwRa/Z6o9dGk3pdhROYYTar
    8oWCmFwBmCsB4GpBB0u6jht3sbsefB9gJLX8b0qAZaHKzUXs+PytsMDuf6sQzSWD
    3zjRN6i6T4xyXmtqFCCYQqsosX2yHSTSvUTGNm6n7SoAlLwN3kHIn1xxtBOKU4Ij
    3rJRVlLeRoVRwGJB/dhTvcgIs8/NiKRTWGXNggk/SIaXagduu4j86cRXhn2eLURC
    aP3VX6ZYIoUTp1UPZgWKhtmgwDrRDryZhf38EmPVk/uOnbbO93C+Xnpl5hRW9X7u
    H8BJzQuYAymFm2EtIRgBrePRWfKSmAcSz56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526486636;
    bh=89wF4iJ9RS4iW6AgNhjlzgiZGRuv9zR0VRwr4bBoY/Q=; b=Z4q2FTIeKjJx
    HkVb5VDgln5c2Fw0DXv7FK2DrE8bsChAi6Xj3BCakFLbG5pe7ZRsY1cf87plfUw4
    bDd8sQKOe1Vds+lRNRLxymfePP7YRI497HPHDyauVf8IAsVpPUK5Byvlk/YHHt4+
    x/pY55UpjKJhpNDwSGlI/0vvCCFpD53nQ4iMvX0npR8OlU0waaFFuDkyovcott+M
    Scf0uxlUB9FotAT1H9HioKwkY4XL2evUcHW7RSfVdgH/I65MU4cMMEQxpMX36DmG
    KziJJ7PEJ/+gyHD/BO1awqD+KVR/9y0Pi+YCneL0mh56TzlndkRjos/ahG0YhM4L
    qfTU/CZfJg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=lCyuRgE4 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=lCyuRgE4 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJyldPL3+FSvB3ts+18ZNZ6sce3CNWYeUywI9S7K2QSu7U7vMPiUgT2eCrAWMBPztnYH4afnHOEMiZd65emYI4NU0xBM1b5C/OKNw4RutpfmzXmRYE3F
    JCVRXPqrD81X7pnwqV7/cFJRBKEQOf+fuPneRow4dsm6HM0I9ubsh+woa4k4xUn1Orof/a3XxbvbaEwUNz0CMHl7cacw+F8yBi9T4yjbvbwkkSzJ+ZGJzcS1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=HDAr3mqWKCJPgiilD_kA:9 a=mDKagj5kuoDv7BAO:21 a=9nbN-Bm3VVAJibg7:21
    a=QEXdDO2ut3YA:10 a=EXIHoFXNZbBO50mfkSkA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeEPQDX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 12:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeEPQDV (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 16 May 2018 12:03:21 -0400
Date: Wed, 16 May 2018 18:03:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.132
Message-ID: <20180516160304.GA18499@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.132 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2=20
 arch/s390/kvm/kvm-s390.c                          |    4=20
 arch/x86/kernel/cpu/perf_event.c                  |    8=20
 arch/x86/kernel/cpu/perf_event_intel_cstate.c     |    2=20
 arch/x86/kernel/cpu/perf_event_msr.c              |    9=20
 crypto/af_alg.c                                   |    8=20
 drivers/ata/libata-core.c                         |    3=20
 drivers/atm/zatm.c                                |    3=20
 drivers/bluetooth/btusb.c                         |    2=20
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |    1=20
 drivers/infiniband/core/ucma.c                    |    2=20
 drivers/infiniband/hw/mlx5/qp.c                   |   22 -
 drivers/input/input-leds.c                        |    8=20
 drivers/input/touchscreen/atmel_mxt_ts.c          |    9=20
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c            |   78 +++
 drivers/net/can/usb/kvaser_usb.c                  |    2=20
 drivers/net/usb/qmi_wwan.c                        |    1=20
 drivers/net/wireless/ath/ath10k/core.c            |    8=20
 drivers/net/wireless/ath/ath10k/core.h            |    4=20
 drivers/net/wireless/ath/ath10k/htt_rx.c          |  100 ++++
 drivers/net/wireless/ath/wcn36xx/txrx.c           |    2=20
 drivers/usb/core/config.c                         |    4=20
 drivers/usb/musb/musb_host.c                      |    4=20
 drivers/usb/serial/option.c                       |  448 +++++++----------=
-----
 drivers/usb/serial/visor.c                        |   69 +--
 fs/f2fs/data.c                                    |    2=20
 fs/fs-writeback.c                                 |    2=20
 fs/xfs/xfs_file.c                                 |   14=20
 include/net/inet_timewait_sock.h                  |    1=20
 include/net/mac80211.h                            |   14=20
 include/net/nexthop.h                             |    2=20
 kernel/bpf/arraymap.c                             |    2=20
 kernel/bpf/hashtab.c                              |    9=20
 kernel/bpf/syscall.c                              |   20=20
 kernel/events/callchain.c                         |   10=20
 kernel/events/core.c                              |    2=20
 kernel/events/ring_buffer.c                       |    7=20
 kernel/trace/trace_events_filter.c                |    3=20
 kernel/trace/trace_uprobe.c                       |    2=20
 kernel/tracepoint.c                               |    4=20
 mm/percpu.c                                       |    1=20
 net/atm/lec.c                                     |    9=20
 net/core/dev_addr_lists.c                         |    4=20
 net/core/skbuff.c                                 |    1=20
 net/dccp/ipv4.c                                   |    1=20
 net/dccp/ipv6.c                                   |    1=20
 net/ipv4/inet_timewait_sock.c                     |    1=20
 net/ipv4/tcp.c                                    |    2=20
 net/mac80211/util.c                               |    5=20
 net/mac80211/wep.c                                |    3=20
 net/mac80211/wpa.c                                |   45 +-
 net/netfilter/ipvs/ip_vs_ctl.c                    |    8=20
 net/netfilter/ipvs/ip_vs_sync.c                   |  155 +++----
 net/netlink/af_netlink.c                          |    2=20
 net/rfkill/rfkill-gpio.c                          |    7=20
 net/xfrm/xfrm_user.c                              |    2=20
 sound/core/pcm_compat.c                           |    2=20
 sound/core/seq/seq_virmidi.c                      |    4=20
 sound/drivers/aloop.c                             |   29 +
 tools/testing/selftests/firmware/fw_filesystem.sh |    6=20
 60 files changed, 655 insertions(+), 530 deletions(-)

Alan Stern (1):
      USB: Accept bulk endpoints with 1024-byte maxpacket

Alexander Yarygin (1):
      KVM: s390: Enable all facility bits that are known good for passthrou=
gh

Ben Hutchings (1):
      test_firmware: fix setting old custom fw path back on exit, second try

Bin Liu (1):
      usb: musb: host: fix potential NULL pointer dereference

Danit Goldberg (1):
      IB/mlx5: Use unlimited rate when static rate is not supported

Darrick J. Wong (1):
      xfs: prevent creating negative-sized file via INSERT_RANGE

David Spinadel (1):
      mac80211: Add RX flag to indicate ICV stripped

Dmitry Torokhov (1):
      Input: leds - fix out of bound access

Eric Dumazet (8):
      crypto: af_alg - fix possible uninit-value in alg_bind()
      netlink: fix uninit-value in netlink_sendmsg
      net: fix rtnh_ok()
      net: initialize skb->peeked when cloning
      net: fix uninit-value in __hw_addr_add_ex()
      dccp: initialize ireq->ir_mark
      soreuseport: initialise timewait reuseport field
      tcp: fix TCP_REPAIR_QUEUE bound checking

Greg Kroah-Hartman (2):
      USB: serial: visor: handle potential invalid device configuration
      Linux 4.4.132

Gustavo A. R. Silva (2):
      net: atm: Fix potential Spectre v1
      atm: zatm: Fix potential Spectre v1

Hans de Goede (2):
      libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
      Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"

Jan Kara (1):
      bdi: Fix oops in wb_workfn()

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_=
msg()

Jiri Olsa (1):
      perf: Remove superfluous allocation error check

Johan Hovold (2):
      USB: serial: option: reimplement interface masking
      rfkill: gpio: fix memory leak in probe error path

Julian Anastasov (1):
      ipvs: fix rtnl_lock lockups caused by start_sync_thread

Kristian Evensen (1):
      USB: serial: option: Add support for Quectel EP06

Leon Romanovsky (1):
      RDMA/mlx5: Protect from shift operand overflow

Markus Pargmann (1):
      gpmi-nand: Handle ECC Errors in erased pages

Masami Hiramatsu (1):
      tracing/uprobe_event: Fix strncpy corner case

Mathieu Desnoyers (1):
      tracepoint: Do not warn on ENOMEM

Peter Zijlstra (5):
      perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*
      perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr
      perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver
      perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]
      perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()

Robert Rosengren (1):
      ALSA: aloop: Mark paused device as inactive

Roland Dreier (1):
      RDMA/ucma: Allow resolving address w/o specifying source address

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (2):
      NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
      USB: serial: option: adding support for ublox R410M

Sara Sharon (2):
      mac80211: allow not sending MIC up from driver for HW crypto
      mac80211: allow same PN for AMSDU sub-frames

Steven Rostedt (VMware) (1):
      tracing: Fix regex_match_front() to not over compare the test string

Takashi Iwai (3):
      ALSA: pcm: Check PCM state at xfern compat ioctl
      ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
      ALSA: aloop: Add missing cable lock to ctl API callbacks

Tan Xiaojun (1):
      perf/core: Fix the perf_cpu_time_max_percent check

Tejun Heo (1):
      percpu: include linux/sched.h for cond_resched()

Teng Qin (1):
      bpf: map_get_next_key to return first key on NULL

Thomas Hellstrom (1):
      drm/vmwgfx: Fix a buffer object leak

Vasanthakumar Thiagarajan (2):
      ath10k: fix rfc1042 header retrieval in QCA4019 with eth decap mode
      ath10k: rebuild crypto header in rx data frames

Vittorio Gambaletta (VittGam) (1):
      Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromeb=
ook Pro

Wei Fang (1):
      f2fs: fix a dead loop in f2fs_fiemap()

Yi Zhao (1):
      xfrm_user: fix return value from xfrm_user_rcv_msg


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlr8VjcACgkQONu9yGCS
aT7rsA//dZRGUsATo4T20S4l6D1Gm8fCRgSITYoG63Gx+VXQZn0qclEuDZzKF/qa
eehiSpYK+PxPgGwyjouSBsTp9X7RffxTvviTd8zQn6DDjUO2wqo8vitl0tM6W7xV
/zDKtqhGxvV5DksfZFdhD+PmLCF0/XQBxKayW1u3+m9oR1hODBS6s3dlIfH46FX3
Biekv0bmRzleITfuhCM1462yeCmQbqqyVQtVKXKaEJhLbocA7iGiIUpPI5QdoZ25
u63y2NB035/Ziil9CeslyFStTUc7jwcR5uTycPMC8hCxObysAZcR2UqsJ/eg1Gmd
NbA4ENg/4sxVlOvwz6VCEZ0w6H+O5Rsl1xV43xJsYHbV9ycjUUIWhNcf4fsnVgjm
LegyERFh7oTwgK2eSyDAkmH9hoZokxrF4MSM0uePjKT4qHYtVyJ8PJEE/6d0VqhU
zJDKuQ5zknXqNe2B2Fc3eGxiKJR/Jxy6EM/+8JKm53jabTuQQhvJRiFdwwvMYQMO
UIRAP3M+liXLtE6CLzrCWySM6ZzHW7q3kgvBJhg0uxbu1QnEgvgv9/OwnWPKNseG
o8RtDo5iETD17VlTQPmSto/DYiaUTeyUxry71vh/J7lVQn5ocUSIHhvOnKIg//cK
i5gkhVkqvcKhTmkXT3j6O+5p9Zy8LDM5w0uVAomO+MAty2DzIGw=
=7eYN
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
