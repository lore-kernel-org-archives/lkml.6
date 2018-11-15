Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2170522507
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPVkJ3FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2170522507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbeKPC2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:28:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbeKPC2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:28:44 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B1D223CB;
        Thu, 15 Nov 2018 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542298815;
        bh=GhIlKk7RdX4LS/XDlOC+iPR8tFEMb0oEGuNx8npoga4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPVkJ3FQcMkn6Hf92tOm5w7Yd9t5qZgJmA9VVUbgOm6fHWqDVrxc3Blxuk+GhO+rw
         lbyidh05/pECh82dcvXKQX5yK5VdlBCFQHsJP632MQrnfTaCg3O5LGt9ESk65hbvAw
         iC+xyanZpCLD50TYv/6JZN682k58FMLXD6Y0R8nI=
Date:   Thu, 15 Nov 2018 18:20:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zwisler@kernel.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181115162008.GO3759@mtr-leonro.mtl.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
 <20181115061036.1575223d@silica.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline
In-Reply-To: <20181115061036.1575223d@silica.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 15, 2018 at 06:10:36AM -0800, Mauro Carvalho Chehab wrote:
> Em Thu, 15 Nov 2018 09:03:11 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> escreveu:
>
> > Hi Dan,
> >
> > On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > Document the basic policies of the libnvdimm subsystem and provide a
> > > first example of a Subsystem Profile for others to duplicate and edit.
> > >
> > > Cc: Ross Zwisler <zwisler@kernel.org>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > Thanks for your patch!
> >
> > > --- /dev/null
> > > +++ b/Documentation/nvdimm/subsystem-profile.rst
> >
> > > +Trusted Reviewers
> > > +-----------------
> > > +Johannes Thumshirn
> > > +Toshi Kani
> > > +Jeff Moyer
> > > +Robert Elliott
> >
> > Don't you want to add email addresses?
> > Only the first one is listed in MAINTAINERS.
>
> IMO, it makes sense to have their e-mails here, in a way that it could
> easily be parsed by get_maintainers.pl.

I personally think that list of "trusted reviewers" makes more harm than
good. It creates unneeded negative feelings to those who wanted to be in
this list, but for any reason they don't. Those reviewers will feel
"untrusted".

Thanks

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb7Zy4AAoJEORje4g2clindrgP/1qcVPjXlzT/2KPN0TVNBnWU
znL7sRQ1QhswSAfRNWdSyqR4/15ANb8wz6lV4p22d+p/NuswrYRMqxWA5X6XTjUc
L8Y8SQPMXIaGnlY7hUjY2FSnYSyK+sW71zZe6ys6ciDEmXhJYZGYx+kY2OENZ9K2
lTIsQg5EPVNKP7lE9mMYe17ga1ctCDCzIuhvBLoIw7bHPHyefc4YCWRFJXh24vsn
DnUZXzfg8WLie/PcdWAqkQlCPkG784+d6jAaiEHIe4iel4nJfXf1tzdwaUUSPq4U
0Ri2m9l1KtdJHug1UV+/JFcQIq9I+M/rdjSqIkcZrKj1YIwKp39wqOzRe+bIVA0u
/SY0zI0osAjDyWV5HrQRJko7XlXFlJxoqJLW/rGa2B3E3pigyAxoIj/Cs5alxJQg
HYjjaktPfGWgW9i4/8IK2BJM8GdDbdG8qQe1v2neFPgbGC6tBGZMP9Rx/oXeq1NW
UXj4wPzGczoXxmzKgrNLviEgL7UfRD31gMl6vO1wxhkVsMzGhdyB80awqQWSTSek
7MztMEC0OM2aL043qrdH5oBqzCDgUaQL3KEY2O/r+BirBe1VlUpD3mW8sBvJ8gYs
WaiDPE3zkaQkYJYvIctnOrJKi9cm1DSo1GCN6xQrA3+hBWAULUUyI0fmG0S3ftrc
JOhcb8uIgYycsbk3MBdk
=/bPL
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--
