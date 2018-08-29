Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2512A204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2512A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeH2QLv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:11:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44002 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeH2QLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:11:51 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fuzNJ-0001Yz-PZ; Wed, 29 Aug 2018 14:15:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, robh@kernel.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] devicetree/bindings: display: Add document for rockchip RGB output
Date:   Wed, 29 Aug 2018 14:15:04 +0200
Message-ID: <1862757.LMSXp8aoQ6@phil>
In-Reply-To: <2858027f-69f5-57ee-d14a-2f0b329e8e0e@ysoft.com>
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com> <1535443954-38806-2-git-send-email-hjc@rock-chips.com> <2858027f-69f5-57ee-d14a-2f0b329e8e0e@ysoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Am Dienstag, 28. August 2018, 10:31:15 CEST schrieb Michal Vokáč:
> On 28.8.2018 10:12, Sandy Huang wrote:
> > This path add support rv1108 and px30 rgb output interface driver.
> 
> Hi Sandy,
> Seems like you forgot to address Rob's comment regarding the "driver" word.
> Also fix the typo: s/path/patch
> The subject could be improved as well: s/devicetree\/bindings/dt-bindings

We actually honored Rob's bigger concern of the rgb output not being
an actual device backed by programmable hardware and moved the rgb
output inside the driver, see v7 of the patchset [0].


Heiko

[0] https://patchwork.freedesktop.org/patch/246297/
https://patchwork.freedesktop.org/patch/246298/
https://patchwork.freedesktop.org/patch/246299/


