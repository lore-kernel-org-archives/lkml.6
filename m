Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE1BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700B6217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544946309;
	bh=TWR85vNrMu4M6q7j3Qiy4mDxLIIpdTZdIDobq82MKQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qdSB2eVKpiWAwxDJ/bPkqruWli28YQHQohX073xZ6o3dKJ8nwVi947U7eI80MN/3a
	 k2aQ9Eb/HyawXyYfFs2+r0/41gA+j6JkkzZGNbZeRhFioI7ejaX4sfg0JCUisXW2fY
	 06dlzKZ3cFZmrK8ALVez6/9MxCJrNKYedXJoC7jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbeLPHpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 02:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbeLPHpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 02:45:06 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5FB42084D;
        Sun, 16 Dec 2018 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544946306;
        bh=TWR85vNrMu4M6q7j3Qiy4mDxLIIpdTZdIDobq82MKQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8p/oGy5Cdi5axYsxzLyz5tjoBH9Ix+Xew+6OllIzAudVRS9wAq+nlUPlW5L2z6Lm
         rjyKBxBW9JHevK8AmK44PUGFNXzmZnXnqROzLkM12EN6CZo507PH0nFLnxIf8lAEsr
         Ifl/KHXVMsgzq/tZlPcb0xMmS4XFpKpay8sWPpwQ=
Date:   Sun, 16 Dec 2018 15:43:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Wen He <wen.he_1@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64: dts: ls1046a: add qdma device tree nodes
Message-ID: <20181216074354.GG13243@dragon>
References: <20181206111823.45985-1-peng.ma@nxp.com>
 <20181206111823.45985-3-peng.ma@nxp.com>
 <VI1PR04MB44313466C33A7BAD7167D4EEEDA10@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44313466C33A7BAD7167D4EEEDA10@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:30:15AM +0000, Peng Ma wrote:
> Hi shawnguo,
> 
> I send this series patch to http://patchwork.ozlabs.org/project/devicetree-bindings/list/
> But I did not find patchs on devicetree patchwork, could I send patchs again.

You do not need to.  I have sent the series for 4.21 inclusion.  I
forgot to reply and let you know.  Sorry.

Shawn
