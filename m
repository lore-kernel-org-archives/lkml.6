Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeEDTqN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:46:13 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34369 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeEDTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:46:11 -0400
Subject: Re: [PATCH] selftests: fix spelling mistake: "desciptor" ->
 "descriptor"
To: Colin King <colin.king@canonical.com>,
        "Eric W . Biedermane" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180429115425.9378-1-colin.king@canonical.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <55d4fa6c-2870-afd4-2506-b7a3d721e711@kernel.org>
Date: Fri, 4 May 2018 13:45:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180429115425.9378-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/29/2018 05:54 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/filesystems/devpts_pts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
> index b9055e974289..ea5de8271521 100644
> --- a/tools/testing/selftests/filesystems/devpts_pts.c
> +++ b/tools/testing/selftests/filesystems/devpts_pts.c
> @@ -279,7 +279,7 @@ int main(int argc, char *argv[])
>  	int ret;
>  
>  	if (!isatty(STDIN_FILENO)) {
> -		fprintf(stderr, "Standard input file desciptor is not attached "
> +		fprintf(stderr, "Standard input file descriptor is not attached "
>  				"to a terminal. Skipping test\n");
>  		exit(EXIT_FAILURE);
>  	}
> 

Thanks. I will queue this up for 4.18-rc1

-- Shuah
