Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEDToI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:44:08 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38043 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbeEDToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:44:05 -0400
Subject: Re: [PATCH] cpupower: fix spelling mistake: "logilename" ->
 "logfilename"
To: Colin King <colin.king@canonical.com>,
        Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180503090910.29144-1-colin.king@canonical.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f176fe63-b697-aac7-6906-1e074056f793@kernel.org>
Date: Fri, 4 May 2018 13:43:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503090910.29144-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 03:09 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dprintf message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/power/cpupower/bench/parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index 9b65f052081f..9ba8a44ad2a7 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -104,7 +104,7 @@ FILE *prepare_output(const char *dirname)
>  			dirname, time(NULL));
>  	}
>  
> -	dprintf("logilename: %s\n", filename);
> +	dprintf("logfilename: %s\n", filename);
>  
>  	output = fopen(filename, "w+");
>  	if (output == NULL) {
> 

Thanks. I will send this for 4.18-rc1

-- Shuah
