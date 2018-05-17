Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeEQQwk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:52:40 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:53617 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeEQQwj (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 17 May 2018 12:52:39 -0400
Message-ID: <88678a872bfdd8d7477c374a2ab1ee9dd9324ec0.camel@suse.com>
Subject: Re: [Xen-devel] [RFC][PATCH] KVM: APPLES can improve the
 performance of applications and virtualized systems by up to 49%
From: Dario Faggioli <dfaggioli@suse.com>
To: Weiwei Jia <harrynjit@gmail.com>, linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xenproject.org, Weiwei Jia <harryxiyou@gmail.com>,
        jianchen.shan@gmail.com, kvm@vger.kernel.org, dingxn@gmail.com
Date: Thu, 17 May 2018 18:52:23 +0200
In-Reply-To: <CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com>
References: <CA+scX6kYH8Y9_f1PLcMHG-MD9bhXgd4gGpkJanjzvwwj9L=aOQ@mail.gmail.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Rln2LqRGYgWnOYaKsWpQ"
X-Mailer: Evolution 3.28.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rln2LqRGYgWnOYaKsWpQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-05-12 at 16:27 +0800, Weiwei Jia wrote:
> We already have a prototype implementation based on KVM (Linux Kernel
> 3.19.8). Our patch for Linux Kernel 3.19.8 and the paper describing
> our idea are available in Github repository [1][2][3]. We are pleased
> to revise our patch in order to merge it into Linux/KVM and XEN. We
> hope that you can test and adopt our approach/techniques. We are
> pleased to get some comments/suggestions on the approach and on how
> the idea can be adopted/tested by Linux/KVM and XEN. Thank you.
>=20
To see how this is being handled in Xen currently, I suggest you to
grep for:
 ple_gap
 ple_window
 SECONDARY_EXEC_PAUSE_LOOP_EXITING
 EXIT_REASON_PAUSE_INSTRUCTION
 pauseloop_exits

I am aware of your paper, but I haven't got to being able to read it
carefully yet. I'll do that (but can't promise when).

Regards,
Dario
--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/
--=-Rln2LqRGYgWnOYaKsWpQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlr9s0cACgkQFkJ4iaW4
c+4tjQ//VgJIZVqN6Z5TzS7FkTfoILjNro/0A9ht0LcIaLMgpfRVArXgiEvJhuDJ
M8PVtW5A7nj/bGRH2TdLgcpszqXzpojtDJmvSbYd/Eeo+HbLk5T/hy+n94ttu2Fc
5layirUFu84vVzNLseLIuFfNWafPLx8pWCKqLdQtOJQsfi55vgGpC62+mcsjb7Op
3UcSB9PIeXbuzKDSnUe0x+nIpnOXMJ3v774ENAueHWuYZPhR+I5+/IJzfikUpOJy
P8kxpJa7fAKkBbBQw3cEK//oWoJcyoI+SnoKBFgkuj1BoEdvByafFwgPu9lave0m
UeudyDsA//7ua4zaQjTCjOza+pUsglHEmHOhKxZkbT7pqKkpM0c29xvneY8DKKjo
n4zLIeo2r4hbwT/LqZM96QysJH6EdrhUAPoBjEpIFqwYX6rRfXsGbsXK27cZx2eX
vWraLTZUplooT1Y8vNpScVUeoJhGUwfnC9V/NaG1wZpHBtpXEMwRkO7g8YDZwmCZ
vgfTErv7/3L7pPTUB5ygoqrLj15HRSmMzmHhFbgNTr5XikoL6pdZOacg7V0dEvjQ
IH78HfGAqurFspVbsg28I3yRgtkFD78ozpjlzJzwqvbGYypf2xgHG/nhgQO6atFA
11YyIX8RDjcwrJ9mKiUfezyl8yu9gzxFTp9iUE8vfuEGUHAUr2g=
=kKIQ
-----END PGP SIGNATURE-----

--=-Rln2LqRGYgWnOYaKsWpQ--
