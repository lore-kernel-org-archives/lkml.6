Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91721C67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572A120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108720;
	bh=8O436oxtUgN33f4bCxVN4GTvmdHlVmbINln3iqIn4J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KAC1N7v7Ewtrr7RhNm5VNHdqZj8uVdr9RESZscwohbdx8KIhUhVvtTN7Rt2hMyqYk
	 0sh27yv52aFK/1xSVYgYCr4a+MyxnUA8R5/19OV+OIYt2hnx85kAsLRXb1JqYQADge
	 xtTOrXmRFkBA25G/JC/Jd5M2S93FZt+QusCYcv6I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572A120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLFPFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFPFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:05:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035C520700;
        Thu,  6 Dec 2018 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544108718;
        bh=8O436oxtUgN33f4bCxVN4GTvmdHlVmbINln3iqIn4J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0lSA7hD5acVaeLM1XtxR3vSbkIWC5fVyMsQk+2yuKrEjm9r9ozdUHwkcQird7+eHP
         lora3VWkCsz3Z0M5Zxs83eCA1ShcbleKFccdM3rS5iSLyhhKQuiYPB5oU5sh3RUmvz
         XSiXlxfu1mdXDC5wj8254Wp6ZRrvwfgOjzfUw86E=
Date:   Thu, 6 Dec 2018 16:05:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Sicilia Cristian <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 2/2] staging: greybus: Added space between string
 concatenated
Message-ID: <20181206150516.GA1774@kroah.com>
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
 <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
 <20181205210034.GA24054@peano>
 <e7902148-4f80-2d9c-7f51-d6bd21bf9eff@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7902148-4f80-2d9c-7f51-d6bd21bf9eff@nexus-software.ie>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:43:46AM +0000, Bryan O'Donoghue wrote:
> On 05/12/2018 21:00, Sicilia Cristian wrote:
> > It doesn't change the result string
> 
> So why do it then ?

Because it is easier to read this way and odds are checkpatch is
happier.

thanks,

greg k-h
