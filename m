Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1544821-1527147262-2-1360457035908465692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527147261; b=fIDt6rNbK3a3DC5ZPYkfhmmqQFRD7GiD8ACwXh8uEirCmPPY0+
    LiLmmqP7GZep2XrTMfp5DrBM1gVkYdywZOiYbRuUacdopeOGqls2aVznd4POGjfm
    KNXwbXN3aGoDV6UK/pU2897ptfnkEzvpdOy0+CGalTSc+IRK9NbE7MdC1pbmMdLS
    +89nejEljYvSwfboMR2h5LzF5In6ySt3K6uxrf7cywgLT911eJ7D2lPweJuDrgpO
    YWRWooZ20BaO/la0CuHGk1KNo+peoWcgLCCU9S6wAUFRWnmaxwN/vrO9XRQIhB1Y
    u8BfJaJCOS3Y9I3QWI72IhCmrcjVDqXL9a5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527147261; bh=N4w31hSeb/KQbxU+krAluFAekTdH2T
    XS3QIEeSBIWc4=; b=R1U6RRcD07cxqF8w4XkRN1jCmmwabhRP0e/Ius2/9ssd3U
    M1Thq9qE/js6CrS/hXijlbryGwlARAGAvUcfowC3BYezgqUsM/or5Qql18mvSl9K
    84QYN9oC6D8QnLJcQFW1TinV93tBzW1SRnt38THeT1lZIrIHqNl0P0VvTSBcXla0
    TxP3Roacckbypanf88dY3UgcZunktVbvchiQxHLQJfwEjoQ8XzIQmnoFNXZNl+Ik
    noVgBD7wEzp6ii2q0y26ZpZCxId+UDg0Po0XG8cKa9Tb16rYZVTS04qaBviwwzb7
    WLxpl9EuKCbBml9SSrj9nBI+boYrHT25J2Ii9Kkw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE2SvuhZlbDtS5yI5INa/xb8oR4Dp4vi9vkf4re3+Icmjil26yjnYJYi9FaoueAjDgAE+Yxai4KptH7ljTTdaaGzQrKiwjVleJUBdviPE8Epv+r4gn02
    gpvVc2GZAukSlWHGJrDoIJx+8Llt7W2CcaJcnpLIA2cH9SyelatbYeSnW2IUd5zE+s6lgVJ3yoGjMcLMVDXlu6InpS3SCpXdlRXsdaAIqI510cKFGZoXpHNa
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=bGNZPXyTAAAA:8 a=dwvcf_ZtjtByuscllMIA:9 a=vZLD4xpLj1J1sDsn:21
    a=6h8LlQTh7EVv-d8R:21 a=CjuIK1q_8ugA:10 a=uCQm_HyD9bGlZGFz87oA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=yL4RfsBhuEsimFDS2qtJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935591AbeEXHeE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 03:34:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36743 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935609AbeEXHeD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 24 May 2018 03:34:03 -0400
Date: Thu, 24 May 2018 09:34:00 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v3] usbip: dynamically allocate idev by nports found in
 sysfs
Message-ID: <20180524073400.qqwyy7zsihjjswse@pengutronix.de>
References: <c57fa7e9-d811-234b-fefc-1be998c5a8f1@kernel.org>
 <20180523092256.25922-1-m.grzeschik@pengutronix.de>
 <ac85c509-72ec-c126-afb7-521ddde87ec1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qruuw5b52p5p2hdm"
Content-Disposition: inline
In-Reply-To: <ac85c509-72ec-c126-afb7-521ddde87ec1@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:32:13 up 153 days, 20:10, 75 users,  load average: 0.10, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-usb@vger.kernel.org
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--qruuw5b52p5p2hdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 10:44:57AM -0600, Shuah Khan wrote:
> On 05/23/2018 03:22 AM, Michael Grzeschik wrote:
> > As the amount of available ports varies by the kernels build
> > configuration. To remove the limitation of the fixed 128 ports
> > we allocate the amount of idevs by using the number we get
> > from the kernel.
> >=20
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > v1 -> v2: - reworked memory allocation into one calloc call
> >           - added error path on allocation failure
> > v2 -> v3: - moved check for available nports to beginning of function
> >=20
>=20
> Hmm. With this patch I see a segfault when I run usbip port command.
> I think this patch is incomplete and more changes are needed to the
> code that references the idev array.
>=20
> I can't take this patch.

I missed that get_nports depends on vhci_driver->hc_device which is
not initialized that early. I will rework it to get the hc_device
by parameter and send v4.

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--qruuw5b52p5p2hdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAlsGat0ACgkQC+njFXoe
LGQf6A/9EHkG4NJ39OCL/sPOIOVcpMpUpNygcirXau208M5Oc8GgW8xtJuBjJ+f2
2NrCBPeSKPvw70C0IfxjuDYKCQgIMO+HI8MWLhnFuzk+1+n+mF1zspA8EkRUdqZx
S2b8myivm6E5G59ShSMj+skY9PtLOmoGOlE/QheuWqwD/GkTOFE449Zi+Z5rqOTz
wc4q/u2ntr6ZlgTmcsIinfxBvW8Gs/B7GHGA8wGBsm25/BSI5vzDVfICJNpPOig1
gkMw6OghL8VhX/O6Es4KpP8vlvxk5y2zYnP5YpQ4gT//bFXoT6i6b5SEWCu1a0TK
p9rUDlBzmgn0k06pr5jF80rUNFhZ/hakquWMoMKf88su3T9oy2/oIsuw3ZEIQxXP
TRZq61d3d59vimT0zAfzeNz0Wx2zRxz7/KyqwLN8dvVj8hWcQ1cBYZDVB5VP9Nvd
bSHUC5rYX27+xyJZ5jcBdZCV9M39yg0NF+L8FHX8LHOvUF72cx6kUYPxY7jzrzB4
IHxcwhaYsA/e/GtO0FqZsz74E5oTBnRs2Kju9maHJkm9J3aiFUxfWVMKybsYYek3
/GLSJFjeDdedaVksmV6bSvf/SIc0MMOMvQC4pw8jTz/5NVRnGqncYtkEo/lH+kBH
2Lxyhmih6K0vw/Jef7FJtyQEXumjt4oEPm/xme7dUQ8UCQRvZEI=
=NuhD
-----END PGP SIGNATURE-----

--qruuw5b52p5p2hdm--
