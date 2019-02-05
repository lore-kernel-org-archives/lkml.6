Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE6BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D5E20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="VBMfiJw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfBEJ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:26:40 -0500
Received: from onstation.org ([52.200.56.107]:54958 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfBEJ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:26:40 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4291A11;
        Tue,  5 Feb 2019 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549358799;
        bh=WieUXT/9Lx5fthP2dKFZYxD5gI1WgbGCeuV6V+HxKFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBMfiJw0Kp5IticvSmj0gbuUkWYSjjadSTW781cgboeILCKJmZ6H+qwpl4GFxxWGk
         GymhGNxvqB1xUfqeNeQ9iODw/5C/TsevS8XO1q71aX3wypa2BrBchgHbKAfRuhd4/R
         gM4OSoBwRg5BPrFNl8q7qux4rnb+L9dfoUYwxrCw=
Date:   Tue, 5 Feb 2019 04:26:38 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     dmitry.torokhov@gmail.com
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v3 2/3] Input: add new vibrator driver for various MSM
 SOCs
Message-ID: <20190205092638.GA10771@basecamp>
References: <20181025012937.2154-1-masneyb@onstation.org>
 <20181025012937.2154-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025012937.2154-3-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Oct 24, 2018 at 09:29:36PM -0400, Brian Masney wrote:
> This patch adds a new vibrator driver that supports various Qualcomm
> MSM SOCs. Driver was tested on a LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Any chance that I can get a review of this patch series? Let me know if
you're not the right maintainer that I should send this series to.

Thanks,

Brian
