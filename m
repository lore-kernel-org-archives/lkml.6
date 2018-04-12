Return-Path: <Claudiu.Beznea@microchip.com>
X-Google-Smtp-Source: AIpwx4875ne4fvoXVS2T8XTPYHdPeMfa6VuEEj3fMFcLI2mYO2CI7DR6HTU3z2tddWcHxjxqnYvN
ARC-Seal: i=1; a=rsa-sha256; t=1523521017; cv=none;
        d=google.com; s=arc-20160816;
        b=YL6CNRSz2zPslM4W/padGQkeFgPOhABlMsNNhBmOYS85GuGSSx6emUzTjQJsSwjgDY
         9obqdbWxSOJqu071wnDj4CweFBDlRV3thcGf97972GHvSsHTXbphxNLengr8mq0BM/Rk
         o6CkD/Qc7pDzAXqa6VD9enr91JMAEA/hRWaZxiGzE9BE2Ixq+hrcw8GtlwFYiVszN9Sv
         C+FDAKwUz7MA5SQ0NI18QtwZ5t7ulVqAWkr9rYQ59fvTjUgn6AKn9Ac6g9B1qYoBqFV8
         5jxrHzh2gK5VLnCPWwKNBkuwVRPfzgjazB58Z4T6zmDmOPwVWLV97Bp0Bx3LTpEK23DL
         OAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=95A5Utx9HBclqSD/wnN6Vrk5n3aO19gxlMip87HAz68=;
        b=U1jHOiuR6YzCIBK5DhgyuxohAQRknjdgnnuf8PbSe60Um5eU2N9ewKbronQRVDxdUd
         F5vRdShLjYaJR4a8gxGIovjKT7fOmVt6KepuV/Kz+6mb5HH1eHUfJAFNrw2moW+j8wjp
         xHmjVqjiEIWinEkXGnjVJHL8LOVZ5PXcnst7bJT40S1pBrUG8/MMEfo3Mqc9B7WkwfbI
         iZzkbn2v84eHZlzZ6LLbDDPHeFjwGS6yZSR6mqLx5HzVJ/FLce0aBoPhIT+VDyfN5ZFk
         QJOb0RwvKIx1d5afJyZ4yHDw2xHZmm95oYGScAMFqkw+PwmJW+Fp4eA2dOJD7ELWN3HG
         lEmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of claudiu.beznea@microchip.com designates 216.71.154.253 as permitted sender) smtp.mailfrom=Claudiu.Beznea@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of claudiu.beznea@microchip.com designates 216.71.154.253 as permitted sender) smtp.mailfrom=Claudiu.Beznea@microchip.com
X-IronPort-AV: E=Sophos;i="5.48,440,1517900400";
   d="scan'208";a="10487934"
Subject: Re: [PATCH v2] staging: wilc1000: Remove unnecessary braces {} around
 single statement block
To: Eyal Ilsar <edilsar@gmail.com>, <aditya.shankar@microchip.com>,
	<ganesh.krishna@microchip.com>, <gregkh@linuxfoundation.org>
CC: <devel@driverdev.osuosl.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <1523371795-5090-1-git-send-email-edilsar@gmail.com>
 <1523519972-21017-1-git-send-email-edilsar@gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <de5c65da-2bdb-19e1-db89-c5bd28b5df2f@microchip.com>
Date: Thu, 12 Apr 2018 11:16:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523519972-21017-1-git-send-email-edilsar@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597371147858195854?=
X-GMAIL-MSGID: =?utf-8?q?1597527574639167238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 12.04.2018 10:59, Eyal Ilsar wrote:
> Remove unnecessary braces {} around an 'if' statement block with a single 
> statement. Issue found by checkpatch.
> 
> Signed-off-by: Eyal Ilsar <edilsar@gmail.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

> ---
> Added an empty line before the 'Signed-off-by' line and a space between the
> name and e-mail address within that line.
> 
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> index 205304c..325afe1 100644
> --- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> +++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> @@ -284,9 +284,8 @@ static void remove_network_from_shadow(struct timer_list *unused)
>  		}
>  	}
>  
> -	if (last_scanned_cnt != 0) {
> +	if (last_scanned_cnt != 0)
>  		mod_timer(&hAgingTimer, jiffies + msecs_to_jiffies(AGING_TIME));
> -	}
>  }
>  
>  static void clear_duringIP(struct timer_list *unused)
> 
