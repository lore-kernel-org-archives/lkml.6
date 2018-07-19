Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B085FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760012084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760012084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbeGSPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:51:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbeGSPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:51:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8C9D21090;
        Thu, 19 Jul 2018 15:08:21 +0000 (UTC)
Date:   Thu, 19 Jul 2018 17:08:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.142
Message-ID: <20180719150819.GA28841@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.4.142 kernel.

It's not an "essencial" upgrade, but a number of build problems with
perf are now resolved, and an x86 issue that some people might have hit
is now handled properly.  If those were problems for you, please
upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                |    2 +-
 arch/x86/kernel/cpu/common.c            |    7 ++++---
 scripts/Kbuild.include                  |    5 +++--
 tools/arch/x86/include/asm/unistd_32.h  |    9 +++++++++
 tools/arch/x86/include/asm/unistd_64.h  |    9 +++++++++
 tools/build/Build.include               |    5 +++--
 tools/perf/config/Makefile              |    1 +
 tools/perf/perf-sys.h                   |   18 ------------------
 tools/perf/util/include/asm/unistd_32.h |    1 -
 tools/perf/util/include/asm/unistd_64.h |    1 -
 tools/scripts/Makefile.include          |    2 ++
 11 files changed, 32 insertions(+), 28 deletions(-)

Andy Lutomirski (1):
      x86/cpu: Probe CPUID leaf 6 even when cpuid_level == 6

Arnaldo Carvalho de Melo (1):
      perf tools: Move syscall number fallbacks from perf-sys.h to tools/arch/x86/include/asm/

Greg Kroah-Hartman (1):
      Linux 4.4.142

Rasmus Villemoes (1):
      Kbuild: fix # escaping in .cmd files for future Make


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltQqV8ACgkQONu9yGCS
aT5kbg//emAgkpPkWirFx1wrVbJd0zZ/0UG7HJClOR2i1vovFnH76Ln2WdcFUdan
6nlsOTG6ieNOfb33jakKu+FJEIW7Br472jqfsAlYBtH6d9aS8SwKNa7NKvysOvTr
ZLnHp7tA3Dh3UtfD1tB9334MmXmvLa0/UypCMVJlo35VHswqjklR5aVfjV8Nrlkr
bFF2Hj5bT+GfHS0zyIZ48aAVjgUNYaAyzMs78pjpiTYzBynXpZkaXYrbeTkzxn27
aP+HLorzykclk/RxUxYOPMuImpBsd73i3CUXbqmRjoWgFP+IYrqfVH/B3nE7Vxp6
VkSJmYHIKfXy8KoYsMSBZrX7iMkxchr9AePQ9jyJ9/B+5nphkWaU7QAbksBqOvbg
4K7GnRcPU2wbdbClsTsZPq7sBYE+GiNJD74MsjhsQ0RmW9IpXUzUewvW7YMgGQM1
mlmwzVJUTLpSCHulMi3EsnMXs9YP4ZGfeHYawbXdyMZ2EJOJBvdcmHrpszRF/STJ
35nDHEad2HFDt+Hs67pFfSfy7no4GWtqJ7IX48fiAlSXtWG/WVX0OxeAP7/+U4uF
sViw77XoSKGE/CuZuEvdioSCwBLAqaqkpjQ6AxulBUDoA0KPj/B4cYpq3DfK1+ig
zcyTYgC+A1IHFzhQLtvua6J6mgJXowEmajjq7nImGiS6TKYxJD8=
=fMeu
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
