Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F41C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358E420865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1COrDps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358E420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeK0ByF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeK0ByF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:54:05 -0500
Received: from localhost (unknown [178.228.8.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6331420862;
        Mon, 26 Nov 2018 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543244383;
        bh=oJAgL+WSDhbi47ggHdDiNIGTMZQUs/woIlPEn3t1jgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1COrDpsMqDKmFSyMDBLRwYE5Xs45nMIHTHgagKWBT+2CsOuya2aa4g8m8FXpiSip
         r1pmrEigcA5PVb1hU5QgAPU1zRY21Ikd/SGs9LKmfu7NmDxcAwXVEM1eGoDkornCwM
         rguV20HS9gsjS9d5sm136K9ZpPVQRbjvioU/ftxQ=
Date:   Mon, 26 Nov 2018 15:59:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        nicolas.ferre@microchip.com, rainyfeeling@outlook.com,
        boris.brezillon@bootlin.com, johan@kernel.org
Subject: Re: [PATCH 4.14 58/62] mtd: rawnand: atmel: fix OF child-node lookup
Message-ID: <20181126145939.GB4637@kroah.com>
References: <20181126105050.592727680@linuxfoundation.org>
 <20181126105054.941598787@linuxfoundation.org>
 <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsyM9VS8QkaEizQT_LSvZyT+h6zdoWZbhVQtd1n60Bniw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:46:15PM +0530, Naresh Kamboju wrote:
> Do you see build failure arm x15 beagleboard on 4.14 due to this patch ?

I don't have such a device to test on, don't you?  :)

