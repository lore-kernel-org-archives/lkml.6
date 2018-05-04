Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeEDTmy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:42:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:38001 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeEDTmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:42:53 -0400
Subject: Re: [PATCH] selftests: media_tests: fix spelling mistake:
 "iternations" -> "iterations"
To: Colin King <colin.king@canonical.com>, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180502150010.32333-1-colin.king@canonical.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <140c4e71-071f-039a-c883-fc664e696402@kernel.org>
Date: Fri, 4 May 2018 13:42:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502150010.32333-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 09:00 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/media_tests/media_device_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
> index 421a367e4bb3..d8bb1e15d1d9 100644
> --- a/tools/testing/selftests/media_tests/media_device_test.c
> +++ b/tools/testing/selftests/media_tests/media_device_test.c
> @@ -88,7 +88,7 @@ int main(int argc, char **argv)
>  	       "other Oops in the dmesg. Enable KaSan kernel\n"
>  	       "config option for use-after-free error detection.\n\n");
>  
> -	printf("Running test for %d iternations\n", count);
> +	printf("Running test for %d iterations\n", count);
>  
>  	while (count > 0) {
>  		ret = ioctl(fd, MEDIA_IOC_DEVICE_INFO, &mdi);
> 

Thanks. I will queue this for 4.18-rc1

-- Shuah
