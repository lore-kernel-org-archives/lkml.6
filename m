Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14763C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44BD2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZurvHJbL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZurvHJbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBYKbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:31:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfBYKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:31:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7D96A60CED; Mon, 25 Feb 2019 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551090696;
        bh=T7E9mNYqJrt47AGJBxh2Z6xBJHHC11sFkQ8RXGUz4ic=;
        h=Date:From:To:Cc:Subject:From;
        b=ZurvHJbLStPvYIPloZppmGXkWAI/CgIlwoShrirL8udq9qFjxzAF2vOyO7xxle8X2
         MPe3TBbnpeATl4opjEU/IeLuJBf1ZUJ2Pz6KNTi+7XT0NRV4iTXA8eAJml1jyXTS9y
         3iapIsMAlB/rZ1FRmRMIdkFDwrleW5Qx2s4wSWtQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 14E4060397;
        Mon, 25 Feb 2019 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551090696;
        bh=T7E9mNYqJrt47AGJBxh2Z6xBJHHC11sFkQ8RXGUz4ic=;
        h=Date:From:To:Cc:Subject:From;
        b=ZurvHJbLStPvYIPloZppmGXkWAI/CgIlwoShrirL8udq9qFjxzAF2vOyO7xxle8X2
         MPe3TBbnpeATl4opjEU/IeLuJBf1ZUJ2Pz6KNTi+7XT0NRV4iTXA8eAJml1jyXTS9y
         3iapIsMAlB/rZ1FRmRMIdkFDwrleW5Qx2s4wSWtQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Feb 2019 16:01:36 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Hemantg <hemantg@codeaurora.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux-arm Msm <linux-arm-msm@vger.kernel.org>,
        rjliao@codeauroa.com
Subject: Fw files for QCA BT Chip QCA6174
Message-ID: <c3497a2eee78869911a5328ac3ec6e6a@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following changes since commit 
54b0a748c8966c93aaa8726402e0b69cb51cd5d2:

   WHENCE: Correct errant entries (2019-02-21 07:21:45 -0500)

are available in the Git repository at:

   https://github.com/bgodavar/qca6174_bt_fw.git

for you to fetch changes up to c99beda7e0368961d024ddc8e45a46f118100cc7:

   QCA: Add the fw files for BT Chip QCA6174. (2019-02-25 15:36:36 +0530)

----------------------------------------------------------------
Balakrishna Godavarthi (1):
       QCA: Add the fw files for BT Chip QCA6174.

  WHENCE                    |   2 ++
  qca/nvm_00440302.bin      | Bin 0 -> 2010 bytes
  qca/rampatch_00440302.bin | Bin 0 -> 64940 bytes
  3 files changed, 2 insertions(+)
  create mode 100644 qca/nvm_00440302.bin
  create mode 100644 qca/rampatch_00440302.bin

-- 
Regards
Balakrishna.
