Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C764AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D232145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D232145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbeLCJIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:08:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43773 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLCJIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:08:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so10221527oie.10;
        Mon, 03 Dec 2018 01:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLVzkcixKwGRqX7O7nik0iirXSFGbYUjT4tn0nty4Y4=;
        b=HZQbj+rNnc58ucbjXaVrDmLHavVfXqKrsxdGXXh0XJ3Is550tz26Y/W/Qvf9xGP8H8
         L4DBWfQBg5pfQYvTI0gD2/44IFKQySngkIC5h9wZPF47ctf8BfPtivrawZmAO3pX/+mv
         wP1G7YdzGpNeHfDPxk7+vdpVBNuDTy8JF4rlinCxVD3f9P6/cOZEQuu/yXXX4/wvArRI
         /ruy/m6/e9zBLGs+7DYbJ87a1Abzx7XXtSpoLeFJO9z2+aMExcC4IOp42kccJkvJuC3V
         mZMnAl3pu20APmrbwxatKgAEVg/ZDqh+IkJs/cBc3at/JykEy5Pd92mCYWMeg2J4SjUx
         MIOw==
X-Gm-Message-State: AA+aEWaLFoUSBXszbynzzlFoEba0VvqrwG2E60q2idwjLfZFoTC9bvjR
        n75ZBYbgcXn/zKdM0vX8qxkFtPhdzxfhunehHHI=
X-Google-Smtp-Source: AFSGD/XY2+pfmSj2ElQNFSohboUe5G/x4LKOKMfr/gqB3LpVYhtYFA4CCKRTgBBRMWQzmjIy5oWktSXCZCRACjKiw+w=
X-Received: by 2002:aca:b642:: with SMTP id g63mr8843538oif.195.1543828108951;
 Mon, 03 Dec 2018 01:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-7-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181130192737.15053-7-jarkko.sakkinen@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Dec 2018 10:08:16 +0100
Message-ID: <CAJZ5v0gH_VMoi+KFoy0kPUu435yjXUnhc9XeJQc61t34yrkJJg@mail.gmail.com>
Subject: Re: [PATCH RFC 06/15] cpufreq: replace **** with a hug
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 8:28 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/cpufreq/powernow-k7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index d6cb052b0a75..302315ad3786 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -574,7 +574,7 @@ static int acer_cpufreq_pst(const struct dmi_system_id *d)
>  }
>
>  /*
> - * Some Athlon laptops have really fucked PST tables.
> + * Some Athlon laptops have really hugged PST tables.

Can we just say "broken"?

>   * A BIOS update is all that can save them.
>   * Mention this, and disable cpufreq.
>   */
> --
> 2.19.1
>
