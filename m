Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeDKCB6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:01:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752610AbeDKCB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:01:56 -0400
Date: Wed, 11 Apr 2018 10:01:50 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        "Tan, Jianfeng" <jianfeng.tan@intel.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
 vhost backend
Message-ID: <20180411020150.GE28698@stefanha-x1.localdomain>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 10, 2018 at 09:23:53AM +0000, Liang, Cunming wrote:
> If QEMU is going to build a user space driver framework there, we're open mind on that, even leveraging DPDK as the underlay library. Looking forward to more others' comments from community.

There is already an NVMe VFIO driver in QEMU (see block/nvme.c).  So in
principle there's no reason against userspace drivers in QEMU.

Stefan

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazWyOAAoJEJykq7OBq3PIDxYH/3SjcypJKNjR0hMj21VW4REg
7F6RjwFFlXz5fjIdUTi3sW80T3eWF26MbWBttl1A6XwrWQPrx50iG9xhblCNwLtu
KY8vkQVK89LYwpM1vQn3LH7liEWexUIvq+dksxDts+7XE52qXxJ3hhzhb29ajTFf
aWh4HdJXZyh3243o8tyvUELsSQ/P5mxy6HHt2pggoPViO3ttfjYC/fnkd2Q11tZn
JxPIkqC4OkJW3EBva5V2/dCu0hWC8Gcj69Hda6eMrev4FzkHpFDROrb3CqtWKDEw
ngHk+06CpZF77C73b8OKf8/+yWUXwXc38OVjoX6B3FS/x7a+mW2DZNb/m8NRDXg=
=ueJP
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
