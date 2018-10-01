Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5DBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92572084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="brJ/Q7NJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="brJ/Q7NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92572084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeJAR0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:26:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbeJAR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:26:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4D3D60271; Mon,  1 Oct 2018 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538390971;
        bh=xh95fKkY4RpyzZDLvWejV4ZOD1v6V+qOXMKdyBa4emk=;
        h=Date:From:To:Cc:Subject:From;
        b=brJ/Q7NJt+S95sDkpdtrOG8VDV0ea6dBVsh4k7YAK8G13vlkMcz7bgv+LNcdO2bPB
         APxnssOrzmMZChqrtaRixNcX4A/nZXCmgmIQJh9j8vwnZKS179zF1KJq/kvloodK0a
         c92edNEypYctfpAZIX5a8moYHKdIXwyEIclw5kHw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4446B6053C;
        Mon,  1 Oct 2018 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538390971;
        bh=xh95fKkY4RpyzZDLvWejV4ZOD1v6V+qOXMKdyBa4emk=;
        h=Date:From:To:Cc:Subject:From;
        b=brJ/Q7NJt+S95sDkpdtrOG8VDV0ea6dBVsh4k7YAK8G13vlkMcz7bgv+LNcdO2bPB
         APxnssOrzmMZChqrtaRixNcX4A/nZXCmgmIQJh9j8vwnZKS179zF1KJq/kvloodK0a
         c92edNEypYctfpAZIX5a8moYHKdIXwyEIclw5kHw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 16:19:31 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     linux-firmware@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: qca: update BT firmware files for QCA ROME chip.
Message-ID: <c56b472fa06e3a5e8127c2043c77305b@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following changes since commit 
44d4fca9922a252a0bd81f6307bcc072a78da54a:

   Merge https://github.com/pmachata/linux-firmware (2018-09-13 11:45:40 
-0400)

are available in the Git repository at:

   https://github.com/bgodavar/qca_rome_firmware master

for you to fetch changes up to 534daf431c88b24236d23572039cdd79223b246a:

   qca: update BT firmware files for QCA ROME chip. (2018-09-18 13:11:47 
+0530)

----------------------------------------------------------------
Balakrishna Godavarthi (1):
       qca: update BT firmware files for QCA ROME chip.

  qca/nvm_usb_00000302.bin      | Bin 1953 -> 1996 bytes
  qca/rampatch_usb_00000302.bin | Bin 32940 -> 64168 bytes
  2 files changed, 0 insertions(+), 0 deletions(-)

-- 
Regards
Balakrishna.
