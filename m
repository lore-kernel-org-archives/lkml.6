Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A27C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AEA223D3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BZUOW2Xy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BZUOW2Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AEA223D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeHKBH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:07:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50606 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHKBH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:07:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E5EF9608C9; Fri, 10 Aug 2018 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533940566;
        bh=KvR5brmnokALBS/5cSlHCc5UOL4IVl4bHlLklvpz3N0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BZUOW2Xy8RDlR/cjJhKYvkBvCErkcnL1RI6y98PZp3ud1AGgn9ILxLaLP9oEe76pP
         AvbgBLJCe0kNTZKvCcM8PW85bzO0IVaYVthPpy6hi69mOxJA/fnrx8RVdIvOOAwBKB
         VzapRF/OoFSZxQ7882wPMBVNFF2lVQmcf/y6miQE=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DFA86085F;
        Fri, 10 Aug 2018 22:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533940566;
        bh=KvR5brmnokALBS/5cSlHCc5UOL4IVl4bHlLklvpz3N0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BZUOW2Xy8RDlR/cjJhKYvkBvCErkcnL1RI6y98PZp3ud1AGgn9ILxLaLP9oEe76pP
         AvbgBLJCe0kNTZKvCcM8PW85bzO0IVaYVthPpy6hi69mOxJA/fnrx8RVdIvOOAwBKB
         VzapRF/OoFSZxQ7882wPMBVNFF2lVQmcf/y6miQE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DFA86085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Add stylistic breaks in the default
 cases
To:     Douglas Anderson <dianders@chromium.org>, broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180810200531.88409-1-dianders@chromium.org>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <03a6c012-2dac-8d2f-e8ff-7d4734935532@codeaurora.org>
Date:   Fri, 10 Aug 2018 15:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180810200531.88409-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 01:05 PM, Douglas Anderson wrote:
> No functional change here but it can make the code more readable to
> have breaks in the "default" case even though it's the last case.
> Let's add them.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/regulator/qcom-rpmh-regulator.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 9f27daebd8c8..b8434e521d72 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -504,6 +504,7 @@ static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int rpmh_mode)
>  		break;
>  	default:
>  		mode = REGULATOR_MODE_INVALID;
> +		break;
>  	}
>  
>  	return mode;
> @@ -537,6 +538,7 @@ rpmh_regulator_pmic4_smps_of_map_mode(unsigned int rpmh_mode)
>  		break;
>  	default:
>  		mode = REGULATOR_MODE_INVALID;
> +		break;
>  	}
>  
>  	return mode;
> @@ -566,6 +568,7 @@ static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int rpmh_mode)
>  		break;
>  	default:
>  		mode = REGULATOR_MODE_INVALID;
> +		break;
>  	}
>  
>  	return mode;

Reviewed-by: David Collins <collinsd@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
