Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509DC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52970204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xKgL3RZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52970204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeHYVrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 17:47:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43045 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbeHYVrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 17:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=hppEboJRb+s3vNRoX/TXd6EvWUXdhH1Y+idglygTUPg=;
        b=xKgL3RZSM4NjbdR7nRVYas42cxaPEJ0jyL5CmEN+tDtJ+ePUWSsLi/hGN2XY3iOu6YTn/U8UEKBDcRyDr/+P/7DWxIEmceEbKqFYwFuZrbnkqY5rFW0xKaE3jmbw5FBzlBGnhBBhYqK4NlQjfRc9T5E9HA5fWE6KsZkKx2ruAio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ftcy1-0006Sq-AE; Sat, 25 Aug 2018 20:07:21 +0200
Date:   Sat, 25 Aug 2018 20:07:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "lipeng (Y)" <lipeng321@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com
Subject: Re: [PATCH NET 3/3] net: hns: add configuration constraints for
 1000M half
Message-ID: <20180825180721.GB23992@lunn.ch>
References: <1535082143-122281-1-git-send-email-lipeng321@huawei.com>
 <1535082143-122281-4-git-send-email-lipeng321@huawei.com>
 <20180824034119.GA29111@lunn.ch>
 <194ac663-94d8-55e2-0231-a6be53e35f04@huawei.com>
 <20180824132857.GA1999@lunn.ch>
 <7c40c758-2ef2-665d-f429-0cc4e63a7a38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c40c758-2ef2-665d-f429-0cc4e63a7a38@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch is a  theoretical protect, and the problem does not really 
> happen.
> 
> I think you really get the point, do you think we need this patch?

I think it is not needed.

And if it was needed, it would indicate there is a bug somewhere else.

    Andrew
