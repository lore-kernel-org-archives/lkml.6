Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DAFC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1B6217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH4AnzPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1B6217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeHUSwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeHUSwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:52:16 -0400
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1432177A;
        Tue, 21 Aug 2018 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534865500;
        bh=1C3REt7wIochRwta1CzH4MxOXLqE8keaFSTqEUU6juI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iH4AnzPElx0TNUxPEhAh5WmbljDxuJxIg0EU7NnzRv0oMzD9hmqbBDhUAHVhjE7ja
         eESVINF3bBQq9ls6K/E+ayFJxyaxasrKC5aNry9rfjiE8zCa446jzUpYNbPttMUhRQ
         JOsGyBKNykqlSLFni0hWe9dxVUq/tYh6HoUz9uuI=
Date:   Tue, 21 Aug 2018 23:31:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Revert "ARM: dts: imx7d: Invert legacy PCI irq
 mapping"
Message-ID: <20180821153059.GD32159@dragon>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0ceaa10da805bc79e85ec7d60fcce9d4327066.1532448745.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:14:19PM +0300, Leonard Crestez wrote:
> This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
> 
> That commit followed the reference manual but unfortunately the imx7d
> manual is incorrect.
> 
> Tested with ath9k pcie card and confirmed internally.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
