Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeCTP5Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:57:24 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:33560 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751330AbeCTP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:57:23 -0400
X-Google-Smtp-Source: AG47ELtRv6eLd7TbRHknW1E8bU3krVAIzAoyPR6kOVNtB+KcoEPQh5Z2M/QBQDNsa8MPBlbogvd+oA==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: ip6tables *broken* - last base chain position %u doesn't match underflow %u (hook %u
In-Reply-To: <20180320154842.GC24075@breakpoint.cc>
References: <24374.1521559053@turing-police.cc.vt.edu>
 <20180320154842.GC24075@breakpoint.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1521561434_3137P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Mar 2018 11:57:14 -0400
Message-ID: <30114.1521561434@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1521561434_3137P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Mar 2018 16:48:42 +0100, Florian Westphal said:
> valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu> wrote:
> > (Resending because I haven't heard anything)
> [ ip6tables broken ]
>
> Sorry, did not see this email before.
>
> I'll investigate asap, thanks for the detailed report.

No problem, it reverts cleanly and looks like it's 4.17 material,
and finding stuff like this is why I build linux-next kernels :)

Just remember to stick a Reported-By: on the fix :)


--==_Exmh_1521561434_3137P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWrEvWo0DS38y7CIcAQJRDAf/Y3J/I7eyDI/ychev+yOtsayqCS+g/2G3
hjb690AkLj1hT6pvjbQdeo3QjdEWrtn5nXOkVlcDV4v18JlUrgXNWKcp8DuCrEmf
OQ/mL5Wv01tymVooxGOy/Wu9Xdiy1EZLJaO1yHujixvSa5lyJEL+MCghHMHMXlzc
IkGya2jkvPh8/FVom8RuBBwNXmfOyPWTui1+h19EFwdZ0C/YpHBWr4m7SL7MnBwu
GfXI3Uj7n7/INW7R6tDqVnL/CKwheX25EKfVz58dcmMgtcld0PgtKfD904naJZjH
o7/qQCAlGyGxiCaNFEzNLbjnu4kaUhSohTLVUPzifGnOx4wRs3Cpiw==
=2S3u
-----END PGP SIGNATURE-----

--==_Exmh_1521561434_3137P--
