Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDLXJf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 19:09:35 -0400
Received: from anholt.net ([50.246.234.109]:58684 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753031AbeDLXJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 19:09:34 -0400
From: Eric Anholt <eric@anholt.net>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix leak of the file_priv that stored the perfmon.
In-Reply-To: <20180412111446.742450f0@bbrezillon>
References: <20180409205813.7077-1-eric@anholt.net> <20180412111446.742450f0@bbrezillon>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Thu, 12 Apr 2018 16:09:32 -0700
Message-ID: <87po34dntf.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> On Mon,  9 Apr 2018 13:58:13 -0700
> Eric Anholt <eric@anholt.net> wrote:
>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

Applied to drm-misc-next-fixes.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlrP5ywACgkQtdYpNtH8
nuhgiw//e+nmZjTrewwe2Kq3rWchoVYIf+72xJN3aAQz5xxeGl9cvoBEwZL9HT1K
pnE43YLHTFKo9uof0pKjdN5RRG+uY1gGdbz/Vw/8wXQN8YBbNlUKIO+CMcMiSIFx
ki06YYhdCZQlC1PU5RAhmBz1Ffkn/5EO8NmS9wHeJm6Bl2wHzNW8XSR0djssqSJM
sg5XaCnEOqZff7B0IpOSMk1ZNYLw3o/FSV+Z7VYE5CaTjA2pzuw9WkWJXIHhtGLb
zt+gScvL6m6cX6MLlUhbCR0a9QAzYSa+rIlf8PcfcjvER/gbdfkLQMIbbijuRNg1
PA81aSD25VC6xaYwFOf/jsBpRzcKnJJnakxY+fKb5QPvZAiKuwalS3c3am2WcNH7
tTjWsRiP9trjVoVGqtphv69JR6W/WZDJFZGLsnlK01GdxucvKs4IxgJiq+CRuJVz
ndl6673S+fcS7452As73yjZb2m6rOp6Um5BfvC6mm58hsj0G8N2vvZG57bmiCLkM
omfyKeWbWzXIXZWHsopBWJkch+oQpguZHgm79b+Xd9dzxpMS3dzZdBEEoWkT5j9c
R8Og7z0aSEjA1EA+1Xuy/EIQeb/15Tqmcn/lkFNwAKnQSKFT2DEr5/dLVBq20wwe
jtJ5MXxDZgCR6mrqEsIjf3muvi3EWZ1KnnAmjChQioQC0ThbJSM=
=cG4F
-----END PGP SIGNATURE-----
--=-=-=--
