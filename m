Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbeEaOm6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:42:58 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:33060 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755042AbeEaOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:42:55 -0400
Subject: Re: [PATCH] selftests: add test for USB over IP driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: valentina.manea.m@gmail.com, mchehab+samsung@kernel.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180531030057.32442-1-shuah@kernel.org>
 <20180531063530.GB7744@kroah.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <52c33b15-0bc3-83ab-1e9c-bef7a0cbf791@kernel.org>
Date: Thu, 31 May 2018 08:42:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531063530.GB7744@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 12:35 AM, Greg KH wrote:
> On Wed, May 30, 2018 at 09:00:57PM -0600, Shuah Khan (Samsung OSG) wrote:
>> Add test for USB over IP driver. This test runs several tests on a device
>> specified in the -b <busid> argument and path to the usbip tools.
>>
>> usbip_test.sh -b <busid> -p <usbip tools path>
>>
>> e.g:
>> cd tools/testing selftests/drivers/usb/usbip
>> sudo ./usbip_test.sh -b 3-10.2 -p <yoursrctree>/tools/usb/usbip
>>
>> This test should be run as root and user should build usbip tools before
>> running the test.
>>
>> The usbip test isn't included in the Kselftest run as it requires user to
>> specify a device to run tests on.
>>
>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> 
> If you want to take this through your tree, that's fine with me:
> 
> 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Otherwise I will be glad to queue it up in mine, just let me know what
> is easier for you.
> 
> Nice work, thanks.

Thanks. Please take this through your tree sticking to the current flow
of patches for this driver.

thanks,
-- Shuah
