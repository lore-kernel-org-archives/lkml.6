Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeDDJOt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:14:49 -0400
Received: from mx12-out3.antispamcloud.com ([46.165.232.173]:59570 "EHLO
        mx12-out3.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751306AbeDDJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:14:44 -0400
Subject: Re: Build failure due commit 9217e566bdee
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <76f98816-9f0a-3eb7-e00e-82cf5935afd6@linux.intel.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <1e269233-162c-0f40-6815-328c28c2a093@topic.nl>
Date: Wed, 4 Apr 2018 10:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <76f98816-9f0a-3eb7-e00e-82cf5935afd6@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: nl
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.80.121]
X-EXCLAIMER-MD-CONFIG: 9833cda7-5b21-4d34-9a38-8d025ddc3664
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Originating-IP: 37.74.225.130
X-AntiSpamCloud-Domain: topic.nl
X-AntiSpamCloud-Username: 37.74.225.128/28
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=37.74.225.128/28@topic.nl
X-AntiSpamCloud-Outgoing-Class: ham
X-AntiSpamCloud-Outgoing-Evidence: SB/global_tokens (0.00524354160851)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5qXkIlL58fWdWEnz4LAQj/1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO/C4OCl0Kbbt+9XCk4a8P9Bid2i6c6xaHAfX3xqXjqmPNlDo60GNfZ2F/yvXF5fp0YXL
 i8e7Kvia8KAnQL8EdGJRh3oP0E0rVNmnS6CuBAK/h7DSD1O63Ri4lPFyb5q7iS6MN8xFxlxHZge6
 OlcoYA+YVg8LcgRGdvAKwEo8eYHdNxiQHiz9CkRa4oi6LDzh8AH9CwOjtCL7yGiQ/Xhs9wVBpc/A
 iUjjK788fU1YN0ZF6nnyBmiyWX0RGrFZH3rV0bCF7uPHciCURZGXqWuGSh4i5tdzz1+yJN+pA6Oy
 33V3mdySlZou9qHIGOZDEEo7O3PuJfOIAQpYEteY7zmkHA9oX4/cIYvCqRpDTGmi0vQyVWa9nN/e
 mBiQF7aGHy+VA7q9TSap8NkyvDhVoCnB/H94UKCObeQdNllr+FgloJnx4YPei0K57Aeg48dA7G/i
 NhXZU3s+BKeiVRn7TrBH4neqpIVOWw86kr12AvwtnJkQ04E2Ye4EPTHUM5RuWyT5nnW2G/SF32Bk
 aVUv9IQODMJlPXLsdEyHbf9ma8aFH4+HcaV9d2aAmsqMGVOlazvzLwbagfIvdhUxTOrWRQa0IoWH
 MViWR0Cwlx09XsMZ/eCJIK/1NH5THMtlYvyHAYGOGiINloeONSMv6A+sGH/yfiR6QMFKh2gn9uuV
 g+yqIuhF7LG77rUS9tt1zWOIrm3NkgTC37+Fo2pa1cRuCCoCxfjkbl3FS0anXMSPVONqOzaWbaLc
 rPKffJMtnsmVL5aH2vIK1qWmUmTc/Dar2YjHql6uL4901KTwD4j/tNsUVmCqHPxll6J/TelY6rt6
 JAPl7YcUV9Va3EVGf3y+/ANZ4d82EwF1iFRrZkfauZe2nxU+t483R4KXuhQIqxuSxfSkVVFfEoXm
 0/FPF8PR0w363lnaDwj8yS5wKVJMb+O6FyJY3UVkhX78ZcdZtWJtri4lXTIcXFU6yR3ZRhdyb6eC
 S+L3q5cuVl1TF2xPeZCwgGD9mzvvJzEWC/ZHpFS+HYcdOon5y/vcIKE4+MoDT8NV3zdM7Ahub8TB
 eVhtYGLHDQnyYBy7MnRsdN78hH61PXZFfadBRL7uqFLmd0yZnXUTSZg=
X-Report-Abuse-To: spam@quarantine2.antispamcloud.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿On 04-04-18 09:22, Jarkko Nikula wrote:
> Hi
> 
> Today's head and linux-next doesn't compile due commit 9217e566bdee ("of_net: 
> Implement of_get_nvmem_mac_address helper"):
> 
> drivers/of/of_net.o: In function `of_get_nvmem_mac_address':
> .../drivers/of/of_net.c:100: undefined reference to `of_nvmem_cell_get'
> .../drivers/of/of_net.c:104: undefined reference to `nvmem_cell_read'
> .../drivers/of/of_net.c:106: undefined reference to `nvmem_cell_put'
> Makefile:1033: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> Builds if I set CONFIG_NVMEM=y from CONFIG_NVMEM=m or revert above commit.
> 


I've been looking into it, but haven't come up with a proper solution.

The issue is that OF_NET now requires NVMEM as either not-present or built-in, 
but cannot support it as module.

I don't know if that requirement can be expressed. I think having nvnmem_core 
as a module doesn't make much sense anyway, but that's not up to me.

Moving the code from of to nvmem seems weird, but would solve it.



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
