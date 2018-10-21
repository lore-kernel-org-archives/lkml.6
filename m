Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A13ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 21:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A6320836
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 21:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A6320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJVFgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:36:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbeJVFgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:36:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "To"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 892EBAC11;
        Sun, 21 Oct 2018 21:20:22 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Oct 2018 08:20:11 +1100
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <20181020134908.GA32218@kroah.com>
References: <20181020134908.GA32218@kroah.com>
Message-ID: <87y3ar80ac.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:

> Hi all,
>
> As everyone knows by now, we added a new Code of Conduct to the kernel
> tree a few weeks ago.

I wanted to stay detached from all this, but as remaining (publicly)
silent might be seen (publicly) as acquiescing, I hereby declare that:
   I reject, as illegitimate, this Code and the process by
   which it is being "developed".

It is clear from the surrounding discussions that this is well outside our
core competencies.  It will be flawed, it isn't what we need.

I call on any other community members who reject this process to say so,
not to remain silent.
#Iobject

We don't need a "Code of Conduct" nearly as much as we need "Leadership
in conduct".  Without the leadership, any code looks like a joke.

I call on Linus Torvalds to follow up on his confession (which I think
is momentous and worth celebrating - Hurray!!!) with repentance - a clear
demonstration of change of mind.
  Linus: I know your intentions are good and am confident that, now that
  you see the problem, you will be able to effect a solution.  If you
  are not so confident, please be aware that there are many in the
  community who can see clearly where you were blind, and are willing to
  help guide and coach.  Please reach out to someone you trust, and ask.

I call on the community to respond to this confession and repentance
from Linus with forgiveness and restoration.

I have no direct hurts to report and little to forgive, so my
forgiveness can only be worth little.  However, for what it is worth:
  I offer to Linus, and to any who are seeking to improve their
  behaviour, my forgiveness for any past hurts, whether direct or
  indirect.  I hold no grudge, and wish to continue working together as
  the need and opportunity arises.

  #Iforgive

I call on the community to effect whatever reparation is possible to
those who have been hurt. Sometimes an apology is all that is possible,
sometimes it is all that is needed.  If you are ever in a position to do
more, please consider doing so.

  On behalf of my community, I apologise to all those who have been hurt
  by us, for the lack of respect and care which should have been shown.
  Where I have hurt you, whether through action or inaction, I
  unreservedly apologise.

  #Iapologise  (or #Iapologize :-)

I call on you, Greg:
 - to abandon this divisive attempt to impose a "Code of Conduct"
 - to revert 8a104f8b5867c68
 - to return to your core competence of building a great team around
   a great kernel

 #Isupportreversion

I call on the community to consider what *does* need to be said, about
conduct, to people outside the community and who have recently joined.
What is the document that you would have liked to have read as you were
starting out?  It is all too long ago for me to remember clearly, and so
much has changed.

Thanks,
NeilBrown
#Iobject #Iforgive #Iapologise #Isupportreversion

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvM7YwACgkQOeye3VZi
gbkjDw//cyr6vp+JO+xqqQ/nMglaPJQ5EHrKqC74trz5zPzqJlWIihauFB58+rI5
s3FS0pRz54A979Z/sO4I6Q78zEM+WkZdkBehj/a+z/ofst89A0CvZplJGSbYk9MD
OuTyhC54sUcW4j1Fx+f2t4plbj0XhWLIGzBpQUI28mMQccqLu1OvVIHci+dD5XMV
rQwg9zS1z1qMHZGXmGBOqjAK5rtBk17Xov9ypig4Gnc5RTgZgOdzmqIM8kLeoal1
T1qUzEqKWT4IGNDNEuYlngQi2CMyBH5qrvRVxqpjlQxBU2fggxE7YnnVzjm9FoY0
g84ywIXzM1aydOkmZz+hJglO9iMgwysNk03uIyESe82FIr7zrj8qplqvHrP3ye0X
px6tIkkBgFc7H4eJQIMzV5Mef3D5JDwmNxlnapwvK1Hr34/whCbSoPl9ZS5TymfM
0U19Xd93fwlkaLeMU7BomuSJtOX1skZp6RoTXDmJvbHZHBrV+wfruQrHRjOPWn70
dxvM2/fddAUTnxOk4Q7mpwFH85KPeLEryoG4YZLmwedW2jQXuASAnO+zwg+vr9mD
CkQSjzdAZb1d4S6kq1B7l9UH2XiJaflqpys/AohKR5ZgIJkngeMQATMzsoy4SrBP
ZuSeLhWBT9MLIDfF2iv+IJVLkx4i1CuYjZKfM5rRf22Hq8E3xdY=
=qQ/u
-----END PGP SIGNATURE-----
--=-=-=--
