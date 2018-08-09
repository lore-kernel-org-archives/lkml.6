Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28213C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D546421C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D546421C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeHIFOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 01:14:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbeHIFOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 01:14:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C04AAF59;
        Thu,  9 Aug 2018 02:52:08 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Frank Filz <ffilzlnx@mindspring.com>,
        'Jeff Layton' <jlayton@kernel.org>,
        "'J. Bruce Fields'" <bfields@fieldses.org>
Date:   Thu, 09 Aug 2018 12:52:01 +1000
Cc:     'Alexander Viro' <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Martin Wilck' <mwilck@suse.de>
Subject: RE: [PATCH 0/4] locks: avoid thundering-herd wake-ups
In-Reply-To: <01c401d42f70$5c034db0$1409e910$@mindspring.com>
References: <153369219467.12605.13472423449508444601.stgit@noble> <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org> <20180808212832.GF23873@fieldses.org> <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org> <01c401d42f70$5c034db0$1409e910$@mindspring.com>
Message-ID: <87600ktfou.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Aug 08 2018, Frank Filz wrote:

>
> Now here's another question... How does this new logic play with Open
> File Description Locks? Should still be ok since there's a thread
> waiting on each of those.

At this level Posix locks and OFD locks are almost identical - just a
different owner.
So this enhancement should work equally for posix, flock, ofd and even
leases.

Thanks,
NeilBrown

>
> Frank

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltrrFEACgkQOeye3VZi
gbkJ8Q//YbnVAQEQfIwPXJV43MG5m/w7rjygVH5X28iC/Ig4XUbC3uMaFuGh2Cr1
d0T6s/TFtz1QDQ4533C4xRcc+toIuqPcaacbirBroAEP977LAULpDhl6f1QoELg3
X/febg/jyQYpkQfAfhZqn38gGAS6GUcci6VymZp+8d1FIZ8TK0wVTyfxrk02Q42m
nOJwoCN31oD4dEqBVEvN4yr3BEr3lPRFGEGa1dNg2ZiBQ6GYmux0Euk7rneUY7kR
h8l1V2gEuBjsp3642d6XrOoD5HgRJlLyqlJ13VePnuwxGZq3rZ4l8ddlOwlPpvuk
VHztBooWTivaOYvdxeWdUUZPYUvTg0O+RlYVG4FwmYVSKPA3KGwxgcLHKDDLfHi0
oU7nzYEM16IAnjmnqR8dFjPHFanL0Y3zt32NuwXYg0QLi9Z9W72fyVxhTbtO6PmQ
a5VnB21duPelv3/oGe80CqeKYFoOAm0NEMBOcTfAsjT1LYfxvzkDTrhOl9T2SOlH
6YNx0VI07GChD6EISjNrx9mxPmGL7hOr2CAYrOhmkH+R9JTYKPG+qHJSXumNg6KV
jJFGblOOHpJm1a6PtOMdasZveFDOaKtJ8RN97puKVVH2zFSGluDBnZlHTkpYDW3w
qKa0zaUaqTl6Hn7CV+FEhSfNNrlb73bci+PQ4TeDnhuE9Kgt3XY=
=6tBA
-----END PGP SIGNATURE-----
--=-=-=--
