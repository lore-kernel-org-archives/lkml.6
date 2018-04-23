Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbeDWR4d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:56:33 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59938 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932125AbeDWR4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:56:32 -0400
X-Google-Smtp-Source: AB8JxZpQU8iMtkdji9ReobLsWw2WPUgZV8WjtLOY3DGzlQOmTA7nabIPlV2UsFKIUWUYdcJYWFcMOQ==
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: next-20180416 - warnings from 'make tools/perf'
In-Reply-To: <20180423065204.cgzu7mvivrph3gfw@gmail.com>
References: <61890.1524462741@turing-police.cc.vt.edu>
 <20180423065204.cgzu7mvivrph3gfw@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1524506183_2556P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Apr 2018 13:56:23 -0400
Message-ID: <148698.1524506183@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1524506183_2556P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 Apr 2018 08:52:04 +0200, Ingo Molnar said:

> The warnings are harmless, and they should be fixed in v4.17-rc2.

Having been burnt all too many times over the past 4 decades by mismatched
headers, I figured I should mention it...

I see that in next-20180423 it's down to 2 warnings (prctl.h and if_link.h)


--==_Exmh_1524506183_2556P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWt4eR40DS38y7CIcAQJsBgf7Bd8k1fyHiMG8iI+v6syZxeCV5VGVQ1FG
nPP9T93vPtJp7ryQXq7UnFqw0ynmpC/UQLJO80eRgbT3FbiUSHcIBwkVBe7Jw9L2
Z3j8Za6hsi2JoCfswQjQtjaWooHFdX4WbUwWet5TYOYoDVwW1fhlMIkPkni24oM1
+gHYieoY8kjU49mplhwOKZwnR3HZgnoh5kOf/b0r4Acl6wFhPnOcoEbGhWvwel+h
iof2leHeRreSpSiCEP+cmgCG5NwjyoAvwiyKVVvLGOUsOE06/exbexDPOhgDNwx0
RrZ5VQt0el7zZ/i7oy58qjx1NYOy4wNWBx2CJyolZ7kvc++2lMo1bA==
=27F3
-----END PGP SIGNATURE-----

--==_Exmh_1524506183_2556P--
