Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515A8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11F320836
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11F320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIEHeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:34:21 -0400
Received: from mail1.windriver.com ([147.11.146.13]:57825 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeIEHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:34:21 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8536Fjc022318
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 4 Sep 2018 20:06:15 -0700 (PDT)
Received: from [128.224.162.194] (128.224.162.194) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 4 Sep
 2018 20:06:13 -0700
Subject: Re: [PATCH] sysctl: kselftests: add test_core to .gitignore
To:     <claudiozumbo@gmail.com>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1536115175-10864-1-git-send-email-Lei.Yang@windriver.com>
From:   lei yang <lei.yang@windriver.com>
Message-ID: <78c85cee-7af9-75fc-14c7-6565a7080008@windriver.com>
Date:   Wed, 5 Sep 2018 11:08:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1536115175-10864-1-git-send-email-Lei.Yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.224.162.194]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, the title should be :"cgroup: kselftests: add test_core to 
.gitignore"

Lei



On 2018年09月05日 10:39, Lei Yang wrote:
> Update .gitignore files.
>
> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>   tools/testing/selftests/cgroup/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
> index 95eb3a5..adacda5 100644
> --- a/tools/testing/selftests/cgroup/.gitignore
> +++ b/tools/testing/selftests/cgroup/.gitignore
> @@ -1 +1,2 @@
>   test_memcontrol
> +test_core

