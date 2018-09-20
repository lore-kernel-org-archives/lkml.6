Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87F82152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pimd/hs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87F82152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeIUAj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeIUAj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:39:26 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0714214C2;
        Thu, 20 Sep 2018 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537469672;
        bh=DVDAfpmQnqnzEakfLjcWWfGh3ZoR5dB/Y9h+DzP484Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pimd/hs8hzRERuhl5MDW+Hy7NjEIqzPzF3aimaxGdXt4ws9TjZYbHKeerYCbhpNFM
         f1qR54vK45WHSRyNJrmwm/p+9bcNh0ZueLPrvFXggyxQ5IgJnMUOG8p3ki0hFDnfDT
         NsIyaHu+nNTrguSUJVMvNwELrlt9iYrME/U7Yvww=
Date:   Thu, 20 Sep 2018 21:54:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Rosenbaum <alexr@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: Linux RDMA mini-conf at Plumbers 2018
Message-ID: <20180920185428.GT3519@mtr-leonro.mtl.com>
References: <20180920181923.GA6542@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M0YLxmUXciMpOLPE"
Content-Disposition: inline
In-Reply-To: <20180920181923.GA6542@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 12:19:23PM -0600, Jason Gunthorpe wrote:
> This is just a friendly reminder that registration deadlines are
> approaching for this conference. Please see
>
> https://www.linuxplumbersconf.org/event/2/page/7-attend
>
> For details.
>
> This year we expect to have close to a day set aside for RDMA related
> topics. Including up to half a day for the thorny general kernel issues
> related to get_user_pages(), particularly as exasperated by RDMA.
>
> We have been working on the following concepts for sessions, I've
> roughly marked names based on past participation in related email
> threads. As we get closer to the conference date we will be organizing
> leaders for each section based on these lists, please let us know of
> any changes, or desire to be a leader!
>
> RDMA and get_user_pages
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Dan Williams <dan.j.williams@intel.com>
>   Matthew Wilcox <willy@infradead.org>
>   John Hubbard <jhubbard@nvidia.com>
>   Nicholas Piggin <npiggin@gmail.com>
>   Jan Kara <jack@suse.cz>
>
>  RDMA, DAX and persistant memory co-existence.
>
>  Explore the limits of what is possible without using On
>  Demand Paging Memory Registration. Discuss 'shootdown'
>  of userspace MRs
>
>  Dirtying pages obtained with get_user_pages() can oops ext4
>  discuss open solutions.
>
> RDMA and PCI peer to peer
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>   Don Dutile <ddutile@redhat.com>
>   Alex Williamson <alex.williamson@redhat.com>
>   Christoph Hellwig <hch@lst.de>
>   Stephen Bates <sbates@raithlin.com>
>   Logan Gunthorpe <logang@deltatee.com>
>   J=E9r=F4me Glisse <jglisse@redhat.com>
>   Christian K=F6nig <christian.koenig@amd.com>
>   Bjorn Helgaas <bhelgaas@google.com>
>
>  RDMA and PCI peer to peer transactions. IOMMU issues. Integration
>  with HMM. How to expose PCI BAR memory to userspace and other
>  drivers as a DMA target.
>
> Improving testing of RDMA with syzkaller, RXE and Python
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  Noa Osherovich <noaos@mellanox.com>
>  Don Dutile <ddutile@redhat.com>
>  Jason Gunthorpe <jgg@mellanox.com>
>
>  Problem solve RDMA's distinct lack of public tests.
>  Provide a better framework for all drivers to test with,
>  and a framework for basic testing in userspace.
>
>  Worst remaining unfixed syzkaller bugs and how to try to fix them
>
>  How to hook syzkaller more deeply into RDMA.
>
> IOCTL conversion and new kABI topics
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Jason Gunthorpe <jgg@mellanox.com>
>  Alex Rosenbaum <alexr@mellanox.com>
>
>  Attempt to close on the remaining tasks to complete the project
>
>  Restore fork() support to userspace
>
> Container and namespaces for RDMA topics
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Parav Pandit <parav@mellanox.com>
>  Doug Ledford <dledford@redhat.com>
>
>  Remaining sticky situations with containers
>
>  namespaces in sysfs and legacy all-namespace operation
>
>  Remaining CM issues
>
>  Security isolation problems
>
> Very large Contiguous regions in userspace
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Christopher Lameter <cl@linux.com>
>  Parav Pandit <parav@mellanox.com>
>
>  Poor performance of get_user_pages on very large virtual ranges
>
>  No standardized API to allocate regions to user space
>
>  Carry over from last year
>
> As we get closer to the conference date the exact schedule will be
> published on the conference web site. I belive we have the Thursday
> set aside right now.
>
> If there are any last minute topics people would like to see please
> let us know.

I want to remind you that Mike wanted to bring the topic of enhancing
remote page faults during post-copy container migration in CRIU over
RDMA.

Thanks

>
> See you all in Vancouver!
>
> Thanks,
> Jason & Leon
>

--M0YLxmUXciMpOLPE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbo+zkAAoJEORje4g2clinH6IP+wfLFZ7fzsARxS15q/RbnRf1
fwsHV80uj2xr5fRwGyIvA+zkhOQyzdEyF2Pfo6fK9jtR5lIJDMHv0KLkfkgYhQrB
YMTkWW9KcczlA2d/d1iOMaK7Xg/o/rids7KgTVTPGY8unyfWxUpYNd+R2kSnmmc0
7VkS/uciKu4tacsunPxSHdOjOmU4a3FWZk4U2HpQkRaYfsJIDjcUmdZcN5QOZJcr
4lv3n8xV+u2Hn6O/A0tagh7WWbQay99xQQX6ZEay8Y7Rb+N6sxnsapZf0K3EKK+d
GFWV9lG1+IisMhAvV58zy7nAdWUHGgudqs9eKxcksMWMG1gd6Kf+lnQxqbaixeiE
v15SZNF/zGTmbxzgHbpf9XEznSRIUW9WQmmQU1ncZ4mG7GAJK9aErzpj7nJS3/fi
kk/eRyPeV5mFDZ1uTYV+ppy7azRCmRhVJWhgbHnx6XCBJl3aSXg7RNA7YmzfU3DW
nneLe7HlEENgN/FQjAI540wFnzey1vS384Y0PgcA2h6RaSUzAMlfJxkkauWmECB7
90d6S+Fo/wxPe46Tm4Wz/LFwyQ/LTS+RrobRJn7qJNRZZDLP1YOPSsf2rWRfDCP3
2c7V9p9AVZe7LumdmgO9Te0P6bOZFF8G0/MRSiGL6zxAqqiB6abzFH1DKwI9fRam
W/AMQ5XL93NxGwA/c9G9
=LW6p
-----END PGP SIGNATURE-----

--M0YLxmUXciMpOLPE--
