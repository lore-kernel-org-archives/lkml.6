Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518A320835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eI+A+WwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518A320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeJKQ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:59:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44922 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeJKQ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:59:54 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6CBA26F;
        Thu, 11 Oct 2018 11:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539250404;
        bh=o/Aw8VlWCshtwprbAKc/lUBh+6RvbmCd00PIeHTGnKY=;
        h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
        b=eI+A+WwDTw4cg1hLGCE2Zbr4Co7HiRsLBOpcqI9u4FQPiPq0cmDjQ7LghW63Ti6Ip
         J6msKryUER9esMh7keAQpATfhNCiK6XoF+JvsIqE6EJmkSubPY1LSnyo8+p/g+9J71
         Qw8DjYSP8pMOXPHy1ujU5ewh5jtiLgz5BsBy8+1M=
Subject: Re: [PATCH] media: intel-ipu3: cio2: Remove redundant definitions
To:     Rajmohan Mani <rajmohan.mani@intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>
Cc:     tfiga@chromium.org
References: <20181009234245.25830-1-rajmohan.mani@intel.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <33c53caf-633a-f359-4312-9c2dc317efc5@ideasonboard.com>
Date:   Thu, 11 Oct 2018 10:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009234245.25830-1-rajmohan.mani@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajmohan

Thank you for the patch,

On 10/10/18 00:42, Rajmohan Mani wrote:
> Removed redundant CIO2_IMAGE_MAX_* definitions
> 
> Fixes: c2a6a07afe4a ("media: intel-ipu3: cio2: add new MIPI-CSI2 driver")
> 
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Looks like this {sh,c}ould be bundled in with
 "[PATCH 0/2] Trivial CIO2 patches" from Sakari at integration.

--
Regards

Kieran Bingham

> ---
>  drivers/media/pci/intel/ipu3/ipu3-cio2.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> index 240635be7a31..7caab9b8c2b9 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
> @@ -10,8 +10,6 @@
>  #define CIO2_PCI_ID					0x9d32
>  #define CIO2_PCI_BAR					0
>  #define CIO2_DMA_MASK					DMA_BIT_MASK(39)
> -#define CIO2_IMAGE_MAX_WIDTH				4224
> -#define CIO2_IMAGE_MAX_LENGTH				3136
>  
>  #define CIO2_IMAGE_MAX_WIDTH				4224
>  #define CIO2_IMAGE_MAX_LENGTH				3136
> 

