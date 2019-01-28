Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8567C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775D32171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548687826;
	bh=g9Dlc1VG8HZycPSoWbB5p0SmqQK8O54w2jdihGxn61U=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=u/tBeqKAoFQViWHmugDf8zOVlbKgbFuwtp5RS4fck6eEc3iYceBQWCatPOcawCbuR
	 PK3LH3tI2SAEdsjWeufJ/4uSosjf6wjaLBn/C1X8pwzHBVqCv1LyyP3Vwd3gXDJzGo
	 YsLdVLNtmUYU3nHMxFYbeWvQi0kichToDdIrXhVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfA1PDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1PDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:03:44 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67CB620879;
        Mon, 28 Jan 2019 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548687823;
        bh=g9Dlc1VG8HZycPSoWbB5p0SmqQK8O54w2jdihGxn61U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UoyWDjFxGIBRkH0wM5zro9Gml+/aPbrfKCdmFbg4nudU5Lmq+c9JJVZsxEQZDRrPi
         tWzx11JJsf5epUVgeU+qDoTkHRLw/Faegr31h3wZC0Xvz8lE2MfSqmoqfPcnq3Q+2D
         ZtLdvHQcxT3btPmmYQ9GLyreNsuExopQNSSRH25A=
Subject: Re: linux-next: Signed-off-by missing for commit in the
 kselftest-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Denys Dmytriyenko <denys@ti.com>,
        Fathi Boudra <fathi.boudra@linaro.org>,
        shuah <shuah@kernel.org>
References: <20190127143616.2e27781a@canb.auug.org.au>
From:   shuah <shuah@kernel.org>
Message-ID: <6898228d-5c0f-227c-4164-1a73d97381c3@kernel.org>
Date:   Mon, 28 Jan 2019 08:03:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190127143616.2e27781a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/19 8:36 PM, Stephen Rothwell wrote:
> Hi Shuah,
> 
> Commit
> 
>    5d09ac9241a3 ("selftests: lib: allow to override CC in the top-level Makefile")
> 
> is missing a Signed-off-by from its author.
> 

Thanks for finding this. The patch has been dropped for now.

-- Shuah
