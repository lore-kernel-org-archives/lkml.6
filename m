Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A89C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D7620700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1kU7FGq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D7620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbeKFEHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKFEHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:07:37 -0500
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7AD82085A;
        Mon,  5 Nov 2018 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541443594;
        bh=c0bP8Pe1i8Lf/mQ58LMuArG9iDkxT8R4Kd3KwpSKz7I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1kU7FGq+ppmfWJKGcYtA2a7Id23iv1sUZ2cI+rZPy9grUJWicYIuCzF6IQYzJ0gJB
         /POfnMu0r736934hn+BK0EvQudwncWZ/vW+8cnXfbCo3r8p7rvgw0wyzAIVwF2bTWO
         wqcdfLmdR0ijM68eVh/RzeKuizBHwCaRY2kjRDgM=
Subject: Re: [PATCH resend] Documentation/dev-tools: clean up kselftest.rst
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <67201746-13c6-2b05-7f3d-2b200e4d9af0@infradead.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <759a6f00-a45f-0f04-4efe-6beff9e724ae@kernel.org>
Date:   Mon, 5 Nov 2018 11:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <67201746-13c6-2b05-7f3d-2b200e4d9af0@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2018 03:06 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> This is a small cleanup to kselftest.rst:
> 
> - Fix some language typos in the usage instructions.
> - Change one non-ASCII space to an ASCII space.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/dev-tools/kselftest.rst |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Thanks for the patch. Here is my Ack for it go through doc tree

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
