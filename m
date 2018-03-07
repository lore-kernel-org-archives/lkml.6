Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbeCGPB1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:01:27 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46729 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbeCGPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:01:24 -0500
X-Google-Smtp-Source: AG47ELs9PeowMA2vKQe2MDpjFZA/EV8UCNGcxQJKU/dpT/fCVeyiAtLMZp77U5rZi93SQ02fErv+BQ==
Reply-To: monstr@monstr.eu
Subject: Re: CRIS port status, was: [PATCH] dump_stack: convert generic
 dump_stack into a weak symbol
To: Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>, Mikael Starvik <starvik@axis.com>,
        linux-cris-kernel@axis.com
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <44a75f98-8639-fdbd-6545-5c261f10fe06@monstr.eu>
Date: Wed, 7 Mar 2018 16:01:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GIwpndRIkyO8wCSAmwTMGhZHwuGbTMSUS"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GIwpndRIkyO8wCSAmwTMGhZHwuGbTMSUS
Content-Type: multipart/mixed; boundary="MxfoN6WcoVwoQsOb6gfoRoHAk0ssu9Bip";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Arnd Bergmann <arnd@arndb.de>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
 Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
 Vincent Chen <deanbo422@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 adi-buildroot-devel@lists.sourceforge.net,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jesper Nilsson <jesper@jni.nu>, Mikael Starvik <starvik@axis.com>,
 linux-cris-kernel@axis.com
Message-ID: <44a75f98-8639-fdbd-6545-5c261f10fe06@monstr.eu>
Subject: Re: CRIS port status, was: [PATCH] dump_stack: convert generic
 dump_stack into a weak symbol
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
In-Reply-To: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>

--MxfoN6WcoVwoQsOb6gfoRoHAk0ssu9Bip
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On 7.3.2018 15:09, Arnd Bergmann wrote:
> On Wed, Mar 7, 2018 at 2:40 PM, Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
>> On (03/07/18 13:48), Arnd Bergmann wrote:
>> [..]
>>>>
>>>> I can easily stop building blackfin - and, if the intention is to
>>>> remove it, there is not much point in wasting resources building it =
any
>>>> anyway.
>>>
>>> Right. At the moment, the plan is to remove metag, score, unicore32,
>>> m32r, frv and blackfin. If you are building any more of those, you ca=
n
>>> stop that as well.
>>>
>>> The fate of tile and mn10300 is still open, but I suspect they won't
>>> last long either.
>>
>> That's a huge list.
>>
>> I heard that CRIS is having some problems as well:
>> https://lkml.org/lkml/2018/1/11/403
>=20
> Interesting. I thought I looked at cris when I made the list and found =
that
> it was still (semi-)regularly updated, so I assumed it was still needed=
=2E
>=20
> (adding CRIS and microblaze maintainers)
>=20
> Jesper/Mikael: If you are considering to drop the port, I think it
> would make sense to do it at the same time as the others, so feel
> free to send me a removal pull request for 4.17 that I'll merge with
> the other removal patches, or I can offer to remove it myself.
>=20
> Obviously if your plans have changed in the meantime and you
> prefer to keep it for a while longer, just let me know and I'll documen=
t
> the state in the tag description for the arch removal for future refere=
nce.
>=20
> If we remove cris, it's probably also appropriate to ask the question
> about microblaze: Michal, I know your work on microblaze linux has
> been winding down over the years as the user base shrinks (just
> like for all others above). Should we keep it for a few more years for
> the remaining users, or is it time to let go? I would guess we still
> have active users on modern kernels, but that's what I thought
> about cris as well ;-)

It is not like that. I definitely have less time for Microblaze to
develop new stuff but Microblaze HW is still regularly updated and new
hw features are coming there and new versions are created. We are also
updating and testing newer kernels and using latest kernel at Xilinx. It
is definitely not in state that we should just remove it.

There are still a lot of users which are happy with current state and
there is no pressure to add new features like SMP/address extension/etc
that's why there is no huge development in arch/microblaze.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--MxfoN6WcoVwoQsOb6gfoRoHAk0ssu9Bip--

--GIwpndRIkyO8wCSAmwTMGhZHwuGbTMSUS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqf/rYACgkQykllyylKDCFl9QCdHWWT1cxO0TdL8Byn03uoMPve
jwgAni7efr2iqIDC3ELioHgBq/cSXADB
=eThE
-----END PGP SIGNATURE-----

--GIwpndRIkyO8wCSAmwTMGhZHwuGbTMSUS--
