Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC3BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C670B2089A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C670B2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeGYIuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:50:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:50:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC206AD2;
        Wed, 25 Jul 2018 07:40:12 +0000 (UTC)
Date:   Wed, 25 Jul 2018 09:40:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     devel@driverdev.osuosl.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 4/4] Staging: octeon-usb: Adds SPDX License Identifier
 for header file
Message-ID: <20180725074009.GB21472@kroah.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
 <20180724222212.8742-5-tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724222212.8742-5-tsotsos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:22:11AM +0300, Georgios Tsotsos wrote:
> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---

I can not take patches without any changelog text, sorry :(

