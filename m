Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8C4C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195C32087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195C32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJGWk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:40:26 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57330 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJGWk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:40:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 7AAA24138A;
        Sun,  7 Oct 2018 15:32:47 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ueFkvvzTWGmn; Sun,  7 Oct 2018 15:32:47 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 748BC40EFB;
        Sun,  7 Oct 2018 15:32:41 +0000 (UTC)
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861851.4088.7.camel@HansenPartnership.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <770159f5-ab59-1a59-4156-c2d92587444d@kernel.org>
Date:   Sun, 7 Oct 2018 09:32:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538861851.4088.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2018 03:37 PM, James Bottomley wrote:
> Significant concern has been expressed about the responsibilities outlined in
> the enforcement clause of the new code of conduct.  Since there is concern
> that this becomes binding on the release of the 4.19 kernel, strip the
> enforcement clauses to give the community time to consider and debate how this
> should be handled.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  Documentation/process/code-of-conduct.rst | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index aa40e34e7785..4dd90987305b 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -59,21 +59,6 @@ address, posting via an official social media account, or acting as an appointed
>  representative at an online or offline event. Representation of a project may be
>  further defined and clarified by project maintainers.
>  
> -Enforcement
> -===========
> -
> -Instances of abusive, harassing, or otherwise unacceptable behavior may be
> -reported by contacting the Technical Advisory Board (TAB) at
> -<tab@lists.linux-foundation.org>. All complaints will be reviewed and
> -investigated and will result in a response that is deemed necessary and
> -appropriate to the circumstances. The TAB is obligated to maintain
> -confidentiality with regard to the reporter of an incident.  Further details of
> -specific enforcement policies may be posted separately.
> -
> -Maintainers who do not follow or enforce the Code of Conduct in good faith may
> -face temporary or permanent repercussions as determined by other members of the
> -project’s leadership.
> -
>  Attribution
>  ===========
>  
> 

With the assumption that the enforcement details will be added later after community
discussion in upcoming releases.

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
