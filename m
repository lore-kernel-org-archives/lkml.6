Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D18C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1C6217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546467544;
	bh=IHSa6mUKP1/oHQVxyCKByMWs7vahg3FtcYHNRbGeRqw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZtmxKu5IdXw/UTJTXIou+4j3GQGwjDaROJsvmtXhK88Svx3T3aQ5b8nhfYPG6K78x
	 waZ9aKr/8herk6S1LiJ9AbR3giPZd6Hht5B2D23HMbkcIb6Bt0KFIaO9S5tRVGar3c
	 TlsYwn6mVQvz/t7Q6JedZEI0WRVXP+iWr1FQWtEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfABWTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:19:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfABWTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:19:03 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E905214C6;
        Wed,  2 Jan 2019 22:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546467542;
        bh=IHSa6mUKP1/oHQVxyCKByMWs7vahg3FtcYHNRbGeRqw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sLvp1gA+XuMvZ/+4E4iMCiZBpe7i1fK2OpfLjQjbR/5mnodoz7H3WXcIHxVc8mkzl
         1mbsRiDC2qfN/re86XVbyokoZ99DqW/t1eFa9aBCI3OZLRdfmbpikVJIEf3tnAzmF0
         A5BdyqKGJJDJJskpx5hUr0GiDmwhyGw+9cvesoH0=
Subject: Re: [PATCH 1/2] selftests: rtc: rtctest: fix alarm tests
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org, shuah <shuah@kernel.org>
References: <20181218213421.15447-1-alexandre.belloni@bootlin.com>
From:   shuah <shuah@kernel.org>
Message-ID: <43bcf585-4b66-024a-0968-c96fe327a10b@kernel.org>
Date:   Wed, 2 Jan 2019 15:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218213421.15447-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 2:34 PM, Alexandre Belloni wrote:
> Return values for select are not checked properly and timeouts may not be
> detected.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks. I will get these into the 4.21-rc2

-- Shuah
