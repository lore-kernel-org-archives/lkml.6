Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAED20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544082050;
	bh=9gVa8j51SBfviRPVVhop/zwrQOliN8Pae31iHppBFaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HUa8xIlATl2WOybPS80Q8ABEjWRDJ5aMg9eBsmUu5RVT+IuVBNFiSX6q2Dtg9Trly
	 i4rIkib0IvaNNcf7it0CFpYQ/2BE1fDV7Z+WBRqYkFzY9G2UdqdIBRRYnnq+yVUeZv
	 lDXe1zxFaqh9wzxKpwg4dY3FQcHaLXD3TrGTypEE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAED20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeLFHkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbeLFHkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:40:47 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E541D20878;
        Thu,  6 Dec 2018 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544082046;
        bh=9gVa8j51SBfviRPVVhop/zwrQOliN8Pae31iHppBFaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAJXmqieI5DPy1NWLMPh5CLRQb9qHDYLe/Tn41FcxttfHk0HtTB1SzzEZQeA7SON9
         7L3sUNtVj7P3UPVA7Rw6QfgpQJ77P0Uab/y8C30FUn8/gNjt4sA/3S9rJm8e2H9FwI
         92xLsZj5lBcH3Mh6xlbfgsSt+RdfCHqdcQKQawts=
Date:   Thu, 6 Dec 2018 15:40:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     cphealy@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: vf610-zii-scu4-aib: Add HI8435 support
Message-ID: <20181206074006.GJ3987@dragon>
References: <1544008775-24128-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544008775-24128-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:19:35AM -0200, Fabio Estevam wrote:
> On the vf610-zii-scu4-aib board there is a hi8435 (32-channel
> discrete-to-digital SPI sensor device) in the DSPI0 bus.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Chris Healy <cphealy@gmail.com>

Applied, thanks.
