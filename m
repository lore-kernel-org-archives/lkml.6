Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B41C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406CD20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406CD20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeKBUTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:19:33 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:51940 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:19:33 -0400
Received: from localhost (victim.blr.asicdesigners.com [10.193.185.129])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id wA2BChO1024319;
        Fri, 2 Nov 2018 04:12:44 -0700
Date:   Fri, 2 Nov 2018 16:42:49 +0530
From:   Ganesh Goudar <ganeshgr@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, nirranjan@chelsio.com, dt@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware
Message-ID: <20181102111248.GA19135@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kindly pull the new firmware from the following URL.
git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks
Ganesh

The following changes since commit 1baa34868b2c0a004dc595b20678145e3fff83e7:

  Merge branch 'nxp_mc' of https://github.com/NXP/linux-firmware (2018-10-26 08:13:19 -0400)

are available in the git repository at:


  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to e7cdec460311a76e4f99e6bed763628af5fc2208:

  cxgb4: update firmware to revision 1.21.5.0 (2018-11-02 03:38:38 -0700)

----------------------------------------------------------------
Ganesh Goudar (1):
      cxgb4: update firmware to revision 1.21.5.0

 WHENCE                  |  12 ++++++------
 cxgb4/t4fw-1.20.8.0.bin | Bin 559616 -> 0 bytes
 cxgb4/t4fw-1.21.5.0.bin | Bin 0 -> 561664 bytes
 cxgb4/t4fw.bin          |   2 +-
 cxgb4/t5fw-1.20.8.0.bin | Bin 646144 -> 0 bytes
 cxgb4/t5fw-1.21.5.0.bin | Bin 0 -> 648704 bytes
 cxgb4/t5fw.bin          |   2 +-
 cxgb4/t6fw-1.20.8.0.bin | Bin 692736 -> 0 bytes
 cxgb4/t6fw-1.21.5.0.bin | Bin 0 -> 695296 bytes
 cxgb4/t6fw.bin          |   2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 delete mode 100644 cxgb4/t4fw-1.20.8.0.bin
 create mode 100644 cxgb4/t4fw-1.21.5.0.bin
 delete mode 100644 cxgb4/t5fw-1.20.8.0.bin
 create mode 100644 cxgb4/t5fw-1.21.5.0.bin
 delete mode 100644 cxgb4/t6fw-1.20.8.0.bin
 create mode 100644 cxgb4/t6fw-1.21.5.0.bin

