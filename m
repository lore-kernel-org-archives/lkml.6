Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4D7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCB420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbfAOTtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:49:46 -0500
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:42444 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728745AbfAOTtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:49:45 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 14:49:45 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id F383718023EAD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 19:41:21 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id EC60B18225629;
        Tue, 15 Jan 2019 19:41:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horse67_28b295a43cd07
X-Filterd-Recvd-Size: 1896
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 15 Jan 2019 19:41:19 +0000 (UTC)
Message-ID: <aa7337c0af524751d1f9d738b10d1e2d4e1199d8.camel@perches.com>
Subject: Re: [PATCH] Documentation/process: hardcoded core.abbrev considered
 harmful!
From:   Joe Perches <golf@perches.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Tue, 15 Jan 2019 11:41:18 -0800
In-Reply-To: <20181220000112.24891-1-avarab@gmail.com>
References: <1396949135-27122-1-git-send-email-jeffrey.t.kirsher@intel.com>
         <20181220000112.24891-1-avarab@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-20 at 01:01 +0100, Ævar Arnfjörð Bjarmason wrote:
> Stop recommending that core.abbrev=12 be hardcoded when referring to
> kernel commits, and instead rely on the git's default abbreviation.

Nothing happened to this patch and there was no reply to
it as far as I can tell.

This may be sensible for future git versions, but perhaps
there should be a different abbrev control added and the
kernel should enable that.

> As an aside I have upcoming git.git patches so you'll be able to set
> core.abbbrev to e.g. +1 to get "13" now, "14" when it rolls over at
> ~16 million etc. Maybe that'll be a good fit for projects like
> linux.git that want more future-proof abbreviated SHAs than most.

Will '$ git config --get core.abbrev' return a specific
number in that case?

(not +1 and not blank as current if unspecified)


