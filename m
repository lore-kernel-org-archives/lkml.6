Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE216C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 19:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E3F208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 19:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E3F208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fefe.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754289AbeGHTot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 15:44:49 -0400
Received: from qarx.de ([31.15.64.162]:53089 "EHLO a.mx.fefe.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754138AbeGHTos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 15:44:48 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Jul 2018 15:44:48 EDT
Received: (qmail 7445 invoked by uid 638); 8 Jul 2018 19:38:05 -0000
Date:   Sun, 8 Jul 2018 21:38:05 +0200
From:   Felix von Leitner <felix-linuxkernel@fefe.de>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: XZ compressed kernel broken?
Message-ID: <20180708193805.GA5389@qarx.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I could not get kernel 4.17 or up to boot on my laptop. I tried various
things, started a new config from scratch on a freshly downloaded (not
up-patched) source tree, to no avail.

Today I tried switching kernel compression from XZ to GZIP and now it
boots fine.

Just as a PSA if your kernel just insta-resets after being loaded from
grub.

Might be some kind of freak interdependency, didn't analyze further.

Felix
