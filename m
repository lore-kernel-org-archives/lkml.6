Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE9C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B253224E9
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B253224E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeGGDPu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:15:50 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:25139 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeGGDPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:15:49 -0400
Received: from localhost (victim.blr.asicdesigners.com [10.193.185.129])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id w673FkPw025247;
        Fri, 6 Jul 2018 20:15:47 -0700
Date:   Sat, 7 Jul 2018 08:45:49 +0530
From:   Ganesh Goudar <ganeshgr@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, nirranjan@chelsio.com,
        indranil@chelsio.com, arjun@chelsio.com, venkatesh@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware
Message-ID: <20180707031548.GA6594@chelsio.com>
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

The following changes since commit d1147327232ec4616a66ab898df84f9700c816c1:

  Merge branch 'for-upstreaming-v1.7.2-vsw' of https://github.com/felix-cavium/linux-firmware (2018-06-06 13:23:36 -0400)

are available in the git repository at:


  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 6213586dc3bc830cb27ce726a3002bb312bfa567:

  cxgb4: update firmware to revision 1.20.8.0 (2018-07-06 09:59:41 -0700)

----------------------------------------------------------------
Ganesh Goudar (1):
      cxgb4: update firmware to revision 1.20.8.0

 WHENCE                  |  12 ++++++------
 cxgb4/t4fw-1.19.1.0.bin | Bin 553984 -> 0 bytes
 cxgb4/t4fw-1.20.8.0.bin | Bin 0 -> 559616 bytes
 cxgb4/t4fw.bin          |   2 +-
 cxgb4/t5fw-1.19.1.0.bin | Bin 651776 -> 0 bytes
 cxgb4/t5fw-1.20.8.0.bin | Bin 0 -> 646144 bytes
 cxgb4/t5fw.bin          |   2 +-
 cxgb4/t6fw-1.19.1.0.bin | Bin 698368 -> 0 bytes
 cxgb4/t6fw-1.20.8.0.bin | Bin 0 -> 692736 bytes
 cxgb4/t6fw.bin          |   2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 delete mode 100644 cxgb4/t4fw-1.19.1.0.bin
 create mode 100644 cxgb4/t4fw-1.20.8.0.bin
 delete mode 100644 cxgb4/t5fw-1.19.1.0.bin
 create mode 100644 cxgb4/t5fw-1.20.8.0.bin
 delete mode 100644 cxgb4/t6fw-1.19.1.0.bin
 create mode 100644 cxgb4/t6fw-1.20.8.0.bin
