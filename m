Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9619C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BA52075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffwDasYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BA52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIEK3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbeIEK3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:29:41 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA5020658;
        Wed,  5 Sep 2018 06:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536127269;
        bh=p9RdJ0MbCuNXHX31QpKnhhC1B9GO9yK9aM7F5wAjSHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffwDasYmxn0Mgk4oOiLyeJggect6WAf7r6zSQR/hZ2eNzOO2qKXSvlg6s4mC0fTXs
         MLQ86XEJLSgLjOollP6M1Yhs1AWhwS/aHVzwnb5jZBBQYjryCcg5BIpOxmTFHKhaV/
         GGSRQOTatbanJSV/xrzpBseaW0wx7vZDigxmfrBY=
Date:   Wed, 5 Sep 2018 09:01:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: nes: add unlikely() to assert()
Message-ID: <20180905060106.GI2977@mtr-leonro.mtl.com>
References: <20180831192418.12346-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20180831192418.12346-1-igor.stoppa@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 10:24:18PM +0300, Igor Stoppa wrote:
> Typically the assert is expected to not fail.

This whole assert can be removed.

>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Acked-by: Doug Ledford <dledford@redhat.com>

Most probably that I missed discussion, but anyway, does this
"Acked-by" come from internal or external discussion?

Thanks

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbj3EiAAoJEORje4g2clinidUP/Rork9n9fN0ngNcahEEtYG9U
2qTbEKea5ZwHgXvT+0b8PNCdghqLc3WpaJh15aH7lxs4Faue1qCP8hD5djGu99To
G5eC6hYPGUdN0fR5TEn91pNls5Wsh+BgHhU1J81zR/9u15h8+QpE8KhqhNTi2VWs
gvD99s1qEhUvjDxxCbN3wEEVv//Ld9gcZfYK2GaVOaF57qRBFC+bS9xT0kEgOeC+
5Zm/hwh0Soamzar6jKqT5QakBK6TdxMOyGRY7vLGOgmE7/bS378/VML9pgsdA3ge
XQLWYgBDNIEb4bvVo8VUp6QzSA1faxgoRPz8g0XTg9NaYnFFokvAatTUZJyBkkwQ
9jRwjz1GthYMBAWzsx44QVUBs1qc0H2AahZN8dtn4mqI8zkPHQwvis4edfHc/J8S
f3///vRUhxvYI2OVCPXYpy3scGrG/RapO1asC40ymvWM4tI+9wWK7HZC6u+cXmDS
kPL/VCaLYStWiCxP65v2MTaHOTZ1kx2fZkGsBctUTB0c+F90GPe2zWcVyaNVuEK9
n2UPNXR7j2p5htjcZqslqGf/s62ReH1RoiaH+oj+HQhlKGIY6LG54iDaCbWSwV1g
vL6RiuhSQ6mbagxwuC38J/1WdrpT94/dApGnwuFfqlEVrZiuGYOWRt+ZWU9iFUz2
2z/lL+2+WvjiwqW8TYDI
=abR1
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
