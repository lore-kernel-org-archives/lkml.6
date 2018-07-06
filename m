Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08570C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CCF23E08
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CCF23E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeGFNvN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:51:13 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:54686 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932562AbeGFNvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:51:12 -0400
Received: from [IPv6:2001:983:e9a7:1:18c6:def5:b848:12d6] ([IPv6:2001:983:e9a7:1:18c6:def5:b848:12d6])
        by smtp-cloud9.xs4all.net with ESMTPA
        id bR8dfu9UyEJtcbR8efFTx2; Fri, 06 Jul 2018 15:51:11 +0200
Subject: Re: [PATCH] media: stm32: dcmi: replace "%p" with "%pK"
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        mchehab@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, hans.verkuil@cisco.com,
        hugues.fruchet@st.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20180706130355.22100-1-benjamin.gaignard@st.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <64b2a2ea-2da9-c40d-eae4-6375079771e7@xs4all.nl>
Date:   Fri, 6 Jul 2018 15:51:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706130355.22100-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKu8/0pCnjkKsmGr5LTUOmccjx9PDe9Xe5JqB6gGgZmgQsWhZHM/n1Sv7cJSYLMDzW1/EwM2hStDY6AgP8cOfcH0pOPztYmLd/BE6kVP4Bk00RtKkEsV
 oSNUVd+CaFC5B0IOoQC2XKcbc8wHUKdDkWVlvlnWagDTxTnvQ+/VPFVJpk9vB1BdDwNcnYhvenNvWZ4iY6I2lfDmqdIOIymEBgm87Tgya45jt8fhSXcwxc1c
 HSbaDeHFp+V9oe6Y+C1k4jYXvdRH87gpKlJRPHYR/T3xl1erB57X5Az1rrDuijFFIOBUcVnlmXu4vra/pSK0K8P1zuyLoWycgZNOQB99Qc+Rrz4E0Q606ml1
 MF8SlYcPdribMc5qJgYsBTYsk7lDK/nPVYvBlUetcK8J1HzZ63P0L0P3zb69jo44AMF4ysdm1LAIeex8UGHvBBkn+s5fJhLxKPYFzxgtBmc/K4Un1PQ64cvO
 5E1TlZ9uW+PYTOjxGNmb64bjeFfZuAFzyS5kKpDChwlb/7FsVZSCy+bNJ4GyCwWvONSjT11pUPXRab7dcc08NHs8c4BIUkrtCwRL/4+rgYgrVti/am5wlqhr
 rwk04Yh/U27+NChUQliRd8sSBiiBievqzSt7YTiudcHZn3J3i1LYwPzzhSodEaq0ovM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 15:03, Benjamin Gaignard wrote:
> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.

This patch no longer applies. AFAICT it is obsolete after some code reorg.

Regards,

	Hans

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/media/platform/stm32/stm32-dcmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index 2e1933d872ee..fe90672cf16f 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -1753,7 +1753,7 @@ static int dcmi_probe(struct platform_device *pdev)
>  
>  	ret = clk_prepare(mclk);
>  	if (ret) {
> -		dev_err(&pdev->dev, "Unable to prepare mclk %p\n", mclk);
> +		dev_err(&pdev->dev, "Unable to prepare mclk %pK\n", mclk);
>  		goto err_dma_release;
>  	}
>  
> 

