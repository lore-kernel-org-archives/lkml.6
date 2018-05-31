Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbeEaFYW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:24:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41863 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752025AbeEaFYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:24:18 -0400
From: NeilBrown <neilb@suse.com>
To: Trond Myklebust <trondmy@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 31 May 2018 15:24:10 +1000
Cc: List Linux Next Mailing <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: Signed-off-by missing for commit in the nfs tree
In-Reply-To: <CAABAsM7VZcJvtSnbebOAWEAZ7oTkV6JXJF=GxOj=zLYgjSGQ_Q@mail.gmail.com>
References: <20180531072629.6e19241b@canb.auug.org.au> <CAABAsM7VZcJvtSnbebOAWEAZ7oTkV6JXJF=GxOj=zLYgjSGQ_Q@mail.gmail.com>
Message-ID: <87y3g0tn2d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, May 30 2018, Trond Myklebust wrote:

> Hi Stephen,
>
> Thanks for noticing and apologies for missing that. I'll take that
> patch out until Neil can update it.
>

Thanks for noticing that Stephen,
I've sent and updated version.

Thanks,
NeilBrown


> Cheers
>   Trond
> On Wed, 30 May 2018 at 17:26, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi Trond,
>>
>> Commit
>>
>>   f217ebf24480 ("NFS: slight optimization for walking list for delegations")
>>
>> is missing a Signed-off-by from its author.
>>
>> --
>> Cheers,
>> Stephen Rothwell

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsPhvsACgkQOeye3VZi
gbnMfQ/+Mrg9puY97bp79nb0vdCKOoyVdTElZiQrGwIVc+wyACzzJdKyX9zNc6dP
TqRxDLmLG5pCG9sPRL+zmdDDjtVf2Hp5InvRdJTP5WcbiYrvy9mDrQzJewpVe8JV
GC/84WV2/MmSFdNkkAKBeITe9//zX4+x2Ud5yl90ctrFH5U4lbK4mR8l7P9Ogw5g
4dV+wJBLRKC63URlFNfNVkrzrHWIdx4NsgXTJq0VSJRT1rju+I6P83c6koV3Y/WH
AiP8WHjPVpFRIeezTfIjRO0GWRppC8P7JsGUVus+71dZDlkPnLLvlKxCxZyswdUW
WD/S23C+MmavbzGGFk7RqC8f6FRXzO+YjYb4RModstjPp+IHVsTSd2eb71MFRvfk
zORh69RHtQONc9quUa05qtW9siZSK49kizY6PcH7PeeQlhEU4IpyihlSsJzkGU5R
UPYHbMIZp4HbpB1l1MGtd5n4c2GVBlf7CLSfrd4qMm/oiSeIZm6exOZWGcelCPY8
XrJ6rVk0ls4RkHIrG0FqOuPqAGzwsxLSzDKYV3YauRRBHVbmtEt+rV3cVmRpFuef
fflylH7PBowgLSZOWNNdZWVL8etIL+NPocrgk8TFC/V4u2e7+QbZAl3WlkYhHHeV
dTi19l+xNzQhUYB67Vl9vLDsb+aOhBWVzEsgOCxq8fCsh3FbOQM=
=L4IE
-----END PGP SIGNATURE-----
--=-=-=--
