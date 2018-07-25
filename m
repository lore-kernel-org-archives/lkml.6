Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E7C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B292088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B292088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeGYIu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:50:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:50:56 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3FDD720;
        Wed, 25 Jul 2018 07:40:30 +0000 (UTC)
Date:   Wed, 25 Jul 2018 09:40:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     devel@driverdev.osuosl.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 4/4] Staging: octeon-usb: Adds SPDX License Identifier
Message-ID: <20180725074027.GC21472@kroah.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
 <20180724222212.8742-6-tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724222212.8742-6-tsotsos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:22:12AM +0300, Georgios Tsotsos wrote:
> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.h | 1 +
>  1 file changed, 1 insertion(+)

Two different 4/4 patches in the same series?  How did you create these?

greg k-h
