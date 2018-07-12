Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2633820C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2633820C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeGLGZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:25:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeGLGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:25:06 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7FC3FC22;
        Thu, 12 Jul 2018 06:17:03 +0000 (UTC)
Date:   Thu, 12 Jul 2018 08:17:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kacper =?utf-8?Q?Ko=C5=82odziej?= <kacper@kolodziej.it>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: break line longer than 80 cols
Message-ID: <20180712061701.GF20905@kroah.com>
References: <20180711192411.24817-1-kacper@kolodziej.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711192411.24817-1-kacper@kolodziej.it>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:24:09PM +0200, Kacper Kołodziej wrote:
> Signed-off-by: Kacper Kołodziej <kacper@kolodziej.it>

Sorry, but I need a changelog text in order to be able to take a patch.

thanks,

greg k-h
