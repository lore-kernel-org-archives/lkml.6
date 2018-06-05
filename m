Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeFEFck (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:32:40 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38644 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeFEFcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:32:39 -0400
X-Google-Smtp-Source: ADUXVKL4Ob0ub03C/a/ePm8bWUW4CBMu3HHd0dKLmJUC75uUoZfTOZFSGQswpF70+ED++wTUXwB5HQ==
Date: Tue, 5 Jun 2018 11:02:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Janani Sankara Babu <jananis37@gmail.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] Staging:greybus Fix comparison to NULL
Message-ID: <20180605053236.u57riboa47so66rr@vireshk-i7>
References: <1528030371-3822-1-git-send-email-jananis37@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528030371-3822-1-git-send-email-jananis37@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-06-18, 08:52, Janani Sankara Babu wrote:
> This patch replaces comparison of var to NULL with !var
> 
> Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
> ---
>  drivers/staging/greybus/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/core.c b/drivers/staging/greybus/core.c
> index dafa430..5d14a4e 100644
> --- a/drivers/staging/greybus/core.c
> +++ b/drivers/staging/greybus/core.c
> @@ -48,7 +48,7 @@ static bool greybus_match_one_id(struct gb_bundle *bundle,
>  static const struct greybus_bundle_id *
>  greybus_match_id(struct gb_bundle *bundle, const struct greybus_bundle_id *id)
>  {
> -	if (id == NULL)
> +	if (!id)

It is pretty much personal preference and there is no good reason to accept this
patch really.

-- 
viresh
