Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E94C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B13823F56
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B13823F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeGFJua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:50:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753367AbeGFJu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:50:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B038EAC9A;
        Fri,  6 Jul 2018 09:50:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     kbuild test robot <lkp@intel.com>
Date:   Fri, 06 Jul 2018 19:50:15 +1000
Cc:     kbuild-all@01.org, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <201807061601.oe0LkaJd%fengguang.wu@intel.com>
References: <153086109256.2825.15329014177598382684.stgit@noble> <201807061601.oe0LkaJd%fengguang.wu@intel.com>
Message-ID: <87fu0wy9pk.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Jul 06 2018, kbuild test robot wrote:

> Hi NeilBrown,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on net-next/master]
> [also build test ERROR on next-20180705]
> [cannot apply to linus/master linux-sof-driver/master v4.18-rc3]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]

Patch is against net-next, plus "rhashtable: detect when object movement
might have invalidated a lookup" which was posted earlier (this
dependency wasn't made explicit).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAls/O1gACgkQOeye3VZi
gbmQ+RAApPVHqd2gqf7zwZ1Ak6mb3PFty9hC7stUmySv61BJ0clPixy7EzXGJhKO
7DF66oU/IsuhG97n0e0/kU0mdFUyDKGTlnBmGflxSugB8a/X+3rzgzvgA1QMLHgk
4LwP4veC8pxzzCrcOeG/lsPMtN+hJbcTBIcYSwAkS4nCSNcOrh6UzHFzJ7ZuGuD6
t+ziG0zUkRXqwUaMz+MFCWBqSZIYLDKlIa/qMMAjqB2oADKCxDrTKVJ7grFa4UJT
oYFd3pB4mx8M0DH8Hv8AXCTXmukvwBQN5SLP+JMjIm/aZcSppXj9szH7VdJsxAMt
n5qdyNTufCWjBp44iFkPmGIK4uCOKGJz0Fb7aerKy7ESxIamLANCqYQeJt7q07Gi
3eUi7b1CuT2nVRss4T3qhPnNqvZRZiyybbgf7MXMazMolCj4J4Z8uF/T++/aME95
Ufm1LTDvwimbTOI4Tuvm1kWJZQARxuBwqa02AwhDZV2ISIEwUhFcoXrS8dfbhQQH
zCqzV6YpO0JkjpQREazLSh5fJwNzMh5PpDMjppMjokMcWYDoz6shX5ijVmE0zbX/
6VQ2SQUVhUQIPHrXYJDziLgj//s9GmDqhrnYkvo0NrsuPI9GVMvmjoYcOzotZqjy
kcuEyAV5r418MERXAvI0ptjPWG0Ly9rsTeIe3rvvB3gFeu5r3h8=
=WRv2
-----END PGP SIGNATURE-----
--=-=-=--
