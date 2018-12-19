Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56255C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2622F218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545227003;
	bh=OWmMeCrV2P97uAwEADUcy81pG8JxFVD/lC4TmA3y6ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=am+2Rt7XtG01A+t+T3tGM+MB07hSuk3RpxUIwUM/9y12AlMSSVrMcQqJ2Dol5u+Rm
	 0Gg5KYNss4DYjsJpqsv7lUbUkmuYALYSVEUaweT9ZNzOUVDZHZK569k/wYIHVBuWEJ
	 4YXJpAgJMu8lSf7ulNPdCEIrQecmDYmsRNYnfwdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbeLSNnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:43:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLSNnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:43:21 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86F821841;
        Wed, 19 Dec 2018 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545227001;
        bh=OWmMeCrV2P97uAwEADUcy81pG8JxFVD/lC4TmA3y6ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlFB2/EQpB2wuhAp5LC8rnmnFAXtlWchRmck5/zEqEZ6KY04r9P/4Mb6EIYfA+t9h
         4DoyV4W8NxCPPLNPSgN8PwazM6HkjNbdQDthykMaZdA0kohHGRFfmZpm5+ceJEMnro
         iASldAMsD554D1VcQCeVssnHaqRghKzoa1wOYztw=
Date:   Wed, 19 Dec 2018 08:43:19 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 44/73] net: phy: Fix not to call
 phy_resume() if PHY is not attached
Message-ID: <20181219134319.GJ2746@sasha-vm>
References: <20181213042838.75160-1-sashal@kernel.org>
 <20181213042838.75160-44-sashal@kernel.org>
 <OSAPR01MB229047CACB004208BC5F48ACD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <OSAPR01MB229047CACB004208BC5F48ACD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:48:07AM +0000, Yoshihiro Shimoda wrote:
>Hi,
>
>> From: Sasha Levin, Sent: Thursday, December 13, 2018 1:28 PM
>>
>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> [ Upstream commit ef1b5bf506b1f0ee3edc98533e1f3ecb105eb46a ]
>
>This upstream commit is also reverted on mainline
>as I mentioned other email thread[1]
>
>[1]
>https://lore.kernel.org/lkml/OSAPR01MB2290FE36AF50B2F29170383DD8A00@OSAPR01MB2290.jpnprd01.prod.outlook.com/T/#u

I've dropped this commit, thank you!

--
Thanks,
Sasha
