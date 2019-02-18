Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EAB218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iUlYdTEX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jskuWkT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBRGNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:13:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBRGNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:13:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E02C3602FE; Mon, 18 Feb 2019 06:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550470398;
        bh=N/sF/ZELPs59xKpqF/LqV2/jXsPl6+wvqghI2+w1Vsc=;
        h=Date:From:To:Cc:Subject:From;
        b=iUlYdTEXWBOnHQ8kBLrqy+H2rMOUaHLEvTpU+dtRxmfHDxYH7ARgdnu3FsirNG3FJ
         dLRYV6Wa4VVhoBLrUN8ECca1pHLuFLBytQrcmKR7yclZ7dr1owH8pfHtwXuDgeowrH
         wj+k7wkdcYvxDDoXpQTEA6KAdKyyCxx4Jics47iU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CF6D660397;
        Mon, 18 Feb 2019 06:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550470397;
        bh=N/sF/ZELPs59xKpqF/LqV2/jXsPl6+wvqghI2+w1Vsc=;
        h=Date:From:To:Cc:Subject:From;
        b=jskuWkT3QYsJIKfdjSvYfKpU5Dn5jzp7qTMe7feh2xTmiPB9JP7ajtuvQfZKppSi+
         A/FZgJbRnxY2GlnRKaT0tKLTeBKbPQuGgY/GWKyyFCxWVO+pTc6YKxtxyc+CYaPWm9
         OctVNmC4aQUOpk0Y12rpggCrPmDwxNQrixT+cJE8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Feb 2019 11:43:16 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux-arm Msm <linux-arm-msm@vger.kernel.org>
Subject: Firmware files for QCA BT chip WCN3990.
Message-ID: <795c3942482d96c696b4368e68de1ba0@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following changes since commit 
a9c22d3d8af87bd39a078ec6c846b0674dd2ca38:

   qca: Add firmware files for BT chip wcn3990. (2019-02-15 16:07:56 
+0530)

are available in the Git repository at:

   https://github.com/bgodavar/qca_bt_wcn3990_fw.git

for you to fetch changes up to a9c22d3d8af87bd39a078ec6c846b0674dd2ca38:

   qca: Add firmware files for BT chip wcn3990. (2019-02-15 16:07:56 
+0530)


-- 
Regards
Balakrishna.
