Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeC1Uxn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:53:43 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:35441 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752594AbeC1Uxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:53:42 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:871:960:965:973:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1534:1539:1575:1711:1730:1747:1777:1792:1978:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3866:3867:3868:3871:3872:3873:3874:4321:4390:5007:6261:6506:6747:7281:7909:9040:10004:10848:11232:11658:11914:12296:12740:12895:13095:14181:14721:21080:21433:21627:21740:30054:30070:30083:30091,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: legs34_3d3d207a6835c
X-Filterd-Recvd-Size: 2905
From: Shea Levy <shea@shealevy.com>
To: Joe Perches <joe@perches.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
In-Reply-To: <1522269853.12357.135.camel@perches.com>
References: <20180328152714.6103-1-shea@shealevy.com> <20180328203659.18692-1-shea@shealevy.com> <20180328203659.18692-15-shea@shealevy.com> <1522269853.12357.135.camel@perches.com>
Date: Wed, 28 Mar 2018 16:53:39 -0400
Message-ID: <874lkzudkc.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Joe Perches <joe@perches.com> writes:

> On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
> Most people seem to want some form of commit message
> and not just your sign-off.
>

Ah, if the subject is insufficient I can add some more detail.

>
> And btw:
>
> It seems you used get_maintainer to determine who to
> send these patches to.
>
> I suggest you add --nogit and --nogit-fallback to the
> get_maintainer command line you use to avoid sending
> these patches to people like me that have done drive-by
> cleanup work on these files.

Whoops, thanks for the tip and sorry for the noise!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq8ANMACgkQXAvWlX2G
/iegcA//WYfDBfzNKkTmV0BANUabihFEaRfgTIu2pFV4FPasWT1AFDWeRI07guU/
VLD3eJVIS7xULGDWdeY9MhhOwHcNji/a6Ul7DlBxqyFBdineTnlsU0pBGRPFfwPA
BNKRrQQPos5B83JVebQOUB2wmgoN3iMDYMU1a3dWRxfqjlmDSxfglp9Zdk2X0d+P
PnZ1tTM1f7cnonluEtLsMvzkrNcp6Zl8CfClRO23L8+6+/mt9U00GV6wsOhvrbAn
HSWN3uSi5OAd9INY7zIAXwwJ+tXmXUMHy+rU5lzX35DKuI9nMIs23qpykK8FBXdl
811t+jpcgxeEoHQhbe8UH2Rx9YNGFbEkYpKQfHTv5dcBT3DM2gpOcdRGMSBGdJFK
fPEstwv2ulmyXbhGbc+v7bCaFlSTIzOpVsaZ0i4s08c4T83ebWM3T9wUIDx7hQy/
Btn17I57tZM5DnTduuAAjzvqIE8qDUyddRdrxYcIlH4/kQF5xaJXu4kmdwe0EFIZ
ojQnC0LLH3t56hSAAl4CJAHtcGHc7hizcPzfcW2ma8xJ1pvraOatgEAn6lvTvjMx
MNKT1zYami5Z5YFWyZYpTbb/cVcgxKIuSJ90KQUsuxjtBGZj3zx6HZ/mtMBwDBEw
wEC+pYxkxnbQeCUuUA2FctEDJ2okytfY1e3IVOvPGD9Io8GUZ9U=
=5dqg
-----END PGP SIGNATURE-----
--=-=-=--
