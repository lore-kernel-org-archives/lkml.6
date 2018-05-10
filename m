Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966743AbeEJR2j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:28:39 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46168 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966732AbeEJR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:28:27 -0400
Subject: Re: [PATCH] selftests: media_tests: fix spelling mistake:
 "iternations" -> "iterations"
To: Colin King <colin.king@canonical.com>, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180502150010.32333-1-colin.king@canonical.com>
 <140c4e71-071f-039a-c883-fc664e696402@kernel.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <f990d4dd-ff00-b695-68e6-d8d93a200e57@kernel.org>
Date: Thu, 10 May 2018 11:28:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <140c4e71-071f-039a-c883-fc664e696402@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 01:42 PM, Shuah Khan wrote:
> On 05/02/2018 09:00 AM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in message text
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  tools/testing/selftests/media_tests/media_device_test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
>> index 421a367e4bb3..d8bb1e15d1d9 100644
>> --- a/tools/testing/selftests/media_tests/media_device_test.c
>> +++ b/tools/testing/selftests/media_tests/media_device_test.c
>> @@ -88,7 +88,7 @@ int main(int argc, char **argv)
>>  	       "other Oops in the dmesg. Enable KaSan kernel\n"
>>  	       "config option for use-after-free error detection.\n\n");
>>  
>> -	printf("Running test for %d iternations\n", count);
>> +	printf("Running test for %d iterations\n", count);
>>  
>>  	while (count > 0) {
>>  		ret = ioctl(fd, MEDIA_IOC_DEVICE_INFO, &mdi);
>>
> 
> Thanks. I will queue this for 4.18-rc1
> 
> -- Shuah
> 

Applied to linux-kselftest next for 4.18-rc1

thanks,
-- Shuah
