Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80224C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B73F206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DVjOYPw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B73F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeKGFPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:15:33 -0500
Received: from ozlabs.org ([203.11.71.1]:40759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeKGFPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:15:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42qKqF6dMgz9sBZ;
        Wed,  7 Nov 2018 06:48:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541533722;
        bh=MAWu4bbuelQPy0amkoWOWl6TGnTQfjQ0O7SBvYFXh50=;
        h=Date:From:To:Cc:Subject:From;
        b=DVjOYPw4jMrSiT5FSvmqiz9eJFyHpEpBgrNkYB93+2FSVj3MaCKGGUohEJ3sG2mUQ
         J+71xw+zRwkfOfR9ag4Z110/MD6tOwqW7gTwx+bjtatov8adq0A2DgHiLt6DKppsN+
         drh91xZ7W1x1fhLcFi6VkrKfLJeAx3XtuaGKHdPv65ZVeVPmBfVsuNAsPYAITGcjWW
         4dtdt9maUkGdAdga5YXgoo4kYeUL7iR/4Asxc3YGS/UrM7amBpYgtad300ZIw94N6x
         JeLw+pc8ilDLyJA1HUn0m7jbfLkU8QcPohQ3SMGfflMAZhkmTsreN/i4XRqkdzuWa1
         7rhBSkwhMASnQ==
Date:   Wed, 7 Nov 2018 06:48:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the scsi-fixes tree
Message-ID: <20181107064834.734f322f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/L7rKo.3z7X+WuKycZom69CC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L7rKo.3z7X+WuKycZom69CC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Commit

  85ee0a7b2d53 ("Revert "scsi: ufs: Disable blk-mq for now"")

is missing a Signed-off-by from its author and committer.

Reverts are commits, too.

--=20
Cheers,
Stephen Rothwell

--Sig_/L7rKo.3z7X+WuKycZom69CC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvh8BIACgkQAVBC80lX
0Gzhuwf9H46VNyS60Wd2VFmlxnzGhYl/mtT8UxKlvJ3IdGjkj713SXFI2x/WAJzl
DrrSFjcdlsMOiGFlRhIDTeDBNBjvyDLkQKSM0J3ChO+cHJlyBjGC+hAA6hoZEoCi
kisEeJh3ta9uNCs5zOVn5AVY12wooaYS8yEtsql14gWqL0JfEF2fCUsC6dDHGheO
1KTx3slW+edkOdsDD6jSVln8hUUpan6WmAd8O9qIaR1UdOTN+yAGEaxg3bvC2Qh4
cJwX/mKAxvDdT7cDGBvg7sPCtergEgWj8gD4MWLO2cyei5bzLIWv6C1EvtJVBfSl
5TeVfrY7AROsTvw40QGpSS8I7ypz2w==
=iZGb
-----END PGP SIGNATURE-----

--Sig_/L7rKo.3z7X+WuKycZom69CC--
