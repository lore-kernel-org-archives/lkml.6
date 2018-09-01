Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B423C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3340A20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="mWv45sVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3340A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=linux-watchdog.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeIANAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 09:00:17 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:47156 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeIANAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 09:00:16 -0400
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id E2534406A0; Sat,  1 Sep 2018 10:28:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org E2534406A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1535790516;
        bh=Tm+ZrgMz8LfGdB2QAOo+ONUbzf0Jw2umAfpeEZ/rJkM=;
        h=Date:From:To:Cc:Subject:From;
        b=mWv45sVfYM2JtjhsrDNWSfJNGP+rtYy2v2yBZFkDYGCV07SaKMlj5nbppQVhhSf+9
         +HqJC7SHGErItOGNr1RdBuTWNOCQkBsw5FYahWR97vE7vV+AKoht6FGqyTPATs8AUf
         pLUTApSIuvIpkuqIQb7XkoTtzI0W50/Z74t1TN3Q=
Date:   Sat, 1 Sep 2018 10:28:36 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [GIT PULL REQUEST] watchdog - v4.19-rc2
Message-ID: <20180901082836.GA21742@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.19 release cycle.

This pull contains:
* renesas-wdt: Document support for r8a774a1

The output from git request-pull:
----------------------------------------------------------------

The following changes since commit 3f16503b7d2274ac8cbab11163047ac0b4c66cfe:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal (2018-08-28 16:11:34 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.19-rc2

for you to fetch changes up to 74081c9f16a213f8f2681c175dc6ad7d17ad16ba:

  dt-bindings: watchdog: renesas-wdt: Document r8a774a1 support (2018-08-29 20:32:04 +0200)

----------------------------------------------------------------
linux-watchdog 4.19-rc2 tag

----------------------------------------------------------------
Fabrizio Castro (1):
      dt-bindings: watchdog: renesas-wdt: Document r8a774a1 support

 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

----------------------------------------------------------------

Kind regards,
Wim.

