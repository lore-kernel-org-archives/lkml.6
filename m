Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9772089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9772089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeGIH1u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:27:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54504 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932165AbeGIH1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:27:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C663BED1;
        Mon,  9 Jul 2018 00:27:47 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 540933F5AD;
        Mon,  9 Jul 2018 00:27:45 -0700 (PDT)
Date:   Mon, 9 Jul 2018 08:27:41 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
Message-ID: <20180709082741.7cd71bae@why.wild-wind.fr.eu.org>
In-Reply-To: <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
        <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 14:05:02 +0800
Mars Cheng <mars.cheng@mediatek.com> wrote:

> This adds basic chip support for MT6765 SoC.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
