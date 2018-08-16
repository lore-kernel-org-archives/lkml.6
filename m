Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5107C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633E620C10
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI9OOkDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633E620C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeHPWmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeHPWmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:42:40 -0400
Received: from localhost.localdomain (unknown [192.55.54.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD4B120C10;
        Thu, 16 Aug 2018 19:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534448537;
        bh=t69uAvQ6G/2mUeCTjV/S2IkoORlnxRgxGbQEPvCg710=;
        h=From:To:Cc:Subject:Date:From;
        b=fI9OOkDnCdNcBnUrgw53fIo8V2cOdI7lHl/G9+1mCPlmfxEiCwMigRIOZ4P/5cYBx
         bAGEp4HKhAaG/J249SOAN8jnySNf3mgZVUUyCTEImUHB2mV08T3r6PqUoHB+0pHdcw
         QUfx5GbSh9RqI0abuVRMCLav3qW8tYYUiRZ717E0=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH 0/2] fpga: small fixes for 4.19
Date:   Thu, 16 Aug 2018 14:42:12 -0500
Message-Id: <20180816194214.3462-1-atull@kernel.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please take these two small fixes for FPGA.  They've been
reviewed on the mailing lists.  They apply cleanly on
linux-next/master.

Thanks,
Alan

Colin Ian King (1):
  drivers: fpga: fix two trivial spelling mistakes

Wei Yongjun (1):
  fpga: dfl: fme: fix return value check in in pr_mgmt_init()

 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 drivers/fpga/dfl-fme-mgr.c        | 2 +-
 drivers/fpga/dfl-fme-pr.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

