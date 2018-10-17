Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24B5ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F92A2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F92A2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJQX3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:29:08 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:40556 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeJQX3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:29:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 0830021269;
        Wed, 17 Oct 2018 15:32:54 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5uoEJf5aIE0U; Wed, 17 Oct 2018 15:32:54 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 0F1F1211E7;
        Wed, 17 Oct 2018 15:32:50 +0000 (UTC)
Subject: Re: [Ksummit-discuss] [PATCH v3 3/3] code-of-conduct: Add back the
 TAB as the central reporting point
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1539701820.2805.6.camel@HansenPartnership.com>
 <1539702015.2805.10.camel@HansenPartnership.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <eb2ecb2b-7087-d516-b3c5-5e5a09a1f1da@kernel.org>
Date:   Wed, 17 Oct 2018 09:32:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539702015.2805.10.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 09:00 AM, James Bottomley wrote:
> Add a Reporting section where the Enforcement section used to be.  The
> intention is still to debate what should go here, but in the meantime, this
> gives us back the central reporting point we had in the old code of conflict.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> 
> v2: Added this patch to allay concerns we were stripping the reporting
>     mechanism entirely.
> v3: Add (where required by law) as a qualifier to the confidentiality
>     requirement
> ---
>  Documentation/process/code-of-conduct.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index 4dd90987305b..eec768471a4d 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -59,6 +59,17 @@ address, posting via an official social media account, or acting as an appointed
>  representative at an online or offline event. Representation of a project may be
>  further defined and clarified by project maintainers.
>  
> +Reporting
> +=========
> +
> +Instances of abusive, harassing, or otherwise unacceptable behavior may be
> +reported by contacting the Technical Advisory Board (TAB) at
> +<tab@lists.linux-foundation.org>. All complaints will be reviewed and
> +investigated and will result in a response that is deemed necessary and
> +appropriate to the circumstances. The TAB is obligated to maintain
> +confidentiality with regard to the reporter of an incident (except where
> +required by law).
> +
>  Attribution
>  ===========
>  
> 
Acked-by : Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
