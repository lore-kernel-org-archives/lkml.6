Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeBRWPm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:15:42 -0500
Received: from pic75-3-78-194-244-226.fbxo.proxad.net ([78.194.244.226]:48288
        "EHLO mail.corsac.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeBRWPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:15:41 -0500
Message-ID: <1518992132.2542.5.camel@debian.org>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
From: Yves-Alexis Perez <corsac@debian.org>
To: "Raj, Ashok" <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Date: Sun, 18 Feb 2018 23:15:32 +0100
In-Reply-To: <20180213214002.GA27066@otc-nc-03>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
         <20180213140303.42mbzfxpypljy37l@8bytes.org>
         <20180213214002.GA27066@otc-nc-03>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Lsf0i4rxIq4C6g1RKkBY"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lsf0i4rxIq4C6g1RKkBY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-13 at 13:40 -0800, Raj, Ashok wrote:
> This version has only hw dumps for now, but we plan to add some other thi=
ngs
> like walking 2nd level page-tables, or get some SVM specific data from th=
e=20
> driver in the future.=20

Hi,

I'm not sure how much you know about chipsec [1], but with a oneliner [2] y=
ou
can have it print a lot of data from Vt-d configuration, including page
tables. As far as I remember, it doesn't need access to /dev/mem (but I gid=
n't
dig to check how it does it).

It might still be useful to have everything from debugfs because it'll alwa=
ys
be consistent with the current running kernel, but at least it might help
users reporting bugs.

[1] https://github.com/chipsec/chipsec
[2] http://paste.debian.net/1010105
--=20
Yves-Alexis
--=-Lsf0i4rxIq4C6g1RKkBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqJ+wUACgkQ3rYcyPpX
RFvEuQf+NF2yWLkXIM6/XmEXZGQboq4coTLy06M/aT/fQfeUAehE2rBhWQXkmJqF
JXKFuuy6BXoQ1WW4qq6r/1tanadjeRSDTT2PloE1H/g9wppk9tqXG9S/Dqfzhbjo
0dc1Ctl7skiO3ioBH77BI5KhjFXBJay9YMvvoNYHg4Fud+M/Ga62IYQUCaa4x2Xp
mWnLJzY4EPZhQmv1o+ozBVFBltQh2tUER3+W0FHy95OuEv4GaSNhsfrDqhKa0B6a
+j+278FwoidB9kk8LVrG3xFChl7SGF+r2DCsfCMKHaDJaMvWioTOxaqEwIErU9gX
C90bwed2cfMu31qNmdnkxG1cuKVenA==
=egRp
-----END PGP SIGNATURE-----

--=-Lsf0i4rxIq4C6g1RKkBY--
