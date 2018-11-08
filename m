Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E99BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637BD20862
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637BD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeKHKjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:39:04 -0500
Received: from shells.gnugeneration.com ([66.240.222.126]:42746 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeKHKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:39:04 -0500
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id CE1DB1A40335; Wed,  7 Nov 2018 17:06:08 -0800 (PST)
Date:   Wed, 7 Nov 2018 17:06:08 -0800
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [QUESTION] Microsoft, WSL, and the Linux trademark
Message-ID: <20181108010608.mlcjfwwsdwt2nee5@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reading the news today, I stumbled across an article talking about a
$20 "linux-based distro" app for Windows 10.

This is just a bundled userspace for WSL, there is no actual Linux in
this thing, yet the trademarked Linux name is used throughout.

Did Microsoft license the trademark or something?  Did I miss a memo?
Does their joining the Linux Foundation as a Platinum member two years
ago include such use of the trademark?

I'm confused by what seems to be total silence about what _appears_ to
be an obvious large-scale trademark abuse in everything WSL-related.

Could somebody informed please shed some light on this?

The situation strikes me as harmful to the kernel as the majority of
folks being introduced to "Linux" this way will be tricked into thinking
they're using/supporting Linux.

Has the Linux Foundation deliberately turned a blind eye to this
trademark abuse because MS is throwing money at them or is it a formal
licensing situation?  Do we, the community, even have any right to know
what's going on?

Cheers,
Vito Caputo
