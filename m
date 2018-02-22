Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeBVISZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:18:25 -0500
Received: from anchovy3.45ru.net.au ([203.30.46.155]:51729 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeBVISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:18:24 -0500
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
 <alpine.DEB.2.20.1802212101160.2292@hadrien>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <6d7692ef-0929-7ef2-a1c5-989593f02b1c@electromag.com.au>
Date: Thu, 22 Feb 2018 16:11:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802212101160.2292@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2018 04:01, Julia Lawall wrote:
> 
> On Wed, 21 Feb 2018, Rodrigo Siqueira wrote:
> 
>> This patch fixes the checkpatch.pl warning:
>>
>> drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
>> 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> I haven't studied up on it in great detail, but isn't there a more
> specific macro that doesn't need a permission argument at all?
> 

Probably thinking of IIO_DEVICE_ATTR_RO / IIO_DEVICE_ATTR_WO
But they don't provide flexibility for the show / store method.

-- 
Regards
Phil Reid
