Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1DAC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310AC2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310AC2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbeHBPfj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:35:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43242 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbeHBPfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:35:39 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1flDtq-0002Cp-Qi; Thu, 02 Aug 2018 15:44:18 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Schultz <d.schultz@phytec.de>
Cc:     robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: dt-bindings: Add rk808 PMIC reset property
Date:   Thu, 02 Aug 2018 15:44:18 +0200
Message-ID: <15808668.FuvN5QfznR@phil>
In-Reply-To: <1522334683-22169-1-git-send-email-d.schultz@phytec.de>
References: <1522334683-22169-1-git-send-email-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am Donnerstag, 29. März 2018, 16:44:43 CEST schrieb Daniel Schultz:
> Add documentation about a new rk808 devicetree property. This can enable
> the rk805/rk808/rk818 PMIC reset, instead of using soft resets from the
> Control and Reset Module.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Is this patch still current?

Normally they go through the relevant subsystem tree but I don't
see Lee Jones <lee.jones@linaro.org> in the list of recipients.

So you might want to resend with him (and Rob's Ack) added?


Heiko



