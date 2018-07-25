Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F09C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A36A20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A36A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbeGYQqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:46:04 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:52643 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbeGYQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:46:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B25C1837F27B;
        Wed, 25 Jul 2018 15:33:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rifle55_788d6c850ea34
X-Filterd-Recvd-Size: 5389
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 25 Jul 2018 15:33:48 +0000 (UTC)
Message-ID: <0fa2951559a9618c635d5a1fc6d4e32a5b795826.camel@perches.com>
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-iio@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Date:   Wed, 25 Jul 2018 08:33:47 -0700
In-Reply-To: <CAK8P3a3tOuP1FVS7oD1UhO5s4C+fLkL8VT3eCpRnSxBZxKzf6A@mail.gmail.com>
References: <20180724111600.4158975-1-arnd@arndb.de>
         <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
         <aa39b6d15f44555cb79d5ebdef74aeab19003d6a.camel@perches.com>
         <20180724175531.75276cf4e539124aa9e27177@linux-foundation.org>
         <CAK8P3a3tOuP1FVS7oD1UhO5s4C+fLkL8VT3eCpRnSxBZxKzf6A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 15:12 +0200, Arnd Bergmann wrote:
> tools/perf/tests/.gitignore:
>                             LLVM byte-codes, uncompressed
> On Wed, Jul 25, 2018 at 2:55 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Tue, 24 Jul 2018 17:13:20 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > On Tue, 2018-07-24 at 14:00 -0700, Andrew Morton wrote:
> > > > On Tue, 24 Jul 2018 13:13:25 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > Almost all files in the kernel are either plain text or UTF-8
> > > > > encoded. A couple however are ISO_8859-1, usually just a few
> > > > > characters in a C comments, for historic reasons.
> > > > > This converts them all to UTF-8 for consistency.
> > > 
> > > []
> > > > Will we be getting a checkpatch rule to keep things this way?
> > > 
> > > How would that be done?
> > 
> > I'm using this, seems to work.
> > 
> >         if ! file $p | grep -q -P ", ASCII text|, UTF-8 Unicode text"
> >         then
> >                 echo $p: weird charset
> >         fi
> 
> There are a couple of files that my version of 'find' incorrectly identified as
> something completely different, like:
> 
> Documentation/devicetree/bindings/pinctrl/pinctrl-sx150x.txt:
>             SemOne archive data
> Documentation/devicetree/bindings/rtc/epson,rtc7301.txt:
>             Microsoft Document Imaging Format
> Documentation/filesystems/nfs/pnfs-block-server.txt:
>             PPMN archive data
> arch/arm/boot/dts/bcm283x-rpi-usb-host.dtsi:
>         Sendmail frozen configuration  - version = "host";
> Documentation/networking/segmentation-offloads.txt:
>         StuffIt Deluxe Segment (data) : gmentation Offloads in the
> Linux Networking Stack
> arch/sparc/include/asm/visasm.h:                              SAS 7+
> arch/xtensa/kernel/setup.c:                                         ,
> init=0x454c, stat=0x090a, dev=0x2009, bas=0x2020
> drivers/cpufreq/powernow-k8.c:
> TI-XX Graphing Calculator (FLASH)
> tools/testing/selftests/net/forwarding/tc_shblocks.sh:
>                             Minix filesystem, V2 (big endian)
> tools/perf/tests/.gitignore:
>                             LLVM byte-codes, uncompressed
> 
> All of the above seem to be valid ASCII or UTF-8 files, so the check
> above will lead
> to false-positives, but it may be good enough as they are the
> exception, and may be
> bugs in 'file'.
> 
> Not sure if we need to worry about 'file' not being installed.

checkpatch works on patches so I think the test isn't
really relevant.  It has to use the appropriate email
header that sets the charset.

perhaps:
---
 scripts/checkpatch.pl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 34e4683de7a3..57355fbd2d28 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2765,9 +2765,13 @@ sub process {
 # Check if there is UTF-8 in a commit log when a mail header has explicitly
 # declined it, i.e defined some charset where it is missing.
 		if ($in_header_lines &&
-		    $rawline =~ /^Content-Type:.+charset="(.+)".*$/ &&
-		    $1 !~ /utf-8/i) {
-			$non_utf8_charset = 1;
+		    $rawline =~ /^Content-Type:.+charset="?([^\s;"]+)/) {
+			my $charset = $1;
+			$non_utf8_charset = 1 if ($charset !~ /^utf-8$/i);
+			if ($charset !~ /^(?:us-ascii|utf-8|iso-8859-1)$/) {
+				WARN("PATCH_CHARSET",
+				     "Unpreferred email header charset '$charset'\n" . $herecurr);
+			}
 		}
 
 		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&



