Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 69EF9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133E62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLMugr4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133E62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbeFOFnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755577AbeFOFnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:43:32 -0400
Received: from redbean (ip5f5ade9d.dynamic.kabel-deutschland.de [95.90.222.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3272086A;
        Fri, 15 Jun 2018 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529041411;
        bh=XF4ZXOP+93mMhIvYKvEueOtWCIo2MQazYQ1vE9U9ib0=;
        h=Date:From:To:Cc:Subject:From;
        b=PLMugr4XIEx0q/LFUbJ4C0YTYW0yWyPbn9tpSDh8UmSv4zc1kcdsaJFk48Hryp3Ds
         56iq1UDlrF5Y0dS6t8ik1QMJ3cKhqqIxaYWL+pCY2vDZrKkGlnEDqBbIqgUmjZIPqw
         ePfC24wJKkTaUiyaIkZ6ubetBxg9EqmkP4BJEnik=
Date:   Fri, 15 Jun 2018 07:43:27 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] modules for v4.18
Message-ID: <20180615054327.uhxk7e3plmo6hmm7@redbean>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, 

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v4.18

for you to fetch changes up to c554b89868015d86cd330d9cc10656c3756352a5:

  module: Allow to always show the status of modsign (2018-04-16 23:49:33 +0200)

----------------------------------------------------------------
Modules updates for v4.18

Summary of modules changes for the 4.18 merge window:

- Minor code cleanup and also allow sig_enforce param to be shown in
  sysfs with CONFIG_MODULE_SIG_FORCE

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jia Zhang (2):
      module: Do not access sig_enforce directly
      module: Allow to always show the status of modsign

 kernel/module.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
