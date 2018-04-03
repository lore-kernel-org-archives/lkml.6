Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeDCCXu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:23:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:50882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754725AbeDCCXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:23:49 -0400
From: NeilBrown <neilb@suse.com>
To: David Miller <davem@davemloft.net>
Date: Tue, 03 Apr 2018 12:23:40 +1000
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rhashtable_walk fixes
In-Reply-To: <20180330.101826.1844442556880257787.davem@davemloft.net>
References: <152228607974.16370.14544827502467836789.stgit@noble> <20180330.101826.1844442556880257787.davem@davemloft.net>
Message-ID: <8760591103.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30 2018, David Miller wrote:

> From: NeilBrown <neilb@suse.com>
> Date: Thu, 29 Mar 2018 12:19:09 +1100
>
>> These two patches apply on top of my previous "rhashtable: reset iter
>> when rhashtable_walk_start sees new table" patch.
>>=20
>> The first fixes a bug that I found in rhltable_insert().
>>=20
>> The second is an alternate to my "rhashtable: allow a walk of the hash
>> table without missing object."
>> This version doesn't require an API change and should be reliable for
>> rhltables too (my first version didn't handle these correctly).
>
> Neil, please don't mix and match patches.
>
> Also when you need to change a patch in a series, please post the entire
> new series not just the patch that changes.
>
> Patch #1 in this series is unnecessary.  As Herbert explained this has
> been fixed already.
>
> So please repost freshly the patches that are relevant and you want me
> to consider for inclusion.  Also be explicit and clear about which of
> my two networking trees you are targetting these changes.

Hi Dave,
 I'm sorry if I've caused some confusion, but I didn't think that I was
 submitting patches to you and know nothing about your two trees.
 I was submitting patches to Thomas and Herbert, the registered
 maintainers of rhashtable.  I assumed they would review, respond, and
 take responsibility for getting them upstream, if that's what they
 decided, based on whatever arrangements they have in place.

 If it is appropriate I can resend all of my patches that receive an
 Ack as a coherent series, and send this to you nominating a particular
 tree, but I'm unlikely to do that unless asked and told which tree to
 nominate.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrC5awACgkQOeye3VZi
gblgbw/7Bs+w5kLnhO7r31SB4z38gCyYHK1lWub/bhXamriv0kdGyoPpZG2nBIW1
AtRzkAuTUtpdpDTUspeuFRvAVDin6JkYuX2nI4lFJpPq3iHWJ0Lxuqr0O5s+Mmxz
VxNQhj9x3M71tq4URpA0Zw0ejGhoomvgARKKL6M6tHQraW4b3KcS7ddnoGYogi5r
q6MHqeu1cM3XJPc3VlvKlXf0r2/o8ZfSsoNdzTnSYtxjYX7vYXqTrsxcWkTNfHwO
Bj/Qi6yCESmwGw0QkkV/dQVqgw6Cd5rqQ/vnZWa4B/2/xru1JaPdGGDIKUP1KaAx
MkznE29x47/GRao4iXKrd3cHJDYcvOfoQiD23UCGffT7SrtPe60UcpHKMXKquo8w
xEOz0PrFu+fq9F+achbcvmL3eRDj3ZGo5twaF/vlfuPh5lCCxepHxXrolnu0hxO5
HgfW6bO04CdP/VYftuuMwbMe9lQscX5to4/t1WHjDTJ8R5C4uTkAAGEZNEjwWduh
Y5KYcutFW1u/jza8FEWyqn0Z7OP6gVOrKm5hWaNj3WImrkvNkqoTGi30V9cS7i+s
3ylKBhsAHrz35x4oc1KyT3KcC1ekbC3Gy1BgdQtMiLbPHM5uk7X2P+GZVF1a8GeE
2xQUa6l5mlF3ynmMLb2fwTVd9Sk68UkDh15lCtXpp+29dLirS6A=
=LDxQ
-----END PGP SIGNATURE-----
--=-=-=--
