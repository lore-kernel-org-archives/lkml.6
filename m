Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A05021550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fjHbA62p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A05021550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390546AbeIUVxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:53:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46108 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeIUVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:53:04 -0400
Received: from [192.168.0.23] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 122481280;
        Fri, 21 Sep 2018 18:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537545810;
        bh=2nM0WjSQy7aiBX9nU+aa3CMFcY9SEg4ZIMcEZRSzv/A=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=fjHbA62pt2MUzaVs3nmfFwEEOincM64r3ySWKFfWToAFQciETt+5tAWrSSHsKjntd
         gaUIz1oN9ugB9BF2jv+4b+2YB1I9I+m34Xz+GBCYWg86bp2/M05fbWALXTkQtglrYd
         Psvqd010LAKgtLEL1BCPXyrZE1U9hxDP6PQfpSNM=
Reply-To: kieran.bingham+renesas@ideasonboard.com,
          kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] kernel/bounds: Provide prototype for foo
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
 <20180921144527.GB16316@kroah.com>
 <6436e493-a3e4-7f9e-da1f-9db50643dff8@ideasonboard.com>
Openpgp: preference=signencrypt
Organization: Ideas on Board
Message-ID: <cfb48097-31d7-be19-994f-81f88f2bb1c8@ideasonboard.com>
Date:   Fri, 21 Sep 2018 17:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6436e493-a3e4-7f9e-da1f-9db50643dff8@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/18 16:58, Kieran Bingham wrote:
> Hi Greg,
> 
> Thank you for quick response!

Ahem; s/for quick/for your quick/

I hate re-reading mails after I hit send and spotting things like this.
Sigh :-)

Regards
--
Kieran
