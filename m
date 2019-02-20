Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D12C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB322147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NhN/UtzT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NhN/UtzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfBTNBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:01:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfBTNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:01:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E80F460716; Wed, 20 Feb 2019 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550667673;
        bh=hoSO5XqD8OaR5JQudwk4tpheMFo0FQNoHNbA9yl1ITM=;
        h=Date:From:To:Cc:Subject:From;
        b=NhN/UtzT87Z/O50l4xSv7WxE/5h1wukafBn4mSOB95dwHYP6RCw9IxZTmzYDFhGfh
         JxN4zYhTe79u+CNbTSnwAgvCHCO3C2v4G0xHArVFp8+7eGoR0yJp1rrcIIuwo6iH7z
         +Vh6qPOkHk8/cfZ759Igv3NaMLlIoH84Kasl3QIw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6E56F6034F;
        Wed, 20 Feb 2019 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550667673;
        bh=hoSO5XqD8OaR5JQudwk4tpheMFo0FQNoHNbA9yl1ITM=;
        h=Date:From:To:Cc:Subject:From;
        b=NhN/UtzT87Z/O50l4xSv7WxE/5h1wukafBn4mSOB95dwHYP6RCw9IxZTmzYDFhGfh
         JxN4zYhTe79u+CNbTSnwAgvCHCO3C2v4G0xHArVFp8+7eGoR0yJp1rrcIIuwo6iH7z
         +Vh6qPOkHk8/cfZ759Igv3NaMLlIoH84Kasl3QIw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Feb 2019 18:31:13 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Hemantg <hemantg@codeaurora.org>,
        Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Linux-arm Msm <linux-arm-msm@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Firmware files for QCA BT chip wcn3990
Message-ID: <26af87bceb0a7c355ba90cce863bfd1e@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following changes since commit 
710963fe53ee3f227556d36839df3858daf6e232:

   Merge https://github.com/ajaykuee/linux-firmware (2019-02-13 07:42:20 
-0500)

are available in the Git repository at:

   https://github.com/bgodavar/qca_bt_wcn3990_fw.git

for you to fetch changes up to f859d9fda9379205c9bcf2eab11fae68891085ee:

   qca: Add firmware files for BT chip wcn3990. (2019-02-20 18:23:46 
+0530)

----------------------------------------------------------------
Balakrishna Godavarthi (1):
       qca: Add firmware files for BT chip wcn3990.

  WHENCE           |   2 +
  qca/NOTICE.txt   | 334 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------
  qca/crbtfw21.tlv | Bin 0 -> 177060 bytes
  qca/crnv21.bin   | Bin 0 -> 4587 bytes
  4 files changed, 129 insertions(+), 207 deletions(-)
  create mode 100644 qca/crbtfw21.tlv
  create mode 100644 qca/crnv21.bin


-- 
Regards
Balakrishna.
